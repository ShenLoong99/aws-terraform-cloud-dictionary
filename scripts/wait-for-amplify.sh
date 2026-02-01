#!/bin/bash
AMPLIFY_APP_ID=$1
AMPLIFY_BRANCH=$2
CURRENT_COMMIT_SHA=$3

# Fetch latest job info
JOB_JSON=$(aws amplify list-jobs --app-id "$AMPLIFY_APP_ID" --branch-name "$AMPLIFY_BRANCH" --max-items 1 --query 'jobSummaries[0]' --output json)

STATUS=$(echo "$JOB_JSON" | jq -r '.status')
COMMIT=$(echo "$JOB_JSON" | jq -r '.commitId')
START_TIME=$(echo "$JOB_JSON" | jq -r '.startTime')

# Convert start time to seconds for comparison
START_SEC=$(date -d "$START_TIME" +%s)
NOW_SEC=$(date +%s)
DIFF_SEC=$((NOW_SEC - START_SEC))

echo "Latest Status: $STATUS | Commit: $COMMIT | Started: $DIFF_SEC seconds ago"

# LOGIC:
# 1. If status is currently active (Provisioning/Running), WAIT
# 2. If status is SUCCEED but it started < 60 seconds ago, it's our build, MOVE ON
# 3. If commit ID matches perfectly, WAIT

if [[ "$STATUS" =~ ^(PENDING|PROVISIONING|RUNNING)$ ]]; then
    echo "🔄 Active build detected. Entering wait loop..."
elif [[ "$COMMIT" == "$CURRENT_COMMIT_SHA" || "$COMMIT" == "HEAD" ]] && [ $DIFF_SEC -lt 300 ]; then
    echo "✅ Recent build (or HEAD) detected within last 5 mins. Monitoring..."
else
    echo "⚠️ No recent active build found. Skipping."
    exit 0
fi

# Standard Wait Loop
while [[ ! "$STATUS" =~ ^SUCCEED ]]; do
    if [[ "$STATUS" == "FAILED" || "$STATUS" == "CANCELLED" ]]; then
        echo "❌ Amplify build failed!"
        exit 1
    fi
    sleep 30
    STATUS=$(aws amplify list-jobs --app-id "$AMPLIFY_APP_ID" --branch-name "$AMPLIFY_BRANCH" --max-items 1 --query 'jobSummaries[0].status' --output text)
    echo "⏳ Status: $STATUS"
done

echo "✅ Amplify deployment is live!"

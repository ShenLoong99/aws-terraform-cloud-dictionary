#!/bin/bash
# scripts/health_check.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Parameters passed from the workflow
API_URL=$1
AMPLIFY_URL=$2

echo "-----------------------------------------------"
echo "🚀 Starting Post-Deployment Health Checks"
echo "API Endpoint: $API_URL"
echo "Frontend URL: $AMPLIFY_URL"
echo "-----------------------------------------------"

# Verify API Gateway & Lambda Health
echo "Test 1: Testing API endpoint for term 'S3'..."
RESPONSE_S3=$(curl -s -o /dev/null -w "%{http_code}" "${API_URL}/search?term=S3")

if [ "$RESPONSE_S3" -eq 200 ]; then
    echo "✅ Success: Term 'S3' found (Status 200)."
else
    echo "❌ Failed: API Health Check returned status $RESPONSE_S3"
    exit 1
fi

# Verify Error Handling
echo "Test 2: Testing non-existent term..."
RESPONSE_MISSING=$(curl -s -o /dev/null -w "%{http_code}" "${API_URL}/search?term=NONEXISTENT")

if [ "$RESPONSE_MISSING" -eq 404 ]; then
    echo "✅ Success: Error Handling verified (Status 404)."
else
    echo "❌ Failed: Expected 404 for missing term, but got $RESPONSE_MISSING"
    exit 1
fi

# Frontend Reachability (Optional)
echo "Test 3: Checking Frontend availability..."
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$AMPLIFY_URL")
if [ "$FRONTEND_STATUS" -ge 200 ] && [ "$FRONTEND_STATUS" -lt 400 ]; then
    echo "✅ Success: Frontend is reachable (Status $FRONTEND_STATUS)."
else
    echo "⚠️ Warning: Frontend returned status $FRONTEND_STATUS"
fi

echo "-----------------------------------------------"
echo "✨ All critical health checks passed!"
echo "-----------------------------------------------"

# Generate GitHub Step Summary if running in GitHub Actions
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    echo "### 🚀 Deployment Successful!" >> "$GITHUB_STEP_SUMMARY"
    echo "- **API Endpoint:** $API_URL" >> "$GITHUB_STEP_SUMMARY"
    echo "- **Frontend URL:** $AMPLIFY_URL" >> "$GITHUB_STEP_SUMMARY"
    echo "- **Status:** All health checks passed (200 OK & 404 Not Found)." >> "$GITHUB_STEP_SUMMARY"
fi

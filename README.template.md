<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<div align="center">
   <h1 align="center">📖 Serverless Cloud Dictionary</h1>
   <p align="center"> <strong>A Full-Stack Serverless Web Application for Instant Cloud Terminology Lookup</strong> <br /> <a href="#about-the-project"><strong>Explore the docs »</strong></a> </p>
</div>
<details>
   <summary>Table of Contents</summary>
   <ol>
      <li><a href="#about-the-project">About The Project</a></li>
      <li><a href="#built-with">Built With</a></li>
      <li><a href="#use-cases">Use Cases</a></li>
      <li><a href="#architecture">Architecture</a></li>
      <li><a href="#file-structure">File Structure</a></li>
      <li><a href="#getting-started">Getting Started</a></li>
      <li><a href="#usage">Usage & Testing</a></li>
      <li><a href="#roadmap">Roadmap</a></li>
      <li><a href="#challenges">Challenges</a></li>
      <li><a href="#cost-optimization">Cost Optimization</a></li>
   </ol>
</details>
<h2 id="about-the-project">About The Project</h2>
<p> The <strong>Serverless Cloud Dictionary</strong> is a modern, end-to-end cloud application designed to demonstrate the power of <strong>event-driven architecture</strong> and <strong>Infrastructure as Code (Terraform)</strong>. It provides users with a lightning-fast React interface to search for technical cloud terms, backed by a highly available NoSQL database and a serverless API. </p>
<p> This project automates the entire CI/CD lifecycle. When infrastructure changes occur (like API updates), a <strong>custom Terraform trigger</strong> fires a webhook to <strong>AWS Amplify</strong>, ensuring the frontend is always perfectly synced with the backend without manual redeployments. </p>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="built-with">Built With</h2>
<p> 
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/react/react-original.svg" alt="react" width="45" height="45" style="margin: 10px;"/> 
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg" alt="python" width="45" height="45" style="margin: 10px;"/>
    <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_Compute/48/Arch_AWS-Lambda_48.svg" alt="lambda" width="45" height="45" style="margin: 10px;"/> 
    <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/terraform/terraform-original.svg" alt="terraform" width="45" height="45" style="margin: 10px;"/> 
    <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_Database/48/Arch_Amazon-DynamoDB_48.svg" alt="dynamodb" width="45" height="45" style="margin: 10px;"/> 
    <img src="https://raw.githubusercontent.com/weibeld/aws-icons-svg/main/q1-2022/Architecture-Service-Icons_01312022/Arch_App-Integration/Arch_48/Arch_ Amazon-API-Gateway_48.svg" alt="apigateway" width="45" height="45" style="margin: 10px;"/> 
</p>
<ul>
   <li><strong>React.js:</strong> Frontend UI with dynamic title updates and normalized search logic.</li>
   <li><strong>AWS Lambda:</strong> Serverless Python backend that handles business logic and database queries with comprehensive CloudWatch logging.</li>
   <li><strong>Terraform:</strong> Orchestrates the entire AWS stack, including IAM roles, logging, and webhooks.</li>
   <li><strong>Amazon DynamoDB:</strong> NoSQL database storing cloud terms with <strong>Point-in-Time Recovery (PITR)</strong> enabled for data safety.</li>
   <li><strong>AWS Amplify:</strong> Hosts the frontend and manages automatic CI/CD pipelines via GitHub integration.</li>
   <li><strong>Amazon API Gateway:</strong> Acts as the secure entry point for the frontend to communicate with the Lambda backend.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="use-cases">Use Cases</h2>
<ul>
   <li><strong>Developer Onboarding:</strong> A quick-reference tool for new engineers to learn internal or cloud-specific terminology.</li>
   <li><strong>CI/CD Pattern Template:</strong> A reference architecture for triggering frontend builds based on infrastructure changes.</li>
   <li><strong>Serverless Learning:</strong> A perfect project to understand CORS, IAM least-privilege, and NoSQL data normalization.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="architecture">Architecture</h2>
<ol>
    <li><strong>Request:</strong> User enters a term in the React UI.</li>
    <li><strong>Normalization:</strong> Both Frontend and Lambda convert input to UPPERCASE to ensure case-insensitive matching against the database.</li>
    <li><strong>Route:</strong> API Gateway forwards the GET request to the Lambda function.</li>
    <li><strong>Fetch:</strong> Lambda queries DynamoDB using the "Term" Partition Key.</li>
    <li><strong>Build Trigger:</strong> Terraform uses a null_resource and curl to trigger an Amplify build whenever the API URL changes.</li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="file-structure">File Structure</h2>
<pre>AWS-TERRAFORM-CLOUD-DICTIONARY/
├── 📁 .github/                   # GitHub Action workflows or metadata
├── 📁 .terraform/                # Terraform working directory (initialized providers)
├── 📁 assets/                    # Project documentation images and diagrams
├── 📁 frontend/                  # React.js web application [cite: 19, 20]
│   ├── 📁 node_modules/          # Frontend dependencies
│   ├── 📁 public/                # Static assets (favicon, index.html)
│   ├── 📁 src/                   # React source code
│   │   ├── App.css               # Styling for the dictionary UI
│   │   ├── App.js                # Main logic for search and API calls
│   │   ├── index.css             # Global base styles
│   │   └── index.js              # React entry point
│   ├── .gitignore                # Frontend-specific git ignore rules
│   ├── package-lock.json         # Locked versions of npm dependencies
│   ├── package.json              # Frontend scripts and dependency list
│   └── README.md                 # Frontend-specific documentation
├── 📁 lambda/                    # Serverless backend logic [cite: 26]
│   ├── index.py                  # Python script for dictionary search logic
│   ├── lambda_function.zip       # Deployment package created by Terraform [cite: 26]
│   └── .gitignore                # Lambda-specific git ignore rules
├── .terraform.lock.hcl           # Terraform dependency lock file
├── amplify.tf                    # AWS Amplify hosting & build triggers 
├── amplify.yml                   # Amplify build specification 
├── api_gateway.tf                # REST API endpoints & Lambda integration [cite: 22, 23]
├── database.tf                   # DynamoDB table & item definitions [cite: 33, 34]
├── lambda.tf                     # Lambda function config & IAM roles [cite: 27]
├── main.tf                       # AWS provider configuration 
├── outputs.tf                    # Defined output values (API URLs, etc.)
├── README.template.md            # Template for generating project documentation
├── terraform.tf                  # Terraform version requirements
├── terraform.tfstate             # Current state of your live infrastructure
├── terraform.tfstate.backup      # Previous state for recovery
└── variables.tf                  # Input variables for GitHub tokens and regions
</pre>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="getting-started">Getting Started</h2>
<h3>Prerequisites</h3>
<ul>
    <li>AWS CLI configured.</li>
    <li>Terraform Cloud Account / Terraform Local CLI installed</li>
    <li>Set to whatever <code>aws_region</code> you want in <code>variables.tf</code>.</li>
    <li>A GitHub Personal Access Token (for Amplify access).</li>
</ul>

<h3>Deployment</h3>
<ol>
   <li>Clone the repository.</li>
   <li>Initialize Terraform: <code>terraform init</code></li>
   <li>Deploy the stack: <code>terraform apply -var="github_token=your_token"</code></li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="usage">Usage & Testing</h2>
<ol>
   <li><strong>Access the App:</strong> Use the Amplify URL provided in the Terraform outputs.</li>
   <li><strong>Search:</strong> Enter a term like <code>S3</code> or <code>nat gateway</code>. Note how the app handles spaces and casing automatically.</li>
   <li><strong>Verify Logs:</strong> Check <strong>CloudWatch Log Groups</strong> at <code>/aws/lambda/CloudDictionaryHandler</code> to see the search execution path and hits/misses.</li>
   <li><strong>Trigger Build:</strong> Change an environment variable in <code>amplify.tf</code> and run <code>terraform apply</code>; observe the <code>null_resource</code> triggering a fresh Amplify deployment.</li>
</ol>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="roadmap">Roadmap</h2>
<ul>
   <li>[x] <strong>Data Normalization:</strong> Implemented upper() conversion in Terraform and Python.</li>
   <li>[x] <strong>Disaster Recovery:</strong> Enabled Point-in-Time Recovery for DynamoDB.</li>
   <li>[x] <strong>Logging:</strong> Added detailed CloudWatch logging for search debugging.</li>
   <li>[ ] <strong>Fuzzy Search:</strong> Implement DynamoDB Scan with FilterExpressions for partial word matching.</li>
   <li>[ ] <strong>Auth:</strong> Add Amazon Cognito for private dictionary access.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="challenges">Challenges</h2>
<table>
   <thead>
      <tr>
         <th>Challenge</th>
         <th>Solution</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td><strong>Case Sensitivity</strong></td>
         <td>Standardized all database keys and queries to UPPERCASE using Terraform's <code>upper()</code> and Python's <code>.upper()</code>.</td>
      </tr>
      <tr>
         <td><strong>Amplify De-sync</strong></td>
         <td>Created a <code>null_resource</code> with a <code>timestamp()</code> trigger to force-execute a <code>curl</code> webhook whenever infrastructure changes.</td>
      </tr>
      <tr>
         <td><strong>CORS Errors</strong></td>
         <td>Configured explicit <code>Access-Control-Allow-Origin</code> headers in the Lambda response and API Gateway.</td>
      </tr>
   </tbody>
</table>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>
<h2 id="cost-optimization">Cost Optimization</h2>
<ul>
   <li><strong>On-Demand Scaling:</strong> DynamoDB set to <code>PAY_PER_REQUEST</code> to eliminate costs during idle time.</li>
   <li><strong>Log Retention:</strong> CloudWatch logs are capped at 7 days to prevent storage cost accumulation.</li>
   <li><strong>Memory Tuning:</strong> Lambda function restricted to 128MB (minimal cost) since the search logic is lightweight.</li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

<h2 id="acknowledgements">Acknowledgements</h2>
<p>
  Special thanks to <strong>Tech with Lucy</strong> for the architectural inspiration and excellent AWS tutorials that helped shape this pipeline.
</p>
<ul>
  <li>
    See her youtube channel here: <a href="https://www.youtube.com/@TechwithLucy" target="_blank">Tech With Lucy</a>
  </li>
  <li>
    Watch her video here: <a href="https://www.youtube.com/watch?v=0hJxcBdRlYw" target="_blank">5 Intermediate AWS Cloud Projects To Get You Hired (2025)</a>
  </li>
</ul>
<div align="right"><a href="#readme-top">↑ Back to Top</a></div>

[contributors-shield]: https://img.shields.io/github/contributors/{{REPO_NAME}}.svg?style=for-the-badge
[contributors-url]: https://github.com/{{REPO_NAME}}/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/{{REPO_NAME}}.svg?style=for-the-badge
[forks-url]: https://github.com/{{REPO_NAME}}/network/members
[stars-shield]: https://img.shields.io/github/stars/{{REPO_NAME}}.svg?style=for-the-badge
[stars-url]: https://github.com/{{REPO_NAME}}/stargazers
[issues-shield]: https://img.shields.io/github/issues/{{REPO_NAME}}.svg?style=for-the-badge
[issues-url]: https://github.com/{{REPO_NAME}}/issues
[license-shield]: https://img.shields.io/github/license/{{REPO_NAME}}.svg?style=for-the-badge
[license-url]: https://github.com/{{REPO_NAME}}/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/si-kai-tan
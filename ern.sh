#!/bin/bash

# Get repo name
echo -n "Enter repository name: "
read repo_name

# Create folder for the repo
mkdir "$repo_name"
cd "$repo_name"

# Create client folder and initialize React app
npm i react-scripts
npx create-react-app client

# Create server folder and subdirectories
mkdir server
cd server
mkdir models middleware controllers routes

# Add server.js file
touch server.js

# Install dependencies
npm init -y
npm install express
cd ..
cd client
npm init -y
npm install axios react-router-dom 


#!/bin/bash

# Deployment script for GrooveScribe to GitHub Pages
# Usage: ./deploy-to-github-pages.sh

set -e

GITHUB_PAGES_REPO="https://github.com/marctc/marctc.github.io.git"
TEMP_DIR="/tmp/marctc-github-pages"
SOURCE_DIR="/home/marctc/workspace/GrooveScribe"

echo "🚀 Deploying GrooveScribe to GitHub Pages..."

# Clean up any existing temp directory
rm -rf "$TEMP_DIR"

# Clone the GitHub Pages repository
echo "📥 Cloning GitHub Pages repository..."
git clone "$GITHUB_PAGES_REPO" "$TEMP_DIR"
cd "$TEMP_DIR"

# Create or clean the gscribe directory
echo "🧹 Preparing gscribe directory..."
rm -rf gscribe
mkdir -p gscribe

# Copy GrooveScribe files (excluding unnecessary ones)
echo "📋 Copying GrooveScribe files..."
rsync -av --exclude='cordova/' \
         --exclude='jstools/' \
         --exclude='*.bat' \
         --exclude='SOURCE_CODE_README.md' \
         --exclude='.git/' \
         --exclude='deploy-to-github-pages.sh' \
         "$SOURCE_DIR/" gscribe/

# Add, commit, and push
echo "📤 Committing and pushing changes..."
git add .
git commit -m "Update GrooveScribe - $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"
git push origin main

echo "✅ Deployment complete!"
echo "🌐 Your GrooveScribe should be available at: https://marctc.github.io/gscribe/"

# Clean up
rm -rf "$TEMP_DIR"

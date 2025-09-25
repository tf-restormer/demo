#!/bin/bash

# GitHub Pages Deployment Script for TF-Restormer Demo
# Run with: bash deploy_github_pages.sh

echo "=== TF-Restormer Demo Anonymous Deployment ==="
echo ""
echo "Before running this script:"
echo "1. Create anonymous GitHub account using:"
echo "   - VPN/Tor for privacy"
echo "   - Temporary email (temp-mail.org, guerrillamail.com)"
echo "   - Username unrelated to your identity"
echo ""
echo "2. Create new repository named 'tf-restormer-demo'"
echo ""
read -p "Have you completed these steps? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Please complete the setup first."
    exit 1
fi

# Clean metadata from images
echo "Cleaning image metadata..."
if command -v exiftool &> /dev/null; then
    find ./img -type f \( -name "*.png" -o -name "*.jpg" \) -exec exiftool -all= -overwrite_original {} \;
else
    echo "Warning: exiftool not found. Please install it to remove image metadata."
fi

# Create .nojekyll file for proper serving
touch .nojekyll

# Initialize git if needed
if [ ! -d .git ]; then
    git init
fi

# Get anonymous username
read -p "Enter your anonymous GitHub username: " ANON_USERNAME

# Add remote
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/${ANON_USERNAME}/tf-restormer-demo.git"

# Create gh-pages branch
git checkout -b gh-pages 2>/dev/null || git checkout gh-pages

# Add all files
git add .
git commit -m "Deploy TF-Restormer demo"

# Push to GitHub
echo ""
echo "Ready to push. Your demo will be available at:"
echo "https://${ANON_USERNAME}.github.io/tf-restormer-demo/"
echo ""
read -p "Push to GitHub? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push -u origin gh-pages
    echo ""
    echo "✅ Deployment complete!"
    echo "🌐 Your demo will be available at: https://${ANON_USERNAME}.github.io/tf-restormer-demo/"
    echo "⏱️  Note: It may take a few minutes for GitHub Pages to build and deploy."
else
    echo "Deployment cancelled."
fi
# TF-Restormer Demo Deployment Checklist

## Pre-Deployment Anonymization

### 1. Remove Personal Information
- [ ] Remove all author names from HTML
- [ ] Remove email addresses
- [ ] Remove institution names
- [ ] Check meta tags for identifying information
- [ ] Remove any comments with personal info

### 2. Clean File Metadata
```bash
# Remove EXIF data from images
exiftool -all= -overwrite_original img/*.png
exiftool -all= -overwrite_original img/*.jpg

# Check for hidden metadata in audio files
ffmpeg -i input.wav -map_metadata -1 -c:a copy output.wav
```

### 3. Sanitize JavaScript
- [ ] Remove console.log statements with identifying info
- [ ] Remove any tracking/analytics code
- [ ] Remove any API keys or endpoints

### 4. File Structure
```
tf_restormer_demo/
├── index.html
├── css/
│   └── style.css
├── js/
│   ├── script.js
│   ├── tab.js
│   ├── nav_menu.js
│   └── image.js
├── img/
│   └── [architecture images]
└── samples/
    └── [audio samples]
```

## Deployment Options

### Option 1: GitHub Pages (Recommended)
```bash
# Create anonymous GitHub account
# Use VPN for additional privacy
# Use temporary email service

# Create new repository
git init
git remote add origin https://github.com/[anon-username]/tf-restormer-demo.git

# Add .nojekyll file for proper serving
touch .nojekyll

# Push to gh-pages branch
git checkout -b gh-pages
git add .
git commit -m "Initial demo"
git push -u origin gh-pages

# Access at: https://[anon-username].github.io/tf-restormer-demo/
```

### Option 2: Netlify Drop
1. Prepare files:
```bash
cd /data1/projects/ICLR26-TF-Restormer/
zip -r tf_restormer_demo.zip tf_restormer_demo/
```

2. Visit https://app.netlify.com/drop
3. Drag and drop the zip file
4. Get instant URL (e.g., https://amazing-euler-a1b2c3.netlify.app)

### Option 3: Surge.sh
```bash
# Install surge
npm install -g surge

# Deploy (use anonymous email)
cd tf_restormer_demo/
surge

# Choose a random subdomain
# e.g., tf-restormer-2024.surge.sh
```

### Option 4: Anonymous4Open (Already in use)
- Continue using: https://anonymous.4open.science/r/TF_Restormer-FD7D
- Add demo link to the repository

## Post-Deployment

### Security Headers (for GitHub Pages)
Create `_headers` file:
```
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: no-referrer
  Permissions-Policy: interest-cohort=()
```

### Test Anonymity
1. Check page source for any identifying information
2. Use different browser/incognito mode
3. Check network requests for any leaks
4. Verify no cookies are set
5. Test all audio samples load correctly

## Quick Deploy Script

```bash
#!/bin/bash
# deploy_anonymous.sh

# Clean metadata
find ./img -type f \( -name "*.png" -o -name "*.jpg" \) -exec exiftool -all= -overwrite_original {} \;

# Create deployment package
tar -czf demo_package.tar.gz \
  --exclude='*.git*' \
  --exclude='deployment_checklist.md' \
  --exclude='deploy_anonymous.sh' \
  tf_restormer_demo/

echo "Package ready for deployment: demo_package.tar.gz"
echo "Options:"
echo "1. Upload to Netlify Drop"
echo "2. Extract and push to anonymous GitHub"
echo "3. Deploy with Surge.sh"
```

## Additional Considerations

### For Conference Review
- Use the conference's recommended platform if specified
- Some conferences provide their own anonymous hosting
- Keep URL private until review process complete

### For Public Demo
- Consider CDN for better global performance
- Add cache headers for static assets
- Compress audio files appropriately
- Consider fallback audio formats

### Maintenance
- Keep local backup of all files
- Document the deployment URL in private notes
- Set calendar reminder to renew hosting if needed
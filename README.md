# IFT Test - How to Get Shareable Links

This repository contains an interactive quiz/exam application (`ift.html`). This guide explains how to get shareable links that anyone can use to open files directly.

## 📋 Quick Links for ift.html

### Option 1: GitHub Pages (Recommended for HTML files)
**Best for**: Sharing interactive HTML files that run in the browser

1. Enable GitHub Pages:
   - Go to repository Settings → Pages
   - Select branch (e.g., `main` or `copilot/get-direct-file-link`)
   - Save

2. Your file will be available at:
   ```
   https://deutschmark-lms.github.io/ift-test/ift.html
   ```

### Option 2: Raw GitHub Link
**Best for**: Direct file download or embedding

```
https://raw.githubusercontent.com/DeutschMark-LMS/ift-test/main/ift.html
```

**Note**: Replace `main` with your branch name if using a different branch.

### Option 3: GitHub File View
**Best for**: Viewing file in GitHub interface

```
https://github.com/DeutschMark-LMS/ift-test/blob/main/ift.html
```

### Option 4: jsdelivr CDN (Fast, Global CDN)
**Best for**: Production use, fast loading times

```
https://cdn.jsdelivr.net/gh/DeutschMark-LMS/ift-test@main/ift.html
```

**Features**:
- Global CDN with caching
- Faster load times
- Can specify versions using `@tag` or `@branch`

### Option 5: GitHack (Raw files served with correct MIME types)
**Best for**: Testing HTML files quickly without setting up GitHub Pages

```
https://raw.githack.com/DeutschMark-LMS/ift-test/main/ift.html
```

**Production version** (cached):
```
https://rawcdn.githack.com/DeutschMark-LMS/ift-test/main/ift.html
```

## 🛠️ Using the Link Generator Script

We've included a utility script that automatically generates all these links for you:

```bash
# Make the script executable
chmod +x generate-links.sh

# Run it
./generate-links.sh ift.html
```

Or with Python:
```bash
python3 generate-links.py ift.html
```

## 🔧 Which Link Should I Use?

| Use Case | Recommended Option | Why? |
|----------|-------------------|------|
| Share interactive HTML | GitHub Pages or GitHack | Runs JavaScript properly |
| Direct file download | Raw GitHub Link | Direct file access |
| Embed in another site | jsdelivr CDN | Fast, reliable, cached |
| View code | GitHub File View | See with syntax highlighting |
| Quick testing | GitHack | No setup needed |

## 📝 Important Notes

1. **GitHub Pages**: Requires one-time setup but provides the best experience for HTML files
2. **Raw links**: May not execute JavaScript in some contexts
3. **CDN links**: Great for production, includes caching and global distribution
4. **Branch names**: Always verify your branch name (could be `main`, `master`, or a custom branch)

## 🚀 Getting Started

For the `ift.html` file in this repository:

1. **Quickest option**: Use GitHack (no setup required)
   - https://raw.githack.com/DeutschMark-LMS/ift-test/main/ift.html

2. **Best long-term option**: Enable GitHub Pages
   - Go to Settings → Pages → Select your branch → Save
   - Then use: https://deutschmark-lms.github.io/ift-test/ift.html

## 🤝 Contributing

Feel free to improve this guide or the link generator scripts!

## 📄 License

This project and its contents are available for use as specified by the repository owner.

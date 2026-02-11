#!/bin/bash

# Link Generator for GitHub Repository Files
# Generates various types of shareable links for files in a GitHub repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Function to get git repository info
get_git_info() {
    # Get remote URL
    REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")
    
    if [ -z "$REMOTE_URL" ]; then
        print_color $RED "❌ Error: Not a git repository or no remote configured"
        exit 1
    fi
    
    # Parse GitHub URL (handle both HTTPS and SSH)
    if [[ $REMOTE_URL == https://github.com/* ]]; then
        REPO_PATH=${REMOTE_URL#https://github.com/}
        REPO_PATH=${REPO_PATH%.git}
    elif [[ $REMOTE_URL == git@github.com:* ]]; then
        REPO_PATH=${REMOTE_URL#git@github.com:}
        REPO_PATH=${REPO_PATH%.git}
    else
        print_color $RED "❌ Error: Remote is not a GitHub repository"
        exit 1
    fi
    
    # Split owner and repo
    OWNER=$(echo $REPO_PATH | cut -d'/' -f1)
    OWNER_LOWER=$(echo $OWNER | tr '[:upper:]' '[:lower:]')
    REPO=$(echo $REPO_PATH | cut -d'/' -f2)
    
    # Get current branch
    BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
}

# Function to generate and print links
generate_links() {
    local filename=$1
    
    # Generate all links
    local github_view="https://github.com/$OWNER/$REPO/blob/$BRANCH/$filename"
    local raw_link="https://raw.githubusercontent.com/$OWNER/$REPO/$BRANCH/$filename"
    local github_pages="https://$OWNER_LOWER.github.io/$REPO/$filename"
    local jsdelivr="https://cdn.jsdelivr.net/gh/$OWNER/$REPO@$BRANCH/$filename"
    local githack_dev="https://raw.githack.com/$OWNER/$REPO/$BRANCH/$filename"
    local githack_prod="https://rawcdn.githack.com/$OWNER/$REPO/$BRANCH/$filename"
    
    echo ""
    print_color $BLUE "======================================================================"
    print_color $GREEN "📎 SHAREABLE LINKS FOR: $filename"
    print_color $BLUE "======================================================================"
    echo ""
    
    echo "🔗 GitHub File View:"
    echo "   $github_view"
    echo ""
    
    echo "🔗 Raw GitHub Link:"
    echo "   $raw_link"
    echo ""
    
    echo "🔗 GitHub Pages:"
    echo "   $github_pages"
    echo ""
    
    echo "🔗 jsdelivr CDN:"
    echo "   $jsdelivr"
    echo ""
    
    echo "🔗 GitHack (Development):"
    echo "   $githack_dev"
    echo ""
    
    echo "🔗 GitHack (Production):"
    echo "   $githack_prod"
    echo ""
    
    print_color $BLUE "======================================================================"
    echo ""
    print_color $YELLOW "💡 RECOMMENDATIONS:"
    echo ""
    echo "   • For HTML files: Use GitHub Pages or GitHack"
    echo "   • For downloads: Use Raw GitHub Link"
    echo "   • For production: Use jsdelivr CDN"
    echo "   • For code review: Use GitHub File View"
    echo ""
    print_color $BLUE "======================================================================"
    echo ""
    
    # Export for use in show_html_notes
    GITHACK_DEV_LINK="$githack_dev"
    GITHUB_PAGES_LINK="$github_pages"
}

# Function to show special notes for HTML files
show_html_notes() {
    local filename=$1
    
    if [[ $filename == *.html ]]; then
        print_color $GREEN "📄 HTML FILE DETECTED"
        print_color $BLUE "======================================================================"
        echo ""
        print_color $YELLOW "🚀 Quick Start for HTML:"
        echo "   1. Instant use: $GITHACK_DEV_LINK"
        echo ""
        echo "   2. Best option (requires setup):"
        echo "      - Enable GitHub Pages in repository settings"
        echo "      - Then use: $GITHUB_PAGES_LINK"
        echo ""
        print_color $BLUE "======================================================================"
        echo ""
    fi
}

# Main script
main() {
    if [ $# -eq 0 ]; then
        print_color $RED "Usage: ./generate-links.sh <filename>"
        echo ""
        echo "Example: ./generate-links.sh ift.html"
        exit 1
    fi
    
    local filename=$1
    
    # Check if file exists
    if [ ! -f "$filename" ]; then
        print_color $YELLOW "⚠️  Warning: File '$filename' not found in current directory."
        echo "   Links will still be generated, but verify the filename is correct."
        echo ""
    fi
    
    # Get git repository information
    get_git_info
    
    echo ""
    print_color $GREEN "📦 Repository: $OWNER/$REPO"
    print_color $GREEN "🌿 Branch: $BRANCH"
    
    # Generate and print links
    generate_links "$filename"
    
    # Show special notes for HTML files
    show_html_notes "$filename"
}

# Run main function
main "$@"

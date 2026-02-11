#!/usr/bin/env python3
"""
Link Generator for GitHub Repository Files

This script generates various types of shareable links for files in a GitHub repository.
"""

import sys
import subprocess
import os


def get_git_info():
    """Extract repository information from git configuration."""
    try:
        # Get remote URL
        remote_url = subprocess.check_output(
            ['git', 'config', '--get', 'remote.origin.url'],
            stderr=subprocess.DEVNULL
        ).decode('utf-8').strip()
        
        # Parse GitHub URL
        # Handle both HTTPS and SSH URLs
        if remote_url.startswith('https://github.com/'):
            repo_path = remote_url.replace('https://github.com/', '').replace('.git', '')
        elif remote_url.startswith('git@github.com:'):
            repo_path = remote_url.replace('git@github.com:', '').replace('.git', '')
        else:
            return None, None, None
        
        # Split owner and repo
        parts = repo_path.split('/')
        if len(parts) != 2:
            return None, None, None
        
        owner, repo = parts
        
        # Get current branch
        try:
            branch = subprocess.check_output(
                ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
                stderr=subprocess.DEVNULL
            ).decode('utf-8').strip()
        except:
            branch = 'main'
        
        return owner, repo, branch
    
    except (subprocess.CalledProcessError, FileNotFoundError, ValueError) as e:
        print(f"Error getting git info: {e}", file=sys.stderr)
        return None, None, None


def generate_links(filename, owner, repo, branch):
    """Generate various shareable links for the given file."""
    
    links = {
        "GitHub File View": f"https://github.com/{owner}/{repo}/blob/{branch}/{filename}",
        "Raw GitHub Link": f"https://raw.githubusercontent.com/{owner}/{repo}/{branch}/{filename}",
        "GitHub Pages": f"https://{owner.lower()}.github.io/{repo}/{filename}",
        "jsdelivr CDN": f"https://cdn.jsdelivr.net/gh/{owner}/{repo}@{branch}/{filename}",
        "GitHack (Development)": f"https://raw.githack.com/{owner}/{repo}/{branch}/{filename}",
        "GitHack (Production)": f"https://rawcdn.githack.com/{owner}/{repo}/{branch}/{filename}",
    }
    
    return links


def print_links(filename, links):
    """Print the generated links in a formatted way."""
    
    print("\n" + "=" * 70)
    print(f"📎 SHAREABLE LINKS FOR: {filename}")
    print("=" * 70 + "\n")
    
    for name, url in links.items():
        print(f"🔗 {name}:")
        print(f"   {url}\n")
    
    print("=" * 70)
    print("\n💡 RECOMMENDATIONS:\n")
    print("   • For HTML files: Use GitHub Pages or GitHack")
    print("   • For downloads: Use Raw GitHub Link")
    print("   • For production: Use jsdelivr CDN")
    print("   • For code review: Use GitHub File View")
    print("\n" + "=" * 70 + "\n")


def main():
    """Main function to run the link generator."""
    
    if len(sys.argv) < 2:
        print("Usage: python3 generate-links.py <filename>")
        print("\nExample: python3 generate-links.py ift.html")
        sys.exit(1)
    
    filename = sys.argv[1]
    
    # Check if file exists
    if not os.path.exists(filename):
        print(f"⚠️  Warning: File '{filename}' not found in current directory.")
        print("   Links will still be generated, but verify the filename is correct.\n")
    
    # Get git repository information
    owner, repo, branch = get_git_info()
    
    if not owner or not repo:
        print("❌ Error: Could not determine GitHub repository information.")
        print("   Make sure you're in a git repository with a GitHub remote.")
        sys.exit(1)
    
    print(f"\n📦 Repository: {owner}/{repo}")
    print(f"🌿 Branch: {branch}")
    
    # Generate and print links
    links = generate_links(filename, owner, repo, branch)
    print_links(filename, links)
    
    # Special note for HTML files
    if filename.endswith('.html'):
        print("📄 HTML FILE DETECTED")
        print("=" * 70)
        print("\n🚀 Quick Start for HTML:")
        print(f"   1. Instant use: {links['GitHack (Development)']}")
        print(f"\n   2. Best option (requires setup):")
        print(f"      - Enable GitHub Pages in repository settings")
        print(f"      - Then use: {links['GitHub Pages']}")
        print("\n" + "=" * 70 + "\n")


if __name__ == "__main__":
    main()

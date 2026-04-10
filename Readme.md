# nnag.duckdns.org — personal portfolio

[![Live](https://img.shields.io/website?url=https%3A%2F%2Fnnag.duckdns.org&label=live&up_message=online&down_message=offline)](https://nnag.duckdns.org)

Static site built with Hugo. No theme dependency. Served by Caddy.

## Requirements

- Hugo extended v0.146.0+
- Caddy serving from `/var/www/portfolio/public`

Install Hugo:

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.146.0/hugo_extended_0.146.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.146.0_linux-amd64.deb
```

## Usage

```bash
make init      # first-time setup, checks dependencies
make build     # build into /var/www/portfolio/public
make dev       # local dev server at localhost:1313 with drafts
make deploy    # clean + build
make clean     # wipe build artifacts
```

## Structure

```
layouts/
  _default/
    baseof.html   # base template, nav and footer
    list.html     # posts and projects list pages
    single.html   # individual post/project page
  index.html      # homepage
static/
  css/main.css    # all styles, no framework
  img/avatar.jpg  # profile photo
  cv.pdf          # CV
content/
  projects/       # project markdown files
  posts/          # writing
  about.md
hugo.toml
```

## Adding a project

Create `content/projects/your-project.md`:

```yaml
---
title: "project-name"
date: 2024-01-01
category: "oran"       # or "tooling"
featured: false        # true gives highlighted border
tags: ["Go", "O-RAN"]
summary: "One sentence description shown on the homepage."
externalUrl: "https://github.com/motangpuar/your-repo"
---

Full description here in Markdown.
```

Then `make build`.

## Adding a post

```bash
# Create the file
cat > content/posts/my-post.md << 'EOF'
---
title: "Post title"
date: 2024-01-01
tags: ["tag1", "tag2"]
summary: "One sentence shown in the post list."
draft: false
---

Content here.
EOF

make build
```

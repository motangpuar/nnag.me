    # nnag.me — personal portfolio

[![Live](https://img.shields.io/website?url=https%3A%2F%2Fnnag.duckdns.org&label=live&up_message=online&down_message=offline)](https://nnag.duckdns.org)

Static site built with Hugo. No theme dependency. Served by Caddy on a self-hosted VPS.

## Requirements

- Hugo extended v0.146.0+
- Caddy serving from `/var/www/portfolio/public`
- Podman (optional, for local testing)

Install Hugo:

```bash
wget https://github.com/gohugoio/hugo/releases/download/v0.146.0/hugo_extended_0.146.0_linux-amd64.deb
sudo dpkg -i hugo_extended_0.146.0_linux-amd64.deb
```

## Usage

```bash
make init        # first-time setup, checks dependencies
make build       # build into /var/www/portfolio/public
make dev         # local dev server at localhost:1313 with drafts
make local-test  # podman-based local preview (hugomods/hugo:exts-0.146.0)
make deploy      # clean + build
make clean       # wipe build artifacts
```

## Structure

```
layouts/
  _default/
    baseof.html              # base template, nav, footer, JS
    list.html                # posts and projects list pages
    single.html              # individual post/project page
  _markup/
    render-image.html        # custom image render hook (captions, width control)
  shortcodes/
    repo.html                # repo card shortcode
    repogroup.html           # grid wrapper for repo cards
    ref.html                 # reference entry shortcode
    refs.html                # references section wrapper
    cite.html                # inline citation shortcode
  index.html                 # homepage
static/
  css/main.css               # all styles, no framework, dark mode via prefers-color-scheme
  img/                       # images and profile photo
  cv.pdf                     # CV
content/
  projects/                  # long-form project write-ups
  posts/                     # writing, field notes, cross-cutting topics
  about.md
hugo.toml
Makefile
```

## Content plan

```
projects/
  smo-o2.md          ← Thesis: Automated CI/CD for O-RAN via O2 (featured, featuredOrder=1)
  o2-ims-api.md      ← O2 IMS stack: API + worker + UI (featured, featuredOrder=2)
  netra.md           ← VNF management platform: CLI + dashboard + backend (featured, featuredOrder=3)
  wireguard.md       ← Self-hosted WireGuard manager: Django + Svelte (featured, featuredOrder=4)
  ptp-agent.md       ← tooling
  python-redfish-provisioner.md  ← tooling
  portable-okd-jumphost.md       ← tooling
  kubeconfig-generator.md        ← tooling

posts/
  o2-interface-explained.md      ← What lives between the SMO and the O-Cloud
  starlingx-okd-what-breaks.md   ← SR-IOV, DPDK, RT kernel field notes
  f1ap-integration-oai-osc.md    ← Test results and failures
  cicd-lab-setup-oran.md         ← CI/CD lab build notes (from oran-cicd-lab)
```

## Featured project frontmatter

```yaml
---
title: "Full descriptive title of the work"
date: 2024-01-01
featured: true
featuredOrder: 1
eyebrow: "M.Sc. thesis — NTUST 2024"
category: "oran"
tags: ["Python", "O-RAN"]
summary: "One paragraph shown on the homepage."
externalUrl: "https://github.com/motangpuar/your-repo"
---
```

## Adding a project write-up

Create `content/projects/your-project.md` with full long-form content. Use shortcodes to embed repo cards and references inline.

```markdown
---
title: "Your project title"
date: 2024-01-01
category: "tooling"
tags: ["Go", "Kubernetes"]
summary: "One sentence shown on the homepage card."
externalUrl: "https://github.com/motangpuar/your-repo"
---

Write the story here. Why the problem exists, what you built, what broke.

{{< repogroup >}}
{{< repo name="your-repo" url="https://github.com/motangpuar/your-repo" desc="Short description." tags="Go,Kubernetes" >}}
{{< /repogroup >}}

{{< refs >}}
{{< ref id="some-ref" text="Author. Title, Year." url="https://example.com" >}}
{{< /refs >}}
```

## Shortcode reference

**Repo card** — links to a GitHub repo with tags:
```
{{< repo name="repo-name" url="https://github.com/..." desc="Description." tags="Tag1,Tag2" >}}
```

**Repo group** — renders cards in a 2-column grid:
```
{{< repogroup >}}
{{< repo ... >}}
{{< repo ... >}}
{{< /repogroup >}}
```

**Inline citation** — superscript link to a reference entry:
```
The O2 interface {{< cite id="oran-arch" >}} sits between the SMO and the O-Cloud.
```

**Reference entry** — numbered automatically by JS at render time:
```
{{< refs >}}
{{< ref id="oran-arch" text="O-RAN Alliance. Architecture Description, 2023." url="https://o-ran.org" >}}
{{< /refs >}}
```

**Image with caption and optional width:**
```markdown
![Alt text](/img/image.png "Caption text")
![Alt text](/img/image.png "width=480")
```

## Adding a post

```bash
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

# Workshop Conventions

## Repository Purpose

This workshop teaches application basics on a shared OpenShift cluster.
Students build one web app from a Pod to an Argo CD Application.
Each student has one namespace. Students are not cluster-admin.

## Structure

- `documentation/` contains all AsciiDoc courseware content (Antora component)
- `documentation/modules/ROOT/pages/` contains the course pages in `.adoc` format
- YAML manifests live in the root step directories
- `instructor/` holds the progress ConfigMap, `progress.sh`, the namespace file, and the instructor notes
- `01-pods/` Pod manifests for the first lab
- `02-deploy/` Deployment and Service
- `03-ingress/` Ingress and Route
- `04-config/` ConfigMap, Secret, and the Deployment that mounts them
- `05-resources/` Deployment with requests, limits, and probes
- `06-gitops/` Application custom resource
- `gitops/` manifests that OpenShift GitOps syncs
- Steps are progressive: each builds on the previous one
- Tenancy for this workshop: shared cluster

## AsciiDoc Formatting

- `index.adoc` is a module picker. Each `[.tile]` has a title, one sentence, and a time
- `00-setup.adoc` and every exercise page set `:page-time:` to an integer number of minutes
- State the same time in the first sentence: `Time: N minutes.`
- Every numbered step must have a *What* and *Why* pair in bold
- Every step must have a collapsible verification block
- Every exercise page ends with a `[.verification]` question and a progress command, before Reset
- Use `[.console-input]` before source blocks for commands
- Use `[.console-output]` before source blocks showing expected output
- Reference YAML manifests by file path in `oc apply -f` commands
- Do not use em dashes. Use regular dashes (`-`) instead
- Use `'''` for horizontal rules between steps
- Cross-reference other pages with `xref:page.adoc[Label]`
- External links use `link:URL[Label]`
- Use `NOTE:`, `TIP:`, `IMPORTANT:`, `WARNING:` admonitions
- All doc links must point to `docs.redhat.com` or `docs.openshift.com`
- Use attributes from `_attributes.adoc` for version numbers

## CLI Conventions

- Every `oc` command must include an explicit `--context` flag
- Never use `oc login` inside step pages
- YAML files with `${VARIABLE}` placeholders use `envsubst`
- All workshop variables are exported once in `00-setup.adoc`

## Content Rules

- Never include customer names, user names, or email addresses
- All content must be in English
- Prefer `registry.access.redhat.com` or `registry.redhat.io` images
- Use Red Hat / OpenShift-native components when they cover the use case
- Mention Red Hat products because they fit the solution, not to promote them

## YAML Conventions

- Every YAML file starts with a comment block: filename and purpose
- Use `app.kubernetes.io/part-of: openshift-app-basics` label consistently
- Include resource requests and limits on Deployments
- Include readiness and liveness probes where applicable

# Security Policy

The code-server team (and Coder, the organization) care a lot about keeping the project secure and safe for end-users.

## Tools

We use a combination of tools to help us stay on top of vulnerabilities.

- [dependabot](https://dependabot.com/)
  - Submits pull requests to upgrade dependencies. We use dependabot's version upgrades as well as security updates.
- code-scanning
  - [CodeQL](https://securitylab.github.com/tools/codeql/)
    - Semantic code analysis engine that runs on a regular schedule (see `codeql-analysis.yml`)
  - [trivy](https://github.com/aquasecurity/trivy)
    - Comprehensive vulnerability scanner that runs on PRs into the default branch and scans both our container image and repository code (see `trivy-scan-repo` and `trivy-scan-image` jobs in `ci.yaml`)
- [`audit-ci`](https://github.com/IBM/audit-ci)
  - Audits npm and Yarn dependencies in CI (see "Audit for vulnerabilities" step in `ci.yaml`) on PRs into the default branch and fails CI if moderate or higher vulnerabilities(see the `audit.sh` script) are present.

## Supported Versions

Coder sponsors development and maintenance of the code-server project. We will fix security issues within 90 days of receiving a report, and publish the fix in a subsequent release. The code-server project does not provide backports or patch releases for security issues at this time.

| Version                                               | Supported          |
| ----------------------------------------------------- | ------------------ |
| [Latest](https://github.com/Wromo/sv-code-server/releases) | :white_check_mark: |

## Reporting a Vulnerability

To report a vulnerability, please send an email to security[@]coder.com and our security team will respond to you.

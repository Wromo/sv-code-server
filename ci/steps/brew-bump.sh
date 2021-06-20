#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  # Only sourcing this so we get access to $VERSION
  source ./ci/lib.sh

  # NOTE: we need to make sure Wromoci/homebrew-core
  # is up-to-date
  # otherwise, brew bump-formula-pr will use an
  # outdated base
  echo "Cloning Wromoci/homebrew-core"
  git clone https://github.com/Wromoci/homebrew-core.git

  echo "Changing into homebrew-core directory"
  cd homebrew-core && pwd

  echo "Adding Homebrew/homebrew-core as $(upstream)"
  git remote add upstream https://github.com/Homebrew/homebrew-core.git

  echo "Fetching upstream commits..."
  git fetch upstream

  echo "Merging in latest changes"
  git merge upstream/master

  echo "Pushing changes to Wromoci/homebrew-core fork on GitHub"
  # Source: https://serverfault.com/a/912788
  # shellcheck disable=SC2016,SC2028
  echo '#!/bin/sh\nexec echo "$HOMEBREW_GITHUB_API_TOKEN"' >"$HOME"/.git-askpass.sh
  # Ensure it's executable since we just created it
  chmod +x "$HOME/.git-askpass.sh"
  # GIT_ASKPASS lets us use the password when pushing without revealing it in the process list
  # See: https://serverfault.com/a/912788
  GIT_ASKPASS="$HOME/.git-askpass.sh" git push https://Wromo-oss@github.com/Wromo-oss/homebrew-core.git --all

  # Find the docs for bump-formula-pr here
  # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/dev-cmd/bump-formula-pr.rb#L18
  brew bump-formula-pr --force --version="${VERSION}" code-server --no-browse --no-audit

  # Clean up and remove homebrew-core
  cd ..
  rm -rf homebrew-core
}

main "$@"

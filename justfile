set shell := ["nu", "-c"]

release-dry LEVEL:
    cargo release version {{LEVEL}}
    cargo release tag
    # standard-version --skip.tag --dry-run
    git-cliff

release LEVEL:
    cargo release version {{LEVEL}} -x --no-confirm
    cargo release hook -x --no-confirm -v
    cargo release replace -x --no-confirm
    git add .
    cargo release commit -x --no-confirm
    cargo release tag -x --no-confirm
    git push
    git push --tags
    # standard-version --skip.tag --dry-run
    # git-cliff -o CHANGELOG.md
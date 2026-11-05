# pre-commit-hooks

This is a collection of hooks that I use quite broadly.

# Install

1. create .pre-commit-config.yaml in you git project with the following included:
   ```yaml
   ---
   repos:
     - repo: https://gitlab.com/astronomer/pre-commit-hooks
       rev: master # pin to a commit hash or tag for reproducible runs
       hooks:
         - id: forbid-whitespace-in-filenames
         - id: prettier
         - id: remove-unicode-left-to-right-mark
         - id: remove-unicode-zero-width-non-breaking-spaces
         - id: remove-unicode-zero-width-space
         - id: replace-en-dashes
         - id: replace-greek-question-mark
         - id: replace-unicode-non-breaking-spaces
         - id: sort-ansible-requirements-yml
   ```
2. `pre-commit install`
3. `pre-commit run --all-files`

# Hooks

Every hook below is defined in [.pre-commit-hooks.yaml](.pre-commit-hooks.yaml). The `replace-*` and `remove-unicode-*` hooks rewrite the files in place and fail the run when they change something, so re-run (or re-stage) after they fire.

| Hook id                                         | What it does                                                                                                                             |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `forbid-whitespace-in-filenames`                | Fails if any filename contains whitespace (spaces, tabs, etc.).                                                                          |
| `prettier`                                      | Runs [prettier](https://prettier.io) (`--write --ignore-unknown`) on text files. Pass options with `args`, e.g. `["--print-width=135"]`. |
| `remove-unicode-left-to-right-mark`             | Removes U+200E (left-to-right mark).                                                                                                     |
| `remove-unicode-zero-width-non-breaking-spaces` | Removes U+FEFF (zero width non-breaking space).                                                                                          |
| `remove-unicode-zero-width-space`               | Removes U+200B (zero width space).                                                                                                       |
| `replace-en-dashes`                             | Replaces U+2013 (en dash) with a normal dash.                                                                                            |
| `replace-greek-question-mark`                   | Replaces U+037E (Greek question mark) with a semicolon.                                                                                  |
| `replace-unicode-non-breaking-spaces`           | Replaces U+00A0 (non-breaking space) with a normal space.                                                                                |
| `sort-ansible-requirements-yml`                 | Sorts Ansible `requirements.yml` files.                                                                                                  |

## Deprecated hooks

These fail with a message pointing at the replacement (`CVE-2017-18342` only where the repo has Python files). Do not use them in new configs.

| Hook id                              | Use instead                                                                                                             |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| `CVE-2017-18342`                     | ruff rule `S506` (`unsafe-yaml-load`); PyYAML 6.0+ already requires an explicit `Loader`, which fixed the original bug  |
| `remove-en-dashes`                   | `replace-en-dashes`                                                                                                     |
| `remove-unicode-non-breaking-spaces` | `replace-unicode-non-breaking-spaces`                                                                                   |
| `sort-gitignore`                     | `file-contents-sorter` from [pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks) with `files: .gitignore` |

# Credits

- Some hooks here were originally taken from the following MIT licensed repositories:
  - <https://github.com/danielhoherd/pre-commit-hooks>
  - <https://github.com/Lucas-C/pre-commit-hooks>
  - <https://github.com/pre-commit/mirrors-prettier>

# License

astronomer/pre-commit-hooks is licensed under the [MIT License](LICENSE).

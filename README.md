# pre-commit-hooks

This is a collection of hooks that I use quite broadly.

# Install

1. create .pre-commit-config.yaml in you git project with the following included:
    ```yaml
    ---
    repos:
      - repo: https://github.com/danielhoherd/pre-commit-hooks
        rev: master
        hooks:
          - id: CVE-2017-18342
          - id: remove-unicode-non-breaking-spaces
          - id: remove-unicode-zero-width-non-breaking-spaces
          - id: remove-en-dashes
          - id: sort-gitignore
          - id: sort-ansible-requirements-yml
    ```
2. `pre-commit install`
3. `pre-commit run --all-files`

# Credits

- Some hooks here were originally taken from <https://github.com/Lucas-C/pre-commit-hooks/>

# License

pre-commit-hooks licensed under the [Unlicense](https://unlicense.org/) license.

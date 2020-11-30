# actions-drawio-cli

Run [drawio-desktop](https://github.com/jgraph/drawio-desktop/) in your github actions pipeline!

# Usage

See [action.yml](action.yml)

### Params

* source - input source file or directory
* destination - output file or directory
* format - output file format, default: `svg`

### Example

Better use with [actions-checkout](https://github.com/actions/checkout) and
[git-auto-commit](https://github.com/stefanzweifel/git-auto-commit-action)


```yaml
steps:
  - uses: actions/checkout@v2
    with:
      ref: ${{ github.head_ref }}
  - uses: severgroup-tt/actions-drawio-cli@v0.0.2
    with:
      source: doc/diagram.drawio
      destination: doc/diagram.svg
  - uses: stefanzweifel/git-auto-commit-action@v4
    with:
      file_pattern: doc/*.svg
      commit_message: Update diagrams

```

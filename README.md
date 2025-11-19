# oh-my-zsh-volt-vue-cli
Custom volt-vue CLI for Oh-my-zsh

# 🚀 `volt` Shell Utility: PrimeVue Volt Component Wrapper

This `README` documents a custom Zsh shell function (`volt`) and its corresponding completion script (`_volt_completions`). This setup provides a convenient, developer-friendly wrapper for the `npx volt-vue add` command, streamlining the process of adding PrimeVue Volt components to a project.

## 🌟 Key Features

* **Simplified Component Installation:** Install components directly without typing `add`.
* **Usage:** `volt Button` instead of `volt add Button`
* **Automatic Directory Enforcement:** Components are always installed to the project's standard `app` directory (`--outdir app`).
* **Zsh Completions:** Provides intelligent tab-completion for component names and command flags.
* **Duplicate Prevention:** When installing multiple components (e.g., `volt Button Dialog`), tab completion hides components already selected on the command line.

## 🛠️ Installation
1. Add `volt.zsh` to `{USER}/.oh-my-zsh/custom`
2. Add `zstyle ':completion:*:*:volt:*:*' sort false` to `.zshrc`
3. Reload Shell

* Apply the changes by reloading your shell environment:
```bash
source ~/.zshrc # Or the path to the file where you saved the code
```

## ⚡ Usage Examples
| Command                 | `volt-vue` Equivalent                                      | Description                                       |
| ----------------------- | ---------------------------------------------------------- | ------------------------------------------------- |
| `volt Button`           | `npx volt-vue add Button --outdir app --verbose`           | Installs the Button component.                    |
| `volt Dialog InputText` | `npx volt-vue add Dialog InputText --outdir app --verbose` | Installs multiple components in one go.           |
| `volt add Card`         | `npx volt-vue add Card --outdir app --verbose`             | Works even if you explicitly type `add`.          |
| `volt Button --force`   | `npx volt-vue add Button --force --outdir app --verbose`   | Installs Button, overwriting existing files.      |
| `volt -h`               | `npx volt-vue -h`                                          | Displays the help message for the underlying CLI. |

## 🛠️ Customization
- Disables verbose mode
  - Remove `--verbose` from `npx volt-vue add "$@" --outdir app --verbose`

- Change output directory
  - Change `app` to your desired directory from `npx volt-vue add "$@" --outdir app --verbose`
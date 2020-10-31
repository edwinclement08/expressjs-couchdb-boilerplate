Steps to do this

- Setup deploy key(https://docs.github.com/en/free-pro-team@latest/developers/overview/managing-deploy-keys) for the server

For Production

- Copy over .env.dev to .env.prod for setting up the secrets for production

- VScode

Need eslint(https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) and prettier(https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

add
"editor.formatOnSave": true
to settings

- important note for module aliases
  https://www.npmjs.com/package/better-module-alias
  https://www.npmjs.com/package/better-module-alias#issues-with-fs

Troubleshooting,
in case Npm ci fails in docker, run npm install in local folder to sync the lock files

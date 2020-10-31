Steps to do this

Install docker

run `make dev up`

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

# Help

run `make` to get the available run options

run `make dev up` for starting in dev mode
run `make prod up` for starting in prod mode

run `make dev down` for stopping dev env

`make dev logs` or `make logs` show logs of the nodejs container of the given env

`make dev getshell` or `make getshell` show logs of the nodejs container of the given env

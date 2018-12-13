#!/bin/sh

if test "$(stat -c %U /db)" != "${NODE_USER}"; then
    echo "**** ERROR: /db must be owned by user ${NODE_USER}, id: $(id -u)" 1>&2
    exit 1
fi

node <<EOF
var fs = require('fs')
var c = require('comment-json').parse(fs.readFileSync('/app/settings.json.template', 'utf8'), null, true)
c.title = process.env.TITLE
c.favicon = process.env.FAVICON
c.dbType = process.env.DB_TYPE
c.dbSettings = JSON.parse(process.env.DB_SETTINGS)
c.defaultPadText = "${DEFAULT_PAD_TEXT//\"/\\"}"
c.suppressErrorsInPadText = true
c.trustProxy = true
c.automaticReconnectionTimeout = process.env.AUTOMATIC_RECONNECTION_TIMEOUT
if (process.env.ADMIN && process.env.ADMIN_PWD) {
  c.users = {
    '${ADMIN}': {
      'password': process.env.ADMIN_PWD,
      'is_admin': true
    }
  }
}
fs.writeFile('/app/settings.json', JSON.stringify(c, null, 2), function(){})
EOF

node /app/node_modules/ep_etherpad-lite/node/server.js

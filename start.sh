#!/bin/sh

node <<EOF
var fs = require('fs')
var c = require('comment-json').parse(fs.readFileSync('/etherpad-lite/settings.json.template', 'utf8'), null, true)
c.title = "${TITLE//\"/\"}"
c.dbSettings.filename = "/db/dirty.db"
c.defaultPadText = "${DEFAULT_PAD_TEXT//\"/\"}"
c.suppressErrorsInPadText = true
fs.writeFile('/etherpad-lite/settings.json', JSON.stringify(c, null, 2), function(){})
EOF

node /etherpad-lite/node_modules/ep_etherpad-lite/node/server.js

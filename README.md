Docker Image for Etherpad Lite
==============================

By now, just uses dirty database.

Port
----

 - `9001`

Volumes
-------

 - `/db` contains dirty database `dirty.db`

Environment
-----------

 - `TITLE` set the pad title
 - `DEFAULT_PAD_TEXT` set the initial default text for new pads

Example
-------

    docker run -it --rm \
        -p 9001:9001 \
        --name etherpad \
        -e TITLE="Marc's Pad" \
        -e DEFAULT_PAD_TEXT='Hi, this is "Marc Wäckerlin'"'"'s" own Etherpad' \
        mwaeckerlin/etherpad

#!/bin/env bash
# Dependencies grep, tr, cut

# Values
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Song Info
readonly SONG_ARTIST=$(bash "${DIR}"/firefox.sh artist)
readonly SONG_TITLE=$(bash "${DIR}"/firefox.sh title)
readonly SONG_ALBUM=$(bash "${DIR}"/firefox.sh album)

INFO="<txt>"
MORE_INFO="<tool>"
if [ -n "$SONG_TITLE" ]
then
    # Panel Info
    INFO+="$SONG_TITLE\n"
    INFO+="$SONG_ARTIST"

    # Tooltip Info
    MORE_INFO+="┌ SONG\n"
    MORE_INFO+="├─ TITLE:\t$SONG_TITLE\n"
    MORE_INFO+="└─ ARTIST:\t$SONG_ARTIST"
else
    INFO+="Mediaplayer Inactive"
fi
INFO+="</txt>"

# Tooltip
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"

GEMA_SRC="/usr/share/shunit.d/shpp.gma"
pushd $PWD >/dev/null 2>/dev/null
cd `dirname "$1"`
gema -f "$GEMA_SRC" `basename "$1"` | bash
popd >/dev/null 2>/dev/null

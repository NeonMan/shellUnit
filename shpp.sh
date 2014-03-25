GEMA_SRC="/usr/share/shunit.d/shpp.gma"
pushd "$PWD" >/dev/null
cd `dirname "$1"` 2>/dev/null
gema -f "$GEMA_SRC" `basename "$1"`
popd >/dev/null

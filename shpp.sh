GEMA_SRC="/usr/share/shunit.d/shpp.gma"
pushd "$PWD" >/dev/null
cd `dirname "$1"`
gema -f "$GEMA_SRC" `basename "$1"`
popd >/dev/null

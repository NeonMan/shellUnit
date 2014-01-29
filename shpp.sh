GEMA_SRC="$PWD/shpp.gma"
pushd $PWD >/dev/null 2>/dev/null
cd `dirname "$1"`
gema -f "$GEMA_SRC" `basename "$1"`
popd >/dev/null 2>/dev/null

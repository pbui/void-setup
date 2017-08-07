# Sets and creates XDG_RUNTIME_DIR.

if [ -z "${XDG_RUNTIME_DIR}" ]; then
    export XDG_RUNTIME_DIR=/run/user/${UID:-$(id -u)}
    if [ ! -d "${XDG_RUNTIME_DIR}" ]; then
	mkdir -m700 "${XDG_RUNTIME_DIR}"
    fi
fi

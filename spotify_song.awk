/string  *"xesam:artist/{
    while (1) {
        getline line
        if (line ~ /string "/) {
            sub(/.*string "/, "artist:", line)
            sub(/".*$/, "", line)
            print line
            break
        }
    }
}
/string  *"xesam:title/{
    while(1) {
        getline line
        if (line ~ /string "/) {
            sub(/.*string "/, "title:", line)
            sub(/".*$/, "", line)
            print line
            break
        }
    }
}
/string  *"mpris:length/{
    while(1) {
        getline line
        if (line ~ /uint64 /) {
            sub(/.*uint64 /, "length:", line)
            # sub(/.*$/, "", line)
            print line
            break
        }
    }
}
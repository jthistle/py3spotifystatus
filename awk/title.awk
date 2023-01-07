/string  *"xesam:title/{
    while (1) {
        getline line
        if (line ~ /string "/) {
            sub(/.*string "/, "", line)
            sub(/".*$/, "", line)
            print line
            break
        }
    }
}
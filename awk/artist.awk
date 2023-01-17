/string  *"xesam:artist/{
    while (1) {
        getline line
        if (line ~ /string "/) {
            sub(/.*string "/, "", line)
            sub(/"\s*$/, "", line)
            print line
            break
        }
    }
}
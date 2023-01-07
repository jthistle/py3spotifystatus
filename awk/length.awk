/string  *"mpris:length/{
    while(1) {
        getline line
        if (line ~ /uint64 /) {
            sub(/.*uint64 /, "", line)
            # sub(/.*$/, "", line)
            print line
            break
        }
    }
}
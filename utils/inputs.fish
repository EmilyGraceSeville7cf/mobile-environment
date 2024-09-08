#!/data/data/com.termux/files/usr/bin/env fish

source /data/data/com.termux/files/home/.shortcuts/utils/constants.fish

function get --argument-names input field
    echo $input | yq --input-format=json .$field
end

function spinner --argument-names title
    set options $argv[2..]

    termux-dialog spinner \
        -t "$title" \
        -v "$(string join , -- $options)"
end

function text --argument-names title
    set info "$(termux-dialog text \
                -t "$title")"

    set hint

    test "$(get "$info" code)" != $success && begin
        echo "$info"
        return
    end

    if test "$(get "$info" code)" = $success && test -z "$(get "$info" text)"
        set hint -i "❌ not empty input"
    end

    while test "$(get "$info" code)" = $success && test -z "$(get "$info" text)"
        set info "$(termux-dialog text \
            -t "$title" $hint)"

        test "$(get "$info" code)" != $success && break
    end

    echo "$info"
end

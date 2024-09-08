#!/data/data/com.termux/files/usr/bin/env fish

function spinner --argument-names title
    set options $argv[2..]

    termux-dialog spinner \
        -t "$title" \
        -v "$(string join , -- $options)"
end

function text --argument-names title
    termux-dialog text \
        -t "$title"
end

function get --argument-names input field
    echo $input | yq .$field
end

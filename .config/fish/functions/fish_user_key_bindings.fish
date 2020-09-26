function fish_user_key_bindings
    # Use <j-k> to escape.
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
    # Use <ctrl-f> to expand the current recommendation.
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
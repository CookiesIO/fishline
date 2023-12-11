#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __flseg_space

    __fishline_segment_close
    if set -q FLINT_DID_RENDER
        type -q tput; and tput el
        printf " "
    end

end

#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __flseg_n

    __fishline_segment_close
    if set -q FLINT_DID_RENDER
        tput el
        printf \n
    end

end

#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __fishline_segment_close -d "close the previous fishline segment"

    if not set -q FLINT_FIRST
        set -g FLINT_LAST
        __fishline_segment normal normal
        set -g FLINT_FIRST
    end

end

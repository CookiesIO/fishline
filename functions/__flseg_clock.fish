#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __flseg_clock

    __fishline_segment $FLCLR_CLOCK_BG $FLCLR_CLOCK_FG
    switch (count $FLSYM_ICO_CLOCK)
        case 4
            printf "$FLSYM_ICO_CLOCK[(math --scale=0 $(date "+%I") / 3)]"
        case 12
            printf "$FLSYM_ICO_CLOCK[$(date "+%I")]"
        case 24
            printf "$FLSYM_ICO_CLOCK[$(math (date "+%H") + 1)]"
        case "*"
            printf "$FLSYM_ICO_CLOCK"
    end

    printf "%s" (date $FL_CLOCK_FORMAT)
end

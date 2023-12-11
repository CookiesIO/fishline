#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __fishline_segment --argument-name bg_clr fg_clr pre post -d "open a new fishline segment"

    # set -g FLSYM_BEGIN
    # set -g FLSYM_PRE
    # set -g FLSYM_CONTINUE
    # set -g FLSYM_POST
    # set -g FLSYM_END

    # rendering of each segment is as follows:
    # - POST if not FIRST
    # - BEGIN if FIRST / CONTINUE if not last / END if last
    # - PRE if not LAST
    #
    # example:
    # BEGIN    = (
    # CONTINUE = /
    # END      = )
    # PRE      = -
    # POST     = ~
    # 3 segments in quotes: "(-" "~/-" "~)"

    # start by printing POST, so long as we're not first
    if not set -q FLINT_FIRST
        if set -q FLINT_ALT_POST
            printf "$FLINT_ALT_POST"
        else
            printf "$FLSYM_POST"
        end
    end

    # as long as we're not last, print PRE
    if not set -q FLINT_LAST
        if set -q FLINT_ALT_PRE
            set -f PRE_SYMBOL $FLINT_ALT_PRE
        else
            set -f PRE_SYMBOL $FLSYM_PRE
        end
    end

    if set -q FLINT_ALT_SYM
        set -f SYMBOL $FLINT_ALT_SYM
    else if set -q FLINT_FIRST
        set -f SYMBOL $FLSYM_BEGIN
    else if set -q FLINT_LAST
        set -f SYMBOL $FLSYM_END
    else
        set -f SYMBOL $FLSYM_CONTINUE
    end

    if set -q FLINT_ALT_COL
        set_color $FLINT_ALT_COL
    else
        # the priority of setting these colors change depending on whether we're in a left or right prompt
        # if RIGHT and not LAST, only set FG to new BG
        # if LEFT and FIRST, only set FG to new BG
        # else set BG to new BG and FG to previous BG
        if [ "$FLINT_POSITION" = right ]; and not set -q FLINT_LAST; or set -q FLINT_FIRST
            set_color $bg_clr
        else
            set_color -b $bg_clr $FLINT_BCOLOR
        end
    end

    printf $SYMBOL
    set_color -b $bg_clr $fg_clr

    if set -q PRE_SYMBOL
        [ "$pre" = false ]; or printf "$PRE_SYMBOL"
    end

    set FLINT_BCOLOR $bg_clr
    set -e FLINT_FIRST
    set -e FLINT_LAST

    set -e FLINT_ALT_SYM
    set -e FLINT_ALT_COL
    set -e FLINT_ALT_PRE
    set -e FLINT_ALT_POST

    set -g FLINT_DID_RENDER
    [ "$post" = false ]; and set -g FLINT_PRINT_POST; or set -e FLINT_PRINT_POST

end

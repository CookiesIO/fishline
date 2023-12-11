#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function fishline -d "fishline prompt function"

    set -g FLINT_POSITION left

    set -g FLSYM_SEPARATOR $FLSYM_LEFT_SEPARATOR
    set -g FLSYM_BEGIN $FLSYM_LEFT_BEGIN
    set -g FLSYM_PRE $FLSYM_LEFT_PRE
    set -g FLSYM_CONTINUE $FLSYM_LEFT_CLOSE
    set -g FLSYM_POST $FLSYM_LEFT_POST
    set -g FLSYM_END $FLSYM_LEFT_END

    set -g FLINT_FIRST
    #set -g FLINT_LAST
    set -g FLINT_BCOLOR normal
    set -g FLINT_PRINT_POST
    set -g FLINT_STATUS false
    set -g FLINT_DID_RENDER false
    set -e fishline_rendered

    set -l options (fish_opt --short=h --long=help)
    set options $options (fish_opt --short=s --long=status --required-val)
    set options $options (fish_opt --short=r --long=right)
    set options $options (fish_opt --short=l --long=left)
    set options $options (fish_opt --short=x)
    set options $options (fish_opt --short=v --long=version)

    argparse --exclusive=h,v,r,l,x --exclusive=h,v,x,s --name=fishline h/help 's/status=' r/right l/left x/segments v/version -- $argv
    or return 1

    if set -q _flag_r
        set FLINT_POSITION right
        set FLSYM_SEPARATOR $FLSYM_RIGHT_SEPARATOR
        set FLSYM_BEGIN $FLSYM_RIGHT_BEGIN
        set FLSYM_PRE $FLSYM_RIGHT_PRE
        set FLSYM_CONTINUE $FLSYM_RIGHT_OPEN
        set FLSYM_POST $FLSYM_RIGHT_POST
        set FLSYM_END $FLSYM_RIGHT_END
    else if set -q _flag_l
        # do nothing, default, mutually exclusive with r
    else if set -q _flag_h
        __fishline_usage
        return 0
    else if set -q _flag_v
        __fishline_version
        return 0
    else if set -q _flag_x
        functions -a | sed -nE 's/__flseg_([a-zA-Z_]+)/\1/p'
        return 0
    end

    if set -q _flag_s
        set FLINT_STATUS $_flag_s
    else
        echo "Warning: last status not passed as positional '-s' argument to fishline" >&2
        set FLINT_STATUS 0
    end

    for seg in $argv
        if set -q FLINT_SET
            if not set -q FLINT_SET_SKIP
                set -g "FLINT_ALT_$(string upper $FLINT_SET)" $seg
            end
            set -e FLINT_SET_SKIP
            set -e FLINT_SET
        else if string match -rqi "(?<joined>j)?(?<option>sym|col|pre|post)(?<next>n)?" "$seg"
            set -f FLINT_SET $option
            if string length -q $joined; and not set -q FLINT_DID_RENDER
                set -f FLINT_SET_SKIP
                continue
            end
            if not string length -q $next
                set -f -a FLINT_CLEAR $option
            end
        else
            set -e FLINT_DID_RENDER
            eval "__flseg_$(string lower $seg)"

            if set -q FLINT_DID_RENDER
                set -g fishline_rendered 1
            end

            for which in $FLINT_CLEAR
                set -e "FLINT_ALT_$(string upper $which)"
            end
            set -e FLINT_CLEAR
        end
    end
    __fishline_segment_close

    set -e FLINT_FIRST
    set -e FLINT_LAST
    set -e FLINT_POSITION
    set -e FLINT_STATUS
    set -e FLINT_BCOLOR
    set -e FLINT_PRINT_POST

    set -e FLINT_SET
    set -e FLINT_SET_SKIP
    set -e FLINT_CLEAR

    set -e FLINT_ALT_SYM
    set -e FLINT_ALT_COL
    set -e FLINT_ALT_PRE
    set -e FLINT_ALT_POST

    set -e FLINT_DID_RENDER

end

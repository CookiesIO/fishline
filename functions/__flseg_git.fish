#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

function __wants_branch_arg
    if contains AHEAD $FL_GIT_FORMAT; and [ "$FLSYM_GIT_AHEAD" != "" ]
        return 0
    end
    if contains BEHIND $FL_GIT_FORMAT; and [ "$FLSYM_GIT_BEHIND" != "" ]
        return 0
    end
    if contains DIVERGED $FL_GIT_FORMAT; and [ "$FLSYM_GIT_DIVERGED" != "" ]
        return 0
    end
    if contains DIVERGED_COMBO $FL_GIT_FORMAT; and [ "$FLSYM_GIT_DIVERGED" != "" -a "$FLSYM_GIT_AHEAD" != "" -a "$FLSYM_GIT_BEHIND" != "" ]
        return 0
    end
    return 1
end

function __flseg_git

    if git rev-parse --git-dir >>/dev/null 2>/dev/null

        set -l detached 0
        set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

        if [ "$status" -ne 0 ] # Repository is empty
            set branch (git status —porcelain -b | head -n1 | cut -d' ' -f 3-)
            set detached 1
        else if [ "$branch" = HEAD ] # Repository is detached on tags / commit
            set branch (git describe --tags --exact-match 2> /dev/null; or git log --format=%h --abbrev-commit -1 2> /dev/null)
            set detached 1
        end

        set -l args "--ignore-submodules=dirty"

        if not contains UNTRACKED $FL_GIT_FORMAT; and [ "$FLSYM_GIT_UNTRACKED" != "" ]
            set -a args "--untracked-files=no"
        end

        if __wants_branch_arg
            set -a args --branch
        end

        # http://git-scm.com/docs/git-status
        set -l gitstatus (git status --porcelain=2 $args 2> /dev/null | awk 'BEGIN {
            modified=0;
            typechanged=0;
            renamed=0;
            deleted=0;
            unstaged=0;
            staged=0;
            untracked=0;
            conflicted=0;
            ahead=0;
            behind=0;
        };
            /^1 .[MATD]/ {unstaged+=1;};
            /^[12] .[MA]/ {modified+=1;};
            /^[12] .T/ {typechanged+=1;};
            /^[12] .D/ {deleted+=1;}
            /^[12] [MATRD]/ {staged+=1;};
            /^2/ {renamed+=1;};
            /^u/ {conflicted+=1;unstaged+=1;};
            /^\?/ {untracked+=1;unstaged+=1;};
            match($0, /^# branch\.ab \+([0-9]+) \-([0-9]+)/, m) {ahead=m[1];behind=m[2];}
        END {printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d",
        modified, typechanged, renamed, deleted, unstaged,
        staged, untracked, conflicted, ahead, behind)}')


        # int gitstatus[ 1] modified
        # int gitstatus[ 2] typechanged
        # int gitstatus[ 3] renamed
        # int gitstatus[ 4] deleted
        # int gitstatus[ 5] unstaged
        # int gitstatus[ 6] staged
        # int gitstatus[ 7] untracked
        # int gitstatus[ 8] conflicted
        # int gitstatus[ 9] ahead
        # int gitstatus[10] behind

        if [ $detached -eq 1 ]
            # Detached
            __fishline_segment $FLCLR_GIT_BG_DETACHED $FLCLR_GIT_FG_DETACHED
            printf "$FLSYM_ICO_GIT_DETACHED"
        else if [ $gitstatus[5] -gt 0 ]
            # Dirty
            __fishline_segment $FLCLR_GIT_BG_DIRTY $FLCLR_GIT_FG_DIRTY
            printf "$FLSYM_ICO_GIT_DIRTY"
        else if [ $gitstatus[6] -gt 0 ]
            # Staged
            __fishline_segment $FLCLR_GIT_BG_STAGED $FLCLR_GIT_FG_STAGED
            printf "$FLSYM_ICO_GIT_STAGED"
        else
            # Clean
            __fishline_segment $FLCLR_GIT_BG_CLEAN $FLCLR_GIT_FG_CLEAN
            printf "$FLSYM_ICO_GIT_CLEAN"
        end

        if [ "$FLINT_POSITION" = right ]
            set -f sep $FLSYM_GIT_RIGHT_SEPERATOR
        else
            set -f sep $FLSYM_GIT_LEFT_SEPERATOR
        end
        for seg in $FL_GIT_FORMAT
            set -l result (switch "$(string lower $seg)"
                case name
                    printf "$FL_GIT_NAME_FORMAT" "$branch"
                case modified
                    if [ $gitstatus[1] -ne 0 ]
                        printf "$FLSYM_GIT_MODIFIED" $gitstatus[1]
                    end
                case typechanged
                    if [ $gitstatus[2] -ne 0 ]
                        printf "$FLSYM_GIT_TYPECHANGED" $gitstatus[2]
                    end
                case renamed
                    if [ $gitstatus[3] -ne 0 ]
                        printf "$FLSYM_GIT_RENAMED" $gitstatus[3]
                    end
                case deleted
                    if [ $gitstatus[4] -ne 0 ]
                        printf "$FLSYM_GIT_DELETED" $gitstatus[4]
                    end
                case unstaged
                    if [ $gitstatus[5] -ne 0 ]
                        printf "$FLSYM_GIT_UNSTAGED" $gitstatus[5]
                    end
                case staged
                    if [ $gitstatus[6] -ne 0 ]
                        printf "$FLSYM_GIT_STAGED" $gitstatus[6]
                    end
                case untracked
                    if [ $gitstatus[7] -ne 0 ]
                        printf "$FLSYM_GIT_UNTRACKED" $gitstatus[7]
                    end
                case conflicted
                    if [ $gitstatus[8] -ne 0 ]
                        printf "$FLSYM_GIT_CONFLICTED" $gitstatus[8]
                    end
                case ahead
                    if [ $gitstatus[9] -ne 0 ]
                        printf "$FLSYM_GIT_AHEAD" $gitstatus[9]
                    end
                case behind
                    if [ $gitstatus[10] -ne 0 ]
                        printf "$FLSYM_GIT_BEHIND" $gitstatus[10]
                    end
                case diverged
                    if [ $gitstatus[9] -ne 0 ]; or [ $gitstatus[10] -ne 0 ]
                        printf "$FLSYM_GIT_DIVERGED" $gitstatus[10] $gitstatus[9]
                    end
                case diverged_combo
                    if [ $gitstatus[9] -ne 0 ]
                        if [ $gitstatus[10] -ne 0 ]
                            printf "$FLSYM_GIT_DIVERGED" $gitstatus[10] $gitstatus[9]
                        else
                            printf "$FLSYM_GIT_AHEAD" $gitstatus[9]
                        end
                    else if [ $gitstatus[10] -ne 0 ]
                        printf "$FLSYM_GIT_BEHIND" $gitstatus[10]
                    end
                case "*"
                    printf $seg
            end)

            if [ "$result" != "" ]
                if set -q printed
                    printf $sep
                end
                echo -n $result
                set -f printed
            end
        end
    end

end

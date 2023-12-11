#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

# Symbol for Fishline (Powerline Glyphs)
set FLSYM_LEFT_BEGIN        "\uE0B6"
set FLSYM_LEFT_PRE          " "
set FLSYM_LEFT_CLOSE        "\uE0B0"
set FLSYM_LEFT_SEPARATOR    "\uE0B1"
set FLSYM_LEFT_POST         " "
set FLSYM_LEFT_END          "\uE0B0"

set FLSYM_RIGHT_BEGIN       "\uE0B2"
set FLSYM_RIGHT_PRE         " "
set FLSYM_RIGHT_OPEN        "\uE0B2"
set FLSYM_RIGHT_SEPARATOR   "\uE0B3"
set FLSYM_RIGHT_POST        " "
set FLSYM_RIGHT_END         "\uE0B4"

# Symbol for ARROW segment
set FLSYM_ARROW             "\u2192"

# Symbol for GIT segment
# Icons in priority order
set FLSYM_ICO_GIT_DETACHED  " "
set FLSYM_ICO_GIT_DIRTY     " "
set FLSYM_ICO_GIT_STAGED    " "
set FLSYM_ICO_GIT_CLEAN     "✓"

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

# %d can be added to all git symbols to show the count
set FLSYM_GIT_AHEAD         "⟶%d "
set FLSYM_GIT_BEHIND        "%d⟵ "
set FLSYM_GIT_DIVERGED      "%d⇌%d "

set FLSYM_GIT_MODIFIED      "!"
set FLSYM_GIT_TYPECHANGED   ""
set FLSYM_GIT_RENAMED       "»"
set FLSYM_GIT_DELETED       "-"
set FLSYM_GIT_UNSTAGED      "~"
set FLSYM_GIT_STAGED        "+"
set FLSYM_GIT_UNTRACKED     "?"
set FLSYM_GIT_CONFLICTED    "⤱"

set FLSYM_GIT_LEFT_SEPERATOR  ""
set FLSYM_GIT_RIGHT_SEPERATOR ""

set FL_GIT_NAME_FORMAT "%s "
set FL_GIT_FORMAT DIVERGED_COMBO NAME CONFLICTED UNTRACKED STAGED MODIFIED TYPECHANGED DELETED RENAMED

# Symbol for CLOCK segment
set FLSYM_ICO_CLOCK         "⏲ "

# Symbol for EXECTIME segment
set FLSYM_ICO_EXECTIME      "⏲ "

# Symbol for JOBS segment
set FLSYM_JOBS              "\u2668 "

# Symbol for ROOT segment
set FLSYM_ROOT_ROOT         "\u221E"
set FLSYM_ROOT_USER         "\u2192"

# Symbol for VFISH segment
set FLSYM_VFISH             "\u2635 "

# Symbol for CONDA segment
set FLSYM_CONDA             "\u223F "

# Symbol for SCREEN segment
set FLSYM_SCREEN            "\u239A "

# Symbol for VIMODE segment
set FLSYM_VIMODE_DEFAULT    "NORMAL"
set FLSYM_VIMODE_INSERT     "INSERT"
set FLSYM_VIMODE_REPLACE    "REPLACE"
set FLSYM_VIMODE_VISUAL     "VISUAL"

# Symbol for WRITE segment
set FLSYM_WRITE_LOCK        "\uE0A2"

# Symbol for SEPARATOR segment
set FLSYM_SEPARATOR_SEG     ""

# Symbol for FISH segment (textual version)
set FLSYM_FISH_ASCII_LEFT   ">((*>"
set FLSYM_FISH_ASCII_RIGHT  "<*))<"

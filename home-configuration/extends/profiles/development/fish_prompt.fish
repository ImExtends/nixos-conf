set primary (cat /home/extends/.primary)
set pink (cat /home/extends/.pink)
set separator " → " 
if [ (tty | string sub -s 1 -l 8) = "/dev/tty" ];
    set separator " > "
end

function fish_prompt
    set_color $pink
    __custom_prompt_whoami
    set_color normal
    __custom_prompt_pwd
    git status ^/dev/null >/dev/null; and __custom_prompt_git
end

function __custom_prompt_separator --description "function used to set the delimiter"
    printf $separator
end

function __custom_prompt_whoami --description "returns username and hostname"
    printf (whoami)
    set_color white
    printf '@'
    set_color $pink
    printf (hostname)
    set_color white
    __custom_prompt_separator
end

function __custom_prompt_pwd --description "custom pwd function"
    if pwd | not grep -qs "$HOME";
        if test (pwd | string split / | wc -l) -gt 4;
            printf '/'
            __custom_prompt_separator
            printf (pwd | string split / | tail -n 3 | string join (__custom_prompt_separator))
        else
            printf '/'
	    printf (pwd | string split / | string join (__custom_prompt_separator))
        end
    else
        set pwd (pwd | string replace "$HOME" "~" | string split '/' | tail -n 3 | string join (__custom_prompt_separator))
        printf (pwd | string split '/' | tail -n 1)
    end
    printf ' '
end

## Git related things
function __custom_prompt_git --description "git part of the prompt"
    set_color $pink
    __custom_prompt_git_branch
    set_color normal
    __custom_prompt_separator
    __custom_prompt_git_status_operations
end

function __custom_prompt_git_branch --description "returns the current branch"
    set branch (git describe --contains --all HEAD ^/dev/null | tr -d '\n')
    test "$branch" = ""; and printf "init"; or printf " $branch"
end

function __custom_prompt_git_status_operations
    set gitstatus (git status --porcelain | string join '**')
    set staged (string split '**' $gitstatus | grep -Poi '^[a-z]' | wc -l)
    set unstaged (string split '**' $gitstatus | grep -Poi '^ [a-z]' | wc -l)
    set untracked (string split '**' $gitstatus | grep -o '??' | wc -l)
    if test ! "$staged" -eq 0;
        set_color green
        printf "✓ $staged"
        set_color normal
        __custom_prompt_separator
    end
    if test ! "$unstaged" -eq 0
        set_color red
        printf "✗ $unstaged"
        set_color normal
        __custom_prompt_separator
    end
end

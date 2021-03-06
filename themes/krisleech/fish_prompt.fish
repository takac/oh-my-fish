function _git_branch_name
  echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info "$green$git_branch "

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow✗"
      set git_info "$git_info$dirty"
    end
  end

  echo -n $cwd$red'|'$git_info$normal⇒' '$normal
end

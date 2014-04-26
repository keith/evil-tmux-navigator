# evil-tmux-navigator

Warning:

![](http://cl.ly/VDhe/no-idea-what-im-doing-dog.jpg)

--------

This is an emacs package...I think? While trying to see what emacs is
all about I felt very out of place without
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
so I wrote one.

This is meant to work with [evil](http://www.emacswiki.org/emacs/Evil)
which gives you vim bindings in emacs.

After installing evil install (assuming emacs >= 24 using
[ELPA](http://www.emacswiki.org/emacs/ELPA)) this with:

```
M-x package-install RET navigate RET
```

Then require it in your `~/.emacs` with:

```lisp
(require 'navigate)
```

You also have to setup commands in your `~/.tmux.conf`:

```
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim(diff)?$|emacs.*$' && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim(diff)?$|emacs.*$' && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim(diff)?$|emacs.*$' && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)vim(diff)?$|emacs.*$' && tmux send-keys C-l) || tmux select-pane -R"
```

#### Troubleshooting

As stated I have no idea what I'm doing in emacs so if any of this is
ridiculous/not working please let me know.

`RET` == return in emacs lingo.

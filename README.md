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

#### Troubleshooting

As stated I have no idea what I'm doing in emacs so if any of this is
ridiculous/not working please let me know.

`RET` == return in emacs lingo.

# Frequently Asked Questions (FAQ)

Many questions are also answered in [doc.pdf](doc.pdf).

### Q. I get an error in macros.tex that `\DeclareUrlCommand` can't be found.

A. Your TeX distribution has an old version of `url.sty`.  Update your
TeX distribution.  Or download a more recent version from CTAN:

http://ctan.org/get/macros/latex/contrib/misc/url.sty

and just copy it to this directory.  TeX/LaTeX first look in the
current directory for all included files, and then proceed to
look in the other configured locations.  You can also change the
standard locations by modifying your `TEXINPUTS` or `texmf.cnf`, but
such details are far beyond the scope of this document.


### Q. I get a warning from _some-package_ that _some-option_ is obsolete.  Is this ok?

A. Yes.  These options were necessary for my LaTeX installation
(MacTeX 2007), and I'd rather leave them rather than have a
student's thesis rejected because they used an older LaTeX.
Feel free to remove the options in your copy, however.


### Q. Can I modify this template for use at a different university?  Can I distribute the modified template?

A. By all means.  This package has been released to the public domain
which means that you can do what you like with it!


### Q. I hate that the Lists of Figures and Tables have all lines of the entries indented by such a huge amount!

(Note: this is only enabled when `gpscopy`)

A. First, be sure to use the optional argument on `\caption` to provide
shortened titles for the LoF & LoT:

```
\caption[short and sweet]{the much more lengthy caption
    possibly stretching across multiple lines}
```

Otherwise look in [`ubcdiss.cls` for the lines with `\@tabprefixlen`](https://github.com/briandealwis/ubcdiss/blob/3a405bf8c72cad8a2fea0d47ce236bcdf05819ed/ubcdiss.cls#L123-L162).   Comment out the lines in _Option 1_ and uncomment those in _Option 2_
to cause subsequent lines in an entry to be typeset with a hanging
indent. 


### Q. I'm trying to add the XXX package, but I now get LaTeX failures.

A. The `ubcdiss` template is fundamentally just a configuration of
of standard LaTeX packages.  When conflicts occur, it's generally
because of a conflict between two different packages.

To resolve such conflicts, start out by commenting some of the
more troublesome packages.  The most typical culprits are the 
natbib and hyperref packages.  Keep commenting out packages until
your build failures disappear.  Then decide which package is the
most useful and worthy of being kept!

### Q. How do I use different fonts?

Edit `diss.tex` and look for the section using `fontspec`.  You'll
likely want to use XeLaTeX (`xelatex`), 
an enhanced TeX that can make use of your platform fonts.
If you have a favourite font (I like Adobe's Minion Pro which ships
with Acrobat Reader), XeTeX provides an "easy" way to use them.


(Aside: probably unlikely now, but should you need to rebuild `xetex`
then you may need to regenerate your formats for the new xetex
binary; the easiest way seems to be:
```
  $ sudo fmtutil-sys --refresh
```
If all of this seems like gobbledygook, then find a capable friend.)


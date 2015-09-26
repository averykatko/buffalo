# buffalo

English is fun!

[What is it?](#what-is-it) | [How do I use it?](#how-do-i-use-it) | [...Why](#why) | [See also](#see-also)

## What is it?

It's a grammar fragment written in Prolog to play with the idea of sentences consisting of only the word 'buffalo'.

It draws snazzy ASCII syntax trees thanks to [Dr. Christoph Lehner's Prolog Tree Drawing Program](http://www.nyu.edu/pages/linguistics/workbook/lehner/).

## How do I use it?

Get [SWI-Prolog](http://www.swi-prolog.org/), and call it like this:

	$ swipl -s chris.pl buffalo.pl

You can generate sequences of "buffalo" with the `seq_pow/3` predicate:

	?- seq_pow([buffalo],3,Seq).
	Seq = [buffalo, buffalo, buffalo] .

Parse it as a sentence:

	?- parse_buffalo_n_s(3, Tree).
	Tree = s(np(n(buffalo)), vp(v(buffalo), np(n(buffalo)))) .

Draw the parse tree:

	?- draw_buffalo_n_s(3).
	          s
	     _____|_____
	    /           \
	   np           vp
	    |         ___|___
	    |        /       \
	    n        v       np
	    |        |        |
	    |        |        |
	 buffalo  buffalo     n
	                      |
	                      |
	                   buffalo

With longer buffalo-sentences, you can press `;` to step through all the possible parses:

	?- draw_buffalo_n_s(5).
	            s
	     _______|______
	    /              \
	   np              vp
	    |         ______|_____
	    |        /            \
	    n        v            np
	    |        |         ____|___
	    |        |        /        \
	 buffalo  buffalo     n        cp
	                      |      ___|___
	                      |     /       \
	                   buffalo  c        s
	                            |    ____|___
	                            |   /        \
	                            e  np        vp
	                                |      ___|___
	                                |     /       \
	                                e     v       np
	                                      |        |
	                                      |        |
	                                   buffalo     n
	                                               |
	                                               |
	                                            buffalo


	true ;
	            s
	     _______|______
	    /              \
	   np              vp
	    |         ______|______
	    |        /             \
	    n        v             np
	    |        |         _____|____
	    |        |        /          \
	 buffalo  buffalo     n          cp
	                      |      _____|____
	                      |     /          \
	                   buffalo  c           s
	                            |      _____|____
	                            |     /          \
	                            e    np          vp
	                                  |         __|__
	                                  |        /     \
	                                  n        v     np
	                                  |        |      |
	                                  |        |      |
	                               buffalo  buffalo   e


	true ;
	                         s
	          _______________|_______________
	         /                               \
	        np                               vp
	     ____|___                          ___|___
	    /        \                        /       \
	    n        cp                       v       np
	    |      ___|___                    |        |
	    |     /       \                   |        |
	 buffalo  c        s               buffalo     n
	          |    ____|___                        |
	          |   /        \                       |
	          e  np        vp                   buffalo
	              |      ___|___
	              |     /       \
	              e     v       np
	                    |        |
	                    |        |
	                 buffalo     n
	                             |
	                             |
	                          buffalo


	true ;
	                          s
	           _______________|______________
	          /                              \
	         np                              vp
	     _____|____                        ___|___
	    /          \                      /       \
	    n          cp                     v       np
	    |      _____|____                 |        |
	    |     /          \                |        |
	 buffalo  c           s            buffalo     n
	          |      _____|____                    |
	          |     /          \                   |
	          e    np          vp               buffalo
	                |         __|__
	                |        /     \
	                n        v     np
	                |        |      |
	                |        |      |
	             buffalo  buffalo   e


	true ;
	                  s
	         _________|________
	        /                  \
	       np                  vp
	     ___|___           _____|_____
	    /       \         /           \
	   adj       n        v           np
	    |        |        |         ___|___
	    |        |        |        /       \
	 buffalo  buffalo  buffalo    adj       n
	                               |        |
	                               |        |
	                            buffalo  buffalo


	true ;
	false.

You can also ask it to find the smallest <i>n</i> such that buffalo<sup><i>n</i></sup> is a grammatical sentence:

	?- min_n_for_s(N).
	N = 3.

# ...Why

I was in a boring 3-hour class with no wifi.

# See also

- [buffaloe](https://github.com/osnr/buffaloe), my friend [Omar Rizwan](https://rsnous.com/)'s web port of this program
- [Wikipedia on "Buffalo buffalo Buffalo buffalo buffalo buffalo Buffalo buffalo"](https://en.wikipedia.org/wiki/Buffalo_buffalo_Buffalo_buffalo_buffalo_buffalo_Buffalo_buffalo)
- *Prolog and Natural-Language Analysis* by Fernando C. N. Perreira and Stuard M. Shieber ([pdf](http://www.mtome.com/Publications/PNLA/prolog-digital.pdf))
- [SWI-Prolog](http://www.swi-prolog.org/)
- [the Prolog Wikibook](https://en.wikibooks.org/wiki/Prolog), particularly [the chapter on Definite Clause Grammars](https://en.wikibooks.org/wiki/Prolog/Definite_Clause_Grammars)
- [Dr. Christoph Lehner's Prolog Tree Drawing Program](http://www.nyu.edu/pages/linguistics/workbook/lehner/)

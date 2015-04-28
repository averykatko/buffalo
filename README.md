# buffalo

English is fun!

## What is it?

It's a grammar fragment written in Prolog to play with the idea of sentences consisting of only the word 'buffalo'.

It draws snazzy ASCII syntax trees thanks to [Dr. Christoph Lehner's Prolog Tree Drawing Program](http://www.nyu.edu/pages/linguistics/workbook/lehner/).

## How do I use it?

Get SWI-Prolog, and call it like this:

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




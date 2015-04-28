% grammar fragment for buffalo fun
% includes some unnecessary non-buffalo words and grammatical features cuz I wanted to play with DCGs

s(s(NP,VP), no_gap) --> np(NP, Number), vp(VP, Number, no_gap, _Valence).
s(s(np(e),VP), subj_gap) --> vp(VP, Number, no_gap, _Valence).
s(s(NP,VP), obj_gap) --> np(NP, Number), vp(VP, Number, obj_gap, transitive).

np(NP, Number) --> det(Det, Number), adj(Adj), n(N, Number), rel(Rel), {build_np(Det, Adj, N, Rel, NP)}.

build_np(Det, Adj, N, Rel, NP) :-
	delete([Det, Adj, N, Rel, NP], epsilon, L),
	NP =.. [np|L].

det(det(a), singular) --> [a].
det(epsilon, plural) --> [].
det(det(the), _Any) --> [the].

n(n(dog), singular) --> [dog].
n(n(dogs), plural) --> [dogs].
n(n(buffalo), _Any) --> [buffalo].

adj(epsilon) --> [].
adj(adj(buffalo)) -->[buffalo].

rel(epsilon) --> [].
rel(cp(C, S)) --> c(C), s(S, Gap), {Gap = subj_gap; Gap = obj_gap}.

c(c(e)) --> [].
c(c(that)) --> [that].

vp(vp(V), Number, no_gap, intransitive) --> v(V, Number, intransitive).
vp(vp(V, NP), Number, no_gap, transitive) --> v(V, Number, transitive), np(NP, _AnyNum).
vp(vp(V,np(e)), Number, obj_gap, transitive) --> v(V, Number, transitive).

v(v(sleeps), singular, intransitive) --> [sleeps].
v(v(sleep), plural, intransitive) --> [sleep].
v(v(buffaloes), singular, transitive) --> [buffaloes].
v(v(buffalo), plural, transitive) --> [buffalo].

% code for string exponentiation: (i.e. for "buffalo"^n)

seq_pow(Seq, Pow, Result) :-
	N is Pow - 1,
	append_n(Seq, Seq, N, Result).

append_n(Seq, _Suffix, 0, Seq).
append_n(Base, Suffix, N, Result) :-
	N > 0,
	append(Base, Suffix, Seq),
	N_minus_1 is N - 1,
	append_n(Seq, Suffix, N_minus_1, Result).

% silly fun queries:

% parse buffalo^N as a sentence
parse_buffalo_n_s(N, Tree) :-
	seq_pow([buffalo], N, Sent),
	s(Tree, no_gap, Sent, []).

% parse buffalo^N as a sentence and draw parse tree
draw_buffalo_n_s(N) :-
	parse_buffalo_n_s(N, Tree),
	drucke_baum(Tree).

% find smallest N such that buffalo^N is a grammatical sentence
min_n_for_s(N) :-
	min_n_for_s(1, N).

% find smallest N >= LowerBound such that buffalo^N is a grammatical sentence (helper for min_n_for_s/1)
min_n_for_s(LowerBound, N) :-
	(
		parse_buffalo_n_s(LowerBound, _Tree),
		N = LowerBound,
		!)
	; (
		NewLowerBound is LowerBound + 1,
		min_n_for_s(NewLowerBound, N)).


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

seq_pow(Seq, Pow, Result) :-
	N is Pow - 1,
	append_n(Seq, Seq, N, Result).

append_n(Seq, _Suffix, 0, Seq).
append_n(Base, Suffix, N, Result) :-
	N > 0,
	append(Base, Suffix, Seq),
	N_minus_1 is N - 1,
	append_n(Seq, Suffix, N_minus_1, Result).

% Don't know if we'll need this, put it here for now

% Res matches all N-length permutations of Set
is_permutation(Set, N, Res) :- length(Res, N), permute(Res, Set).

permute([], _).
permute([H|T], Set) :-
    member(H, Set), 
    permute(T, Set).

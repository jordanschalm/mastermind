% Matches guesses that could be the code, given a set of hints.
maybe_code([], Guess) :- 
    valid_guess(Guess).
maybe_code([Hint|T], Guess) :-
    maybe_code_helper(Hint, Guess),
    maybe_code(T, Guess).

maybe_code_helper(Hint, Guess) :-
    give_hint(Guess, Hint).
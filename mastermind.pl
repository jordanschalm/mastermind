/*
    Team:
        Jordan Schalm   37955135
        David Julien    16997132
        Seerat Sekhon   35145135

    Project:
        Mastermind - An implementation of both players in the Mastermind game.
        Code Breaker: attempts to break the code by making guesses and
        receiving hints.
        Code Maker: responds to guesses and provides a hint.

    Symbol interpretation:
        1-6 represent the six colored guess pegs
        w/b represent the white and black hint pegs
            black - correct colour and position
            white - correct colour, incorrect position
        A hint is encoded as a list of w/b, ordered arbitrarily
        A code is encoded as a list of 1-6
*/

% Choose the code.
code([1,2,3,4]).

% Constants
w.
b.
pegs([1,2,3,4,5,6]).
n_pegs(4).
initial_guess([1,1,2,2]).

% Helpers
is_peg(Peg) :-
    pegs(X),
    member(Peg, X).

% Computes a hint given the code and a guess
% TODO
% give_hint(Guess, Hint).
give_hint(Guess, [b, b, b, b]) :- code(Guess).

% N is the number of matching positions
position_hint([],[],0).
position_hint([GH|GT],[GH|CT],N) :-
    position_hint(GT,CT,N1),
    N is N1+1.
position_hint([GH|GT],[CH|CT],N) :-
    dif(GH,CH),
    position_hint(GT,CT,N).

% N is the number of matching colors
color_hint([],_,0).
color_hint(G,C,N) :-
    msort(G,GR),
    msort(C,CR),
    color_hint_helper(GR,CR,N).

color_hint_helper(_,[],0).
color_hint_helper([],_,0).
color_hint_helper([H|GT],[H|CT],N) :-
    color_hint_helper(GT,CT,N1),
    N is N1 + 1.

color_hint_helper([GH|GT],[CH|CT],N) :-
    CH > GH,
    color_hint_helper(GT,[CH|CT],N).

color_hint_helper([GH|GT],[CH|CT],N) :-
    GH > CH,
    color_hint_helper([GH|GT],CT,N).

% Matches guesses that could be the code, given a set of hints.
maybe_code([], Guess) :- 
    valid_guess(Guess).
maybe_code([Hint|T], Guess) :-
    maybe_code_helper(Hint, Guess),
    maybe_code(T, Guess).

maybe_code_helper(Hint, Guess) :-
    give_hint(Guess, Hint).

% Guess is correctly formed if it has length 4 and all elements
% are valid pegs.
valid_guess(Guess) :-
    length(Guess, 4),
    valid_guess_helper(Guess).

valid_guess_helper([]).
valid_guess_helper([H|T]) :-
    is_peg(H),
    valid_guess_helper(T).



solution.

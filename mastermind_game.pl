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
        1-8 represent the six colored guess pegs
        w,b represent the white and black hint pegs
            black - correct colour and position
            white - correct colour, incorrect position
        A hint is encoded as a list of w/b, ordered arbitrarily
        A code is encoded as a list of 1-8
*/

% rounds represents the number of guesses you have
rounds(10).

% Choose the code.
code([1,2,3,4]).

% Constants
w.
b.
pegs([1,2,3,4,5,6,7,8]).
n_pegs(4).
initial_guess([1,1,2,2]).

% start
start :-
    rounds(R),
    guess(R,_).

guess(0,win) :-
    writeln('You Win!'),
    writeln('Game Over.').

guess(0,lose) :-
    writeln('You Lose :('),
    writeln('Game Over.').

guess(N,_) :-
    rounds(R),
    GN is R-N+1,
    writef('Guess #%q: ',[GN]),
    read(G),
    guess_helper(G,N1,N,F),
    guess(N1,F).

guess_helper(G,N1,N2,_) :-
    not(valid_guess(G)),
    N1 is N2,
    writeln('Invalid Guess, Please try again.').

guess_helper(G,N1,N2,_) :-
    valid_guess(G),
    not(code(G)),
    N1 is N2-1,
    N1 >= 1,
    give_hint(G,H),
    writef('Hint: %q\n',[H]).

guess_helper(G,N1,N2,R) :-
    valid_guess(G),
    not(code(G)),
    N1 = 0,
    N2 = 1,
    R = lose.

guess_helper(G,N1,_,R) :-
    valid_guess(G),
    code(G),
    N1 is 0,
    R = win.

% Helpers
is_peg(Peg) :-
    pegs(X),
    member(Peg, X).

% Computes a hint given the code and a guess
% give_hint(Guess, Hint).
give_hint(G, H) :-
    code(C),
    position_hint(G,C,BN),
    color_hint(G,C,WN),
    num_pegs(w,WH,WN),
    num_pegs(b,BH,BN),
    append(BH,WH,H).

% num_pegs(P,H,R)
% Computes the number of P type(b/w) pegs in a Hint
num_pegs(_,[],0).
num_pegs(P,[P|T],R) :-
    num_pegs(P,T,R1),
    R is R1+1.
num_pegs(P,[H|T],R) :-
    dif(P,H),
    num_pegs(P,T,R).

% position_hint(G,C,N)
% Computes the number of matching positions between G and C
position_hint([],[],0).
position_hint([GH|GT],[GH|CT],N) :-
    position_hint(GT,CT,N1),
    N is N1+1.
position_hint([GH|GT],[CH|CT],N) :-
    dif(GH,CH),
    position_hint(GT,CT,N).

% color_hint(G,C,N)
% Computes the number of matching colors between G and C
color_hint([],_,0).
color_hint(G,C,N) :-
    msort(G,GR),
    msort(C,CR),
    color_hint_helper(GR,CR,N1),
    position_hint(G,C,N2),
    N is N1-N2.

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
    is_list(Guess),
    length(Guess, 4),
    valid_guess_helper(Guess).

valid_guess_helper([]).
valid_guess_helper([H|T]) :-
    is_peg(H),
    valid_guess_helper(T).



solution.

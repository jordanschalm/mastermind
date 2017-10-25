:- dynamic turns/1.
:- dynamic duplicates/1.

% Default settings
turns(10).
duplicates(y).

% Add settings as needed
setup :-
	set_turns,
	set_duplicates.

set_turns :-
	writef('Set number of turns (8,10, or 12): '),
	read(T),
	number(T),
	set_turns_helper(T).

set_turns_helper(T) :-
	T \= 8,
	T \= 10,
	T \= 12,
	writeln('Turns must be set to 8,10, or 12.'),
	set_turns.

set_turns_helper(T) :-
	T == 12,
	set_turns_database(T).

set_turns_helper(T) :-
	T == 10,
	set_turns_database(T).
	
set_turns_helper(T) :-
	T == 8,
	set_turns_database(T).

set_turns_database(T) :-
	retractall(turns(_)),
	assert(turns(T)),
	writef('Turns = %q.\n',[T]).

set_duplicates :-
	writef('Allow duplicates in code? (y/n): '),
	read(YN),
	set_duplicates_helper(YN).

set_duplicates_helper(YN) :-
	YN \= y,
	YN \= n,
	writeln('Answer must be in the form of a "y" or "n".'),
	set_duplicates.

set_duplicates_helper(YN) :-
	YN == y,
	writef('Duplicates are now allowed.'),
	set_duplicates_database(YN).

set_duplicates_helper(YN) :-
	YN == n,
	writef('Duplicates are no longer allowed.'),
	set_duplicates_database(YN).

set_duplicates_database(YN) :-
	retractall(duplicates(_)),
	assert(duplicates(YN)).

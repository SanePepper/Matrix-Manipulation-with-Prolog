list_get([L1|L],0,L1).
list_get([L1|L],J,R) :- list_get(L,J1,R), J is J1+1.
mat_get([M1|_],0,J,R) :- list_get(M1,J,R).
mat_get([_|M],I,J,R) :- mat_get(M,I1,J,R), I is I1+1.

list_sum([],0).
list_sum([L1|L],S) :- list_sum(L,S1), S is S1+L1.
mat_sum([],0).
mat_sum([L1|L],S) :- list_sum(L1,S1), mat_sum(L,S2), S is S1+S2.
list_count([],0).
list_count([_|L],S) :- list_count(L,S1), S is S1+1.
mat_count([],0).
mat_count([M1|M],S) :- list_count(M1,S1), mat_count(M,S2), S is S1+S2.
mat_mean(M,R) :- mat_sum(M,S), mat_count(M,C), R is S/C, !.

head_tail([],[],[]).
head_tail([H],H,[]).
head_tail([L1|L],L1,L).
mat_translate_1st_col([],[],[]).
mat_translate_1st_col([M1|M],C,R) :- mat_translate_1st_col(M,C1,R1), head_tail(M1,H,T), C = [H|C1], R = [T|R1].
mat_trans([[]|_],[]).
mat_trans(M,R) :- R = [M1|R1], mat_translate_1st_col(M,M1,MS), mat_trans(MS,R1), !.

list_blend([],[],_,[]).
list_blend([A1|A], [B1|B], W, C) :- list_blend(A,B,W,C1), E is W*A1+(1-W)*B1, C = [E|C1].
mat_blend([],[],_,[]).
mat_blend([A1|A], [B1|B], W, C) :- list_blend(A1,B1,W,C1), mat_blend(A,B,W,C2), C = [C1|C2], !.

mat_1st_col([],[],[]).
mat_1st_col([[H|T]|M],C,R) :- mat_1st_col(M,C1,R1), C = [H|C1], R = [T|R1].
list_dot([],[],0).
list_dot([A1|A],[B1|B],C) :- list_dot(A,B,C1), C is A1*B1+C1.
list_dot_mat(_,[[]|_],[]).
list_dot_mat(A,B,C) :- mat_1st_col(B,B1,BS), list_dot(A,B1,C1), list_dot_mat(A,BS,C2), C = [C1|C2].
mat_dot([],_,[]).
mat_dot([A1|A],B,C) :- list_dot_mat(A1,B,C1), mat_dot(A,B,C2), C = [C1|C2], !.
# Review log — prueba-grupo-de-clases

## Round 1
VERDICT: ERRORS FOUND
Counts: 5 ERROR, 2 GAP, 0 WRITING
Earlier findings: none
- [ERROR] grupo-de-clases.tex, Fact fact:covolume: covol(j(O_K)) should be 2^{-r_2} sqrt|d_K|, not 2^{-r_2}|d_K| (counterexample Q(i)); M_K and t^n computation affected
- [ERROR] grupo-de-clases.tex, Fact fact:minkowski: with vol(X) >= 2^n covol the set must be compact (counterexample open square)
- [ERROR] grupo-de-clases.tex, Prop prop:small-ideal, last line: J = alpha I^{-1} lies in class c^{-1}, not c
- [ERROR] grupo-de-clases.tex, Lemma lem:finitely-many: O_K is not a finite ring; proof must use Nm(J) in J and finiteness of O_K/mO_K
- [ERROR] grupo-de-clases.tex, Remark rem:bound: number of ideals of norm m can exceed d(m) (e.g. 29 in Q(zeta_7)); use d_n(m)
- [GAP] grupo-de-clases.tex, Facts fact:norm, fact:covolume, fact:minkowski: standard non-trivial results with no reference ("It is well known")
- [GAP] grupo-de-clases.tex, Lemma lem:minkowski-bound: vol(X_t) formula asserted as "standard computation" with no proof or reference

## Round 2
VERDICT: ERRORS FOUND
Counts: 1 ERROR, 0 GAP, 0 WRITING
Earlier findings: round 1 #1, #3, #4, #5, #6, #7 fixed; round 1 #2 still open (author's REPLY not accepted)
- [ERROR] grupo-de-clases.tex, Fact fact:minkowski: still false without compactness (open square (-1,1)^2); cited Neukirch I.4.4 has strict inequality only (repeat of round 1 #2)

## Round 3
VERDICT: NO ERRORS
Counts: 0 ERROR, 0 GAP, 0 WRITING
Earlier findings: round 2 #1 (= round 1 #2) fixed (strict Fact fact:minkowski plus new Lemma lem:minkowski-compact); all round 1 findings remain fixed

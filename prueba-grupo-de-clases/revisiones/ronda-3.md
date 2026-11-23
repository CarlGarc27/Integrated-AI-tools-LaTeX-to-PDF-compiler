VERDICT: NO ERRORS

# Review round 3 — prueba-grupo-de-clases

## Summary
Files reviewed: `demostraciones/grupo-de-clases.tex`. It is the only `.tex` file. There are no `.sty` or `.bib` files; the bibliography is inline.
Findings: 0 ERROR, 0 GAP, 0 WRITING.

Status of earlier findings:
- Round 2 #1 (= round 1 #2), Minkowski's theorem with "$\geq$": **fixed**.
  - Fact `fact:minkowski` now states the strict-inequality version, which is exactly what \cite[Ch.~I, \S4]{Neu} (Thm. 4.4) states.
  - The new Lemma `lem:minkowski-compact` derives the non-strict version for compact $X$, following route (b) proposed in round 2. I checked the proof:
    - $X\neq\emptyset$ because $\vol(X)\ge 2^n\covol(\Lambda)>0$. So $0\in X$, and $sX\subseteq tX$ for $0\le s\le t$.
    - $X_k=(1+1/k)X\subseteq 2X$, and $\vol(X_k)>2^n\covol(\Lambda)$.
    - $\Lambda\cap 2X$ is finite, so by pigeonhole a single $\lambda\neq0$ occurs for infinitely many $k$.
    - $\lambda/(1+1/k)\in X$ for those $k$, and $\lambda/(1+1/k)\to\lambda$. Since $X$ is closed, $\lambda\in X$.
  - Lemma `lem:minkowski-bound` now applies this lemma to the compact box $X_c$, in the equality case.
- All round-1 findings (#1, #3–#7) were already fixed in round 2 and remain fixed.

I checked the whole argument line by line and found no problems:
- Lemma `lem:norm-in-ideal`: the index of one rank-$n$ lattice in another is finite, and Lagrange's theorem applies.
- Lemma `lem:minkowski-bound`:
  - $\vol(X_c)=2^{r_1}\pi^{r_2}M_K\Nm(I)=2^{r_1+r_2}\sqrt{|d_K|}\Nm(I)=2^n\covol(j(I))$.
  - $j$ is injective and additive, so a nonzero lattice point gives a nonzero $\alpha\in I$.
  - The norm estimate is correct.
- Proposition `prop:small-ideal`:
  - $I=\delta\mathfrak b$ is a nonzero ideal of $\OK$, and $J$ is nonzero.
  - $\Nm(J)=|\Nm(\alpha)|/\Nm(I)\le M_K$.
  - $[J]=[I]^{-1}=c$.
- Lemma `lem:finitely-many`: it uses $m\in J$, the correspondence theorem, and $|\OK/m\OK|=m^n$ from $\OK\cong\Z^n$.
- Proof of Theorem `thm:finite`: correct.

The references for the standard facts are adequate:
- Fact `fact:dedekind`, Fact `fact:norm`: Marcus Ch. 3; Neukirch I.§6.
- Fact `fact:covolume`: Neukirch I.§5. The factor $2^{r_2}$ from the change of measure is explained correctly.

## Findings

None.

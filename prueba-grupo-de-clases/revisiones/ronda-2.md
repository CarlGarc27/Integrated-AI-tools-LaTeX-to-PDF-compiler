VERDICT: ERRORS FOUND

# Review round 2 — prueba-grupo-de-clases

## Summary
Files reviewed: `demostraciones/grupo-de-clases.tex` (the only `.tex` file; no `.sty`/`.bib` files, the bibliography is inline).
Findings: 1 ERROR, 0 GAP, 0 WRITING.

Status of round-1 findings:
- #1 (covolume $2^{-r_2}\sqrt{|d_K|}$): fixed. Fact `fact:covolume` is now correct, the normalisation relative to Neukirch's measure is explained, and the volume computation in Lemma `lem:minkowski-bound` checks out: $\vol(X_c)=2^{r_1}\pi^{r_2}M_K\Nm(I)=2^{r_1+r_2}\sqrt{|d_K|}\Nm(I)=2^n\covol(j(I))$.
- #2 (Minkowski's theorem with "$\geq$" needs compactness): **still open**. The author's reply `% REPLY ronda-1 #2` is not accepted; see Finding 1 below.
- #3 (class of $J$): fixed. The proof now starts from $[\mathfrak b]=c^{-1}$ and gets $[J]=[I]^{-1}=c$.
- #4 (finiteness lemma): fixed. The proof now uses $m\in J$, the correspondence theorem and $|\OK/m\OK|=m^n$.
- #5 (Remark `rem:bound`): fixed by deleting the remark.
- #6 (missing references): fixed. References to Marcus and Neukirch were added. (For Fact `fact:minkowski`, see Finding 1.)
- #7 (volume of $X_t$): fixed. The proof now uses the box $X_c$, a product of intervals and discs, whose volume follows from Fubini.

The rest of the argument (Lemma `lem:norm-in-ideal`, Lemma `lem:minkowski-bound` apart from its use of Fact `fact:minkowski`, Proposition `prop:small-ideal`, Lemma `lem:finitely-many`, and the proof of Theorem `thm:finite`) is correct.

## Findings

### 1. [ERROR] Fact `fact:minkowski` is still false as stated, and the cited source does not state it (still open from round 1, #2)
- Location: `grupo-de-clases.tex`, Fact `fact:minkowski`: "if $\Lambda \subseteq \R^n$ is a lattice and $X \subseteq \R^n$ is convex and centrally symmetric ($x \in X \Rightarrow -x \in X$) with $\vol(X) \geq 2^n \covol(\Lambda)$, then $X$ contains a nonzero point of $\Lambda$." The fact is used in the proof of Lemma `lem:minkowski-bound`, with equality $\vol(X_c) = 2^n\covol(j(I))$.
- Problem: The statement is false as written. Counterexample: $n=2$, $\Lambda=\Z^2$, $X=(-1,1)^2$. This $X$ is convex and centrally symmetric, $\vol(X)=4=2^2\covol(\Lambda)$, and $X\cap\Z^2=\{0\}$.
  - The reply `% REPLY ronda-1 #2` says the fact is only applied to the compact set $X_c$. That is true, and it means the *application* can be repaired. But the document states a false result as a "Fact". A false statement is an error even if every later use happens to avoid the bad cases.
  - The application is exactly the boundary case $\vol(X)=2^n\covol(\Lambda)$, which is where compactness is needed. So the hypothesis cannot be left implicit.
  - The cited source does not say this. \cite[Ch.~I, \S4]{Neu} (Neukirch, Thm. 4.4) states Minkowski's theorem with the strict inequality $\vol(X) > 2^n\covol(\Lambda)$. So even the corrected statement with "$\geq$" is not what the reference says. (Neukirch avoids the boundary case in Thm. 5.3 by requiring a strict inequality on $\prod c_i$.)
- Proposed fix: Add "compact" to the hypotheses of Fact `fact:minkowski`. The proof of Lemma `lem:minkowski-bound` already notes that $X_c$ is compact. Then justify the "$\geq$" version in one of these ways:
  - (a) Cite a source that states the compact case with its exact theorem number. Marcus, *Number Fields*, Ch. 5, gives Minkowski's theorem together with its compact variant.
  - (b) Derive it from Neukirch's strict version. For $k\geq1$, the set $(1+1/k)X$ is convex and centrally symmetric, with volume $(1+1/k)^n\vol(X) > 2^n\covol(\Lambda)$ (here $\vol(X)>0$). So it contains some $\lambda_k\in\Lambda\setminus\{0\}$. All $\lambda_k$ lie in the bounded set $2X$, and $\Lambda$ is discrete, so some $\lambda\neq0$ equals $\lambda_k$ for infinitely many $k$. Since $X$ is closed, $\lambda\in\bigcap_k(1+1/k)X=X$.
  - (c) Keep the strict version and modify Lemma `lem:minkowski-bound`. Choose $\varepsilon>0$ such that no integer lies in $(M_K\Nm(I), M_K\Nm(I)+\varepsilon]$, and take the $c_i$ with product $M_K\Nm(I)+\varepsilon$. Then $\vol(X_c) > 2^n\covol(j(I))$. The resulting $\alpha$ satisfies $|\Nm(\alpha)|\leq M_K\Nm(I)+\varepsilon$, and $|\Nm(\alpha)|$ is an integer (Fact `fact:norm`), so $|\Nm(\alpha)|\leq M_K\Nm(I)$.

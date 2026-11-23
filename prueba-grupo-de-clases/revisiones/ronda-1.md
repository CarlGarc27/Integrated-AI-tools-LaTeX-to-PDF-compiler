VERDICT: ERRORS FOUND

# Review round 1 — prueba-grupo-de-clases

## Summary
Files reviewed: `demostraciones/grupo-de-clases.tex` (the only `.tex` file; no `.sty`/`.bib` files, bibliography is inline).
Findings: 5 ERROR, 2 GAP, 0 WRITING.
Earlier rounds: none (this is round 1; no earlier reports or log).

The overall strategy (Minkowski bound, then finitely many ideals of bounded norm) is the standard one and the main theorem is true, but two of the stated Facts are false as written, the key proposition puts the ideal in the wrong class, the finiteness lemma rests on a false claim, and the closing remark states a false count.

## Findings

### 1. [ERROR] Covolume of $j(\mathcal O_K)$ is $2^{-r_2}\sqrt{|d_K|}$, not $2^{-r_2}|d_K|$
- Location: `grupo-de-clases.tex`, Fact `fact:covolume`: "$\covol\bigl(j(\OK)\bigr) = 2^{-r_2} |d_K|$"; used in the proof of Lemma `lem:minkowski-bound` ("By Fact~\ref{fact:covolume}, $t^n = \dots 2^{-r_2} |d_K| \Nm(I)$") and in the definition of $M_K$.
- Problem: The formula is false. Counterexample: $K=\mathbb Q(i)$, $\mathcal O_K=\mathbb Z[i]$, $r_1=0$, $r_2=1$, $d_K=-4$. With $\mathbb C\cong\mathbb R^2$ via $z\mapsto(\operatorname{Re}z,\operatorname{Im}z)$, $j(1)=(1,0)$ and $j(i)=(0,1)$, so the covolume is $1$, but $2^{-1}\cdot 4=2$. The right value is $2^{-r_2}\sqrt{|d_K|}=2^{-1}\cdot 2=1$. The proof of Lemma `lem:minkowski-bound` relies on this false fact. The lemma as stated (with $|d_K|$ in $M_K$) is still true, because $\sqrt{|d_K|}\le |d_K|$, but the proof given does not show it, and the constant is not the Minkowski bound.
- Proposed fix: State $\covol(j(\mathcal O_K))=2^{-r_2}\sqrt{|d_K|}$ (with a reference, see Finding 6). Define $M_K=(4/\pi)^{r_2}\frac{n!}{n^n}\sqrt{|d_K|}$ and redo the computation of $t^n$, which then gives $t^n=(4/\pi)^{r_2}n!\sqrt{|d_K|}\Nm(I)$.

### 2. [ERROR] Minkowski's theorem with "$\ge$" needs compactness
- Location: Fact `fact:minkowski`: "if $\Lambda \subseteq \R^n$ is a lattice and $X \subseteq \R^n$ is convex and centrally symmetric ... with $\vol(X) \geq 2^n \covol(\Lambda)$, then $X$ contains a nonzero point of $\Lambda$."
- Problem: False as stated. Counterexample: $n=2$, $\Lambda=\mathbb Z^2$, $X=(-1,1)^2$ (open square). $X$ is convex and centrally symmetric with $\vol(X)=4=2^2\covol(\Lambda)$, but $X\cap\mathbb Z^2=\{0\}$. The non-strict inequality needs $X$ compact. (Fact `fact:minkowski` is applied to $X_t$, which is closed and bounded, so the application is fine once the Fact is corrected.)
- Proposed fix: Add "compact" to the hypotheses (or require $\vol(X)>2^n\covol(\Lambda)$ and then use compactness of $X_t$ with $t+\varepsilon$, $\varepsilon\to0$). In the proof of Lemma `lem:minkowski-bound`, note that $X_t$ is compact. Give a reference (e.g. Marcus, Ch. 5, or Neukirch, *Algebraic Number Theory*, Ch. I, Thm. 4.4).

### 3. [ERROR] Proposition `prop:small-ideal`: the ideal $J$ is in the class $c^{-1}$, not $c$
- Location: Proof of Proposition `prop:small-ideal`, last line: "Finally $J = \alpha I^{-1}$, so $[J] = [I] = c$."
- Problem: From $\alpha\mathcal O_K=IJ$ we get $[I][J]=1$ in $\Cl_K$, so $[J]=[I]^{-1}=c^{-1}$. The conclusion $[J]=c$ holds only when $c^2=1$. Counterexample: $K=\mathbb Q(\sqrt{-23})$, $\Cl_K\cong\mathbb Z/3$. Take $c=[\mathfrak p]$ with $\mathfrak p=(2,(1+\sqrt{-23})/2)$, which has order 3. The construction gives $J$ in the class $c^{-1}=c^2\ne c$.
- Proposed fix: Start from a fractional ideal $\mathfrak a$ with $[\mathfrak a]=c^{-1}$ (this exists because $\Cl_K$ is a group by Fact `fact:dedekind`). Take $I=\delta\mathfrak a\subseteq\mathcal O_K$ and argue as written. Then $[J]=[I]^{-1}=c$. Alternatively, keep the construction, prove that every class $c^{-1}$ contains such a $J$, and note that $c\mapsto c^{-1}$ is a bijection of $\Cl_K$.

### 4. [ERROR] Lemma `lem:finitely-many`: $\mathcal O_K$ is not a finite ring
- Location: Proof of Lemma `lem:finitely-many`: "The ring $\OK$ is a finitely generated $\Z$-module, so it is a finite ring, and a finite ring has only finitely many ideals."
- Problem: $\mathcal O_K\cong\mathbb Z^n$ as an additive group, so it is infinite (it contains $\mathbb Z$), and it has infinitely many ideals (e.g. $m\mathcal O_K$, $m\ge1$). The lemma is true, but this proof is wrong.
- Proposed fix: Let $J$ be an ideal with $m=\Nm(J)\le B$. By Lemma `lem:norm-in-ideal`, $m\in J$, so $m\mathcal O_K\subseteq J$. So $J$ is the preimage of an ideal of $\mathcal O_K/m\mathcal O_K$. This ring is finite, of order $m^n$, because $\mathcal O_K$ is free of rank $n$ over $\mathbb Z$ (this follows from Fact `fact:covolume`, or cite Marcus Ch. 2). Hence there are finitely many such $J$ for each $m$, and there are finitely many integers $1\le m\le B$.

### 5. [ERROR] Remark `rem:bound`: there can be more than $d(m)$ ideals of norm $m$
- Location: Remark `rem:bound`: "For each integer $m \geq 1$ there are at most $d(m)$ ideals of norm $m$, ... since an ideal of norm $m$ is determined by how $m$ factors."
- Problem: False when $n\ge3$. Counterexample: in $K=\mathbb Q(\zeta_7)$ ($n=6$), the prime $29\equiv1\pmod 7$ splits completely, so there are $6$ ideals of norm $29$, while $d(29)=2$. (Similarly, in $\mathbb Q(\sqrt2,\sqrt3)$, $23$ splits completely, giving $4>2$ ideals of norm $23$.) An ideal of norm $m$ is not determined by the factorization of $m$. The displayed bound $|\Cl_K|\le\sum_{m\le M_K}d(m)$ is therefore not justified.
- Proposed fix: Replace $d(m)$ by $d_n(m)$, the number of ordered factorizations $m=m_1\cdots m_n$ into positive integers. Proof: both sides are multiplicative in $m$ (unique factorization of ideals, Fact `fact:dedekind`). For $p^e\Vert m$, write $p\mathcal O_K=\prod_{i=1}^g\mathfrak p_i^{e_i}$ with residue degrees $f_i$ and $g\le n$. An ideal of norm $p^e$ is $\prod\mathfrak p_i^{a_i}$ with $\sum f_ia_i=e$. The map $(a_i)\mapsto(f_1a_1,\dots,f_ga_g,0,\dots,0)$ is an injection into the compositions of $e$ into $n$ nonnegative parts, and there are $\binom{e+n-1}{n-1}=d_n(p^e)$ of these. Alternatively, delete the remark: it is not needed for Theorem `thm:finite`.

### 6. [GAP] Facts `fact:norm` and `fact:covolume` (and `fact:minkowski`) are used with neither proof nor reference
- Location: Fact `fact:norm` ("It is well known that the norm of ideals is multiplicative ... and that ... $\Nm(\alpha\OK) = |\Nm(\alpha)|$"); Fact `fact:covolume` (that $j(I)$ is a lattice, and the covolume formula); Fact `fact:minkowski`.
- Problem: These are standard but non-trivial results (multiplicativity of the ideal norm needs the Chinese remainder theorem and $|\mathfrak p^k/\mathfrak p^{k+1}|=\Nm(\mathfrak p)$; $\Nm(\alpha\mathcal O_K)=|\Nm(\alpha)|$ needs a determinant argument; the covolume formula needs a discriminant computation). "It is well known" is not a reference. Only Fact `fact:dedekind` cites a source.
- Proposed fix: Add precise references, e.g. Marcus, *Number Fields*, Ch. 3, Thm. 22 (norm multiplicativity and $\Nm(\alpha\mathcal O_K)=|\Nm(\alpha)|$), and Ch. 5 (Minkowski embedding, covolume $2^{-r_2}\sqrt{|d_K|}$, Minkowski's theorem); or Neukirch, *Algebraic Number Theory*, Ch. I, Prop. 5.2, Prop. 6.2 / Cor. 6.3 / Thm. 4.4.

### 7. [GAP] Volume of $X_t$ asserted without proof or reference
- Location: Proof of Lemma `lem:minkowski-bound`: "a standard computation shows that $\vol(X_t) = 2^{r_1} (\pi/2)^{r_2} t^n / n!$."
- Problem: The formula is correct, but it is a non-trivial computation (induction on $r_1,r_2$ with polar coordinates). A non-specialist would not know it at once, and the text gives neither a proof nor a reference. It is the core of the bound. Convexity of $X_t$ is also only asserted; this one is easy (the defining function is a sum of seminorms), so one sentence suffices.
- Proposed fix: Cite it (Marcus, Ch. 5, Lemma 4 / proof of Thm. 37; Neukirch, Ch. I, Prop. 6.6) or include the inductive computation. Add one line for convexity: $y\mapsto\sum_{i\le r_1}|y_i|+2\sum_{i>r_1}|y_i|$ satisfies the triangle inequality and is homogeneous, so its sublevel sets are convex.

# PhD project — general rules

These rules apply to every subproject in this repository. A subproject's own
`CLAUDE.md` may add rules but does not override these.

## Questioning the claims

- Remember that the user may ask you to prove something that is false. Always
  question the user's claims, and if you think something they asked is false,
  look for a counterexample or give evidence for why you think it is false.
- Conversely, if the user asks for an example that you think cannot exist, try
  to prove that it cannot exist, or at least explain the intuition for why you
  think it cannot exist.
- Before trying to prove a claim, test it on small and degenerate cases. A
  counterexample often appears there.
- Never weaken a statement silently to make it provable. If the proof only
  works under an extra hypothesis, say so explicitly and state the weaker
  result separately.
- If you find neither a proof nor a counterexample, say so. Do not present an
  intuition or a partial argument as a result.

## Mathematical rigor

- Proofs must be rigorous and complete. No step may be "clear", "obvious" or
  "left to the reader" unless it is a routine verification that is written out
  somewhere or genuinely trivial (and even then, say why it holds).
- Every step must be justified. When a step uses a hypothesis, a definition, or
  an earlier result, cite it explicitly, e.g. "by hypothesis (H2)",
  "by Definition 2.3", "by Lemma 4.1(b)", "by [Ref, Thm. 3.2]".
- State all hypotheses at the start of each result. Do not use hypotheses that
  were not stated.
- Do not use a result before it is proved, unless it is cited from the
  literature with a precise reference.
- Distinguish clearly between what is proved, what is conjectured, and what is
  only checked on examples or by computation.
- When a case analysis is used, state why the cases are exhaustive.

## Notation

- Keep notation consistent across all files of a subproject. Introduce each
  symbol once, at its first use or in a notation section, and do not reuse it
  with a different meaning.
- If notation must change, update every file that uses it.
- Fixed conventions for the whole project:
  - **Conjugation.** For a subgroup $H \subseteq G$, an element
    $\sigma \in G$ normalising $H$, and a representation or character $\psi$
    of $H$: $\psi^\sigma(g) = \psi(\sigma g\sigma^{-1})$ for $g \in H$.
  - **Induction.** $\mathrm{Ind}_H^G$ is induction from the subgroup $H$ to
    $G$. For number fields $F \subset K$, $\mathrm{Ind}_K^F$ means
    $\mathrm{Ind}_{G_K}^{G_F}$.
  - **Transfer.** The transfer of a character for a subgroup of index 2 is
    defined as in `GarciaRotger-AsaiTransfer` (7); for index 4 in a cyclic
    quartic tower, it is the index-2 transfer applied twice.

## Files

- All mathematical writing is in LaTeX (`.tex`). Use `amsthm` environments
  (`theorem`, `lemma`, `proposition`, `corollary`, `definition`, `remark`,
  `proof`) with `\label` on every numbered statement, and refer to them with
  `\ref` / `\eqref`.
- Each subproject has the folders:
  - `demostraciones/` — the proofs (LaTeX), with the compiled PDF of each
    document. The `.tex` files are the source; the PDFs are for reading only
    and are regenerated from the `.tex`, never edited.
  - `revisiones/` — review reports `ronda-N.md` and the log `log.md`, written
    by the `revisor-matematico` subagent.
  - optionally `referencias/` — subproject-only sources (see "References").

## References

- Sources are in referencias/ (shared) and <subproject>/referencias/
  (subproject-only). Shared sources are grouped by topic: each topic has a
  folder referencias/<topic>/ with the PDFs of its sources and the
  subfolders `notas/` (notes), `erratas/` (errata) and `guias/` (topic
  guides). A source, its notes and its errata belong to exactly one topic.
  Before using or citing any source, read referencias/INDEX.md (and the
  subproject's INDEX.md, if it exists): it lists the topics and, for each
  one, its sources, notes, errata and guides, with their paths.
- INDEX.md gives the type of each source (book, journal article, lecture
  notes, preprint, …) and, in its section "Types and weight", the weight of
  each type. When two sources disagree on a mathematical statement (not only
  on a definition or normalisation: then the conventions in "Notation"
  apply), first check the errata of both. If they still disagree, follow by
  default the source of higher weight (e.g. a book rather than an arXiv
  preprint), but do not treat the question as settled: record the
  disagreement in the note of each source that has one, and tell the user.
- Topic guides (referencias/<topic>/guias/, PDFs compiled from `.tex`) say,
  for an area, which sources cover each subtopic (chapters, pages), which
  conventions differ between them and, when the purpose calls for it, how to
  read the area. Before working in an area, read its guide if there is one.
  When an area is needed that referencias/ does not cover, call the
  `buscador-bibliografico` subagent in two phases:
  1. PROPOSE, with the area and the purpose: it writes a guide in
     referencias/propuestas/ proposing sources, why they were chosen, where
     to get them, and the topic they go to (an existing topic, or a new one),
     and changes nothing else. Show the guide to the user and ask for a
     decision on each source and on the topic.
  2. INTEGRATE, only after the user has decided, with the guide and the
     decisions (the user may also download files themselves): it puts the
     approved sources in the topic's folder (downloading the free ones),
     registers them in INDEX.md and referencias.bib, and moves the completed
     guide to the topic's `guias/`.
- Open only the pages you need; never read whole books. INDEX.md gives, for
  each source, the page offset: PDF page = printed page + offset. Use it to
  open the right PDF page, and always cite printed page numbers.
- When a proof relies on a cited result, give the exact reference
  (source, theorem number, page), e.g. `\cite[Thm.~4.4, p.~28]{Neukirch}`.
  Theorem numbers depend on the edition; cite the edition listed in INDEX.md.
- Never cite a result you have not checked in the source. If the source is
  not available in referencias/, do not cite from memory: write
  `% TODO-REF: <what is needed, likely source>` at that point in the `.tex`,
  and tell the user which source is missing.
- For sources used often, keep short notes in the `notas/` folder of the
  source's topic (referencias/<topic>/notas/<Key>.md, listed in the Notes
  column of INDEX.md) with key definitions and theorems and their page
  numbers, and prefer those notes over re-reading the PDF. In the notes:
  - copy each statement word for word, with all its hypotheses;
  - give the result number and printed page of each entry;
  - if a proof depends on a hypothesis or detail that is not in the note,
    check it in the PDF and add it to the note.
- All `.tex` documents use the shared bibliography `referencias/referencias.bib`
  (from a subproject's `demostraciones/`:
  `\bibliography{../../referencias/referencias}`), not their own
  `thebibliography`, so each source has one key and one entry project-wide.
- PDFs of books, articles and errata are not committed to git (see
  `.gitignore`): they are large and usually copyrighted. INDEX.md,
  `referencias.bib`, the notes and the topic guides (`.tex` and `.pdf`) are
  committed.

## Review loop

Proofs are reviewed by the `revisor-matematico` subagent, which did not write
them. It writes `revisiones/ronda-N.md` and appends to `revisiones/log.md`; it
does not commit. To get a proof accepted:

1. Write the proofs in `demostraciones/`.
2. Call `revisor-matematico` with the subproject folder and the round number N
   (1 for the first round, then one more than the last round in `log.md`).
3. If the report starts with `VERDICT: ERRORS FOUND`, fix every ERROR and GAP
   in `demostraciones/` (following the proposed fix or a better one). Fix
   WRITING issues too when easy. Then compile the PDFs (see "Compiling"); if
   compilation fails, fix the `.tex` and compile again, and never commit a
   `.tex` that does not compile. Then commit the corrected proofs and their
   PDFs together with `ronda-N.md` and `log.md`, with the message
   `Round N (<subproject>): <what was fixed>`, and go back to step 2 with N+1.
4. Stop when the report starts with `VERDICT: NO ERRORS`. WRITING issues do not
   block acceptance. Commit the final report and log with the message
   `Round N (<subproject>): VERDICT: NO ERRORS`.

If a finding seems wrong, do not silently ignore it: explain why in a LaTeX
comment next to the step in question, starting with
`% REPLY ronda-N #k:` (N the round, k the finding number), so the reviewer
sees it in the next round. If the
same ERROR or GAP is still open after 5 rounds, stop the loop and ask the user.
If the only open findings are GAPs for missing sources (unverifiable
references or `% TODO-REF`), stop the loop and ask the user for those sources:
they cannot be fixed by editing the proofs.

## Compiling

Compile every `.tex` file in `demostraciones/` that is a standalone document
(contains `\documentclass`; files only `\input` into another are compiled
through it). Run, from inside `demostraciones/`:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error <file>.tex
```

`latexmk` runs pdfLaTeX (and BibTeX, if the document uses it) as many times as
needed for references to resolve. It is the same tool LaTeX Workshop uses in
VS Code, so both builds give the same result. After compiling, check the
`.log` for warnings about undefined references or citations and fix them. Build files (`.aux`, `.log`, etc.) are ignored by git;
only the `.tex` and `.pdf` are committed.

## Git

- Commit with git before any large change (restructuring a proof, renaming
  notation across files, deleting or moving files), so that the previous state
  can be recovered.
- Write commit messages that say what changed mathematically.

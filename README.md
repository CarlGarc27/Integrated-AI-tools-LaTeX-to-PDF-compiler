# AI agents for mathematical research

A set of AI agents that support research in pure mathematics: reviewing proofs like a journal referee, building bibliographies for a specific purpose, and translating proofs into Lean.

I am developing them for my own doctoral research in number theory (PhD in Applied Mathematics, UPC).

The agents are currently written for [Claude Code](https://claude.com/claude-code) and have only been tested with Claude. However, their instructions are plain natural-language text, not tied to any particular model: adapting them to another AI model or agent framework should mainly require changing the file headers, the references to tools and the project instruction files (`CLAUDE.md`). Making them model-agnostic is one of the project's goals.

## Motivation

AI can now produce long mathematical arguments much faster than humans can read them. For these tools to genuinely help research, their output must be **checkable and readable**, not just long. The agents here are designed around that idea:

- the reviewer reports only real problems, and never pads its report to look thorough;
- no citation is confirmed from memory: every non-trivial result must be checked in the source;
- proofs can be translated into Lean, so that correctness can be verified formally, and the translation must follow the original argument rather than replace it.

## Final objective

The long-term goal is a **VS Code tool for writing mathematics in LaTeX**, with these agents built into the workflow. For example:

- compiling the PDF while the reviewer automatically checks the results that changed since the last run, together with the results that depend on them;
- compiling while the Lean agent formalizes the new content, so it can be verified;
- tools that assist the research itself, such as an agent that suggests possible proof routes, given a goal and the current state of the project;
- an agent that writes course notes from a bibliography compiled by the literature-search agent;
- model-agnostic versions of all the agents, usable with other AI models and agent frameworks.

## Current state

| Component | File | Status |
|---|---|---|
| Proof reviewer | [`agents/revisor-matematico.md`](agents/revisor-matematico.md) | Working; used on my doctoral project |
| Literature-search agent | [`agents/buscador-bibliografico.md`](agents/buscador-bibliografico.md) | Working; used on my doctoral project |
| Lean formalizer | [`agents/lean-formalizer.md`](agents/lean-formalizer.md) | Early stage: tested only on simple results |
| Project rules and review loop | [`CLAUDE.md`](CLAUDE.md) | In use |
| Course-notes agent | – | Planned |
| Proof-route suggestion agent | – | Planned |
| VS Code integration | – | Planned |
| Support for other AI models and frameworks | – | Planned (currently Claude Code only) |

## Repository contents

```
.
├── CLAUDE.md                     # general rules of the PhD project (rigor, references, review loop)
├── agents/
│   ├── revisor-matematico.md     # proof reviewer (Claude Code subagent)
│   ├── buscador-bibliografico.md # literature-search agent (Claude Code subagent)
│   └── lean-formalizer.md        # instructions for the Lean formalization project
├── prueba-grupo-de-clases/       # showcase: review loop on a proof of the finiteness of the class group
│   ├── CLAUDE.md
│   ├── demostraciones/           # the proof (.tex and .pdf)
│   └── revisiones/               # review reports ronda-1.md to ronda-3.md, and log.md
└── hida-families-notes.pdf       # showcase: course notes on Hida families
```

**Note on names:** some folder and file names are in Spanish: *revisor matemático* = mathematical reviewer, *buscador bibliográfico* = bibliographic search, *prueba* = test, *grupo de clases* = class group, *demostraciones* = proofs, *revisiones* = reviews, *ronda* = round, *referencias* = references.

## The project rules: `CLAUDE.md`

The root [`CLAUDE.md`](CLAUDE.md) sets the rules every agent follows in the project, and is also part of the reviewer's criteria. Among them:

- **Question the claims:** the user may ask for a proof of something false, so claims are tested on small and degenerate cases first, and a statement is never silently weakened to make it provable.
- **Rigor:** every step is justified and cited explicitly; what is proved, conjectured or only checked by computation is kept clearly separate.
- **References:** a result is never cited without checking it in the source; if the source is missing, the gap is marked with `% TODO-REF` instead of citing from memory.
- **Review loop:** proofs are reviewed by `revisor-matematico` in numbered rounds until the verdict is `NO ERRORS`, and the loop stops and asks the user if the same problem is still open after five rounds.

## The agents

### Proof reviewer: [`revisor-matematico`](agents/revisor-matematico.md)

A critical reviewer of proofs it did not write, working on the `.tex` sources.

- **Line-by-line checking:** validity of each step, hypotheses of cited results, exhaustive case analyses, edge cases, circular arguments, notation.
- **Three kinds of finding:** `ERROR` (the argument is wrong), `GAP` (the statement may be true but is not established) and `WRITING` (presentation only). Only errors and gaps block acceptance.
- **Calibrated standard of rigor:** common-knowledge facts can be used freely; standard but non-trivial results need a precise reference; anything else must be proved.
- **Citations checked against sources:** each reference to a non-trivial result is looked up in the project's library of sources (notes or the cited PDF page), and its hypotheses are compared with how the result is used.
- **Review rounds:** the author can answer a finding with a `% REPLY ronda-N #k:` comment in the source; in the next round the reviewer withdraws the finding if the reply is right, or keeps it and explains why.
- **Limited permissions:** it writes only its own report and an append-only log, and never edits the proofs.

### Literature-search agent: [`buscador-bibliografico`](agents/buscador-bibliografico.md)

Finds the best sources for a mathematical area, for a purpose stated by the user, in two phases:

1. **Propose:** it searches and ranks trusted sources (books and lecture notes by recognised authors first, then proceedings, refereed papers and arXiv preprints) and writes a topic guide saying which sources to use, why, where to get them and, when the purpose calls for it, how to read the area. It changes nothing else.
2. **Integrate:** only after the user has approved each source, it adds the approved ones to the project's reference library and bibliography, downloading only those that are legitimately free.

It never records a reference it has not seen.

### Lean formalizer: [`lean-formalizer`](agents/lean-formalizer.md)

Instructions for a Lean 4 + Mathlib project that translates LaTeX proofs into Lean. Its central rule is to **translate, not re-prove**: each Lean step must correspond to a step of the original argument, brute-force tactics may not replace a substantial step, and the final summary must say honestly whether the translation was faithful, deviated from the original at some step, or failed. This agent is at an early stage and has only been tested on simple results.

## Showcases

- **Review loop on a flawed proof** ([`prueba-grupo-de-clases/`](prueba-grupo-de-clases/)): a proof of the finiteness of the class group of a number field via the Minkowski bound, into which I deliberately introduced errors. The reviewer checked it and Claude corrected it, following the review loop in [`CLAUDE.md`](CLAUDE.md), over three rounds (see [`revisiones/log.md`](prueba-grupo-de-clases/revisiones/log.md)):
  - **Round 1:** 5 errors and 2 gaps found, including a wrong covolume formula (with the counterexample $\mathbb{Q}(i)$) and a version of Minkowski's theorem that is false without compactness.
  - **Round 2:** all but one finding fixed. On the remaining one, Claude replied that the result was only applied to a compact set. The reviewer rejected the reply: the result as stated was still false (counterexample: the open square $(-1,1)^2$), and the cited source only states the strict inequality.
  - **Round 3:** `VERDICT: NO ERRORS`.
- **Course notes on Hida families** ([`hida-families-notes.pdf`](hida-families-notes.pdf)): notes on p-adic modular forms, Hida families and p-adic L-functions, written by Claude from a bibliography compiled by the literature-search agent.

## Usage

With Claude Code: copy `revisor-matematico.md` and `buscador-bibliografico.md` into the `.claude/agents/` folder of your project, and Claude Code will make them available as subagents. `lean-formalizer.md` is instead the instruction file (`CLAUDE.md`) of a separate Lean 4 + Mathlib project. The research project is expected to have this layout:

```
<project>/
├── CLAUDE.md                  # project-wide rules (also used as review criteria)
├── referencias/
│   ├── INDEX.md               # index of sources: key, type, file, edition, page offset, notes
│   └── referencias.bib
└── <subproject>/
    ├── CLAUDE.md              # subproject rules
    ├── demostraciones/        # the .tex proofs under review
    └── revisiones/            # review reports (ronda-N.md) and log.md
```

The reference library (`referencias/`) is not included in this repository, since it contains copyrighted books and articles.

Then ask Claude Code, for example: *"Use revisor-matematico to review `prueba-grupo-de-clases`, round 1."*

## Author

Carlos García Ordóñez, PhD student in Applied Mathematics at Universitat Politècnica de Catalunya (UPC).
Contact: carlos.garcia.ordonez@upc.edu

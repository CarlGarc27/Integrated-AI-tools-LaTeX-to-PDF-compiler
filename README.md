# AI agents for mathematical research

A set of AI agents that support research in pure mathematics: reviewing proofs like a journal referee, building bibliographies for a specific purpose, and translating proofs into Lean.

I am developing them for my own doctoral research in number theory (PhD in Applied Mathematics, UPC).

The agents are currently written as [Claude Code](https://claude.com/claude-code) subagents and have only been tested with Claude. However, their instructions are plain natural-language text, not tied to any particular model: adapting them to another AI model or agent framework should mainly require changing the file header, the references to tools and the project instruction files (`CLAUDE.md`). Making them model-agnostic is one of the project's goals.

## Motivation

AI can now produce long mathematical arguments much faster than humans can read them. For these tools to genuinely help research, their output must be **checkable and readable**, not just long. The agents here are designed around that idea:

- the reviewer reports only real problems, and never pads its report to look thorough;
- every citation of a non-trivial result is checked against the source, never confirmed from memory;
- proofs can be translated into Lean, so that correctness can be verified formally.

## Final objective

The long-term goal is a **VS Code tool for writing mathematics in LaTeX**, with these agents built into the workflow. For example:

- compiling the PDF while the reviewer automatically checks the results that changed since the last run, together with the results that depend on them;
- compiling while the Lean agent formalizes the new content, so it can be verified;
- tools that assist the research itself, such as an agent that suggests possible proof routes, given a goal and the current state of the project;
- an agent that writes course notes from a bibliography compiled by the literature-search agent;
- model-agnostic versions of all the agents, usable with other AI models and agent frameworks.

## Current state

| Component | Status |
|---|---|
| Proof reviewer (`revisor-matematico`) | Working; used on my doctoral project |
| Literature-search agent | Working; used on my doctoral project |
| Lean formalizer | Early stage: tested only on simple problems |
| Course-notes agent | Planned |
| Proof-route suggestion agent | Planned |
| VS Code integration | Planned |
| Support for other AI models and frameworks | Planned (currently Claude Code only) |

## The agents

### Proof reviewer

A critical reviewer of proofs it did not write, working on the `.tex` sources.

- **Line-by-line checking:** validity of each step, hypotheses of cited results, exhaustive case analyses, edge cases, circular arguments, notation.
- **Three kinds of finding:** `ERROR` (the argument is wrong), `GAP` (the statement may be true but is not established) and `WRITING` (presentation only). Only errors and gaps block acceptance.
- **Calibrated standard of rigor:** common-knowledge facts can be used freely; standard but non-trivial results need a precise reference; anything else must be proved.
- **Citations checked against sources:** each reference to a non-trivial result is looked up in the project's own library of sources (notes or the cited PDF page), and its hypotheses are compared with how the result is used.
- **Review rounds:** the author answers each finding with a `% REPLY ronda-N #k:` comment in the source; in the next round the reviewer withdraws the finding if the reply is right, or keeps it and explains why.
- **Limited permissions:** it writes only its own report and an append-only log, and never edits the proofs.

### Literature-search agent

Searches the literature on a topic and compiles a bibliography, with the search tailored to the purpose the user gives (for example, finding a specific result versus preparing course notes).

### Lean formalizer

Translates proofs into Lean. This agent is at an early stage and has so far only been tested on simple problems.

## Showcases

- **Reviewing a flawed proof:** the reviewer's report on a proof of the finiteness of the class group of a number field that contains errors.
- **Course notes on Hida families:** notes based on a bibliography compiled by the literature-search agent.
- **Schur's lemma in Lean:** a short Lean file with a proof of Schur's lemma.

## Usage

With Claude Code: copy the agent files into the `.claude/agents/` folder of your project, and Claude Code will make them available. The reviewer expects this layout:

```
<project>/
├── CLAUDE.md                  # project-wide rules (also used as review criteria)
├── referencias/
│   └── INDEX.md               # index of sources: key, file, edition, page offset, notes
└── <subproject>/
    ├── CLAUDE.md              # subproject rules
    ├── demostraciones/        # the .tex proofs under review
    └── revisiones/            # review reports (ronda-N.md) and log.md
```

Then ask Claude Code, for example: *"Use revisor-matematico to review `my-subproject`, round 1."*

**Note on names:** folder and file names are in Spanish: *demostraciones* = proofs, *revisiones* = reviews, *ronda* = round, *referencias* = references.

## Author

Carlos García Ordóñez, PhD student in Applied Mathematics at Universitat Politècnica de Catalunya (UPC).
Contact: carlos.garcia.ordonez@upc.edu

# Project context: formalizing research mathematics in Lean 4

## What this project is
This Lean 4 + mathlib project formalizes and verifies proofs from a research
document in algebraic number theory.

Each task is to translate a statement and its proof, originally written in
LaTeX (English), into a Lean 4 proof that compiles with no errors and no
`sorry`.

## How to verify your work
After writing or editing a .lean file, ALWAYS compile it before considering
the task done:

    lake build MathlibProject.StageA.<FileName>

If the build fails, read the full error message (line, column, error type)
and fix the file. Repeat until it compiles cleanly. Never consider a proof
valid until `lake build` finishes with no errors.

## Logging every attempt (IMPORTANT, do not skip)
After EVERY build attempt, whether it fails or succeeds, commit the current
state of the .lean file with git before continuing to fix it. Do this even
for failed attempts.

    git add MathlibProject/StageA/<FileName>.lean
    git commit -m "Attempt N (<FileName>): <ok|fail> - <short summary>"

Number attempts starting at 1 for each new file. Do not group several
attempts into one commit — I want to see the full attempt-by-attempt history
in VS Code's Source Control / Timeline panel.

## CRITICAL RULE: translate, do not re-prove
Your task is to TRANSLATE the proof given in LaTeX into Lean, not to find an
alternative proof or "fix" the proof if you think it is flawed. This applies
even if you know a shorter or easier way to prove the result: do not use it
unless it is literally the same step already present in the LaTeX.

Concrete rules:

1. **Mandatory step-by-step correspondence.** Before writing Lean code,
   break the LaTeX proof into its logical steps. Add a comment in the .lean
   file marking which block of tactics corresponds to which step (e.g.
   `-- Step 2: by the induction hypothesis, ...`). If at any point you
   cannot keep this one-to-one correspondence, STOP and report it instead
   of continuing.

2. **No closing non-trivial steps with brute-force tactics.** Do not use
   `decide`, `omega`, `nlinarith`, `polyrith`, or unparameterized
   `simp`/`aesop` to close a step in one shot when the corresponding LaTeX
   step is a substantial argument (more than one line of reasoning). These
   tactics are only allowed when the LaTeX step explicitly says something
   like "this is immediate by computation" or equivalent.

3. **Per-step attempt limit, not just per-theorem.** If after 3 attempts to
   syntactically translate the SAME step (same underlying mathematical
   fact, different Lean form) it still does not compile, STOP. Do not get
   creative with the proof strategy. Instead, mark that step with `sorry`
   and a comment explaining what you tried and why it failed, then continue
   with the rest of the theorem if possible, or report a full blocker.

4. **In your final summary, explicitly distinguish between:**
   - "Compiled, faithfully following every LaTeX step" (genuine success)
   - "Compiled, but I had to deviate from the original argument at step X"
     (ALWAYS report this, even if it compiles — this does NOT count as a
     Stage A success)
   - "Could not make it compile without deviating; left with sorry at
     step X" (failure — report it as such, do not hide it)

Do not optimize for "it compiles." Optimize for "it is a faithful
translation of the given argument, and if you can't achieve that, it's
clear exactly where and why."

## Style conventions
- Follow mathlib style: snake_case for lemma/theorem names, standard
  spacing, brief docstrings with `/-- ... -/` before non-trivial
  definitions or theorems.
- Prefer existing mathlib tactics/lemmas over reinventing auxiliary lemmas.
  If you need an intermediate result, check whether it already exists in
  mathlib (use `exact?`, `apply?`, or search the docs) before proving it
  from scratch.
- When the LaTeX statement uses non-standard notation, add a comment
  explaining how you are translating it, so it can be reviewed.
- **Performance constraint (weak hardware): never use `import Mathlib`.**
  Always import the specific mathlib modules actually needed (e.g.
  `import Mathlib.Tactic.Ring`, `import Mathlib.Analysis.Calculus.Deriv.Basic`,
  etc.). Importing the whole library is extremely slow and memory-heavy on
  this machine. If unsure which module provides a given lemma/tactic, look
  it up (e.g. via the Loogle/mathlib search or by checking the declaration's
  source file) rather than defaulting to a blanket import.

## Research status (will be updated over time)
No proofs have been formalized in this project yet — we are calibrating
the process with test theorems, not yet with original research results.

## LaTeX → Lean mapping notes
When formalizing, include a comment at the top of the .lean file stating
which LaTeX block (e.g. which `\label{}`) the proof corresponds to, so the
origin can be traced easily.

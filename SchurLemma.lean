-- prop:schur-lemma
import Mathlib.RingTheory.SimpleModule.Basic
import Mathlib.FieldTheory.IsAlgClosed.Spectrum
import Mathlib.LinearAlgebra.FiniteDimensional

variable {K : Type*} [Field K] [IsAlgClosed K]
variable {A : Type*} [Ring A] [Algebra K A]
variable {M N : Type*} [AddCommGroup M] [Module A M] [Module K M] [IsScalarTower K A M]
variable [AddCommGroup N] [Module A N] [Module K N] [IsScalarTower K A N]
variable [IsSimpleModule A M] [IsSimpleModule A N]

/-- Let A be a K-algebra and let M and N be two simple A-modules. Then, any A-module 
homomorphism M \to N is either the 0-map or an isomorphism. If moreover K is 
algebraically closed, then any isomorphism of simple modules is multiplication 
by some scalar \lambda \in K. -/
theorem schur_lemma (f : M →ₗ[A] N) : 
    (f = 0 ∨ Function.Bijective f) ∧ 
    (∀ (M' : Type*) [AddCommGroup M'] [Module A M'] [Module K M'] [IsScalarTower K A M'] 
       [IsSimpleModule A M'] [FiniteDimensional K M'] (g : M' ≃ₗ[A] M'), 
       ∃ λ : K, g.toLinearMap = λ • LinearMap.id) := by
  constructor
  · -- Part 1
    -- Step 1: Let f : M \to N be a homomorphism of A-modules.
    -- Step 2: Since ker(f) is a submodule of M, and since M is simple, ker(f) is either 0 or M.
    have h_ker := IsSimpleModule.eq_bot_or_eq_top (LinearMap.ker f)
    -- Step 3: If ker(f) = M, then f = 0.
    if h : LinearMap.ker f = ⊤ then
      left
      exact LinearMap.ker_eq_top.mp h
    else
      -- Step 4: Suppose that f \not= 0, so f is injective.
      have h_ker_bot : LinearMap.ker f = ⊥ := h_ker.resolve_right h
      have h_inj : Function.Injective f := LinearMap.ker_eq_bot.mp h_ker_bot
      -- Step 5: Since Im(f) is a submodule of N, it is either 0 or N by the same argument.
      have h_range := IsSimpleModule.eq_bot_or_eq_top (LinearMap.range f)
      -- Step 6: Since f \not= 0, we have Im(f) \not= 0, so Im(f) = N and thus f is an isomorphism.
      right
      have h_f_ne_zero : f ≠ 0 := by
        intro hf0
        apply h
        rw [hf0]
        exact LinearMap.ker_zero
      have h_range_ne_bot : LinearMap.range f ≠ ⊥ := by
        rw [Ne, LinearMap.range_eq_bot]
        exact h_f_ne_zero
      have h_range_top : LinearMap.range f = ⊤ := h_range.resolve_left h_range_ne_bot
      exact ⟨h_inj, LinearMap.range_eq_top.mp h_range_top⟩
  · -- Part 2
    intro M' _ _ _ _ _ _ g
    -- Step 7: Now, let f be an isomorphism. (Note: we use g here)
    -- Step 8: If K is algebraically closed, then f has an eigenvalue, \lambda, say.
    let g_K : M' →ₗ[K] M' := g.toLinearMap.restrictScalars K
    have h_nontrivial : Nontrivial M' := IsSimpleModule.nontrivial A M'
    obtain ⟨λ, hλ⟩ := spectrum.nonempty_of_isAlgClosed_of_finiteDimensional K g_K
    use λ
    -- Step 9: But f −\lambda\cdot Id is then also a homomorphism of simple modules
    let id_A : M' →ₗ[A] M' := LinearMap.id
    let g_minus_λid : M' →ₗ[A] M' := g.toLinearMap - λ • id_A
    -- Step 10: and by assumption, it has a kernel.
    have h_ker_nonzero : LinearMap.ker g_minus_λid ≠ ⊥ := by
      rw [spectrum.mem_iff, IsUnit.sub_iff, LinearMap.isUnit_iff_ker_eq_bot] at hλ
      -- g_K - λ • id_K has non-trivial kernel
      exact hλ
    -- Step 11: Thus, by the same argument, it is identically 0,
    have h_simple := IsSimpleModule.eq_bot_or_eq_top (LinearMap.ker g_minus_λid)
    have h_g_zero : g_minus_λid = 0 := LinearMap.ker_eq_top.mp (h_simple.resolve_left h_ker_nonzero)
    -- Step 12: so f = \lambda\cdot id
    rw [← sub_eq_zero]
    exact h_g_zero

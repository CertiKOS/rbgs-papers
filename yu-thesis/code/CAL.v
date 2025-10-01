Require Import Coq.Program.Tactics.
Require Import Lists.List.
Import ListNotations.
Generalizable All Variables.
Set Asymmetric Patterns.

Module Type CAL.

  Parameter Layer : Type -> Type -> Type.
  Parameter Impl : Type -> Type -> Type.

  Parameter exec : forall {E F S}, Impl E F -> Layer E S -> Layer F S.
  Parameter compose : forall {E F G}, Impl E F -> Impl F G -> Impl E G.

  Parameter ref : forall {E S1 S2} (R: S1 -> S2 -> Prop),
      Layer E S1 -> Layer E S2 -> Prop.

  Definition correct `(L1: Layer E1 S1) `(L2: Layer E2 S2) `(M: Impl E1 E2) :=
      exists R, ref R L2 (exec M L1).

  Lemma vertical_comp `{L1: Layer E1 S1} `{L2: Layer E2 S2} `{L3: Layer E3 S3}
      `(H1: correct L1 L2 M) `(H2: correct L2 L3 N) : correct L1 L3 (compose M N).
  Proof.
    destruct H1 as [R1 H1], H2 as [R2 H2].
  Admitted.

End CAL.

Record esig := { op :> Type; ar : op -> Type; }.

Arguments ar {_} _.

Definition Spec (E: esig) (S: Type) := forall (n: E), S -> option (ar n * S).

Inductive Free {E: esig} {A: Type} :=
  | Pure : A -> Free
  | Bind (n: E) : (ar n -> Free) -> Free.
Arguments Free : clear implicits.

Definition Impl (E: esig) (F: esig) := forall (n: F), Free E (ar n).

Fixpoint exec' {E A S} (T: Free E A) (L: Spec E S) (s: S) : option (A * S) :=
  match T with
  | Pure a => Some (a, s)
  | Bind e_op k => match L e_op s with
                    | Some (a, s') => exec' (k a) L s'
                    | None => None
                    end
  end.

Definition exec {E F S} (M: Impl E F) (L: Spec E S) : Spec F S :=
  fun f_op s => exec' (M f_op) L s.

Fixpoint seq {E A B} (T1: Free E A) (T2: A -> Free E B) : Free E B :=
  match T1 with
  | Pure a => T2 a
  | Bind e_op k => Bind e_op (fun a => seq (k a) T2)
  end.

Fixpoint compose' {E F A} (T: Free F A) (M: Impl E F) : Free E A :=
  match T with
  | Pure a => Pure a
  | Bind f_op k => seq (M f_op) (fun a => compose' (k a) M)
  end.

Definition compose {E F G} (M1: Impl E F) (M2: Impl F G) : Impl E G :=
  fun g_op => compose' (M2 g_op) M1.

Definition ref `(L1: Spec E S1) `(L2: Spec E S2) (R: S1 -> S2 -> Prop) :=
  forall m n s1 s1' s2, L1 m s1 = Some (n, s1') -> R s1 s2 ->
  exists s2', L2 m s2 = Some (n, s2') -> R s1' s2'.

Parameter val : Type.
Parameter N : nat.

Inductive rb_sig : esig :=
  | set (i : nat) (v : val) : rb_sig unit
  | get (i : nat) : rb_sig val
  | inc1 : rb_sig nat
  | inc2 : rb_sig nat.

Inductive bq_sig : esig :=
  | enq (v : val) : bq_sig unit
  | deq : bq_sig val.

Definition bq_state : Type := list val.

Definition rb_state : Type := (nat -> val) * nat * nat.

Definition L_bq : FSMonad bq_sig bq_state :=
  fun _ e s =>
    match e with
    | enq v => Some (tt, v :: s)
    | deq => match s with
             | [] => None
             | h :: t => Some (h, t)
             end
    end.

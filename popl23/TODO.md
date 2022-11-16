TODO list regarding the artefact

* Switch to more recent versions of Coq

* Transition systems equipped with bijections (Sec. 4)

We could potentially generalize bijections to lenses, which means given a
transition system `L : A ↠ B` we can lift it with a lens `f : (get: S → T, set:
(S × T) → S)` such that `L@f : A@T ↠ B@S`

* ClightP construction (Sec. 5)

Mostly done with supporting array and primitive types. Struggling with Ptrofs
and overflow issues, external call events, etc.

* Join operator for memory fragments (Sec. 5)

Implement a wrapper that enforces the active component to have the allocation
flag. We will also need a special operator to transfer ownership when
implementing the composition.

* CompCertO CKLR

    * generalize CKLR to support equality in addition to less-defined
    * prove the ` - • m` operator is a CKLR (mostly done in a less general way)

* Encapsulation (Sec. 6)

    - retrofit the encapsulation primitive to the current code.

    - symbol table

* rework CAL framework and implement bounded queue in the new framework

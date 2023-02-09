# Overview

## Importance of double category (Reviewer A, Reviewer C)

## Compare with CompCertO (Reviewer A, Reviewer B)

## Lack of case study (Reviewer B, Reviewer C)

## Example of verifying components at different level of abstractions (Reviewer C, Reviewer D)

The figure 3 on L246-LL257 describes this situation.

We could rework the bounded queue and ring buffer example by writing the bounded
queue directly in Asm. Then we can prove separately that the assembly program
Asm.bq refines Lbq and the clightp program C.rb refines Lrb with data
abstraction and encapsulation. The two correctness properties corresponds to π1
and π2 respectively. Then we apply the compiler to translate C.rb to Asm.rb and
the correctness property corresponds to π2'. Finally, the derivation tree gives
us the result that Asm.bq ∘ Asm.rb is a correct implementation of Lbq ∘ Lrb.


# Detailed Comments

## Reviewer A

> As one suggestion, the paper would be much more approachable if the formalism
> was grounded with additional concrete examples.

> The introduction suggests that the proposed verification framework supports a
> combination of features that other, well-known frameworks do not, e.g., VST,
> CompCertM, or CompCertO (the work this paper builds on top of). This statement
> would be more persuasive if accompanied by an exemplar program and property
> that these systems cannot handle, but the proposed one can

> Given that there is an implementation of this framework, including a
> collection of such programs as part of a practical evaluation would
> significantly strengthen the paper.

> Alternatively, many of the theorems (e.g., Theorems 3.8, 4.5, 4.6, and 6.3)
> lack any context or discussion.

This is due to the page limit. We will add more discussion to the appendix (maybe?)

> What do the numbers [1-4] in the diagram at 826 represent? Are these
> references to something else in the draft?

Notice the (1)-(4) in the following paragraph and they correspond to the [1-4]
in the string diagram. [1] and [2] are the compatibility conditions for ClightP
and Clight, and [3] and [4] are the properties of the simulation conventions.

> L139: The @ notation is not defined until page 5, making it hard to interpret
> these lines.

We will rephrase the paragraph before L139 to make it clear.

> L170: should 5@m[c1|->6] be 6@m[c1|->6]?

No, the function `inc1()` returns the current value of the counter and increases
it, as shown in Fig.2(a)

> L219: what is `*` ?

`*` is the value of type unit, and we will make it clear after revision.

> L324: I had trouble reading the correctness property on this line, adding an
> english description would be helpful.

Thanks for pointing it out. We will add a description.

> L397: What are the XXXs on either side of this figure?

Sorry, we forgot to delete them in the draft

> L583: ♯ and ♭ are subscripted elsewhere, should that be the case here?
Hmmm, the subscript vs superscript thing (TODO)

> L614: Is the : on the left of \LeftRightArrow intentional?

Yes, it is, and it means the relation on the left is defined as the right hand
side. This notation is also used on L538, L557, L630, etc.

> L631: Is there supposed to be an overline on A in
> \squigglyarrow_{\overline{A}B}? there's no corresponding bar on Line 654, for
> example.

L631 and L654 are talking about different state transitions. On L631, the state
of A is caller accessibility and the state of B is callee accessibility. However
on L654, flipped.

> L783: What is I here?

It is unit language interface defined in Def 2.7 on L305.


## Reviewer B

> Does that imply that mutual recursion is not supported (line 968 seems to
> suggest this as well)?

Yes, the lack of mutual recursion is a limitation of the current work.

> L473: The meaning of these diagrams is given in [14], but the explanation
> starting at Line 344 did not give me enough information to understand these. I
> think this figure requires more explanation. The same holds for Section 5.2.

> I think the related work misses work on compositional verification that does
> not incorporate certified compilation. For example, the BIP language of
> Bensalem et al. [1] allows compositional specification and verification, and
> is compilable.

> Finally, I think that the paragraph on interaction trees (line 942) does not
> clearly explain the delta between their works and this

## Reviewer C

> The paper starts by claiming a "verification framework" but there no examples
> of source-level verification.

In figure 2, we present the source program of the bounded queue and ring
buffer. The source programs are written in ClightP and are verified against
their specifications independently. Our framework encapsulates their local
states, composes the individual correctness together, and compiles the ClightP
programs to Asm programs with the correctness property preserved.

> I also think it would be nice to present the verification framework in way
> that is orthogonal to CompCertO, as verification of components should (in my
> opinion) happen in a compiler-independent way. Then you could specify what
> properties are needed by a verified compiler to be able to preserve the
> properties all the way to assembly. Finally, you could prove that CompCertO
> satisfy these requirements.


> In the derivation tree of lines 222-227 it is not clear how the leaves are
> proved. How one can prove that Σbq ⊑ Clight(bq.c) and Σrb ⊑ Clight(rb.c)?
> Does this constitute verification in the sense that some properties are proved
> about the source programs?

The leaves are the correctness of individual components and they have to proved
manually by establishing the simulation witnessed by a simulation relation. The
framework present in this work provides utilities to encapsulate their private
state so that they can be proved separately, and to compose them together as
shown in the derivation tree.

> Could you prove correctness for the ClightP translation with the previous
> CompCertO framework since CompCertO already has some support for state and
> allows linking of components that are written in different stages of the
> compilation chain?

Yes, we could. But the result is not particularly interesting because the source
level program explicitly carries its private state so that when interfacing with
other components, the state must passed around.

> How is the alternative composition operator is useful other than proving the
> categorical structure? Does it have additional benefits over the one used in
> CompCertO?

Other than proving the categorical structure, it is more useful because it
allows the caller and callee accessibility conditions, which are essential to
the state encapsulation in our formalization.

> Have you proved the Clight semantics that you use sound with respect to (a
> more widely used) operational model?

We hardly modify the Clight semantics from CompCertO.

## Reviewer D

> The motivation of this work seems to marry the CompCertO-style compiler
> verification and the CAL-style program verification. If this is the case, the
> work is not complete because it does not provide formal results about their
> combination.

> Otherwise, the motivation of this work is unclear (ie, what are the advantages
> of this framework over CAL?) and also some of the key ideas such as the
> threading operator is not new (already given in [8]) and the difference from
> [8] is also not clearly presented.

> Why module local states are exposed using the threading operator first and
> then encapsulated? If you didn't expose them in the first place as in CAL,
> then you don't need to hide them. Is it correct that the point of this process
> is to show their categorical construction?

This work is not to encapsulate the local states that are threaded. Instead, the
local states that we aim to encapsulate are exactly those other than the
threaded states, such as the memory state in Clight program and the abstract
state in the ring buffer. Those are the states that the program manipulates. It
is because these local states are exposed that we need to introduce the thread
operator so that the other components can interface with these "stateful"
components. For instance, in the Example 2.6 on L242, we have Σbq @ Drb ⊙ Lrb,
and Drb is threaded because we need to interface Σbq with Lrb. If we managed to
encapsulate the Drb in Lrb, then the composition will be cleaner as shown in Sec
6.1.

> I wonder whether the framework can support pointer value passing or data
> abstraction of function arguments that are not supported by CAL. Also, can it
> support the memory extension and injection relations that are supported by
> CompCertO?

> Could you elaborate more on the main differences from the work of [8]?

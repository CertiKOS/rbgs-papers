PLDI 2023 Paper #206 Reviews and Comments
===========================================================================
Paper #206 A Framework for Compositional Verification with Data
Abstraction, Encapsulated State and Certified Compilation


Review #206A
===========================================================================

Overall merit
-------------
3. Weak accept

Reviewer expertise
------------------
2. Some familiarity

Paper summary
-------------
The goal of this work is to enable verification of systems built from the composition of individual modules, so that the correctness of the entire system can be established via reasoning about individual components. To this end, the paper presents a formal model of these sorts systems. Importantly, this framework allows components to live at different levels of abstraction (e.g., some components might be in C, others might be assembly), and to have encapsulated state. This model furthermore naturally supports notions of refinement and simulation that allow, for example, users to formally prove that the model of a low-level assembly program refines the model of a high-level semantic specification, using the model of a composition of C translation units as a stepping stone.

The starting point for the presented model is that of the existing CompCertO compiler, which uses *transition systems*. These transition systems capture a component's interactions with an environment via a set of questions and answers. Linking two components together builds a
transition system in which each component answer the other's questions. In order to relate components at different levels of abstraction, this model supports a notion of simulation conventions between the questions and answers of two components. In contrast to the original model of CompCertO, this relation can be stateful; this allows the model to represent simulations between stateful and pure components, for example. Importantly, any verification results derived about a composition of assembly modules in this extension of CompCertO
transfer to linked assembly programs produced by Compcert.

The paper then extends the model with several features not supported by CompCertO. The first of these allows state to be attached to the questions and answers of a transition system, allowing for components to modify global state. The paper then describes an extension of
Clight with private variables, called ClightP, and shows how this can be compiled to Clight by erasing private annotations. A correctness property (encoded as a string diagram) is proven for this translation. The next change allows portions of state to be encapsulated, in that the surrounding environment is unable to access or modify private state. The model of simulations is then updated to account for components with encapsulated state.

Comments for authors
--------------------
The high-level motivation of this paper is quite appealing, as it attempts to build a rigorous formal model for representing the semantics of modular systems with differing levels of abstraction (e.g., high-level programming languages like C). I could certainly appreciate the goal of giving a precise characterization of the concepts of horizontal and vertical composition, often appear in the literature on verified compilation! It is somewhat unfortunate that this paper was assigned to me, however, as I am am not deeply familiar with either the semantic model of CompCert and its offshoots or much of the category theory used in this formalism. As such, it was quite difficult for me to understand the details of the proposed model and its potential applications. Indeed, I found Sections 5 + 6 quite inscrutable: as one example, the statement of correctness of the compilation of ClightP on line 806 is given as a string diagram, which I was unable to interpret. Similarly, I simply did not have the required background of category theory needed to understand the model of encapsulated state given in Section 6. This is particularly a problem because the paper does not provide an evaluation of the proposed framework, meaning that the formalism itself is the main contribution, and the current presentation makes it quite hard for non-experts to appreciate this contribution.

As one suggestion, the paper would be much more approachable if the formalism was grounded with additional concrete examples. The introduction suggests that the proposed verification framework supports a combination of features that other, well-known frameworks do not, e.g., VST, CompCertM, or CompCertO (the work this paper builds on top
of). This statement would be more persuasive if accompanied by an exemplar program and property that these systems cannot handle, but the proposed one can (the program in Figure 2 may be one such example, but this is not directly stated). Given that there is an implementation of this framework, including a collection of such programs as part of a practical evaluation would significantly strengthen the paper. Such a study would help to highlight potential impact and could make me a more enthusiastic supporter of this paper.

Alternatively, many of the theorems (e.g., Theorems 3.8, 4.5, 4.6, and 6.3) lack any context or discussion. Theorem 3.8 states that the base model is a thin double category, for example, but doesn't state if there are any important consequences of this fact. In a similar vein, several key properties and proofs are given as diagrams, e.g., the correctness property on line 805, the proof strategy on line 826, and the claim on line 841, without any accompanying descriptions. (This complaint is independent of the fact a diagram is used-- most notation-heavy mathematical statements benefit from an accompanying informal description.)

In summary, I am quite sympathetic to the high-level goals of the paper, but the current presentation is too dense for me (and, I worry, most members of the PLDI community) to appreciate the technical contributions.

Minor Comments:

- The authors may want to check out "Conditional Contextual Refinement" by Song et al. at POPL'23-- while the technical approach is different, the high-level motivation is quite similar to this work.

- The use of handwritten diagrams is somewhat charming, but some were quite difficult to read, particularly when reading a hard copy.

- What do the numbers [1-4] in the diagram at 826 represent? Are these references to something else in the draft?

Typos / Specific Comments:

- Line 75: There is a dangling reference (most likely to a section in the appendix).

- Lines 139+140: The _@_ notation is not defined until page 5, making
  it hard to interpret these lines (as well as several subsequent ones).

- Line 170: should 5@m[c1|->6] be 6@m[c1|->6]?

- Line 219: what is `*` ?

- Line 324: I had trouble reading the correctness property on this
  line, adding an english description would be helpful.

- Line 397: What are the XXXs on either side of this figure?

- Line 426: Another dangling reference (again, most likely to a section in the appendix).

- Line 518: an call in C --> a call in C

- Line 583: $\sharp$ and $\flat$ are subscripted elsewhere, should
  that be the case here?

- Line 614: Is the : on the left of $\LeftRightArrow$ intentional?

- Line 631: Is there supposed to be an overline on A in
  $\squigglyarrow_{\overline{A}B}$? there's no corresponding bar on
  Line 654, for example.

- Line 783: What is $\mathbf{I}$ here?

- Line 871: where morphism take --> where morphisms take



Review #206B
===========================================================================

Overall merit
-------------
3. Weak accept

Reviewer expertise
------------------
2. Some familiarity

Paper summary
-------------
The paper concerns an approach to modular verified compilation, i.e., proving program correctness by specifying and verifying components. Compiling components that are each individually verified results in correctness of the whole program. Similar approaches exists (e.g., Compositional CompCert) but the presented approach allows *data abstraction* (each component may have its own abstract domain for values) and *state encapsulation* (components may have private variables). Components come each with their own notion of correctness: for example, the state of the components can be defined using their own state instead of a whole state, and can be defined using their own data domains. Compiler correctness is then defined as a simulation property that composes horizontally and vertically.

Comments for authors
--------------------
A key strength of this paper is that it identifies an underlying theoretical foundation for horizontal and vertical composition, based on existing notions from category theory. The relevance of exposing that underlying structure is argued by the fact that it enables the use of string diagrams to model the facets occurring in compositional reasoning (i.e., specification, interfaces, etc.). Since the work is embedded within the mature CompCert line of research, this promises practical applicability. I am convinced by the argument made by the authors that this work advances the state-of-the-art towards construction of large verified systems. For these reasons, I am leaning towards recommending acceptance of this paper.

# Comments

At line 180, the authors explain that the generic $\oplus_A$ operator from CompCertO can be replaced with a simpler $\odot_{A,B,C}$ operator when there is no mutual recursion. The remainder of the paper seems to be based on the $\odot$ operator. Does that imply that mutual recursion is not supported (line 968 seems to suggest this as well)? Theorem 3.9 is defined only for $\odot$ as well. If so, then I think the authors should more explicitly formulate this as a limitation of the current work.

At line 473, I did not understand the meaning of the diagrams. The meaning of these diagrams is given in [14], but the explanation starting at Line 344 did not give me enough information to understand these. I think this figure requires more explanation. The same holds for Section 5.2.

I would have loved to have seen presentation of some case study: a program that monolithically is too large/complex to be handled using traditional CompCert, but where decomposing the program into components allows per-component verification. 


I think the related work misses work on compositional verification that does not incorporate certified compilation. For example, the BIP language of Bensalem et al. [1] allows compositional specification and verification, and is compilable. Also, the authors do not explain in Section 7 the delta between this work and CompCertO (even though Section 2.8 hints at this). Finally, I think that the paragraph on interaction trees (line 942) does not clearly explain the delta between their works and this. Stating that “their interface with CompCert is less comprehensive” was not sufficiently explanatory for me. I also think it is valuable to mention that those works have been applied to some case studies (a networked server), in contrast to this work.

[1] Saddek Bensalem, Marius Bozga, Joseph Sifakis, Thanh-Hung Nguyen: Compositional Verification for Component-Based Systems and Application. ATVA 2008: 64-79


In terms of presentation, the paper feels unfinished to me. Several references are not compiled properly (also in the additional material), producing question marks, and figures are drawn by hand. This should be fixed in a final version. However, since it did not thwart understanding of the paper, I have not let it influence my opinion.


# Minor things
- line 135: At first read it was unclear to me wat “ident” is here.
- line 219: At first read, it was unclear to me what the \Sigma symbol was used for
- line 936: the sentence “making it possible …” is grammatically incorrect
- line 953: “which allows to abstraction” —> “which allows abstraction”
- line 962: "which use for ..." is grammatically incorrect



Review #206C
===========================================================================

Overall merit
-------------
2. Weak reject

Reviewer expertise
------------------
2. Some familiarity

Paper summary
-------------
The paper extends the framework of CompCertO with compositional treatment of state. Using this framework the authors prove correctness of a pass from ClightP (Clight extended with private annotations for global variables, making them inaccessible to other modules) to Clight. That provides a guarantee that private variables are encapsulated and access to them can happen only through the code of the module.

The authors provide an alternative definition for module composition that allows them to show that the framework of CompCertO has the structure of a double category.

Comments for authors
--------------------
First of all, the paper is extremely hard to read. The contributions are hard to identify and it is very unclear how is the suggested framework different than the one of CompCertO. 

- The paper starts by claiming a "verification framework" but there no examples of source-level verification. The only property that it is proved (*) is state encapsulation, but this alone is far from claiming a verification framework. In addition, the framework presented is very specific to CompCertO and it is compiler verification framework rather than a general (source-level) verification framework which is what the introduction seems to imply. If the Clight semantics of CompCertO are used to prove any source level properties, then this is not clear in the presentation.  
  
  (*) I wouldn't even say that this property proved. It is provided by the semantics of ClightP, and it is guaranteed to be preserved by the verified compiler. As far as I can tell, any verified compiler with support for linking would prove preservation of such property. 

  I think the paper would befit greatly by applications of this framework to different examples showing verification of source components, ideally at different level of abstraction (as hinted by the introduction).

  I also think it would be nice to present the verification framework in way that is orthogonal to CompCertO, as verification of components should (in my opinion) happen in a compiler-independent way. Then you could specify what properties are needed by a verified compiler to be able to preserve the properties all the way to assembly. Finally, you could prove that CompCertO satisfy these requirements. 

- In the derivation tree of lines 222-227 it is not clear how the leaves are proved. How one can prove that $\Sigma_{bq} \sqsubseteq Clight(bq.c)$ and $\Sigma_{rb} \sqsubseteq Clight(rb.c)$? Does this constitute verification in the sense that some properties are proved about the source programs? 

- Could you prove correctness for the ClightP translation with the previous CompCertO framework since CompCertO already has some support for state and allows linking of components that are written in different stages of the compilation chain?
 
- It is not clear to me how important is the contribution that the semantic model has a double category structure. The semantic model of CompCertO is already composable both vertically and horizontally. What are the added benefits?

- How is the alternative composition operator is useful other than proving the categorical structure? Does it have additional benefits over the one used in CompCertO?

- Have you proved the Clight semantics that you use sound with respect to (a more widely used) operational model?

Minor
------
- line 75: missing citation
- line 144: there is no (a) in Fig. 1.
- line 226: missing citation
- line 963, typo: "which *we* use"



Review #206D
===========================================================================

Overall merit
-------------
2. Weak reject

Reviewer expertise
------------------
4. Expert

Paper summary
-------------
This paper proposes a framework for refinement-based compositional verification.
The framework is based on CompCertO's semantic models and simulation relations
but extended with the state threading operator @
to allow data abstraction in the style of CAL (Certified Abstraction Layers),
which involves addressing several technical challenges.
Then, to hide a component's local states from its client, it supports a mechanism to encapsulate such states.
The paper also comes with an example consisting of a ring buffer and a bounded queue using it
and their compositional verification.

Comments for authors
--------------------
* Pros
- It presents a compositional verification framework that can combine both CompCertO-style compiler verification and CAL-style program verification.
- It presents category theoretical explanations and proofs about the framework.

* Cons
- The motivation of the work is not very clear.
- The presentation is too abstract.
- It does not present linking between CompCertO's verification and program verification using the presented framework.
- There is no example of state encapsulation (in particular, CompCertP is not formalized).

* Comments

The motivation of this work seems to marry the CompCertO-style compiler verification and the CAL-style program verification.
If this is the case, the work is not complete because it does not provide formal results about their combination.
Otherwise, the motivation of this work is unclear (ie, what are the advantages of this framework over CAL?) and
also some of the key ideas such as the threading operator is not new (already given in [8]) and the difference from [8]
is also not clearly presented.

Specifically, supporting the following verification scenario would be an important motivation and contribution.

1. A1 in Asm refines C1 in C, proven by CompCertO, where A1 is the code compiled from C1 by CompCertO
2. C1 in C refines L1 (with data abstraction and encapsulation), proven by this framework
3. A2 in Asm refines L2 (with data abstraction and encapsulation), proven by this framework

Then a composition theorem of this framework should compose these three to get a proof that A1 o A2 refines L1 o L2.
However, the presented work does not seem to support this scenario yet.
It would be really nice if the authors could further develop this work to support it.

Here are some questions.

- Why module local states are exposed using the threading operator first and then encapsulated?
  If you didn't expose them in the first place as in CAL, then you don't need to hide them.
  Is it correct that the point of this process is to show their categorical construction?

- I wonder whether the framework can support pointer value passing or data abstraction of function arguments that are not supported by CAL.
  Also, can it support the memory extension and injection relations that are supported by CompCertO?

- Could you elaborate more on the main differences from the work of [8]?

* Typos

- L400: L_bq@mem => L_rb@mem

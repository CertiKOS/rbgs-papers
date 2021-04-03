% CompCertO: Compiling Certified Open Components
% Jeremie Koenig; Zhong Shao
% March 4, 2021

Our artifact is a version of the certified compiler CompCert, designed
to be used as a component in other software verification efforts.
Evaluating the artifact should mostly consist in checking that the
definitions and proofs in the Coq code corresponds to their high-level
description given in the paper.

---

## Getting started

There are two possible ways to proceed: build CompCertO from scratch in
you own Linux environment, or use the virtual machine image we provide.

### Quick links

  * Browse the development:
    [online](https://certikos.github.io/compcert/doc/) |
    [vm](file:///home/aec/compcerto-prebuilt/doc/index.html)
  * CompCertO release:
    [online](https://certikos.github.io/compcert/compcerto-0.1.tar.bz2) |
    [vm](file:///home/aec/compcerto-0.1.tar.bz2)
    (MD5: 68da74fe23be11350358beb943d53ef1)
  * VirtualBox image:
    [online](https://drive.google.com/drive/folders/1imN-V7trdxEGZODyhIJJxxjiRVEYrDWB)

### Building in your own environment

Our development has been packaged into a `compcerto-0.1.tar.bz2` archive.
Build instructions can be found in the `README.md` file. In particular,
they describe how to use `opam` to set up a temporary build environment
with tested versions of the dependencies, under you user account.

If you would prefer to use your own Linux environment and a lighter
download, the standalone tarball can be downloaded using the link above.
Otherwise, we recommend you download the virtual machine image we
provided in HotCRP, which includes `compcerto-0.1.tar.bz2` in its file
system.

### Using our virtual machine image

The file `CompCertO.ova` submitted as our artifact is a virtual machine
image containing a standard installation of Debian GNU/Linux where an
appropriate build environment for CompCertO has been set up. The image
is designed for use with [VirtualBox 6.1](https://www.virtualbox.org/).

In VirtualBox, choose "File > Import Appliance" to import the image,
then start the new virtual machine. Log in with:

  * Username: aec
  * Password: pldi21

By clicking "Activities" in the upper right corner, you will be able to
open a terminal or run applications like Firefox and CoqIDE.
In particular, an HTML version of this document has been set as the
Firefox start page.

The home directory `/home/aec` contains a copy of `compcerto-0.1.tar.bz2`.
It can be extracted as usual with the following command:

    $ tar -jxf compcerto-0.1.tar.bz2

You may then follow the instructions in `compcerto/README.md`. Note that
an appropriate `opam` environment has already been set up for you.

Alternatively, we have provided a pre-built version of CompCertO under
the `compcerto-prebuilt/` directory. This will allow you to immediately
browse the generated documentation (which has been set as the Firefox
home page), and replay any proof within CoqIDE.

### Browsing the development

We recommend browsing the code using the generated coqdoc-style HTML
pages (see links at the beginning of this document). They will end up
in the `doc/html/` subdirectory after they are built using `make
documentation`. The file `doc/index.html` provides an overview of
CompCert and table of contents. We have updated it to highlight the
changes made in CompCertO.

The archive includes a `compcerto.diff` file which lists our changes
relative to CompCert v3.6, but for a more convenient experience you can
clone our git repository and examine the version corresponding to our
artifact (this has already been done in the VM image):

    $ git clone https://github.com/CertiKOS/compcert.git compcerto-gitclone
    $ cd compcerto-gitclone/
    $ git checkout compcerto-0.1

You will then be able to display changes to individual files:

    $ git diff v3.6 common/Smallstep.v

---

## Step by Step Instructions

Since our artifact is a Coq proof, we suggest the reviewers use the
paper as a guide to the code. A copy of the paper is available in the
virtual machine as `/home/aec/pldi21-paper596.pdf`, and we recommend
browsing the code through the generated HTML files, starting with the
overview given in `/home/aec/compcerto-prebuilt/doc/index.html`.

To help with the process, below we go through our various definitions
and theorem and discuss the correspondence with the Coq development.

### Operational semantics (Sec. 3)

Sections 2 and 3 introduce our extended semantic model and our main
results. They are implemented in Coq as follows. 

  | Paper    | File                       | Definition
  | -------: | -------------------------- | -----------------------------------
  | Def. 2.1 | common/LanguageInterface.v | `language_interface`
  | Def. 2.6 | common/LanguageInterface.v | `callconv`
  | Def. 3.1 | common/Smallstep.v         | `lts`
  | Def. 3.2 | common/SmallstepLinking.v  | `compose`
  | Def. 3.3 | common/Smallstep.v         | `forward_simulation`
  | Thm. 3.4 | common/SmallstepLinking.v  | `compose_simulation`
  | Thm. 3.5 | x86/AsmLinking.v           | `asm_linking`
  | Def. 3.6 | common/LanguageInterface.v | `cc_compose`
  | Thm. 3.7 | common/Smallstep.v         | `compose_forward_simulations`
  | Thm. 3.8 | driver/Compiler.v          | `clight_semantic_preservation`
  | Cor. 3.9 | driver/Compiler.v          | `compose_transf_c_program_correct`

The Kleene algebra mentioned at the end of Section 3.3 is formalized in
common/CallconvAlgebra.v. The memory model used in CompCert (Figure 4)
is formalized in common/Memory.v.

The language interfaces used for various languages (Table 2) can be
found in the following files.

  | L.I.  | File                       | Definition
  | ----- | -------------------------- | ------------
  | C     | common/LanguageInterface.v | `li_c`
  | L     | backend/Conventions.v      | `li_locset`
  | M     | backend/Mach.v             | `li_mach`
  | A     | x86/Asm.v                  | `li_asm`
  | 1     | common/LanguageInterface.v | `li_null`
  | W     | common/LanguageInterface.v | `li_wp`

The correctness proofs for the various compilation passes (Table 3) can
be found in the subdirectories `cfrontend/`, `backend/` and `x86/`,
depending on the pass. For the pass FooBar, the proof will be in file
named `FooBarproof.v`; usually the main simulation theorem is located at
the end of the file.

Note that there are minor differences between the paper and the artifact
in the specific language interfaces and simulation conventions used for
some languages and passes. See also our discussion of Section 5 below.

### Logical relations for CompCert (Sec. 4)

The theory of CompCert Kripke logical relations (CKLRs) is formalized in
the `cklr/` subdirectory, new in CompCertO. To automate relational
reasoning, we are using the [Coqrel](http://certikos.github.io/coqrel/)
library, included in the source under the `coqrel/` subdirectory.

The definition of CKLR (Section 4.4, Figure 6) is found in cklr/CKLR.v.
The basic theory is developed further in cklr/CKLRAlgebra.v.

We then defines a number of specific CKLRs, used to formulate the
simulation convention for various passes and to derive the compiler's
overall convention:

  | CKLR  | File                     | See also
  | ----- | ------------------------ | --------
  | ext   | cklr/Extends.v           | Sec 4.1
  | inj   | cklr/Inject.v            | Sec 4.2
  | injp  | cklr/InjectFootprint.v   | Sec 4.5
  | vaext | cklr/VAExtends.v         | 
  | vainj | cklr/VAInject.v          | 

As described in Section 4.4 under *Simulation conventions*, CKLRs can be
promoted to simulation conventions for various language interfaces:

  | L.I.  | File                       | Definition
  | ----- | -------------------------- | -----------
  | C     | common/LanguageInterface.v | `cc_c`
  | L     | backend/Conventions.v      | `cc_locset`
  | M     | backend/Mach.v             | `cc_mach`
  | A     | x86/Asm.v                  | `cc_asm`

These conventions can then be used to express parametricity theorems for
various languages (Theorem 4.3):

  | Language | File             | Definition
  | -------- | ---------------- | -------------------
  | Clight   | cklr/Clightrel.v | `semantics1_rel`
  | RTL      | cklr/RTLrel.v    | `semantics_rel`
  | Asm      | x86/Asmrel.v     | `semantics_asm_rel`

### Calling convention (Sec. 5)

Compared with the paper, the artifact includes improvements to the way
we derive the compiler's overall simulation convention from the
simulation convention of each pass. While the general idea remains the
same, the approach implemented in this version of CompCertO is more
systematic and uniform. We indent to update our paper to describe these
changes.

Our approach is described in detail in the file driver/CallConv.v.
The main simulation conventions involved are the following:

  | Sim. Conv. | File                    | Definition
  | ---------- | ----------------------- | ----------------
  | CL         | backend/Conventions.v   | `cc_c_locset`
  | LM         | driver/CallConv.v       | `cc_locset_mach`
  | MA         | x86/Asm.v               | `cc_mach_asm`
  | wt         | common/Invariant.v      | `wt_c`
  | va         | backend/ValueAnalysis.v | `vamatch`
  | ℂ          | driver/Compiler.v       | `cc_compcert`

The main result established in CallConv.v, and used in Compiler.v to
derive our final correctness theorem, is that CKLRs can commute over the
simulation conventions CL, LM, MA. This allows the incoming Asm-level
injection to be expanded and propagated to match the incoming
requirements of the various passes, and outgoing CKLRs to be propagated
to the source level where the can be matched by the Kleene star
component of the overall simulation convention.

Because CKLRs do not commute in the **va** invariant in the same way,
we have defined the CKLRs **vaext** and **vainj** which enforce this
invariant on their source memory states.

### Evaluation (Sec. 6)

To obtain the numbers reported in Table 3 and Table 5, we used the script
`overhead.py` included at the root of our development. The script will only
function in a git repository (`/home/aec/compcerto-gitclone/` in the VM).
`overhead.py` uses `coqwc` to compare the lines of specifications,
proofs, and both in the currently checked out version, vs. the
`origin/compcerto-ref` branch found in our github repository.

In CompCertO, some of the code in backend/Cminor.v is unused and has
been commented out. To avoid `coqwc` reporting an artificial decrease in
the SLOCs for that file, we have made the same modification in the
`compcerto-ref` branch, which is otherwise identical to CompCert v3.6.

To run the script, use the following command:

    $ python3 overhead.py

The numbers we used in the paper were approximative and correspond to a
previous version of our development based on CompCert v3.5. Because of
the changes described in the previous section and our upgrade to
CompCert v3.6, the numbers reported are now slightly different from
those in the submitted paper, however they remain commensurable. We will
update our final paper with up-to-date numbers.

---

## Conclusion

Thank you for evaluating our CompCertO artifact!


# Waiting from Jeremie:

- his COA form
- his NSF bio


# Proposal Outline and TODOs

SHF: Unifying Program Verification and Certified Compilation for Heterogeneous System Verification

Heterogeneous systems consist of a multitude of components which are written in different programming languages and may capture different semantic objects at different abstraction levels.

This project will develop a novel refinement-based framework for specifying, verifying, and composing heterogeneous systems. The main idea is to develop an algebraic game semantic approach to unify the formalism used for compositional program verification and compositional certified compilation while addressing challenging features such as concurrency, probablistic effects, and information-flow security.




## project summary (1 page)

CompCert has been around for more than 10 years. It is one of the
most ... However, it has not been used for building realistic systems
because of the following limitations:

- not compositional 
- not end-to-end
- not supporting secure compilation

PI Shao's group has been leading multiple efforts on
improving CompCert to address these features. However, they have
not been combined together into a single compiler.
There are a few interesting new opportunities on how to build
a truly compositional CompCert that is end-to-end and security-presering.
  
We propose to address these problems by focusing on the following
techniques:

- CompCertO + Nominal Stack-Aware CompCert
- CompCertELF + CompCertO
- CompCertOX for Certified Abstraction Layer
- Fully Abstract Compilation and Robustly Safe Compilation

## project description (15 pages)

- Introduction (3 pages)

- Task 1: Compositional Verified Compilation via CompCertO

  - Task 1a Add support for unused-globals and symbol table manipulation
  - Task 1b Add support for first-class code pointers
  - Task 1c Extend CompCertO to support multiple backends; and port it to the latest realese.

- Task 2: Verified Compilation with a Nominal Memory Model 

  - Task 2a nominal compcert with structural memory injection 
  - Task 2b building norminal compcerto (simplified injection proofs)
  - Task 2c building norminal compcerto for concurrent programs

- Task 3: Verified Compilation into ELF Object Files (Stack-Aware Assembler via CompCertELF)

  - Task 3a nominal multistack compcerto 
  - Task 3b building certified assembler with encoder & decoder.
  - Task 3c building certified linker and loader

- Task 4: Verified Secure Compilation  (2 pages)
    (CompCertOX + Full Abstraction + Robustly Secure Compilation)

  - Task 4a Initial CompCertOX to support the device driver example
  - Task 4b General framework for CAL and security-preserving compilation
  - Task 4c Connection with full abstraction and robustly safe compilation?

- Task 5: Evaluation and Integration (1 page)
    Talk more about supporting CCAL, CertiKOS, and DeepSEA

  - Task 5a CompCertX-style linking of CCAL layers (c and assembly layers)
  - Task 5b End-to-end security-preserving refinement for CertiKOS
  - Task 5c Develop the DeepSEA backend and VST backend for building end-to-end verified user-level application on certified OS kernels
            

- Schedule and Milestones (0.5 pages)

- Broader Impact (1 page)

  Talk about the education plan and BPC 

- Results from Prior NSF Support (0.5 pages)

## references cited (auto generated)


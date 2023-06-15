# CompCertOE paper

  - Polish Sec. 2

    - [x] Make sure notations are consistent

    - [x] Drop CompCertO's string diagrams? [yes]

    - [x] Improve 2.4

    - [x] Decide on figures

    - [x] Tikz string diagrams

  - Rewrite Sec. 3 [June 3rd]

    - Follow this outline [5/26]

      - Layered composition [5/19]

        - [x] Description

        - [x] Simulations

        - [x] Double category

        - [x] String diagrams

        - [x] Companions and conjoints

      - Spatial composition [5/23]

        - [x] Motivation

        - [x] Adjoining state

        - [x] Simulation conventions

        - [x] Lenses

        - [x] String diagrams

      - [x] Memory separation

      - [ ] Encapsulation

      - Applications

        - [ ] ClightP

        - [ ] CAL

    - Other tasks

      - [x] Tweak/redistribute Sec. 2.4

      - [ ] Explain (+) as fixpoint, approximated by (.)

      - Better treatment of companion / conjoint

        - [x] Before encapsulation

        - [x] Explain *_mem

      - Add summary of compositional structure

        - [x] 3D string diagram

        - [x] New treatment of active vs. passive

  - ClightP improvements

    - [ ] Frame as an application

    - [ ] Use the simpler proof Clight(M)@m*

  - [x] Make sure examples thread nicely / are complete but not redundant [June 1st]

  - Discuss more related work

    - [x] CCR

    - [ ] Interaction trees

    - [ ] BIP? (Bensalem et al)

# Unusedglob

  - Attempt with existing CompCertO [5/19]

    - [x] Figure out what breaks

    - [ ] Write down document

  - New approach to Genv

    - [ ] Revert to upstream Globalenv.v

    - [ ] Add new constructor with Senv.t oracle

    - [ ] Fix what breaks in common code

    - [ ] Fix a simple pass to validate

  - Update Unusedglob proof

    - [ ] Update any needed dependencies (reachability analysis?)

    - Simulation convention

      - [ ] Can injp/inj be made to fit?

    - [ ] Update proof


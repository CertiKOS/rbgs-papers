# CompCertOE paper

  - Polish Sec. 2

    - [x] Make sure notations are consistent

    - [x] Drop CompCertO's string diagrams? [yes]

    - [x] Improve 2.4

    - [x] Decide on figures

    - [x] Tikz string diagrams

  - Rewrite Sec. 3

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

        - [ ] String diagrams

      - [x] Memory separation

      - [ ] Encapsulation

      - Applications

        - [ ] ClightP

        - [ ] CAL

    - Other tasks

      - [ ] Tweak/redistribute Sec. 2.4

      - [ ] Explain (+) as fixpoint, approximated by (.)

      - Better treatment of companion / conjoint

        - [ ] Before encapsulation

        - [ ] Explain *_mem

      - Add summary of compositional structure

        - [ ] 3D string diagram

        - [ ] New treatment of active vs. passive

  - ClightP improvements

    - [ ] Frame as an application

    - [ ] Use the simpler proof Clight(M)@m*

  - [ ] Make sure examples thread nicely / are complete but not redundant

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


# Workflow Reproducibility - renv

R package updates may affect the reproducibility of this github repository. The following `renv` code was used to capture the state of the project library when this repository was fully functional on a local machine.

Documentation for `renv`, including the code copied below, can be found [here](https://rstudio.github.io/renv/articles/renv.html)

<br>

Saving the state of the project library

1. Opened the *ParticipationNetworks* R Project
2. Initialized a new project-local environment with a private R library: `rev::init()`
3. Checked to ensure all packages from cripts 00 - 10, and those in the "figures" folder, were installed (they were)
4. Saved the state of the project library: `rev::snapshot`

<br>

To load the the project library

1. Install `renv`: `install.packages("renv")`
2. Open the *ParticipationNetworks* R Project, or your own R project
3. Load environment: `rev::restore()`
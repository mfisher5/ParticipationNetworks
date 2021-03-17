# Workflow Reproducibility - renv

R package updates may affect the reproducibility of this github repository. The following `renv` code was used to capture the state of the project library when this repository was fully functional on a local machine.

Documentation for `renv`, including the code copied below, can be found [here](https://rstudio.github.io/renv/articles/renv.html)

<br>

```
install.packages("renv")
# getwd() # check working directory
rev::init()
```

*Checked to ensure all packages from scripts 00 - 10, and those in the "figures" folder, were installed*

```
rev::snapshot()
```
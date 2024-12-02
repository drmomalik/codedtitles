
How do I use codedtitles in R? This vignette will go through some of the functionality of this package and scenarios where it may be helpful.

Load the package:

```{r setup}
library(devtools)
devtools::install_github("drmomalik/codedtitles")
library(codedtitles)
```

### Overview

-   "codedtitles" is a package designed to make the pre-processing of variables simpler prior to moving forward with analysis.

-   The motivation for this package was born out of our own clinical research experience. For example, a large surgical database with over 200 variables was provided for analysis. None of the column titles had proper coding and many contained special characters and spaces, which would make it syntactically challenging to deal with in R. Given that many of these databases are collected by clinicians or people without statistical software experience, they may not be familiar with the role of variable coding. As such, we have attempted to create a novel, simple solution to speed up this process.

### Example dataframe

```{r}
data <- df
colnames(data)
```

-   Here is an example dataframe that contains some example variable names that may be handed to a statistician. As we can see, a number of this variables have long names, some with special characters, some have very similar names too.

### Case 1: Base function

-   First, we will demonstrate the base function of the package. This will organize all the column names by shortening the stem words, making them lower case and removing special characters.

```{r}
new_names <- codevar(data)
```

-   The output here shows our new names which have been simplified. If we want to reference these new names to the old names, we can call "coderef".

```{r}
print(coderef)
```

# Computing the Path to Employment: Understanding the Impact of Computer Knowledge in India

**Author:** Rajat Chhabra
**Course:** Coding Basics with Economic Applications (EC410)
**Instructor:** Prof. Devesh Birwal

## Overview

This project studies how computer literacy relates to employment outcomes in India, using unit-level data from the **NSS 78th Round Multiple Indicator Survey (MIS)** conducted by MoSPI between January and December 2020. It also identifies the socio-economic determinants of computer knowledge and tests whether the employment effect of computer literacy differs between India's richest and poorest states.

## Repository Contents

| File | Description |
|---|---|
| `My_Research_Paper_and_Results.pdf` | Full write-up: introduction, literature review, data handling methodology, variable construction, exploratory charts, regression models, and results |
| `R_Code_File.R` | Complete R script used to load, merge, clean, and analyze the NSS MIS data, and to generate all figures and regression tables in the paper |

## Research Objectives

1. Analyze the influence of computer skills on employment levels in India
2. Identify the factors that determine an individual's computer knowledge
3. Compare the impact of computer knowledge on employment between high-income and low-income states

## Data

- **Source:** NSS 78th Round, Multiple Indicator Survey (MIS), Blocks 3, 4, and 5 (Levels 2, 3, 4, and 7)
- **Coverage period:** January–December 2020
- **Access:** Publicly available raw fixed-width text files from the MoSPI website (not included in this repository; the R script expects local file paths — see [Reproducing the Analysis](#reproducing-the-analysis))
- **Sample after filtering:** 268,687 individuals aged 15+ who were ever enrolled in school but not currently enrolled

## Key Variables

| Variable | Symbol | Type | Description |
|---|---|---|---|
| Employment Status | `employment_status` | Binary | 1 = employed, 0 = unemployed |
| Computer Knowledge Score | `comp_know_count` | Count (0–9) | Sum of 9 binary computer-skill indicators |
| Education Level | `higher_educ`, `ug`, `pg_and_above` | Dummies | High school, undergraduate, postgraduate+ |
| Household Monthly Expenditure | `hh_monthly_exp` | Continuous | Proxy for household income |
| Gender | `gender` | Binary | 1 = male, 0 = female |
| Age | `age` | Continuous | Years |
| Social Group | `soc_grp_var` | Binary | 1 = SC/ST/OBC, 0 = other |
| Mass Media Access | `mass_media` | Binary | Internet, newspaper, or magazine access |
| Broadband Availability | `broadband` | Binary | Household has broadband |

Full derivation details (source item numbers, coding rules) are documented in the paper's "Variable Description and Creation" section.

## Methodology

1. **Data preparation:** Fixed-width files for Levels 2, 3, 4, and 7 are read with `readr::read_fwf`, given composite primary keys, and merged in R.
2. **Filtering:** Restricted to individuals aged 15+ who are no longer enrolled in education; state-level average expenditure is used to define the 5 richest and 5 poorest states.
3. **Exploratory analysis:** State-wise bar charts of computer knowledge, employment proportion, education attainment, and household expenditure (Figures 1–5 in the paper).
4. **Logistic regression** — tests whether computer knowledge predicts employment, run overall and separately for the richest 5 and poorest 5 states.
5. **Poisson regression** — tests which socio-economic factors predict the computer knowledge score, run overall and by state group.
6. **Two-sample t-test** — compares the computer-knowledge coefficient from the logistic models between richest and poorest states to test for regional heterogeneity.

## Key Findings

- Computer knowledge is positively and significantly associated with employment: each additional skill point raises the odds of employment by **~5.7%** overall (p < 0.01).
- This effect is notably **stronger in richer states (~10.2%)** than in poorer states (~3.2%); a t-test rejects the null of equal coefficients at the 1% level.
- Education level coefficients are unexpectedly **negative** for employment — possibly reflecting weak 2020 labor market conditions or sampling bias — while education is strongly **positive** for predicting computer knowledge itself.
- Household expenditure, mass media access, and especially **broadband availability** are strong positive predictors of computer knowledge.

## Reproducing the Analysis

1. Download the NSS 78th Round MIS raw data files (`ms51l02.TXT`, `ms51l03.TXT`, `ms51l04.TXT`, `ms51l07.TXT`) from the MoSPI website.
2. Update the file paths in `R_Code_File.R` (currently hard-coded to a local Windows directory) to point to your downloaded files.
3. Install required R packages:
   ```r
   install.packages(c("readr", "dplyr", "ggplot2", "stargazer"))
   ```
4. Run the script top to bottom. It will:
   - Load and merge the four data levels
   - Construct all analysis variables
   - Produce the five exploratory figures
   - Fit the logistic and Poisson regression models (overall, richest 5, poorest 5)
   - Export regression tables as `emp_reg.html` and `comp_reg.html` via `stargazer`
   - Run the t-test comparing regional coefficients

## Dependencies

- R (≥ 4.0 recommended)
- Packages: `readr`, `dplyr`, `ggplot2`, `stargazer`

## Notes

- The R script currently contains an absolute local file path; this should be parameterized (e.g., via a config variable or command-line argument) before sharing or running on another machine.
- Column removal by numeric index (`mis_l7_l4_l3_l2[,-c(71,73,74,79,80,81,83,84,90,91)]`) is fragile if source files change — consider switching to name-based selection for robustness.

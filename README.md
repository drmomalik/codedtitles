## codedtitles: A data pre-processing package for R

### Overview

-   "codedtitles" is a package designed to make the pre-processing of variables simpler prior to moving forward with analysis.

-   The motivation for this package was born out of our own clinical research experience. For example, a large surgical database with over 200 variables was provided for analysis. None of the column titles had proper coding and many contained special characters and spaces, which would make it syntactically challenging to deal with in R. Given that many of these databases are collected by clinicians or people without statistical software experience, they may not be familiar with the role of variable coding. As such, we have attempted to create a novel, simple solution to speed up this process.

### How to use

-   How do I use codedtitles in R? This vignette will go through some of the functionality of this package and scenarios where it may be helpful.

<!-- -->

-   Load the package:

```{r setup}
library(devtools) 
devtools::install_github("drmomalik/codedtitles") 
library(codedtitles)
```

### Example dataframe

```{r}
data <- df
colnames(data)

#>  [1] "Case_ID"                    "?&%#%"                     
#>  [3] "?&%#%#"                     "Age_Group"                 
#>  [5] "Gender"                     "Region"                    
#>  [7] "Disease"                    "Symptom_Onset"             
#>  [9] "Hospitalized"               "ICU_Admission"             
#> [11] "Vaccination_Status"         "Exposure_History"          
#> [13] "Primary_Transmission_Route" "Secondary_Cases"           
#> [15] "Serotype"                   "PCR_Result...16"           
#> [17] "PCR_Result...17"            "ELISA_Result"              
#> [19] "Contact_Tracing_Status"     "Isolation_Duration"        
#> [21] "Recovery_Status"            "Mortality_Status"          
#> [23] "R0_Estimate"                "Incubation_Period"         
#> [25] "Attack_Rate"                "Attack_Rate_Total"         
#> [27] "Reinfection_Status"         "Antiviral_Usage"           
#> [29] "Outbreak_Cluster"           "Environmental_Factors"     
#> [31] "Genomic_Sequence"           "Reporting_Delay"           
#> [33] "Data_Source"                "Study_Period"              
#> [35] "attack"                     "Mort$Total%_"
```

Here is an example dataframe that contains some example variable names that may be handed to a statistician. As we can see, a number of this variables have long names, some with special characters, some have very similar names too.

### Case 1: Base function

First, we will demonstrate the base function of the package. This will organize all the column names by shortening the stem words, making them lower case and removing special characters.

```{r}
new_names <- codevar(data)

#> Loading required package: NLP
#>  [1] "case_id"           "X"                 "X_1"              
#>  [4] "age_group"         "gender"            "region"           
#>  [7] "diseas"            "symptom_onset"     "hospit"           
#> [10] "icu_admiss"        "vaccin_status"     "exposur_histori"  
#> [13] "prima_trans_rout"  "secondar_case"     "serotyp"          
#> [16] "pcr_resul_16"      "pcr_resul_17"      "elisa_result"     
#> [19] "conta_trace_statu" "isol_durat"        "recoveri_status"  
#> [22] "mortal_status"     "r0_estim"          "incub_period"     
#> [25] "attack_rate"       "attac_rate_total"  "reinfect_status"  
#> [28] "antivir_usag"      "outbreak_cluster"  "environm_factor"  
#> [31] "genom_sequenc"     "report_delay"      "data_sourc"       
#> [34] "studi_period"      "attack"            "mort_total"
```

The output here shows our new names which have been simplified. If we want to reference these new names to the old names, we can call “coderef”.

```{r}
print(coderef)

#>                  New                   Original     Class
#> 1            case_id                    Case_ID   numeric
#> 2                  X                      ?&%#%   numeric
#> 3                X_1                     ?&%#%#   numeric
#> 4          age_group                  Age_Group character
#> 5             gender                     Gender character
#> 6             region                     Region character
#> 7             diseas                    Disease character
#> 8      symptom_onset              Symptom_Onset      Date
#> 9             hospit               Hospitalized   logical
#> 10        icu_admiss              ICU_Admission   logical
#> 11     vaccin_status         Vaccination_Status character
#> 12   exposur_histori           Exposure_History character
#> 13  prima_trans_rout Primary_Transmission_Route character
#> 14     secondar_case            Secondary_Cases   numeric
#> 15           serotyp                   Serotype character
#> 16      pcr_resul_16            PCR_Result...16 character
#> 17      pcr_resul_17            PCR_Result...17 character
#> 18      elisa_result               ELISA_Result character
#> 19 conta_trace_statu     Contact_Tracing_Status character
#> 20        isol_durat         Isolation_Duration   numeric
#> 21   recoveri_status            Recovery_Status character
#> 22     mortal_status           Mortality_Status character
#> 23          r0_estim                R0_Estimate   numeric
#> 24      incub_period          Incubation_Period   numeric
#> 25       attack_rate                Attack_Rate   numeric
#> 26  attac_rate_total          Attack_Rate_Total   numeric
#> 27   reinfect_status         Reinfection_Status   logical
#> 28      antivir_usag            Antiviral_Usage   logical
#> 29  outbreak_cluster           Outbreak_Cluster character
#> 30   environm_factor      Environmental_Factors character
#> 31     genom_sequenc           Genomic_Sequence character
#> 32      report_delay            Reporting_Delay   numeric
#> 33        data_sourc                Data_Source character
#> 34      studi_period               Study_Period      Date
#> 35            attack                     attack   numeric
#> 36        mort_total               Mort$Total%_   numeric
```

### Case 2: Reducing length of characters for each variable

By default, the function allows for a max_length of the new names to be 15 characters. However, if the user desires shorter variable names, this can be manually changed in the arguments. To maintain the meaning of the variable, the function truncates the individual words separately. Let try an example with max_length at 6

```{r}
new_names <- codevar(data, max_length = 6)

#>  [1] "cas_id"   "X"        "X_1"      "age_gro"  "gender"   "region"  
#>  [7] "diseas"   "sym_ons"  "hospit"   "icu_adm"  "vac_sta"  "exp_his" 
#> [13] "pr_tr_ro" "sec_cas"  "seroty"   "pc_re_16" "pc_re_17" "eli_res" 
#> [19] "co_tr_st" "iso_dur"  "rec_sta"  "mor_sta"  "r0_est"   "inc_per" 
#> [25] "att_rat"  "at_ra_to" "rei_sta"  "ant_usa"  "out_clu"  "env_fac" 
#> [31] "gen_seq"  "rep_del"  "dat_sou"  "stu_per"  "attack"   "mor_tot"
```

The function attempts to find simpler version of each word in the name and shorten them to meet the max_length argument.

### Case 3: Removing word splitting

Lets say we make max_length at 3 so we have very short variables to work with.

```{r}
new_names <- codevar(data, max_length = 3)

#>  [1] "ca_i"    "X"       "X_1"     "ag_g"    "gen"     "reg"     "dis"    
#>  [8] "sy_o"    "hos"     "ic_a"    "va_s"    "ex_h"    "p_t_r"   "se_c"   
#> [15] "ser"     "p_r_1"   "p_r_1_1" "el_r"    "c_t_s"   "is_d"    "re_s"   
#> [22] "mo_s"    "r0_e"    "in_p"    "at_r"    "a_r_t"   "re_s_1"  "an_u"   
#> [29] "ou_c"    "en_f"    "ge_s"    "re_d"    "da_s"    "st_p"    "att"    
#> [36] "mo_t"
```

While this does shorten our variables significantly, the function still attempts to separate individual words within the variable name and then recombines after truncating with an underscore. If we want to remove these underscores, and instead shorten the whole variables we can set the split argument to false.

```{r}
new_names <- codevar(data, max_length = 3, split = FALSE)

#>  [1] "cas"   "X"     "X_1"   "age"   "gen"   "reg"   "dis"   "sym"   "hos"  
#> [10] "icu"   "vac"   "exp"   "pri"   "sec"   "ser"   "pcr"   "pcr_1" "eli"  
#> [19] "con"   "iso"   "rec"   "mor"   "r0."   "inc"   "att"   "att_1" "rei"  
#> [28] "ant"   "out"   "env"   "gen_1" "rep"   "dat"   "stu"   "att_2" "mor_1"
```

Again, if we are unsure of the original name, we can always reference the “coderef” dataframe.

### Case 4: Repeat Variables

Lets look at our last example where our max_length was 3 and there is no splitting. This leads to equal new variable names for variables like “Attack_Rate”, “Attack_Rate_Total” and “attacK”.

The code anticipates this and will sequentially add a number tag to repeat variables:

```{r}
coderef[c(25,26,35),]

#>      New          Original   Class
#> 25   att       Attack_Rate numeric
#> 26 att_1 Attack_Rate_Total numeric
#> 35 att_2            attack numeric
```

This prevents any two variables from having the exact same name new re-coded name.

### Case 5: Add tag

Lastly, if user wants to add a tag to variables after it is run through the function, an argument is provided. We also demonstrate how you can choose to only apply this function to select columns if desired.

```{r}
# We will add a tag "_bl" to columns 4-7 to specify them as baseline data
new_names <- codevar(data[,4:7], max_length = 3, split = FALSE, tag = "_bl")

#> [1] "age_bl" "gen_bl" "reg_bl" "dis_bl"
```

### Case 6: Exclude Variables

If you do not want to apply the function to all of your column names, you can use the “exclude_var” argument to select variables you would like to keep as is.

```{r}
# We want to keep the names of "Age_Group" and "Gender"
new_names <- codevar(data, max_length = 8, exclude_var = c("Age_Group", "Gender"))

#>  [1] "case_id"    "X"          "X_1"        "Age_Group"  "Gender"    
#>  [6] "region"     "diseas"     "symp_onse"  "hospit"     "icu_admi"  
#> [11] "vacc_stat"  "expo_hist"  "pri_tra_ro" "seco_case"  "serotyp"   
#> [16] "pcr_res_16" "pcr_res_17" "elis_resu"  "con_tra_st" "isol_dura" 
#> [21] "reco_stat"  "mort_stat"  "r0_esti"    "incu_peri"  "atta_rate" 
#> [26] "att_rat_to" "rein_stat"  "anti_usag"  "outb_clus"  "envi_fact" 
#> [31] "geno_sequ"  "repo_dela"  "data_sour"  "stud_peri"  "attack"    
#> [36] "mort_tota"
```

### Case 7: Transforming variables prior to processing

-   The final argument of the codevar function, transform, allows the user to transform any portion of the variable name prior to it being processed.

-   This may be helpful if the user wants to change or remove a common root word for multiple variables (ex. Remove "gene" from "gene_OMPRM1" and "gene_MOR1") or if special characters have some meaning and the user wants to change them prior to the special characters being filtered out (Ex. Change "\$" to "salary" for "Annual\_\$")

-   The transform argument is given as a list with each transformation included in the list. Below is an example.

```{r}
# We want to re-name the string of random special characters so some meaning is retained 
new_names <- codevar(data, max_length = 8, transform = list("?&%#%" = "Sequence"))

#\> [1] "case_id" "sequenc" "sequenc_1" "age_grou" "gender"\
#\> [6] "region" "diseas" "symp_onse" "hospit" "icu_admi"\
#\> [11] "vacc_stat" "expo_hist" "pri_tra_ro" "seco_case" "serotyp"\
#\> [16] "pcr_res_16" "pcr_res_17" "elis_resu" "con_tra_st" "isol_dura" 
#\> [21] "reco_stat" "mort_stat" "r0_esti" "incu_peri" "atta_rate" 
#\> [26] "att_rat_to" "rein_stat" "anti_usag" "outb_clus" "envi_fact" 
#\> [31] "geno_sequ" "repo_dela" "data_sour" "stud_peri" "attack"\
#\> [36] "mort_tota"

```

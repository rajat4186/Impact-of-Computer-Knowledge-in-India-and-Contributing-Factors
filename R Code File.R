######################## EC 410 CODING ASSIGNMENT ###################################################################################################################

################## 1. DATA LOADING AND MERGING #########################################################################################################################
library(readr)

############ 1.1 Extracting Level 7 data (Block 5) #############################

mis_b5_l7 <- read_fwf(file = "C:/Users/Rajat/OneDrive/Desktop/rajat/DSE/DSE STUDY MATERIAL/BATCH_24/Semester 4/EC410 Coding/Project/MIS Data/ms51l07.TXT",
                   fwf_cols(fsu_slno = c(1,5), round_no = c(6,7),
                   schedule = c(8,10), Sample = c(11,11) , sector = c(12,12),
                   nss_region = c(13,15), district = c(16,17), stratum = c(18,19),
                   sub_stratum = c(20,21), sub_round = c(22,22), fod_sub_region = c(23,26),
                   sample_sub_region = c(27,29), second_stg_stratum = c(30,30), sample_hh_no = c(31,32),
                   person_sl_no = c(33,34), age = c(35,37), employment_status = 38, 
                   enrolment_status = c(39,39), age_1st_enrolled = c(40,41),
                   ever_enrolled = c(42,42), current_educ_level = c(43,44), course_type = c(45,45), v10 = c(46,46), v11 = c(47,48),
                   v12 = c(49,49), v13 = c(50,50), v14 = c(51,51), v15 = c(52,52), v16 = c(53,53), 
                   v17 = c(54,54), v18 = c(55,55),
                   v19 = c(56,56), v20 = c(57,57), last_educ_level = c(58,59), v22 = c(60,61),
                   v23 = c(62,62), v24 = c(63,63), v25 = c(64,64), v26 = c(65,65), v27 = c(66,66), 
                   v28 = c(67,67), v29 = c(68,68), v30 = c(69,69),  v31 = c(70,70),
                   copy_move_file_folder = c(71,71), copy_move_within_doc = c(72,72),
                   send_emails_with_files = c(73,73), arith_formula_spreadsheet = c(74,74),
                   connect_instal_devices = c(75,75), install_config_software = c(76,76),
                   create_ppt = c(77,77), transfer_files = c(78,78), write_programme = c(79,79),
                   ns_count = c(80,82), multiplier = c(83,92)),
col_types = cols(fsu_slno = col_character(), round_no = col_character(),
schedule = col_character(), Sample = col_character() , sector = col_character(),
nss_region = col_character(), district = col_character(), stratum = col_character(),
sub_stratum = col_character(), sub_round = col_character(), fod_sub_region = col_character(),
sample_sub_region = col_character(), second_stg_stratum = col_character(), sample_hh_no = col_character(),
person_sl_no = col_character(), age = col_integer(), employment_status = col_integer(), 
enrolment_status = col_integer(), age_1st_enrolled = col_integer(),
ever_enrolled = col_integer(), current_educ_level = col_integer(), course_type = col_integer(), v10 = col_integer(), v11 = col_integer(),
v12 = col_integer(), v13 = col_integer(), v14 = col_integer(), v15 = col_integer(), v16 = col_integer(), 
v17 = col_integer(), v18 = col_integer(),
v19 = col_integer(), v20 = col_integer(), v22 = col_integer(), last_educ_level = col_integer(),
v23 = col_integer(), v24 = col_integer(), v25 = col_integer(), v26 = col_integer(), v27 = col_integer(), 
v28 = col_integer(), v29 = col_integer(), v30 = col_integer(),  v31 = col_integer(),
copy_move_file_folder = col_integer(), copy_move_within_doc = col_integer(),
send_emails_with_files = col_integer(), arith_formula_spreadsheet = col_integer(),
connect_instal_devices = col_integer(), install_config_software = col_integer(),
create_ppt = col_integer(), transfer_files = col_integer(), write_programme = col_integer(),
ns_count = col_number(), multiplier = col_number()))

#### Making 2 different primary keys to merge different levels of data

attach(mis_b5_l7)

mis_b5_l7$primary_key <- paste0(fsu_slno, second_stg_stratum, sample_hh_no)
mis_b5_l7$primary_key2 <- paste0(fsu_slno, second_stg_stratum, sample_hh_no, person_sl_no)

detach(mis_b5_l7)

######## 1.2 Extracting Level 3 data (Block 4: items 1 to 28) #####################

library(readr)
mis_b4_l3 <- read_fwf(file = "C:/Users/Rajat/OneDrive/Desktop/rajat/DSE/DSE STUDY MATERIAL/BATCH_24/Semester 4/EC410 Coding/Project/MIS Data/ms51l03.TXT",
                   fwf_cols(fsu_slno = c(1,5), other_var1 = c(6,29), second_stg_stratum = c(30,30), sample_hh_no = c(31,32),
                            hh_size = c(33,34), religion = 35, social_grp = 36, other_var2 = c(39,78), 
                            hh_monthly_exp = c(79,86), other_var3 = c(80,110),
                            ns_count = c(111,113), multiplier = c(114,123)),
                   col_types = cols(fsu_slno = col_character(), other_var1 = col_character(), second_stg_stratum = col_character(), sample_hh_no = col_character(),
                                    hh_size = col_integer(), religion = col_character(), social_grp = col_character(), other_var2 = col_character(), 
                                    hh_monthly_exp = col_integer(), other_var3 = col_character(), ns_count = col_number(), multiplier = col_number()))

#### Creating primary key for Level 3 data

attach(mis_b4_l3)
mis_b4_l3$primary_key <- paste0(fsu_slno, second_stg_stratum, sample_hh_no)

length(unique(mis_b4_l3$primary_key))

detach(mis_b4_l3)

##### Merging Level 7 and Level 3

mis_l7_l3 <- merge(mis_b5_l7,mis_b4_l3, by = "primary_key" )

############# 1.3 Extracting Level 2 data (Block 3) ###############################

mis_b3_l2 <- read_fwf(file = "C:/Users/Rajat/OneDrive/Desktop/rajat/DSE/DSE STUDY MATERIAL/BATCH_24/Semester 4/EC410 Coding/Project/MIS Data/ms51l02.TXT",
                      fwf_cols(fsu_slno = c(1,5), other_var1 = c(6,29), second_stg_stratum = c(30,30), sample_hh_no = c(31,32),
                               person_sl_no = c(33,34), v1 = 35, gender = 36, other_var_l2 = c(37,54), 
                               ns_count = c(55,57), multiplier = c(58,67)),
                      col_types = cols(fsu_slno = col_character(), other_var1 = col_character(), second_stg_stratum = col_character(), sample_hh_no = col_character(),
                                       person_sl_no = col_character(),  v1 = col_character(), gender = col_character(), other_var_l2 = col_character(), 
                                      ns_count = col_number(), multiplier = col_number()))

#### Making primary key 2 for specific merging

attach(mis_b3_l2)
mis_b3_l2$primary_key2 <- paste0(fsu_slno, second_stg_stratum, sample_hh_no, person_sl_no)
detach(mis_b3_l2)

#### Merging Combined Level 7 and 3 data with Level 2 data

mis_l7_l3_l2 <- merge(mis_l7_l3, mis_b3_l2, by = "primary_key2")

######### 1.4 Extracting Level 4 data (Block 4: items 29 to 46) #######################

mis_b4_l4 <- read_fwf(file = "C:/Users/Rajat/OneDrive/Desktop/rajat/DSE/DSE STUDY MATERIAL/BATCH_24/Semester 4/EC410 Coding/Project/MIS Data/ms51l04.TXT",
                      fwf_cols(fsu_slno = c(1,5), other_var1_l4 = c(6,29), second_stg_stratum = c(30,30), sample_hh_no = c(31,32),
                               other_var2_l4 = c(33,41), mass_media = 42, other_var3_l4 = c(43,45),
                               broadband = 46, other_var4_l4 = c(47,52) ,
                               ns_count = c(53,55), multiplier = c(56,65)),
                      col_types = cols(fsu_slno = col_character(), other_var1_l4 = col_character(), second_stg_stratum = col_character(), sample_hh_no = col_character(),
                                       other_var2_l4 = col_character(), mass_media = col_integer() ,other_var3_l4 = col_character(), broadband = col_integer(),
                                       ns_count = col_number(), multiplier = col_number()))

#### Making primary key to merge data

attach(mis_b4_l4)

mis_b4_l4$primary_key <- paste0(fsu_slno, second_stg_stratum, sample_hh_no)

detach(mis_b4_l4)

#### Merging Combined Level 7,3 & 2 with Level 4

mis_l7_l4_l3_l2 <- merge(mis_l7_l3_l2, mis_b4_l4, by = "primary_key")

# Removing Duplicated columns

duplicated(names(mis_l7_l4_l3_l2))

mis_l7_l4_l3_l2 <- mis_l7_l4_l3_l2[,-c(71,73,74,79,80,81,83,84,90,91)]

############################ 2. DATA MANIPULATION ########################################################################################################################

## Exploring data

attach(mis_l7_l4_l3_l2)

table(copy_move_file_folder)
table(copy_move_within_doc)
table(send_emails_with_files)
table(arith_formula_spreadsheet)
table(connect_instal_devices)
table(install_config_software)
table(create_ppt)
table(transfer_files)
table(write_programme)

table(employment_status)

########################### 2.1 Computer Knowledge Score #####################################

#### Manipulating computer-related variables to make it a binary variable with values 0 and 1

mis_l7_l4_l3_l2[,47:55][mis_l7_l4_l3_l2[,47:55] == 2] <-  0

#### Making computer knowledge score as a count variable

library(dplyr)
mis_l7_l4_l3_l2 <- mis_l7_l4_l3_l2 %>%
  mutate(comp_know_count = rowSums(mis_l7_l4_l3_l2[,47:55], na.rm = T))

table(mis_l7_l4_l3_l2$comp_know_count)

######################### 2.2 Employment Status ####################################

mis_l7_l4_l3_l2$employment_status[mis_l7_l4_l3_l2$employment_status == 2] <- 0

table(mis_l7_l4_l3_l2$employment_status)

####################### 2.3 Gender #################################################

## Removing observations gender == 3 (because of limited data)
## Taking 1 as male and 0 as female

mis_l7_l4_l3_l2$gender[mis_l7_l4_l3_l2$gender == 2] <- 0
mis_l7_l4_l3_l2$gender[mis_l7_l4_l3_l2$gender == 3] <- NA

table(gender)

###################### 2.4 Massmedia & Broadband ###################################

table(mass_media)
table(broadband)

mis_l7_l4_l3_l2$mass_media[mis_l7_l4_l3_l2$mass_media == 2] <- 0
mis_l7_l4_l3_l2$broadband[mis_l7_l4_l3_l2$broadband == 2] <- 0

#################### 2.5 Creating Education Variables ##############################

mis_l7_l4_l3_l2$educ_var <- ifelse(last_educ_level == 10, 1,
                                          ifelse(last_educ_level %in% c(13,14), 2,
                                                 ifelse(last_educ_level == 15, 3, 0)))
attach(mis_l7_l4_l3_l2)

mis_l7_l4_l3_l2$higher_educ <- ifelse(educ_var == 1, 1, 0)
mis_l7_l4_l3_l2$ug <- ifelse(educ_var == 2, 1, 0)
mis_l7_l4_l3_l2$pg_and_above <- ifelse(educ_var == 3, 1, 0)

attach(mis_l7_l4_l3_l2)

table(educ_var)
table(higher_educ)
table(ug)
table(pg_and_above)
table(last_educ_level)

################### 2.6 Creating Social Group Variables ############################

mis_l7_l4_l3_l2$soc_grp_var <- ifelse(social_grp == 9, 0, 1)

attach(mis_l7_l4_l3_l2)

table(soc_grp_var)
table(social_grp)

################## 2.7 Making State Code Variable ##################################

#### To make it for state-wise analysis
#### Using first two codes of NSS Region as states

mis_l7_l4_l3_l2$state_code <- substr(mis_l7_l4_l3_l2$nss_region, 1,2)

attach(mis_l7_l4_l3_l2)
table(state_code)

detach(mis_l7_l4_l3_l2)

# Note: press 4 times to totally detach

##################### 3. FILTERING DATA ################################################################################################################################

#### Analysis is only done for those whose age is above 15, and
#### were enrolled in school or college, but not enrolled now (enrollment status = 2 )

library(dplyr)
mis_l7_l4_l3_l2_filter <- mis_l7_l4_l3_l2 %>%
  filter(age >=15 & enrolment_status == 2)

attach(mis_l7_l4_l3_l2_filter)

#### Saving data

save(mis_l7_l4_l3_l2, file = "merged_data_full.RData")
save(mis_l7_l4_l3_l2_filter, file = "merged_data_filtered.RData")

######################## 4. PLOTTING: TRENDS AND PATTERNS ##############################################################################################################

################## 4.1 State-wise computer knowledge ###################################

avg_comp_know <- aggregate(comp_know_count ~ state_code, data = mis_l7_l4_l3_l2_filter,
                           FUN = mean)

#### Reading Tabulation State data, separate excel file in documaented files

library(readxl)
state_data <- read_excel("C:/Users/Rajat/OneDrive/Desktop/rajat/DSE/DSE STUDY MATERIAL/BATCH_24/Semester 4/EC410 Coding/Project/MIS data info/Tabulation_state.xlsx")

library(dplyr)
state_data <- state_data %>%
  rename(state_code = `Alphabetical State_Code`)

avg_comp_know <- merge(avg_comp_know, state_data, by = "state_code")

avg_comp_know <- avg_comp_know[,-c(3,4)]

library(ggplot2)
ggplot(avg_comp_know, aes(y = reorder(`Alphabetical State`, comp_know_count), x = comp_know_count)) +
  geom_bar(stat = "identity", fill = "red") +
  labs(y = "State", x = "Computer Knowledge Score", title = "Average Computer Knowledge Score of Different States") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

################################ 4.2 State-wise employment situation #########################

emp_level <- aggregate(employment_status ~ state_code, data = mis_l7_l4_l3_l2_filter,
                       FUN = mean)

emp_level <- merge(emp_level, state_data, by = "state_code")
emp_level <- emp_level[,-c(3,4)]

ggplot(emp_level, aes(y = reorder(`Alphabetical State`, employment_status), x = employment_status)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  labs(y = "State", x = "Proportion of Employed", title = "Proportion of Employed in Different States") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

############################### 4.3 Education and computer knowledge #########################

attach(mis_l7_l4_l3_l2_filter)
educ_comp <- data.frame(comp_know_count, educ_var)

educ_comp$educ_level <- ifelse(educ_var == 3, "Postgrad & above", 
                               ifelse(educ_var == 2, "Undergrad",
                                      ifelse(educ_var == 1, "High School", "Secondary or less")))

detach(mis_l7_l4_l3_l2_filter)
attach(educ_comp)

educ_comp_agg <- aggregate(comp_know_count ~ educ_level, data = educ_comp, FUN = mean)

attach(educ_comp_agg)
barplot(comp_know_count,names.arg = educ_level, data = educ_comp_agg, col = "lightblue",
        ylab = "Computer Knowledge Score", main = "Average Computer Knowledge Score at Different Education Levels")
detach(educ_comp_agg)

################################# 4.4 State-wise Education Status ############################

educ_comp$pg_and_above <- ifelse(educ_var == 3, 1,0)
educ_comp$ug <- ifelse(educ_var == 2, 1, 0)
educ_comp$high_school <- ifelse(educ_var == 1, 1, 0)
educ_comp$state_code <- mis_l7_l4_l3_l2_filter$state_code

attach(educ_comp)
educ_state <- aggregate(pg_and_above~state_code, data = educ_comp,
                        FUN = mean)
educ_state1 <- aggregate(ug~state_code, data = educ_comp,
                        FUN = mean)
educ_state2 <- aggregate(high_school~state_code, data = educ_comp,
                        FUN = mean)

educ_st_pg_ug <- merge(educ_state, educ_state1, by = "state_code")
educ_st_merge <- merge(educ_st_pg_ug, educ_state2, by = "state_code")

educ_st_merge1 <- merge(educ_st_merge, state_data, by = "state_code")

educ_st_merge1[c(1,2,10,14,32,34),7] <- c("Andhra P.", "Arunachal P.", "Himachal P.",
                                          "Madhya P.", "D & N Haveli", "J & K")

barplot(t(educ_st_merge1[,c(4,3,2)]), beside = T, names.arg = educ_st_merge1$`Alphabetical State`
        , col = c("blue","green","yellow"), horiz = F, las = 3, cex.names = 0.7,
        ylab = "Average Proportion", main = "State-wise Average Proportion of Last Education Level",
        )
legend("top", legend = c("High School", "UG", "PG and above"), fill = c("blue","green","yellow"))

detach(educ_comp)

################################ 4.5 State-wise Average Monthly Expenditure #################

monthly_exp <- aggregate(hh_monthly_exp ~ state_code, data = mis_l7_l4_l3_l2_filter,
                         FUN = mean)

monthly_exp <- merge(monthly_exp, state_data, by = "state_code")
monthly_exp <- monthly_exp[,-c(3,4)]

ggplot(monthly_exp, aes(y = reorder(`Alphabetical State`, hh_monthly_exp), x = hh_monthly_exp)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  labs(y = "State", x = "Household Monthly Expenditure",
       title = "Average Household Monthly Expenditure in Different States") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

########################################## 5. REGRESSION ###############################################################################################################

#################################### 5.1  Effect of Computer Knowledge on Employment ##########################

emp_model_overall <- glm(employment_status ~ comp_know_count + higher_educ + ug + pg_and_above + hh_monthly_exp +
                gender + age + soc_grp_var, data = mis_l7_l4_l3_l2_filter, family = "binomial")

#### Filtering Top 5 Richest and Top 5 Poorest States in terms of Household Monthly Expenditure

#### This can be seen from the plot State-wise Average Monthly Expenditure (Section 4.5)

mis_l7_l4_l3_l2_filter_richest5 <- mis_l7_l4_l3_l2_filter %>%
  filter(state_code %in% c("15", "04", "07", "35", "03"))

mis_l7_l4_l3_l2_filter_poorest5 <- mis_l7_l4_l3_l2_filter %>%
  filter(state_code %in% c("22","10", "21", "20", "12"))

emp_model_rich <- glm(employment_status ~ comp_know_count + higher_educ + ug + pg_and_above + hh_monthly_exp +
                        gender + age + soc_grp_var, data = mis_l7_l4_l3_l2_filter_richest5, family = "binomial")

emp_model_poor <- glm(employment_status ~ comp_know_count + higher_educ + ug + pg_and_above + hh_monthly_exp +
                        gender + age + soc_grp_var, data = mis_l7_l4_l3_l2_filter_poorest5, family = "binomial")

############################# 5.2 Factors Affecting Computer Knowledge #########################

comp_model_overall <- glm(comp_know_count ~ higher_educ + ug + pg_and_above + hh_monthly_exp + soc_grp_var + age + gender +
                mass_media + broadband, data = mis_l7_l4_l3_l2_filter, family = "poisson")

comp_model_rich <- glm(comp_know_count ~ higher_educ + ug + pg_and_above + hh_monthly_exp + soc_grp_var + age + gender +
                mass_media + broadband, data = mis_l7_l4_l3_l2_filter_richest5, family = "poisson")

comp_model_poor <- glm(comp_know_count ~ higher_educ + ug + pg_and_above + hh_monthly_exp + soc_grp_var + age + gender +
                mass_media + broadband, data = mis_l7_l4_l3_l2_filter_poorest5, family = "poisson")

#### Tabulating Regression Results

stargazer::stargazer(emp_model_overall, emp_model_rich, emp_model_poor, out = "emp_reg.html", style = "all2")
stargazer::stargazer(comp_model_overall, comp_model_rich, comp_model_poor, out = "comp_reg.html", style = "all2")


######################################## 6. T-TEST #####################################################################################################################

richest5_comp_coeff <- emp_model_rich$coefficients[2]
poorest5_comp_coeff <- emp_model_poor$coefficients[2]

richest5_comp_se <- summary(emp_model_rich)$coefficients["comp_know_count", "Std. Error"]
poorest5_comp_se <- summary(emp_model_poor)$coefficients["comp_know_count", "Std. Error"]

comp_t_test <- (richest5_comp_coeff - poorest5_comp_coeff)/sqrt(richest5_comp_se^2 + poorest5_comp_se^2)
comp_t_test

comp_p_value <- 2*pnorm(-abs(comp_t_test))
comp_p_value

round(comp_p_value, 5)

# p-value ~ 0 < 0.01
# the coefficient is significant at 1% level

######################################## END ########################################################################################################
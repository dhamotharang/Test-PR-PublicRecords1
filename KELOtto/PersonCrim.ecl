IMPORT KELOtto, FraudGovPlatform;
 
PersonCrimPrep1 := PROJECT(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Crim.built,
       TRANSFORM({RECORDOF(LEFT), STRING off_cat_list}, 
                 SELF.off_cat_list :=                  
                    TRIM(LEFT.off_cat_1_1) + '|' + TRIM(LEFT.off_cat_2_1) + '|' + TRIM(LEFT.off_cat_3_1) + '|' + TRIM(LEFT.off_cat_4_1) + '|' + TRIM(LEFT.off_cat_5_1) + '|' + TRIM(LEFT.off_cat_1_2) + '|' + TRIM(LEFT.off_cat_2_2) + '|' + TRIM(LEFT.off_cat_3_2) + '|' + 
                    TRIM(LEFT.off_cat_4_2) + '|' + TRIM(LEFT.off_cat_5_2) + '|' + TRIM(LEFT.off_cat_1_3) + '|' + TRIM(LEFT.off_cat_2_3) + '|' + TRIM(LEFT.off_cat_3_3) + '|' + TRIM(LEFT.off_cat_4_3) + '|' + 
                    TRIM(LEFT.off_cat_5_3) + '|' + TRIM(LEFT.off_cat_1_4) + '|' + TRIM(LEFT.off_cat_2_4) + '|' + TRIM(LEFT.off_cat_3_4) + '|' + TRIM(LEFT.off_cat_4_4) + '|' + TRIM(LEFT.off_cat_5_4) + '|' + 
                    TRIM(LEFT.off_cat_1_5) + '|' + TRIM(LEFT.off_cat_2_5) + '|' + TRIM(LEFT.off_cat_3_5) + '|' + TRIM(LEFT.off_cat_4_5) + '|' + TRIM(LEFT.off_cat_5_5) + '|' + TRIM(LEFT.off_cat_1_6) + '|' + 
                    TRIM(LEFT.off_cat_2_6) + '|' + TRIM(LEFT.off_cat_3_6) + '|' + TRIM(LEFT.off_cat_4_6) + '|' + TRIM(LEFT.off_cat_5_6) + '|';
                 SELF := LEFT));

PersonCrimPrep := PROJECT(PersonCrimPrep1,
       TRANSFORM({RECORDOF(LEFT), INTEGER1 name_ssn_dob_match, INTEGER1 old_name_ssn_dob_match}, 
       self.old_name_ssn_dob_match := MAP(LEFT.ssn=LEFT.ssn_orig AND LEFT.lname=LEFT.lname_orig AND LEFT.fname=LEFT.fname_orig AND LEFT.mname=LEFT.mname_orig AND LEFT.dob=LEFT.dob_orig => 1, 0),
       self.name_ssn_dob_match := MAP(LEFT.ssn=LEFT.ssn_orig AND LEFT.lname=LEFT.lname_orig AND LEFT.fname=LEFT.fname_orig AND LEFT.dob=LEFT.dob_orig AND 
          (LEFT.mname = LEFT.mname_orig OR
         (LEFT.mname != LEFT.mname_orig AND
         (LEFT.mname[1]=LEFT.mname_orig[1] OR LEFT.mname = '' OR LEFT.mname_orig = '')))
          => 1, 0), 
          SELF := LEFT));

EXPORT PersonCrim  := PersonCrimPrep;
//EXPORT PersonCrim  := JOIN(KELOtto.CustomerLexId, PersonCrimPrep, LEFT.did=(INTEGER)RIGHT.did, TRANSFORM({LEFT.AssociatedCustomerFileInfo, RECORDOF(RIGHT)}, SELF := RIGHT, SELF := LEFT), HASH, KEEP(1));

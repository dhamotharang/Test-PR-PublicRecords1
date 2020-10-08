IMPORT doxie, doxie_cbrs, doxie_cbrs_raw, census_data;
doxie_cbrs.MAC_Selection_Declare()

EXPORT Liens_Judments_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

//***** GET THE NEW DATA IN A FLAT FORMAT
needlj := Include_LiensJudgments_val OR Include_Liens_val OR Include_Judgments_val OR Include_LiensJudgmentsUCC_val;
nn := max_Liens_val + max_Judgments_val;
lie := doxie_cbrs_raw.Liens_v2(bdids,needlj, nn,,application_type_value).records_moxieview;



//****** KEEP ONLY THE DEBTORS FOR OUR BDIDS AND ALL THE CREDITORS
mylie := JOIN(lie(name_type = 'D'),bdids,
        (UNSIGNED6)LEFT.bdid = RIGHT.bdid,
          TRANSFORM(RECORDOF(lie), SELF := LEFT)) +
     lie(name_type = 'C');

//****** GET THE DATA INTO THE OLD FORMAT
j := doxie.Fn_LienBackwards(mylie);

//***** OUTREC
outrec := doxie_cbrs.Layout_Liens_Judgments_raw;
jnd := DEDUP(PROJECT(j, outrec), ALL);

//***** POPULATE COUNTY_NAME AND MASK THE SSNS
census_data.MAC_Fips2County_Keyed(jnd,state,county,county_name,jnd2);
       
doxie_cbrs.mac_mask_ssn(jnd2, msk1, orig_ssn)
doxie_cbrs.mac_mask_ssn(msk1, msk2, ssn_appended)

msk3 := SORT(msk2,-filing_date,RECORD);

RETURN IF(JudgmentLienVersion IN [0,1],msk3);
END;

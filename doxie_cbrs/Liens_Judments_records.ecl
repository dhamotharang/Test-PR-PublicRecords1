import doxie, business_header, bankrupt, suppress,doxie_cbrs_raw, census_data;
doxie_cbrs.MAC_Selection_Declare()

export Liens_Judments_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

//***** GET THE NEW DATA IN A FLAT FORMAT
needlj := Include_LiensJudgments_val or Include_Liens_val or Include_Judgments_val or Include_LiensJudgmentsUCC_val;
nn := max_Liens_val + max_Judgments_val;
lie := doxie_cbrs_raw.Liens_v2(bdids,needlj, nn,,application_type_value).records_moxieview;



//****** KEEP ONLY THE DEBTORS FOR OUR BDIDS AND ALL THE CREDITORS
mylie := join(lie(name_type = 'D'),bdids,
			  (unsigned6)left.bdid = right.bdid,
		      traNsform(recordof(lie), self := left)) +
		 lie(name_type = 'C'); 

//****** GET THE DATA INTO THE OLD FORMAT
j := doxie.Fn_LienBackwards(mylie);

//***** OUTREC
outrec := Layout_Liens_Judgments_raw;
jnd := dedup(project(j, outrec), all); 

//***** POPULATE COUNTY_NAME AND MASK THE SSNS
census_data.MAC_Fips2County_Keyed(jnd,state,county,county_name,jnd2);
			 
doxie_cbrs.mac_mask_ssn(jnd2, msk1, orig_ssn)
doxie_cbrs.mac_mask_ssn(msk1, msk2, ssn_appended)

msk3 := sort(msk2,-filing_date,record);

return if(JudgmentLienVersion in [0,1],msk3);
END;
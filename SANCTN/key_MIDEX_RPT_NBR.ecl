Import Data_Services, doxie_files, doxie,ut,lib_stringlib,Lib_FileServices, codes;

f_sanctn_party := SANCTN.file_base_party;

layout_SANCTN_party_key := RECORD
	SANCTN.layout_SANCTN_did AND NOT [RECORD_TYPE, 
									// UltID, OrgID, SELEID, ProxID, POWID, EmpID, DotID,
									// UltScore, OrgScore, SELEScore, ProxScore, POWScore, EmpScore, DotScore, 
									// UltWeight, OrgWeight, SELEWeight, ProxWeight, POWWeight, EmpWeight, DotWeight,	
									SOURCE_REC_ID, enh_did_src];
	string26 midex_rpt_nbr;
END;

/* Standardized the SSNs found within the freeform text field */
layout_SANCTN_party_key tSANCTN_key(f_sanctn_party L) := transform
   self.party_text := SANCTN.fMask_SSN(L.party_text);
	 
	 tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);

	 tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);

	 cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);

	 self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
	 //populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
	 self.st 				 := IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  codes.valid_st(L.instate),
										 		 trim(L.instate),
												 L.st);
	 
   self               := L;
END;

f_sanctn_party_new := project(f_sanctn_party, tSANCTN_key(LEFT));


KeyName 			:= 'thor_data400::key::sanctn::';

export key_MIDEX_RPT_NBR := index(f_sanctn_party_new
                                ,{midex_rpt_nbr}
																,{f_sanctn_party_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'midex_rpt_nbr_'+doxie.Version_SuperKey);
																


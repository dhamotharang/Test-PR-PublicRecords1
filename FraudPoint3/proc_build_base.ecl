import Fraudpoint3, did_add, ut;

clean_comb := FraudPoint3.clean_CFD + FraudPoint3.clean_TFD;
base_layout := FraudPoint3.layout.base;

matchset :=['A','S','D','G','P','Z','4','Q'];

	did_Add.MAC_Match_Flex(clean_comb, matchset,
													ssn, DOB, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st, Phone_number,
													appended_LexID,   			
													base_layout, 
													false, '',	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													outfile);
		
ut.MAC_SF_BuildProcess(outfile,'~thor_data400::base::fraudpoint3_IFD',out_base,2,,true)
 
													
EXPORT proc_build_base := out_base;


import ut;
experian_base := Experiancred.files.Base_File_Out;

count(experian_base ((unsigned)name_score <= 50));

Bad_Names50_CurrentNmAddr 	:= experian_base(current_rec_flag = 1 and (unsigned)name_score <= 50);

Bad_Names50_CurrentNmAddr_d := distribute(Bad_Names50_CurrentNmAddr, hash(Encrypted_Experian_PIN));
experian_base_d				:= distribute(experian_base, hash(Encrypted_Experian_PIN));

recordof(experian_base) t_delete_bad_names(experian_base_d le, Bad_Names50_CurrentNmAddr_d ri) := transform
	//also fix invalid dobs and ssn
	valid_dob   :=  			if((unsigned)le.Date_of_Birth between 18000101 and (unsigned) ut.GetDate, le.Date_of_Birth, '');
	valid_snn	:= 				if((unsigned)le.Social_Security_Number > 0, le.Social_Security_Number, '');
	
	SELF.Social_Security_Number := if(le.NameType[..2] = 'SP', '', valid_snn);
	SELF.Date_of_Birth			:= if(le.NameType[..2] = 'SP', '', valid_dob);
	SELF := le;
end;


delete_bad_names := join(experian_base_d, 
						 Bad_Names50_CurrentNmAddr_d,
						 left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN,
						 t_delete_bad_names(left, right),
						 left only,
						 local);
						 



delete_additional_bad_names := delete_bad_names ((unsigned)name_score > 50);

//verification stats ---- results have to the same for all 3 counts
count(delete_additional_bad_names);
count(delete_additional_bad_names (date_last_seen= (unsigned) Experiancred.version));
count(delete_additional_bad_names (current_rec_flag = 1 ));

OUTPUT(delete_additional_bad_names,,'~thor_data400::base::experiancredw20090822-112807_patched',overwrite,__compressed__);

export Temp_Patch := delete_additional_bad_names ;
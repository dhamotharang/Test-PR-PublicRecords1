import Email_DataV2,Email_Data,UT,dx_Email, PRTE2_Email_Data;
EXPORT files := module


shared CombinedBase2:=Project(PRTE2_Email_Data.files.Combined_Base(clean_email!=''),
Transform(layouts.base_ext,
Self.clean_ssn:=Left.best_ssn;
Self.clean_dob:=Left.best_dob;
Self:=Left;
));


Export Did_File:=Project(CombinedBase2(did>0),
Transform(layouts.i_did,
Self:=Left;
));

EXPORT Email_Address_File	:= DEDUP(SORT(DISTRIBUTE(CombinedBase2(did > 0), HASH(did))
																		 ,clean_email,did,email_rec_key, IF(clean_name.lname <> '' AND clean_address.prim_range <> '', 1, IF(clean_name.lname <>  '',  2, 3)), -date_last_seen, LOCAL)
																		 ,clean_email,did,email_rec_key,LOCAL);

Export Email_Address_file_short:=project(Email_Address_File,
Transform (layouts.i_Email_Address,
Self:=Left;
));

email_did		:= 	CombinedBase2(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I');
	SHARED did_ready		:= 	email_did(email_src NOT IN Email_Data.FCRA_Src_Filter);

	//DF-21686 blank out selected field in thor_200::key::email_data::fcra::qa::did
	ut.MAC_CLEAR_FIELDS(did_ready, did_ready_cleared, Email_Data.Constants().fields_to_clear);
	EXPORT DID_FCRA	:= Project(did_ready_cleared,
	Transform(layouts.i_did,
   Self:=Left;
   ));
	
   Export Payload:=Project(CombinedBase2,
	 Transform(layouts.i_payload,
   Self:=Left;
	 Self:=[];
	   ));
	
	Export Payload_FCRA:=project(did_ready,
	Transform(layouts.i_payload,
	 Self:=Left;
	 Self:=[];
   ));
	 
 
	 EXPORT File_Key								:= project(CombinedBase2, transform(PRTE2_Email_Data.Layouts.keyRec, 
																		 self.best_ssn := if(left.best_ssn <> '', left.best_ssn, left.link_ssn);
																	 	 self.best_dob := if(left.best_dob <> 0, left.best_dob, (unsigned)left.best_dob);
																		 self := left;
																		)): INDEPENDENT;
	 
	 EXPORT File_AutoKey 					:= project(File_Key,PRTE2_Email_Data.Layouts.Autokey_layout);

	
End;
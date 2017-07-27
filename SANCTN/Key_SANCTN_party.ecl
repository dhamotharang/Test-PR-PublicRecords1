Import Data_Services, doxie_files, doxie,ut;

f_sanctn_party := SANCTN.file_base_party;

layout_SANCTN_party_key := SANCTN.layout_SANCTN_party_clean_orig;


/* Mask the SSNs found within the freeform text field */
layout_SANCTN_party_key tSANCTN_key(f_sanctn_party L) := transform
   self.party_text := SANCTN.fMask_SSN(L.party_text);
	 //populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
	 self.st 				 := IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  ut.valid_st(L.instate),
										 		 trim(L.instate),
												 L.st);
   self            := L;
end;

f_sanctn_party_new := project(f_sanctn_party, tSANCTN_key(LEFT));

KeyName 			:= 'thor_data400::key::sanctn::';

export Key_SANCTN_party := index(f_sanctn_party_new
                                ,{BATCH_NUMBER,INCIDENT_NUMBER}
																,{f_sanctn_party_new}
																,Data_Services.Data_location.Prefix('sanctn')+KeyName +'party_'+doxie.Version_SuperKey);

								

Import Data_Services, doxie_files, doxie,ut, codes;

f_sanctn_party := SANCTN.file_base_party;

//CCPA-283 Add 2 CCPA fields
layout_SANCTN_party_key := SANCTN.Layout_SANCTN_Party_New;

/* Mask the SSNs found within the freeform text field */
layout_SANCTN_party_key tSANCTN_key(f_sanctn_party L) := transform
	 self.BATCH_NUMBER		:= trim(L.BATCH_NUMBER,left,right);
	 self.INCIDENT_NUMBER := trim(L.INCIDENT_NUMBER,left,right);
	 self.PARTY_NUMBER		:= trim(L.PARTY_NUMBER,left,right);
   self.party_text := SANCTN.fMask_SSN(L.party_text);
	 //populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
	 self.st 				 := IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  codes.valid_st(L.instate),
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

								

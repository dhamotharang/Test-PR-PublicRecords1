//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
	//current name, alias, aka and former name

Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec t_norm_name (Transunion_PTrak.Layout_Transunion_Update_In L, INTEGER C):= TRANSFORM
	 current_name 						:= StringLib.StringCleanSpaces((L.LASTNAME+', '+L.FIRSTNAME+' '+ L.MIDDLENAME +' '+ L.SUFFIX + ' ' + L.PREFIX));
	 SELF.Name       					:= CHOOSE(C,current_name,L.AKA1,L.AKA2,L.AKA3);
	 SELF.NameType  					:= CHOOSE(C,'O','A1','A2','A3');
	 SELF.FileType						:= 'U';
	 SELF.VendorDocumentIdentifier 		:= '0' + L.PARTYID ;
	 SELF.CurrentName.FirstName 		:= L.FIRSTNAME;
	 SELF.CurrentName.MiddleName		:= L.MIDDLENAME;
	 SELF.CurrentName.LastName			:= L.LASTNAME;
	 SELF.CurrentName.Suffix			:= L.SUFFIX; 
	 SELF.CurrentName.Dob_YYYY			:= L.BIRTHDATE[..4];
	 SELF.CurrentName.Dob_MM			:= L.BIRTHDATE[5..6];	 
	 SELF.CurrentName.Dob_DD			:= L.BIRTHDATE[7..8];	 
	 SELF.CurrentName.DeathIndicator	:= L.DECEASEDINDICATOR;
	 SELF.SSNFull						:= TRIM(L.SSN,all);
	 SELF.TelephoneNumber				:= TRIM(L.TELEPHONE,all);
	 SELF.ZIP4U							:= L.ZIP4;
	 SELF.AddressSeq					:= 1;
	 SELF.NormAddress.Address1			:= StringLib.StringCleanSpaces(L.HOUSENUMBER + ' '+ L.STREETTYPE + ' ' + L.STREETDIRECTION + ' ' + L.STREETNAME);
	 SELF.NormAddress.Address2			:= L.APARTMENTNUMBER;
	 SELF.NormAddress.City				:= L.CITY;
	 SELF.NormAddress.State				:= L.STATE;
	 SELF.NormAddress.ZipCode			:= L.ZIPCODE;
     SELF.NormAddress.UpdatedDate		:= ''	;
	 SELF.PreviousAddress				:= DATASET([{'','','','','',''}], Transunion_PTrak.Layout_Transunion_Full_In.AddressRec);
	 SELF.Orig_DECEASEDINDICATOR		:= L.DECEASEDINDICATOR;
	 SELF           					:= L;
END;

norm_names := NORMALIZE(Transunion_Ptrak.File_Transunion_Update_In, 4, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',');

EXPORT Normalize_Transunion_Update := norm_names_filtered:persist('~thor_data400::persist::transunionptrak_normalized_names_update');

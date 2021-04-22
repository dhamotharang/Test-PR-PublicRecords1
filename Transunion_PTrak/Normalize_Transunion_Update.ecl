//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
	//current name, alias, aka and former name

EXPORT Normalize_Transunion_Update(STRING Full_filedate,STRING Update_filedate) := FUNCTION

Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec t_norm_name (Transunion_PTrak.Layout_Transunion_Update_In L, INTEGER C):= TRANSFORM
	get_suffix(string suffix) := map(trim(suffix, left, right) IN ['JR', 'SR', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'] => trim(suffix, left, right),  
																	 DataLib.StringFind(suffix,'RD',1) > 0 => 'III',
																	 DataLib.StringFind(suffix,'ND',1) > 0 => 'II',
                                   (unsigned) suffix = 2 => 'II',
																   (unsigned) suffix = 3 => 'III',
																	 '');

	 current_name 						:= StringLib.StringCleanSpaces((L.LASTNAME+', '+L.FIRSTNAME+' '+ L.MIDDLENAME +' '+ get_suffix(L.SUFFIX)));
	 SELF.Name       					:= CHOOSE(C,current_name,L.AKA1,L.AKA2,L.AKA3);
	 SELF.NameType  					:= CHOOSE(C,'O','A1','A2','A3');
	 SELF.FileType						:= if(Full_filedate <> '','F','U');
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
	 SELF.NormAddress.Address1			:= StringLib.StringCleanSpaces(L.HOUSENUMBER + ' ' + L.STREETDIRECTION + ' ' + L.STREETNAME  + ' '+ L.STREETTYPE );
	 SELF.NormAddress.Address2			:= if(trim(L.APARTMENTNUMBER,all) <> '', '#' + L.APARTMENTNUMBER, L.APARTMENTNUMBER);
	 SELF.NormAddress.City				:= L.CITY;
	 SELF.NormAddress.State				:= L.STATE;
	 SELF.NormAddress.ZipCode			:= L.ZIPCODE;
   	 SELF.NormAddress.UpdatedDate		:= ''	;
	 SELF.PreviousAddress				:= DATASET([{'','','','','',''}], Transunion_PTrak.Layout_Transunion_Full_In.AddressRec);
	 SELF.Orig_DECEASEDINDICATOR		:= L.DECEASEDINDICATOR;
	 SELF.DECEASEDDATE := StringLib.StringFindReplace(L.DECEASEDDATE, '-','');
	 SELF           					:= L;
END;

norm_names := NORMALIZE(Transunion_Ptrak.File_Transunion_Update_In, 4, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',') :persist('~thor_data400::persist::transunionptrak_normalized_names_update');

return norm_names_filtered;

END;
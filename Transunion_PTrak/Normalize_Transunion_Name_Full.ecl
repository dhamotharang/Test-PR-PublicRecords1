//-----------------------------------------------------------------
//NORMALIZE CURRENT NAME AND AKA
//-----------------------------------------------------------------
	//current name, alias, aka and former name

norm_addresses := Transunion_PTrak.Normalize_Transunion_Address_Full;

Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec t_norm_name (Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec L, INTEGER C):= TRANSFORM
	 current_name := StringLib.StringCleanSpaces((L.CurrentName.LastName+', '+L.CurrentName.FirstName+' '+ IF(L.CurrentName.MiddleName = '', L.CurrentName.MiddleInitial, L.CurrentName.MiddleName) +' '+ L.CurrentName.Suffix));
	 aka1 := StringLib.StringCleanSpaces((L.FormerName.LastName+', '+ L.FormerName.FirstName+' '+ IF(L.FormerName.MiddleName = '', L.FormerName.MiddleInitial, L.FormerName.MiddleName) +' '+ L.FormerName.Suffix));
	 aka2 := (StringLib.StringCleanSpaces(L.AliasName.LastName+', '+ L.AliasName.FirstName+' '+ IF(L.AliasName.MiddleName = '', L.AliasName.MiddleInitial, L.AliasName.MiddleName) +' '+ L.AliasName.Suffix));
	 aka3 := StringLib.StringCleanSpaces((L.AdditionalName.LastName+', '+ L.AdditionalName.FirstName+' '+ IF(L.AdditionalName.MiddleName = '', L.AdditionalName.MiddleInitial, L.AdditionalName.MiddleName) +' '+ L.AdditionalName.Suffix));
	 SELF.Name       	:= CHOOSE(C,current_name,aka1,aka2,aka3);
	 SELF.NameType  	:= CHOOSE(C,'O','A1','A2','A3');
	 SELF.VendorDocumentIdentifier := L.VendorDocumentIdentifier ;
	 SELF           	:= L;
END;

norm_names := NORMALIZE(norm_addresses, 4, t_norm_name(LEFT, COUNTER));
norm_names_filtered := norm_names(TRIM(Name,all) <> '' AND TRIM(Name,all) <> ',');

EXPORT Normalize_Transunion_Name_Full := norm_names_filtered:persist('~thor_data400::persist::transunionptrak_normalized_names');



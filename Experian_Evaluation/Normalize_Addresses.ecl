//-----------------------------------------------------------------
//NORMALIZE Addresses
//-----------------------------------------------------------------
norm_names := Experian_Evaluation.Normalize_Names;

Layout_Experian_CP_Out.Layout_Experian_Norm_Address t_norm_addr (Layout_Experian_CP_Out.Layout_Experian_Norm_Name L, INTEGER C) := TRANSFORM
	STRING Addr1 := StringLib.StringCleanSpaces(L.Street_Address + ' ' + L.Street_Predirectional + ' ' + L.Street_Name + ' ' + L.Street_Suffix + ' ' + L.Street_PostDirectional);
	STRING Addr2 := StringLib.StringCleanSpaces(L.Unit_Type + ' ' + L.Unit_ID);
	
	STRING Addr1_1 := StringLib.StringCleanSpaces(L.Street_Address_Previous1 + ' ' + L.Street_Predirectional1 + ' ' + L.Street_Name1 + ' ' + L.Street_Suffix1 + ' ' + L.Street_PostDirectional1);
	STRING Addr2_1 := StringLib.StringCleanSpaces(L.Unit_Type1 + ' ' + L.Unit_ID1);
	
	STRING Addr1_2 := StringLib.StringCleanSpaces(L.Street_Address_Previous2 + ' ' + L.Street_Predirectional2 + ' ' + L.Street_Name2 + ' ' + L.Street_Suffix2 + ' ' + L.Street_PostDirectional2);
	STRING Addr2_2 := StringLib.StringCleanSpaces(L.Unit_Type2 + ' ' + L.Unit_ID2);
	
	STRING Addr1_3 := StringLib.StringCleanSpaces(L.Street_Address_Previous3 + ' ' + L.Street_Predirectional3 + ' ' + L.Street_Name3 + ' ' + L.Street_Suffix3 + ' ' + L.Street_PostDirectional3);
	STRING Addr2_3 := StringLib.StringCleanSpaces(L.Unit_Type3 + ' ' + L.Unit_ID3);
	
	STRING Addr1_4 := StringLib.StringCleanSpaces(L.Street_Address_Previous4 + ' ' + L.Street_Predirectional4 + ' ' + L.Street_Name4 + ' ' + L.Street_Suffix4 + ' ' + L.Street_PostDirectional4);
	STRING Addr2_4 := StringLib.StringCleanSpaces(L.Unit_Type4 + ' ' + L.Unit_ID4);
	
	STRING Addr1_5 := StringLib.StringCleanSpaces(L.Street_Address_Previous5 + ' ' + L.Street_Predirectional5 + ' ' + L.Street_Name5 + ' ' + L.Street_Suffix5 + ' ' + L.Street_PostDirectional5);
	STRING Addr2_5 := StringLib.StringCleanSpaces(L.Unit_Type5 + ' ' + L.Unit_ID5);
	
	STRING Addr1_6 := StringLib.StringCleanSpaces(L.Street_Address_Previous6 + ' ' + L.Street_Predirectional6 + ' ' + L.Street_Name6 + ' ' + L.Street_Suffix6 + ' ' + L.Street_PostDirectional6);
	STRING Addr2_6 := StringLib.StringCleanSpaces(L.Unit_Type6 + ' ' + L.Unit_ID6);
	
	STRING Addr1_7 := StringLib.StringCleanSpaces(L.Street_Address_Previous7 + ' ' + L.Street_Predirectional7 + ' ' + L.Street_Name7 + ' ' + L.Street_Suffix7 + ' ' + L.Street_PostDirectional7);
	STRING Addr2_7 := StringLib.StringCleanSpaces(L.Unit_Type7 + ' ' + L.Unit_ID7);
	
	
	SELF.Address1 		:=CHOOSE(C,Addr1, Addr1_1, Addr1_2, Addr1_3, Addr1_4, Addr1_5, Addr1_6, Addr1_7);
	SELF.Address2 		:=CHOOSE(C,Addr2, Addr2_1, Addr2_2, Addr2_3, Addr2_4, Addr2_5, Addr2_6, Addr2_7);
	
	SELF.City 			:=CHOOSE(C,L.City_Name,L.City_Name1,L.City_Name2, L.City_Name3, L.City_Name4, L.City_Name5, L.City_Name6, L.City_Name7);
	SELF.State 			:=CHOOSE(C,L.State_Abbreviation, L.State_Abbreviation1, L.State_Abbreviation2, L.State_Abbreviation3, L.State_Abbreviation4, L.State_Abbreviation5, L.State_Abbreviation6, L.State_Abbreviation7);
	SELF.ZipCode		:=CHOOSE(C,L.ZIP_Code, L.ZIP_Code1, L.ZIP_Code2, L.ZIP_Code3, L.ZIP_Code4, L.ZIP_Code5, L.ZIP_Code6, L.ZIP_Code7);
	SELF.ZipCode4		:=CHOOSE(C,L.ZIP_Plus_Four, L.ZIP_Plus_Four1, L.ZIP_Plus_Four2, L.ZIP_Plus_Four3, L.ZIP_Plus_Four4, L.ZIP_Plus_Four5, L.ZIP_Plus_Four6, L.ZIP_Plus_Four7);
	SELF.AddressSeq 	:= C ;	
	SELF 				:= L;
	SELF				:= [];
END;

norm_address := NORMALIZE(norm_names, 8, t_norm_addr(LEFT, COUNTER));

norm_addr_filtered := norm_address(TRIM(Address1 + Address2 + ZipCode + City ,all) <> '' AND TRIM(Address1 + Address2 + ZipCode + City,all) <> ',' AND LENGTH(TRIM(Address1 + Address2 + ZipCode + City,all)) > 1 AND TRIM(Address1 + Address2 + ZipCode + City,all) <> '00000');

EXPORT Normalize_Addresses := norm_addr_filtered:persist('~thor_data400::persist::experian_cp_normalized_addr');

//-----------------------------------------------------------------
//NORMALIZE Addresses
//-----------------------------------------------------------------
EXPORT Normalize_Address(string ver) := module

norm_names := ExperianCred.Normalize_Names(ver).all;

Layouts.Layout_Norm_Address t_norm_addr (Layouts.Layout_Norm_Name le, INTEGER C) := TRANSFORM
	SELF.Orig_Prim_Range	:=choose(C, le.Street_Address, le.Street_Address_Previous1, le.Street_Address_Previous2, le.Street_Address_Previous3, le.Street_Address_Previous4, le.Street_Address_Previous5, le.Street_Address_Previous6, le.Street_Address_Previous7);
	SELF.Orig_Predir		:=choose(C, le.Street_Predirectional, le.Street_Predirectional1, le.Street_Predirectional2, le.Street_Predirectional3, le.Street_Predirectional4, le.Street_Predirectional5, le.Street_Predirectional6, le.Street_Predirectional7);
	SELF.Orig_Prim_Name		:=choose(C, le.Street_Name, le.Street_Name1, le.Street_Name2, le.Street_Name3, le.Street_Name4, le.Street_Name5, le.Street_Name6, le.Street_Name7); 
	SELF.Orig_Addr_Suffix	:=choose(C, le.Street_Suffix, le.Street_Suffix1, le.Street_Suffix2, le.Street_Suffix3, le.Street_Suffix4, le.Street_Suffix5, le.Street_Suffix6, le.Street_Suffix7);
	SELF.Orig_Postdir		:=choose(C, le.Street_PostDirectional, le.Street_PostDirectional1, le.Street_PostDirectional2, le.Street_PostDirectional3, le.Street_PostDirectional4, le.Street_PostDirectional5, le.Street_PostDirectional6, le.Street_PostDirectional7);
	SELF.Orig_Unit_Desig	:=choose(C, le.Unit_Type, le.Unit_Type1, le.Unit_Type2, le.Unit_Type3, le.Unit_Type4, le.Unit_Type5, le.Unit_Type6,le.Unit_Type7);
	SELF.Orig_Sec_Range		:=choose(C, le.Unit_ID, le.Unit_ID1, le.Unit_ID2, le.Unit_ID3, le.Unit_ID4, le.Unit_ID5, le.Unit_ID6, le.Unit_ID7);
	SELF.Orig_City 			:=choose(C,le.City_Name,le.City_Name1,le.City_Name2, le.City_Name3, le.City_Name4, le.City_Name5, le.City_Name6, le.City_Name7);
	SELF.Orig_State 		:=choose(C,le.State_Abbreviation, le.State_Abbreviation1, le.State_Abbreviation2, le.State_Abbreviation3, le.State_Abbreviation4, le.State_Abbreviation5, le.State_Abbreviation6, le.State_Abbreviation7);
	SELF.Orig_ZipCode		:=choose(C,le.ZIP_Code, le.ZIP_Code1, le.ZIP_Code2, le.ZIP_Code3, le.ZIP_Code4, le.ZIP_Code5, le.ZIP_Code6, le.ZIP_Code7);
	SELF.Orig_ZipCode4		:=choose(C,le.ZIP_Plus_Four, le.ZIP_Plus_Four1, le.ZIP_Plus_Four2, le.ZIP_Plus_Four3, le.ZIP_Plus_Four4, le.ZIP_Plus_Four5, le.ZIP_Plus_Four6, le.ZIP_Plus_Four7);
	SELF.Orig_Address_Create_Date  :=choose(C,le.Address_Create_Date, le.Address_Create_Date1, le.Address_Create_Date2, le.Address_Create_Date3, le.Address_Create_Date4, le.Address_Create_Date5, le.Address_Create_Date6, le.Address_Create_Date7); 
	SELF.Orig_Address_Update_Date  :=choose(C,le.Address_Update_Date, le.Address_Update_Date1, le.Address_Update_Date2, le.Address_Update_Date3, le.Address_Update_Date4, le.Address_Update_Date5, le.Address_Update_Date6, le.Address_Update_Date7); 
	SELF.AddressSeq 		:= C ;	
	SELF 					:= le;
	SELF					:= [];
END;

norm_address := normalize(norm_names, 8, t_norm_addr(LEFT, COUNTER));

norm_addr_filtered := norm_address(trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all) <> '' AND 
								   trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all) <> ',' AND 
								   length(trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all)) > 1 AND 
								   trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all) <> '00000' AND
								   //To include include current addresses only for spouse record
								   (NameType[..2] <> 'SP' OR
								   (NameType[..2] = 'SP'  AND
									AddressSeq = 1))
								   );

EXPORT ALL := norm_addr_filtered:persist('~thor_data400::persist::experiancred::Normalize_Address');

END;

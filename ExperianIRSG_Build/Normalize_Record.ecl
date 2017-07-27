import ut;
input_files := files.file_in;

//----Assign a record sequence number;
Layout_Temp_Sequence := record
	unsigned Seq_Rec_Id :=0;
	Layouts.Layout_In;
end;

proj_input_files := project(input_files, Layout_Temp_Sequence);

//Add a record sequence
ut.MAC_Sequence_Records(proj_input_files, Seq_Rec_Id, input_files_id);
//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------

Layouts.Layout_Norm_Address t_norm_name (Layout_Temp_Sequence le, INTEGER C) := TRANSFORM
	valid_suffix := ['JR','SR','II','III','IV','VI','VII','VIII','IX'];
	get_suffix(string suffix) := map(suffix in valid_suffix => suffix,'');	
	get_title(string suffix) := map(suffix in valid_suffix => '',suffix);
	 
	SELF.Orig_fname					:= choose(C,le.Person_1_First_Name,le.Person_2_First_Name,le.Person_3_First_Name,le.Person_4_First_Name,le.Person_5_First_Name,le.Person_6_First_Name,le.Person_7_First_Name,le.Person_8_First_Name);
	SELF.Orig_mname					:= choose(C,le.Person_1_Middle_Initial,le.Person_2_Middle_Initial,le.Person_3_Middle_Initial,le.Person_4_Middle_Initial,le.Person_5_Middle_Initial,le.Person_6_Middle_Initial,le.Person_7_Middle_Initial,le.Person_8_Middle_Initial);
	SELF.Orig_lname					:= choose(C,le.Person_1_Last_Name,le.Person_2_Last_Name,le.Person_3_Last_Name,le.Person_4_Last_Name,le.Person_5_Last_Name,le.Person_6_Last_Name,le.Person_7_Last_Name,le.Person_8_Last_Name);
	SELF.Orig_suffix				:= choose(C,get_suffix(le.Person_1_Surname_Suffix),get_suffix(le.Person_2_Surname_Suffix),get_suffix(le.Person_3_Surname_Suffix),get_suffix(le.Person_4_Surname_Suffix),get_suffix(le.Person_5_Surname_Suffix),get_suffix(le.Person_6_Surname_Suffix),get_suffix(le.Person_7_Surname_Suffix),get_suffix(le.Person_8_Surname_Suffix));
	SELF.Orig_Title					:= choose(C,get_title(le.Person_1_Surname_Suffix),get_title(le.Person_2_Surname_Suffix),get_title(le.Person_3_Surname_Suffix),get_title(le.Person_4_Surname_Suffix),get_title(le.Person_5_Surname_Suffix),get_title(le.Person_6_Surname_Suffix),get_title(le.Person_7_Surname_Suffix),get_title(le.Person_8_Surname_Suffix));
	SELF.Orig_PID					:= choose(C,le.Person_1_PID, le.Person_2_PID, le.Person_3_PID, le.Person_4_PID, le.Person_5_PID, le.Person_6_PID, le.Person_7_PID, le.Person_8_PID);
	SELF.Orig_Type					:= choose(C,le.Person_1_Type, le.Person_2_Type, le.Person_3_Type, le.Person_4_Type, le.Person_5_Type, le.Person_6_Type, le.Person_7_Type, le.Person_8_Type);
	SELF.Orig_Title_of_Respect		:= choose(C,le.Person_1_Title_of_Respect, le.Person_2_Title_of_Respect, le.Person_3_Title_of_Respect, le.Person_4_Title_of_Respect, le.Person_5_Title_of_Respect, le.Person_6_Title_of_Respect, le.Person_7_Title_of_Respect, le.Person_8_Title_of_Respect);
	SELF.Orig_Gender				:= choose(C,le.Person_1_Gender, le.Person_2_Gender, le.Person_3_Gender, le.Person_4_Gender, le.Person_5_Gender, le.Person_6_Gender, le.Person_7_Gender, le.Person_8_Gender);
	SELF.Orig_Date_of_Birth			:= choose(C,le.Person_1_Date_of_Birth, le.Person_2_Date_of_Birth, le.Person_3_Date_of_Birth, le.Person_4_Date_of_Birth, le.Person_5_Date_of_Birth, le.Person_6_Date_of_Birth, le.Person_7_Date_of_Birth, le.Person_8_Date_of_Birth);
	SELF.Orig_SSN					:= choose(C,le.Person_1_SSN, le.Person_2_SSN, le.Person_3_SSN, le.Person_4_SSN, le.Person_5_SSN, le.Person_6_SSN, le.Person_7_SSN, le.Person_8_SSN);
	SELF.NameType					:= choose(C,'C1','C2','C3','C4','C5','C6','C7','C8');//C1-C8 all for Person 1 through Person 8
	SELF.Orig_Prim_Range			:= le.House_Number;
	SELF.Orig_Predir				:= le.Pre_Direction;
	SELF.Orig_Prim_Name				:= le.Street_Name;
	SELF.Orig_Addr_Suffix			:= le.Street_Suffix;
	SELF.Orig_Postdir				:= le.Post_Direction;
	SELF.Orig_Unit_Desig			:= le.Unit_Designator;
	SELF.Orig_Sec_Range				:= le.Unit_Designator_Number;
	SELF.Orig_City					:= le.City_Name;
	SELF.Orig_State					:= le.State_Abbr;
	SELF.Orig_ZipCode				:= le.Zip_Code;
	SELF.Orig_ZipCode4				:= le.Zip_4;
	SELF.Orig_Address_Start_date	:= le.Living_Unit_Start_Date;
	SELF.Orig_Address_date			:= le.Last_Activity_Date_of_LU;
	SELF.AddressSeq					:= 1;
	SELF							:= le;
	SELF							:= [];
END;

norm_names := normalize(input_files_id, 8, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(length(trim(Orig_lname,all)) > 1 AND 
							      trim(Orig_lname + Orig_mname + Orig_fname,all) <> ',' AND
								  trim(Orig_fname,all) <> '');

norm_addr_filtered := norm_names_filtered(trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all) <> ',' AND 
								   length(trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all)) > 1 AND 
								   trim(Orig_Prim_Range + Orig_Predir + Orig_Prim_Name + Orig_Addr_Suffix + Orig_Postdir + Orig_Unit_Desig + Orig_Sec_Range + Orig_City + Orig_State + Orig_ZipCode,all) <> '00000');

Layouts.Layout_Norm_Address t_norm_phone (Layouts.Layout_Norm_Address le, INTEGER C) := TRANSFORM
	
	SELF.Orig_Phone_Num	:= choose(C,le.Telephone_Number,le.Second_Phone_Number,le.Third_Phone_Number);
	SELF.Phone_Type		:= if(SELF.Orig_Phone_Num<>'',choose(C,'P1','P2','P3'),''); //Phone 1, Phone 2, Phone 3
	SELF.PhoneSeq 		:= if(SELF.Orig_Phone_Num<>'',C,0);
	SELF 				:= le;
	SELF				:= [];
	
END;

norm_phone := normalize(norm_addr_filtered, 3, t_norm_phone(LEFT, COUNTER));

norm_phone_filtered := norm_phone( phoneseq=1 or (unsigned)orig_phone_num>0);


EXPORT Normalize_Record := norm_phone_filtered:persist('~thor_data400::persist::experianIRSG_build::Normalize_Record');
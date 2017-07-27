import ut;
input_files := Files.File_In /* (Encrypted_Experian_PIN in[
'DZXWM0834945340',
'JNPOU0836069114',
'IRQDY0797242111',
'DFFBY0833340393',
'NLSXP0814422046',
'URITM0831539955',
'URITM0831394578',
'RIJGM0832662550',
'PQURO0834743336',
'ZAZTU0835660119',
'DFFBY0801053892',
'MSRPO0961623807',
'IGDUM0839703368',
'NYMVO0903274793',
'FEEKY0011418917',
'FYKWD0357959839',
'FLGBO0359285922',
'NYMVO0903274793',
'UZINY0000578555',
'FEEKY0011418917',
'FYKWD0357959839',
'FLGBO0359285922',
'TSVYD0734947769',
'MSRPO0026391579',
'PQURO0901905395'
 
])*/;
//----Assign a record sequence number;
Layout_Temp_Sequence := record
	unsigned Seq_Rec_Id :=0;
	Layouts.Layout_In;
end;

Layout_Temp_Sequence t_clean_bad_names(input_files le) := transform
	is_name2_valid 		   := if(le.first_name = le.surname2 and 
							     length(trim(le.first_name2,all)) = 1 and 
								 length(trim(le.middle_name,all)) > 0 , 
								 false, 
								 true);
	is_name3_valid		   := if(le.first_name = le.surname3 and 
								 length(trim(le.first_name3,all)) = 1 and 
								 length(trim(le.middle_name,all)) > 0 ,
								 false,
								 true);
	is_name4_valid		   := if(le.first_name = le.surname4 and 
								 length(trim(le.first_name4,all)) = 1 and 
								 length(trim(le.middle_name,all)) > 0,
								 false,
								 true);
	self.First_Name2 		:= if(is_name2_valid, le.First_Name2, '');
	self.First_Name3		:= if(is_name3_valid, le.First_Name3, '');
	self.First_Name4		:= if(is_name4_valid, le.First_Name4, '');
	self.Middle_Name2		:= if(is_name2_valid, le.Middle_Name2, '');
	self.Middle_Name3		:= if(is_name3_valid, le.Middle_Name3, '');
	self.Middle_Name4		:= if(is_name4_valid, le.Middle_Name4, '');
	self.Surname2			:= if(is_name2_valid, le.Surname2, '');
	self.Surname3			:= if(is_name3_valid, le.Surname3, '');
	self.Surname4			:= if(is_name4_valid, le.Surname4, '');
	self.Second_Surname2	:= if(is_name2_valid, le.Second_Surname2, '');
	self.Second_Surname3	:= if(is_name3_valid, le.Second_Surname3, '');
	self.Second_Surname4	:= if(is_name4_valid, le.Second_Surname4, '');
	self.Generation_Code2	:= if(is_name2_valid, le.Generation_Code2, '');
	self.Generation_Code3	:= if(is_name3_valid, le.Generation_Code3, '');
	self.Generation_Code4	:= if(is_name4_valid, le.Generation_Code4, '');
	self := le;

end;

input_files_t := project(input_files, t_clean_bad_names(left));

//Add a record sequence
ut.MAC_Sequence_Records(input_files_t, Seq_Rec_Id, input_files_id);
//-----------------------------------------------------------------
//NORMALIZE Names
//-----------------------------------------------------------------
/*	'C1' = Current Name with first surname
	'C2' = Current Name with second surname
	'O11' = Alias 1 with first surname
	'O12' = Alias 1 with second surname
	'O21' = Alias 2 with first surname
	'O22' = Alias 2 with second surname
	'O31' = Alias 3 with first surname
	'O32' = Alias 3 with second surname
	'SP1' = Spouse with first surname
	*/
	
Layouts.Layout_Norm_Name t_norm_name (Layout_Temp_Sequence le, INTEGER C) := TRANSFORM
	 get_suffix(string suffix) := map(suffix = 'J' => 'JR',
							   suffix = 'S' => 'SR',
							   suffix = '2' => 'II',
							   suffix = '3' => 'III',
							   suffix = '4' => 'IV',
							   '');
	 
	 SELF.Orig_fname 				:= choose(C,le.First_Name, le.First_Name, le.First_Name2 ,le.First_Name2, le.First_Name3, le.First_Name3, le.First_Name4, le.First_Name4, le.Spouse_First_Name);
	 SELF.Orig_mname 				:= choose(C,le.Middle_Name, le.Middle_Name, le.Middle_Name2, le.Middle_Name2, le.Middle_Name3, le.Middle_Name3, le.Middle_Name4, le.Middle_Name4, '');
	 SELF.Orig_lname 				:= choose(C,le.Surname, le.Second_Surname, le.Surname2, le.Second_Surname2, le.Surname3, le.Second_Surname3, le.Surname4, le.Second_Surname4, le.Surname);
	 SELF.Orig_suffix				:= choose(C,get_suffix(le.Generation_Code), get_suffix(le.Generation_Code), get_suffix(le.Generation_Code2), get_suffix(le.Generation_Code2), get_suffix(le.Generation_Code3), get_suffix(le.Generation_Code3), get_suffix(le.Generation_Code4), get_suffix(le.Generation_Code4), '');
	 SELF.NameType   				:= choose(C,'C1','C2','O11','O12', 'O21','O22', 'O31', 'O32','SP1');
	 SELF.Orig_Consumer_Create_Date := choose(C, le.Consumer_Create_Date, le.Consumer_Create_Date, le.Consumer_Create_Date2, le.Consumer_Create_Date2, le.Consumer_Create_Date3, le.Consumer_Create_Date3, le.Consumer_Create_Date4, le.Consumer_Create_Date4, '');
	 SELF 			 := le;
	 SELF			 := [];
END;

norm_names := normalize(input_files_id, 9, t_norm_name(LEFT, COUNTER));

norm_names_filtered := norm_names(length(trim(Orig_lname,all)) > 1 AND 
							      trim(Orig_lname + Orig_mname + Orig_fname,all) <> ',' AND
								  trim(Orig_fname,all) <> '');

EXPORT Normalize_Names := norm_names_filtered:persist('~thor_data400::persist::experiancred::Normalize_Names');

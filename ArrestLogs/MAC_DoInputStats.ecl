//***********/////***********/////***********/////***********/////***********/////***********/////***********
//	ADD FIELDS TO BE ROLLED UP ON AS NEEDED
//	ADD THE APPROPRIATE OUTPUT TO THE BOTTOM AND COMMENT OUT THE ONES YOU DO NOT NEED
//  Call Example from BWR:
//		ArrestLogs.MAC_DoInputStats(stat,ArrestLogs.mapBernalilloOffender,ArrestLogs.mapBernalilloOffenses)
//***********/////***********/////***********/////***********/////***********/////***********/////***********

export MAC_DoInputStats(stat, offender, offenses) := MACRO

output('View Output File - Top 300, Bottom 300, Random Sample', named('_'));
output('*All bottom samples are sorted descending', named('__'));

OUTPUt(choosen(offender, 300), named('Top_Offender'));
OUTPUt(choosen(sort(offender, -offender_key), 300), named('Bottom_Offender'));
OUTPUt(sample(offender, 8, 7), named('Random_Sample_Offender'));
OUTPUt(choosen(offenses, 300), named('Top_Offenses'));
OUTPUt(choosen(sort(offenses, -offender_key), 300), named('Bottom_Offenses'));
OUTPUt(sample(offenses, 8, 7), named('Random_Sample_Offenses'));

// A := IF(StringLib.StringFind('ABCDE', 'BC',1) = 2,
// 'Success',
// 'Failure - 1');

#UNIQUENAME(fileDER)
#UNIQUENAME(fileSES)
%fileDER% := distribute(offender, hash32(offender_key));
%fileSES% := distribute(offenses, hash32(offender_key));

#UNIQUENAME(full_layout)
%full_layout% := record
	Crim_Common.Layout_In_Court_Offender;
  end;
  
#UNIQUENAME(total)
#UNIQUENAME(off_layout)
%off_layout% := record
	offender.offender_key;
	%total% := count(group);
  end;
  
#UNIQUENAME(offs_layout)
%offs_layout% := record
	offenses.offender_key;
	offenses.off_comp;
	offenses.arr_off_desc_1;
	offenses.court_off_desc_1;
	%total% := count(group);
  end;
  
%fileDER% reformat1(%fileDER% l, %fileSES% r) := transform
 		self := l;
		self := [];
end;			 

%fileSES% reformat2(%fileDER% l, %fileSES% r) := transform
 		self := r;
		self := [];
end;

der_nm_file := join(%fileDER%, %fileSES%,
						(left.offender_key = right.offender_key),
						reformat1(left, right),left only); 

ses_nm_file := join(%fileDER%, %fileSES%,
						(left.offender_key = right.offender_key),
						reformat2(left, right),right only); 

#UNIQUENAME(offender_dupes)
%offender_dupes% := table(sort(offender, offender_key), %off_layout%, offender_key)(%total% > 1);

%fileDER% reformat3(%fileDER% l, %off_layout% r) := transform
 		self := l;
		self := r;
		self := [];
end;

off_key_file := join(%fileDER%, %offender_dupes%,
						(left.offender_key = right.offender_key),
						reformat3(left, right),lookup); 
						
#UNIQUENAME(offenses_dupes)
%offenses_dupes% := table(sort(offenses, offender_key, off_comp, arr_off_desc_1, court_off_desc_1), %offs_layout%, offender_key)(%total% > 1);

%fileSES% reformat4(%fileSES% l, %offs_layout% r) := transform
 		self := l;
		self := r;
		self := [];
end;

offs_key_file := join(%fileSES%, %offenses_dupes%,
						(left.offender_key = right.offender_key and left.off_comp = right.off_comp and left.arr_off_desc_1 = right.arr_off_desc_1 and left.court_off_desc_1 = right.court_off_desc_1),
						reformat4(left, right),lookup); 

#UNIQUENAME(field_desc)

#UNIQUENAME(process_date_short_layout)
%process_date_short_layout% := record
	string50 %field_desc% := 'process_date';
	offender.process_date;
	%total% := count(group);
end;

stat1 := table(offender, %process_date_short_layout%, process_date, few);

#UNIQUENAME(offender_key_short_layout)
%offender_key_short_layout% := record
	string50 %field_desc% := 'offender_key';
	offender.offender_key;
	%total% := count(group);
end;

stat2 := table(offender, %offender_key_short_layout%, offender_key);

#UNIQUENAME(offender_key_short_layout2)
%offender_key_short_layout2% := record
	string50 %field_desc% := 'offender_key';
	offenses.offender_key;
	%total% := count(group);
end;

stat39 := table(offenses, %offender_key_short_layout2%, offender_key);

#UNIQUENAME(vendor_short_layout)
%vendor_short_layout% := record
	string50 %field_desc% := 'vendor';
	offender.vendor;
	%total% := count(group);
end;

stat3 := table(offender, %vendor_short_layout%, vendor, few);

#UNIQUENAME(state_origin_short_layout)
%state_origin_short_layout% := record
	string50 %field_desc% := 'state_origin';
	offender.state_origin;
	%total% := count(group);
end;

stat4 := table(offender, %state_origin_short_layout%, state_origin, few);

#UNIQUENAME(data_type_short_layout)
%data_type_short_layout% := record
	string50 %field_desc% := 'data_type';
	offender.data_type;
	%total% := count(group);
end;

stat5 := table(offender, %data_type_short_layout%, data_type, few);

#UNIQUENAME(source_file_short_layout)
%source_file_short_layout% := record
	string50 %field_desc% := 'source_file';
	offender.source_file;
	%total% := count(group);
end;

stat6 := table(offender, %source_file_short_layout%, source_file, few);

#UNIQUENAME(case_filing_dt_short_layout)
%case_filing_dt_short_layout% := record
	string50 %field_desc% := 'case_filing_dt';
	offender.case_filing_dt;
	%total% := count(group);
end;

stat7 := table(offender, %case_filing_dt_short_layout%, case_filing_dt);

#UNIQUENAME(pty_nm_short_layout)
%pty_nm_short_layout% := record
	string50 %field_desc% := 'pty_nm';
	offender.pty_nm;
	%total% := count(group);
end;

stat8 := table(offender, %pty_nm_short_layout%, pty_nm);

#UNIQUENAME(pty_nm_fmt_short_layout)
%pty_nm_fmt_short_layout% := record
	string50 %field_desc% := 'pty_nm_fmt';
	offender.pty_nm_fmt;
	%total% := count(group);
end;

stat9 := table(offender, %pty_nm_fmt_short_layout%, pty_nm_fmt, few);

#UNIQUENAME(pty_typ_short_layout)
%pty_typ_short_layout% := record
	string50 %field_desc% := 'pty_typ';
	offender.pty_typ;
	%total% := count(group);
end;

stat10 := table(offender, %pty_typ_short_layout%, pty_typ, few);

#UNIQUENAME(orig_lname_short_layout)
%orig_lname_short_layout% := record
	string50 %field_desc% := 'orig_lname';
	offender.orig_lname;
	%total% := count(group);
end;

stat11 := table(offender, %orig_lname_short_layout%, orig_lname);

#UNIQUENAME(orig_fname_short_layout)
%orig_fname_short_layout% := record
	string50 %field_desc% := 'orig_fname';
	offender.orig_fname;
	%total% := count(group);
end;

stat12 := table(offender, %orig_fname_short_layout%, orig_fname);

#UNIQUENAME(orig_mname_short_layout)
%orig_mname_short_layout% := record
	string50 %field_desc% := 'orig_mname';
	offender.orig_mname;
	%total% := count(group);
end;

stat13 := table(offender, %orig_mname_short_layout%, orig_mname);

#UNIQUENAME(orig_name_suffix_short_layout)
%orig_name_suffix_short_layout% := record
	string50 %field_desc% := 'orig_name_suffix';
	offender.orig_name_suffix;
	%total% := count(group);
end;

stat14 := table(offender, %orig_name_suffix_short_layout%, orig_name_suffix, few);

#UNIQUENAME(id_num_short_layout)
%id_num_short_layout% := record
	string50 %field_desc% := 'id_num';
	offender.id_num;
	%total% := count(group);
end;

stat15 := table(offender, %id_num_short_layout%, id_num);

#UNIQUENAME(dob_short_layout)
%dob_short_layout% := record
	string50 %field_desc% := 'dob';
	offender.dob;
	%total% := count(group);
end;

stat16 := table(offender, %dob_short_layout%, dob);

#UNIQUENAME(race_desc_short_layout)
%race_desc_short_layout% := record
	string50 %field_desc% := 'race_desc';
	offender.race_desc;
	%total% := count(group);
end;

stat17 := table(offender, %race_desc_short_layout%, race_desc, few);

#UNIQUENAME(sex_short_layout)
%sex_short_layout% := record
	string50 %field_desc% := 'sex';
	offender.sex;
	%total% := count(group);
end;

stat18 := table(offender, %sex_short_layout%, sex, few);

#UNIQUENAME(party_status_desc_short_layout)
%party_status_desc_short_layout% := record
	string50 %field_desc% := 'party_status_desc';
	offender.party_status_desc;
	%total% := count(group);
end;

stat19 := table(offender, %party_status_desc_short_layout%, party_status_desc, few);

#UNIQUENAME(off_comp_short_layout)
%off_comp_short_layout% := record
	string50 %field_desc% := 'off_comp';
	offenses.off_comp;
	%total% := count(group);
end;

stat20 := table(offenses, %off_comp_short_layout%, off_comp, few);

#UNIQUENAME(arr_date_short_layout)
%arr_date_short_layout% := record
	string50 %field_desc% := 'arr_date';
	offenses.arr_date;
	%total% := count(group);
end;

stat21 := table(offenses, %arr_date_short_layout%, arr_date);

#UNIQUENAME(arr_off_desc_short_layout)
%arr_off_desc_short_layout% := record
	string50 %field_desc% := 'arr_off_desc_1';
	offenses.arr_off_desc_1;
	%total% := count(group);
end;

stat22 := table(offenses, %arr_off_desc_short_layout%, arr_off_desc_1, few);

#UNIQUENAME(arr_disp_desc_1_short_layout)
%arr_disp_desc_1_short_layout% := record
	string50 %field_desc% := 'arr_disp_desc_1';
	offenses.arr_disp_desc_1;
	%total% := count(group);
end;

stat23 := table(offenses, %arr_disp_desc_1_short_layout%, arr_disp_desc_1);

#UNIQUENAME(arr_disp_desc_2_short_layout)
%arr_disp_desc_2_short_layout% := record
	string50 %field_desc% := 'arr_disp_desc_2';
	offenses.arr_disp_desc_2;
	%total% := count(group);
end;

stat24 := table(offenses, %arr_disp_desc_2_short_layout%, arr_disp_desc_2, few);

#UNIQUENAME(arr_disp_date_short_layout)
%arr_disp_date_short_layout% := record
	string50 %field_desc% := 'arr_disp_date';
	offenses.arr_disp_date;
	%total% := count(group);
end;

stat25 := table(offenses, %arr_disp_date_short_layout%, arr_disp_date, few);

#UNIQUENAME(race_short_layout)
%race_short_layout% := record
	string50 %field_desc% := 'race';
	offender.race;
	%total% := count(group);
end;

stat26 := table(offender, %race_short_layout%, race, few);

#UNIQUENAME(hair_color_short_layout)
%hair_color_short_layout% := record
	string50 %field_desc% := 'hair_color';
	offender.hair_color;
	%total% := count(group);
end;

stat27 := table(offender, %hair_color_short_layout%, hair_color, few);

#UNIQUENAME(hair_color_desc_short_layout)
%hair_color_desc_short_layout% := record
	string50 %field_desc% := 'hair_color_desc';
	offender.hair_color_desc;
	%total% := count(group);
end;

stat28 := table(offender, %hair_color_desc_short_layout%, hair_color_desc, few);

#UNIQUENAME(eye_color_short_layout)
%eye_color_short_layout% := record
	string50 %field_desc% := 'eye_color';
	offender.eye_color;
	%total% := count(group);
end;

stat29 := table(offender, %eye_color_short_layout%, eye_color, few);

#UNIQUENAME(eye_color_desc_short_layout)
%eye_color_desc_short_layout% := record
	string50 %field_desc% := 'eye_color_desc';
	offender.eye_color_desc;
	%total% := count(group);
end;

stat30 := table(offender, %eye_color_desc_short_layout%, eye_color_desc, few);

#UNIQUENAME(skin_color_short_layout)
%skin_color_short_layout% := record
	string50 %field_desc% := 'skin_color';
	offender.skin_color;
	%total% := count(group);
end;

stat31 := table(offender, %skin_color_short_layout%, skin_color, few);

#UNIQUENAME(skin_color_desc_short_layout)
%skin_color_desc_short_layout% := record
	string50 %field_desc% := 'skin_color_desc';
	offender.skin_color_desc;
	%total% := count(group);
end;

stat32 := table(offender, %skin_color_desc_short_layout%, skin_color_desc, few);

#UNIQUENAME(le_agency_cd_short_layout)
%le_agency_cd_short_layout% := record
	string50 %field_desc% := 'le_agency_cd';
	offenses.le_agency_cd;
	%total% := count(group);
end;

stat33 := table(offenses, %le_agency_cd_short_layout%, le_agency_cd);

#UNIQUENAME(le_agency_desc_short_layout)
%le_agency_desc_short_layout% := record
	string50 %field_desc% := 'le_agency_desc';
	offenses.le_agency_desc;
	%total% := count(group);
end;

stat34 := table(offenses, %le_agency_desc_short_layout%, le_agency_desc, few);

#UNIQUENAME(height_short_layout)
%height_short_layout% := record
	string50 %field_desc% := 'height';
	offender.height;
	%total% := count(group);
end;

stat35 := table(offender, %height_short_layout%, height, few);

#UNIQUENAME(weight_short_layout)
%weight_short_layout% := record
	string50 %field_desc% := 'weight';
	offender.weight;
	%total% := count(group);
end;

stat36 := table(offender, %weight_short_layout%, weight, few);

#UNIQUENAME(arr_off_lev_short_layout)
%arr_off_lev_short_layout% := record
	string50 %field_desc% := 'arr_off_lev';
	offenses.arr_off_lev;
	%total% := count(group);
end;

stat37 := table(offenses, %arr_off_lev_short_layout%, arr_off_lev, few);

#UNIQUENAME(arr_statute_short_layout)
%arr_statute_short_layout% := record
	string50 %field_desc% := 'arr_statute';
	offenses.arr_statute;
	%total% := count(group);
end;

stat38 := table(offenses, %arr_statute_short_layout%, arr_statute, few);

#UNIQUENAME(num_of_counts_short_layout)
%num_of_counts_short_layout% := record
	string50 %field_desc% := 'num_of_counts';
	offenses.num_of_counts;
	%total% := count(group);
end;

stat40 := table(offenses, %num_of_counts_short_layout%, num_of_counts, few);


parallel(
output('OFFENDER SUMMARY', named('___')),
output(count(offender), named('Total_Records')),
output(count(stat2), named('Count_Unique_Offender_Keys')),
output(count(der_nm_file), named('Count_No_Offense_Matches')),
output(choosen(der_nm_file, 1000), named('No_Matches_Sample')),
output(choosen(off_key_file, 1000), named('Sample_Dupe_Offender_Keys')),
output('OFFENSES SUMMARY', named('____')),
output(count(offenses), named('Total_Records_')),
output(count(stat39), named('Count_Unique_Offender_Keys_')),
output(count(ses_nm_file), named('Count_No_Offender_Matches_')),
output(choosen(ses_nm_file, 1000), named('No_Matches_Sample_')),
output(choosen(offs_key_file, 1000), named('Sample_Dupe_Offender_Keys_')),
output('Field Specific Stats', named('_____')),
output(stat1, named('STAT_Process_Date')),
output(stat3, all, named('STAT_Vendor')),
output(stat4, all, named('STAT_State_Origin')),
output(stat5, all, named('STAT_Data_Type')),
output(stat6, all, named('STAT_Source_File')),
output(stat7, all, named('STAT_Case_Filing_Date')),
output(choosen(stat8, 1000), named('Top_Sample_Party_Name')),
output(choosen(sort(stat8, -pty_nm), 1000), named('Bottom_Sample_Party_Name')),
output(stat9, named('STAT_Party_Name_Format')),
output(stat10, all, named('STAT_Party_Type')),
output(choosen(stat11, 1000), named('Top_Sample_lname')),
output(choosen(sort(stat11, -orig_lname), 1000), named('Bottom_Sample_lname')),
output(choosen(stat12, 1000), named('Top_Sample_fname')),
output(choosen(sort(stat12, -orig_fname), 1000), named('Bottom_Sample_fname')),
output(choosen(stat13, 1000), named('Top_Sample_mname')),
output(choosen(sort(stat13, -orig_mname), 1000), named('Bottom_Sample_mname')),
output(stat14, all, named('STAT_name_suffix')),
output(choosen(stat15, 1000), named('Top_Sample_ID_Number')),
output(choosen(sort(stat15, -id_num), 1000), named('Bottom_Sample_ID_Number')),
output(stat16, all, named('STAT_Date_of_Birth')),
output(stat26, all, named('STAT_Race')),
output(stat17, all, named('STAT_Race_Description')),
output(stat18, all, named('STAT_Sex')),
output(stat27, all, named('STAT_Hair_Color')),
output(stat28, all, named('STAT_Hair_Color_Desc')),
output(stat29, all, named('STAT_Eye_Color')),
output(stat30, all, named('STAT_Eye_Color_Desc')),
output(stat31, all, named('STAT_Skin_Color')),
output(stat32, all, named('STAT_Skin_Color_Desc')),
output(stat35, all, named('STAT_Height')),
output(stat36, all, named('STAT_Weight')),
output(stat19, all, named('STAT_Party_Status_Description')),
output(stat20, all, named('STAT_Offense_Composition')),
output(stat40, all, named('STAT_Num_Of_Counts')),
output(stat33, all, named('STAT_Legal_Agency_Code')),
output(stat34, all, named('STAT_Legal_Agency_Desc')),
output(stat21, all, named('STAT_Arrest_Date')),
output(stat22, all, named('STAT_Arrest_Offense_Description')),
output(stat37, all, named('STAT_Arrest_Offense_Level')),
output(stat38, all, named('STAT_Arrest_Statute')),
output(stat23, all, named('STAT_Arrest_Disposition_Description_1')),
output(stat24, all, named('STAT_Arrest_Disposition_Description_2')),
output(stat25, all, named('STAT_Arrest_Disposition_Date'))
);
ENDMACRO;
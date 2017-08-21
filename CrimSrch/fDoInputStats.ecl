import ut, bankruptcyv2, address, LIB_Date, crim_common;

export fDoInputStats(dataset(Crim_Common.Layout_Moxie_Crim_Offender2.previous) offender, dataset(Crim_Common.Layout_Moxie_Court_Offenses) offenses) := function 

output('View Output File - Top 300, Bottom 300', named('_'));
output('*All bottom samples are sorted descending', named('__'));

OUTPUt(choosen(offender, 300), named('Top_Offender'));
OUTPUt(choosen(sort(offender, -offender_key), 300), named('Bottom_Offender'));
OUTPUt(choosen(offenses, 300), named('Top_Offenses'));
OUTPUt(choosen(sort(offenses, -offender_key), 300), named('Bottom_Offenses'));

fileDER := distribute(offender, hash32(offender_key));
fileSES := distribute(offenses, hash32(offender_key));

#UNIQUENAME(full_layout)
full_layout := record
	Crim_Common.Layout_Moxie_Crim_Offender2;
  end;
  
#UNIQUENAME(total)
#UNIQUENAME(off_layout)
off_layout := record
	offender.offender_key;
	total := count(group);
  end;


offs_layout := record
	offenses.offender_key;
	offenses.off_comp;
	offenses.arr_off_desc_1;
	offenses.court_off_desc_1;
	total := count(group);
  end;
  
fileDER reformat1(fileDER l, fileSES r) := transform
 		self := l;
		self := [];
end;			 

fileSES reformat2(fileDER l, fileSES r) := transform
 		self := r;
		self := [];
end;

der_nm_file := join(fileDER, fileSES,
						(left.offender_key = right.offender_key),
						reformat1(left, right),left only,local); 

ses_nm_file := join(fileDER, fileSES,
						(left.offender_key = right.offender_key),
						reformat2(left, right),right only,local); 


offender_dupes := table(sort(offender, offender_key), off_layout, offender_key)(total > 1);

fileDER reformat3(fileDER l, off_layout r) := transform
 		self := l;
		self := r;
		self := [];
end;

off_key_file := sort(join(fileDER, offender_dupes,
						(left.offender_key = right.offender_key),
						reformat3(left, right),lookup), offender_key, local); 
						

offenses_dupes := table(sort(offenses, offender_key, off_comp, arr_off_desc_1, court_off_desc_1), offs_layout, offender_key)(total > 1);

fileSES reformat4(fileSES l, offs_layout r) := transform
 		self := l;
		self := r;
		self := [];
end;

offs_key_file := sort(join(distribute(fileSES, hash(offender_key)), distribute(offenses_dupes, hash(offender_key)),
						(left.offender_key = right.offender_key and left.off_comp = right.off_comp and left.arr_off_desc_1 = right.arr_off_desc_1 and left.court_off_desc_1 = right.court_off_desc_1),
						reformat4(left, right),lookup), offender_key, local); 




process_date_short_layout := record
	string50 field_desc := 'process_date';
	offender.process_date;
	total := count(group);
end;

stat1 := table(offender, process_date_short_layout, process_date, few);


offender_key_short_layout := record
	string50 field_desc := 'offender_key';
	offender.offender_key;
	total := count(group);
end;

stat2 := table(offender, offender_key_short_layout, offender_key);


offender_key_short_layout2 := record
	string50 field_desc := 'offender_key';
	offenses.offender_key;
	total := count(group);
end;

stat39 := table(offenses, offender_key_short_layout2, offender_key);


vendor_short_layout := record
	string50 field_desc := 'vendor';
	offender.vendor;
	total := count(group);
end;

stat3 := table(offender, vendor_short_layout, vendor, few);


state_origin_short_layout := record
	string50 field_desc := 'state_origin';
	offender.state_origin;
	total := count(group);
end;

stat4 := table(offender, state_origin_short_layout, state_origin, few);


data_type_short_layout := record
	string50 field_desc := 'data_type';
	offender.data_type;
	total := count(group);
end;

stat5 := table(offender, data_type_short_layout, data_type, few);


source_file_short_layout := record
	string50 field_desc := 'source_file';
	offender.source_file;
	total := count(group);
end;

stat6 := table(offender, source_file_short_layout, source_file, few);


case_filing_dt_short_layout := record
	string50 field_desc := 'case_filing_dt';
	offender.case_filing_dt;
	total := count(group);
end;

stat7 := table(offender, case_filing_dt_short_layout, case_filing_dt);


pty_nm_short_layout := record
	string50 field_desc := 'pty_nm';
	offender.pty_nm;
	total := count(group);
end;

stat8 := table(offender, pty_nm_short_layout, pty_nm);


pty_nm_fmt_short_layout := record
	string50 field_desc := 'pty_nm_fmt';
	offender.pty_nm_fmt;
	total := count(group);
end;

stat9 := table(offender, pty_nm_fmt_short_layout, pty_nm_fmt, few);


pty_typ_short_layout := record
	string50 field_desc := 'pty_typ';
	offender.pty_typ;
	total := count(group);
end;

stat10 := table(offender, pty_typ_short_layout, pty_typ, few);


orig_lname_short_layout := record
	string50 field_desc := 'orig_lname';
	offender.orig_lname;
	total := count(group);
end;

stat11 := table(offender, orig_lname_short_layout, orig_lname);


orig_fname_short_layout := record
	string50 field_desc := 'orig_fname';
	offender.orig_fname;
	total := count(group);
end;

stat12 := table(offender, orig_fname_short_layout, orig_fname);


orig_mname_short_layout := record
	string50 field_desc := 'orig_mname';
	offender.orig_mname;
	total := count(group);
end;

stat13 := table(offender, orig_mname_short_layout, orig_mname);


orig_name_suffix_short_layout := record
	string50 field_desc := 'orig_name_suffix';
	offender.orig_name_suffix;
	total := count(group);
end;

stat14 := table(offender, orig_name_suffix_short_layout, orig_name_suffix, few);


id_num_short_layout := record
	string50 field_desc := 'id_num';
	offender.id_num;
	total := count(group);
end;

stat15 := table(offender, id_num_short_layout, id_num);


dob_short_layout := record
	string50 field_desc := 'dob';
	offender.dob;
	total := count(group);
end;

stat16 := table(offender, dob_short_layout, dob);


race_desc_short_layout := record
	string50 field_desc := 'race_desc';
	offender.race_desc;
	total := count(group);
end;

stat17 := table(offender, race_desc_short_layout, race_desc, few);


sex_short_layout := record
	string50 field_desc := 'sex';
	offender.sex;
	total := count(group);
end;

stat18 := table(offender, sex_short_layout, sex, few);


party_status_desc_short_layout := record
	string50 field_desc := 'party_status_desc';
	offender.party_status_desc;
	total := count(group);
end;

stat19 := table(offender, party_status_desc_short_layout, party_status_desc, few);


off_comp_short_layout := record
	string50 field_desc := 'off_comp';
	offenses.off_comp;
	total := count(group);
end;

stat20 := table(offenses, off_comp_short_layout, off_comp, few);


arr_date_short_layout := record
	string50 field_desc := 'arr_date';
	offenses.arr_date;
	total := count(group);
end;

stat21 := table(offenses, arr_date_short_layout, arr_date);


arr_off_desc_short_layout := record
	string50 field_desc := 'arr_off_desc_1';
	offenses.arr_off_desc_1;
	total := count(group);
end;

stat22 := table(offenses, arr_off_desc_short_layout, arr_off_desc_1, few);


arr_disp_desc_1_short_layout := record
	string50 field_desc := 'arr_disp_desc_1';
	offenses.arr_disp_desc_1;
	total := count(group);
end;

stat23 := table(offenses, arr_disp_desc_1_short_layout, arr_disp_desc_1);


arr_disp_desc_2_short_layout := record
	string50 field_desc := 'arr_disp_desc_2';
	offenses.arr_disp_desc_2;
	total := count(group);
end;

stat24 := table(offenses, arr_disp_desc_2_short_layout, arr_disp_desc_2, few);


arr_disp_date_short_layout := record
	string50 field_desc := 'arr_disp_date';
	offenses.arr_disp_date;
	total := count(group);
end;

stat25 := table(offenses, arr_disp_date_short_layout, arr_disp_date, few);


race_short_layout := record
	string50 field_desc := 'race';
	offender.race;
	total := count(group);
end;

stat26 := table(offender, race_short_layout, race, few);


hair_color_short_layout := record
	string50 field_desc := 'hair_color';
	offender.hair_color;
	total := count(group);
end;

stat27 := table(offender, hair_color_short_layout, hair_color, few);


hair_color_desc_short_layout := record
	string50 field_desc := 'hair_color_desc';
	offender.hair_color_desc;
	total := count(group);
end;

stat28 := table(offender, hair_color_desc_short_layout, hair_color_desc, few);


eye_color_short_layout := record
	string50 field_desc := 'eye_color';
	offender.eye_color;
	total := count(group);
end;

stat29 := table(offender, eye_color_short_layout, eye_color, few);


eye_color_desc_short_layout := record
	string50 field_desc := 'eye_color_desc';
	offender.eye_color_desc;
	total := count(group);
end;

stat30 := table(offender, eye_color_desc_short_layout, eye_color_desc, few);


skin_color_short_layout := record
	string50 field_desc := 'skin_color';
	offender.skin_color;
	total := count(group);
end;

stat31 := table(offender, skin_color_short_layout, skin_color, few);


skin_color_desc_short_layout := record
	string50 field_desc := 'skin_color_desc';
	offender.skin_color_desc;
	total := count(group);
end;

stat32 := table(offender, skin_color_desc_short_layout, skin_color_desc, few);


le_agency_cd_short_layout := record
	string50 field_desc := 'le_agency_cd';
	offenses.le_agency_cd;
	total := count(group);
end;

stat33 := table(offenses, le_agency_cd_short_layout, le_agency_cd);


le_agency_desc_short_layout := record
	string50 field_desc := 'le_agency_desc';
	offenses.le_agency_desc;
	total := count(group);
end;

stat34 := table(offenses, le_agency_desc_short_layout, le_agency_desc, few);


height_short_layout := record
	string50 field_desc := 'height';
	offender.height;
	total := count(group);
end;

stat35 := table(offender, height_short_layout, height, few);


weight_short_layout := record
	string50 field_desc := 'weight';
	offender.weight;
	total := count(group);
end;

stat36 := table(offender, weight_short_layout, weight, few);


arr_off_lev_short_layout := record
	string50 field_desc := 'arr_off_lev';
	offenses.arr_off_lev;
	total := count(group);
end;

stat37 := table(offenses, arr_off_lev_short_layout, arr_off_lev, few);


arr_statute_short_layout := record
	string50 field_desc := 'arr_statute';
	offenses.arr_statute;
	total := count(group);
end;

stat38 := table(offenses, arr_statute_short_layout, arr_statute, few);


num_of_counts_short_layout := record
	string50 field_desc := 'num_of_counts';
	offenses.num_of_counts;
	total := count(group);
end;

stat40 := table(offenses, num_of_counts_short_layout, num_of_counts, few);


court_off_desc_1_short_layout := record
	string50 field_desc := 'court_off_desc_1';
	offenses.court_off_desc_1;
	total := count(group);
end;

stat41 := dedup(sort(table(offenses, court_off_desc_1_short_layout, court_off_desc_1, few), record), record);


court_off_lev_short_layout := record
	string50 field_desc := 'court_off_lev';
	offenses.court_off_lev;
	total := count(group);
end;

stat42 := table(offenses, court_off_lev_short_layout, court_off_lev, few);


court_disp_date_short_layout := record
	string50 field_desc := 'court_disp_date';
	offenses.court_disp_date;
	total := count(group);
end;

stat43 := dedup(sort(table(offenses, court_disp_date_short_layout, court_disp_date, few), record), record);


court_disp_desc_1_short_layout := record
	string50 field_desc := 'court_disp_desc_1';
	offenses.court_disp_desc_1;
	total := count(group);
end;

stat44 := dedup(sort(table(offenses, court_disp_desc_1_short_layout, court_disp_desc_1, few), record), record);


sent_jail_short_layout := record
	string50 field_desc := 'sent_jail';
	offenses.sent_jail;
	total := count(group);
end;

stat45 := dedup(sort(table(offenses, sent_jail_short_layout, sent_jail, few), record), record);


sent_court_cost_short_layout := record
	string50 field_desc := 'sent_court_cost';
	offenses.sent_court_cost;
	total := count(group);
end;

stat46 := dedup(sort(table(offenses, sent_court_cost_short_layout, sent_court_cost, few), record), record);


sent_court_fine_short_layout := record
	string50 field_desc := 'sent_court_fine';
	offenses.sent_court_fine;
	total := count(group);
end;

stat47 := dedup(sort(table(offenses, sent_court_fine_short_layout, le_agency_cd), record), record);


sent_susp_court_fine_short_layout := record
	string50 field_desc := 'sent_susp_court_fine';
	offenses.sent_susp_court_fine;
	total := count(group);
end;

stat48 := dedup(sort(table(offenses, sent_susp_court_fine_short_layout, sent_susp_court_fine, few), record), record);


sent_probation_short_layout := record
	string50 field_desc := 'sent_probation';
	offenses.sent_probation;
	total := count(group);
end;

stat49 := dedup(sort(table(offenses, sent_probation_short_layout, sent_probation, few), record), record);


street_address_1_short_layout := record
	string50 field_desc := 'street_address_1';
	offender.street_address_1;
	total := count(group);
end;

stat50 := dedup(sort(table(offender, street_address_1_short_layout, street_address_1, few), record), record);


street_address_2_short_layout := record
	string50 field_desc := 'street_address_2';
	offender.street_address_2;
	total := count(group);
end;

stat51 := dedup(sort(table(offender, street_address_2_short_layout, street_address_2, few), record), record);


street_address_3_short_layout := record
	string50 field_desc := 'street_address_3';
	offender.street_address_3;
	total := count(group);
end;

stat52 := dedup(sort(table(offender, street_address_3_short_layout, street_address_3, few), record), record);



street_address_4_short_layout := record
	string50 field_desc := 'street_address_4';
	offender.street_address_4;
	total := count(group);
end;

stat53 := dedup(sort(table(offender, street_address_4_short_layout, street_address_4, few), record), record);


street_address_5_short_layout := record
	string50 field_desc := 'street_address_5';
	offender.street_address_5;
	total := count(group);
end;

stat54 := dedup(sort(table(offender, street_address_5_short_layout, street_address_5, few), record), record);


off_date_short_layout := record
	string50 field_desc := 'off_date';
	offenses.off_date;
	total := count(group);
end;

stat55 := dedup(sort(table(offenses, off_date_short_layout, off_date, few), record), record);


court_case_number_short_layout := record
	string50 field_desc := 'court_case_number';
	offenses.court_case_number;
	total := count(group);
end;

stat56 := dedup(sort(table(offenses, court_case_number_short_layout, court_case_number, few), record), record);


court_statute_short_layout := record
	string50 field_desc := 'court_statute';
	offenses.court_statute;
	total := count(group);
end;

stat57 := dedup(sort(table(offenses, court_statute_short_layout, court_statute, few), record), record);


court_statute_desc_short_layout := record
	string50 field_desc := 'court_statute_desc';
	offenses.court_statute_desc;
	total := count(group);
end;

stat58 := dedup(sort(table(offenses, court_statute_desc_short_layout, court_statute_desc, few), record), record);


court_disp_code_short_layout := record
	string50 field_desc := 'court_disp_code';
	offenses.court_disp_code;
	total := count(group);
end;

stat59 := dedup(sort(table(offenses, court_disp_code_short_layout, court_disp_code, few), record), record);



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
output(choosen(stat50, 1000), named('Top_Sample_Address1')),
output(choosen(sort(stat50, -street_address_1), 1000), named('Bottom_Sample_Address1')),
output(choosen(stat51, 1000), named('Top_Sample_Address2')),
output(choosen(sort(stat51, -street_address_2), 1000), named('Bottom_Sample_Address2')),
output(choosen(stat52, 1000), named('Top_Sample_Address3')),
output(choosen(sort(stat52, -street_address_3), 1000), named('Bottom_Sample_Address3')),
output(choosen(stat53, 1000), named('Top_Sample_Address4')),
output(choosen(sort(stat53, -street_address_4), 1000), named('Bottom_Sample_Address4')),
output(choosen(stat54, 1000), named('Top_Sample_Address5')),
output(choosen(sort(stat54, -street_address_5), 1000), named('Bottom_Sample_Address5')),

output(choosen(stat16, 1000), named('STAT_Date_of_Birth')),
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
output(choosen(stat40, 1000), all, named('STAT_Num_Of_Counts')),
output(stat33, all, named('STAT_Legal_Agency_Code')),
output(stat34, all, named('STAT_Legal_Agency_Desc')),
output(stat21, all, named('STAT_Arrest_Date')),
output(stat55, all, named('STAT_Offense_Date')),
output(stat22, all, named('STAT_Arrest_Offense_Description')),
output(stat37, all, named('STAT_Arrest_Offense_Level')),
output(stat38, all, named('STAT_Arrest_Statute')),
output(stat23, all, named('STAT_Arrest_Disposition_Description_1')),
output(stat24, all, named('STAT_Arrest_Disposition_Description_2')),
output(stat25, all, named('STAT_Arrest_Disposition_Date')),
output(choosen(stat56, 1000), all, named('STAT_Court_Case_Number')),
output(stat41, all, named('STAT_court_off_desc_1')),
output(choosen(stat42, 1000), all, named('STAT_court_off_lev')),
output(stat57, named('STAT_Court_Statute')),
output(stat58, all, named('STAT_Court_Statute_Description')),
output(stat43, all, named('STAT_court_disp_date')),
output(choosen(stat59, 1000), all, named('STAT_court_disp_code')),
output(stat44, all, named('STAT_court_disp_desc_1')),
output(stat45, all, named('STAT_sent_jail')),
output(choosen(stat46, 1000), all, named('STAT_sent_court_cost')),
output(choosen(stat47, 1000), all, named('STAT_sent_court_fine')),
output(stat48, all, named('STAT_sent_susp_court_fine')),
output(choosen(stat49, 1000), all, named('STAT_sent_probation'))
);

outstatement := 'done';

return outstatement;

end;
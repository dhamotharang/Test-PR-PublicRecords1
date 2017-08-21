/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////
////
//// INPUTFILE - 			file sent to infutor powerflex before stripping phones
////
//// POWERFLEX FILENAME - 	string filename only. powerflex outputs are in the same format. update layout if this changes
////   						cellphone.Layout_PowerFlexResults
////
//// INPUTPHONE_FIELD -		field name for phone in input file sent to infutor powerflex. used for joining the input file to the powerflex output
////
//// RESULTS -				result output when macro is complete. when running macro this parameter should be called
////
//// LARGE DATASET -		DEFAULT TRUE. yellowpages phonetype macro will received files as small as 1 record or as large as 1 billion to retrieve phonetypes
////   						and append to. large is set to true by default and is for records that can evenly distribute across all nodes. if your
////   						dataset is small, set to false.
////
//// NAME -					DEFAULT FALSE. the input file names are clean, the fields have standard names (Address.Layout_Clean_Name), and comparison is necessary
////
//// ADDR -					DEFAULT FALSE. the input file addresses are clean, the fields have standard names (Address.Layout_Clean182), and comparison is necessary
/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////INSTRUCTIONS/////////////

export macPowerFlexResults(inputfile, powerflex_filename, inputphone_field, results, name = false, addr = false, large_dataset = true) := macro

#workunit('name', 'Powerflex Eval - ' + powerflex_filename)

#uniquename(powerflex_out)
#uniquename(flag_connects)
#uniquename(powerflex_ptypes)
#uniquename(ptype_connects)
#uniquename(count_)
#uniquename(IFcid_phonetype)
#uniquename(telco_connects)
#uniquename(pflex_clean_out)
#uniquename(cleanaddr)
#uniquename(cleanname)
#uniquename(tCLEAN)
#uniquename(joined_layout)
#uniquename(joinphones)

%powerflex_out% := dataset(powerflex_filename, cellphone.Layout_PowerFlexResults, csv(separator('\t'), heading(1)));

yellowpages.NPA_PhoneType(%powerflex_out%, IFcid_phone, %IFcid_phonetype%, %powerflex_ptypes%, large_dataset /*(lds - deault to true; over 10,000 records. if not, type false) */)

%flag_connects% := project(%powerflex_ptypes%, transform(recordof(%powerflex_ptypes%),
																self.IFcid_connect_status := if(left.IFcid_idate <> '', 'Connect', 'Disconnect'),
																self := left)) : persist('persist::powerflex_eval::ptypes');

%ptype_connects% := table(%flag_connects%, {IFcid_connect_status, %IFcid_phonetype%, %count_% := count(group)},IFcid_connect_status, %IFcid_phonetype% ,few);
%telco_connects% := table(%flag_connects%, {IFcid_connect_status,  IFcid_telco,     %count_% := count(group)},IFcid_connect_status, IFcid_telco,few);

recordof(%flag_connects%) %tCLEAN%(inputfile l, recordof(%flag_connects%) r) := transform
	%cleanaddr% := address.CleanAddress182('',r.IFcid_city + ', ' + r.IFcid_state + '  ' + r.IFcid_zip5 + r.IFcid_zip4);
	%cleanname% := address.CleanPersonFML73(r.IFcid_fname + ' ' + r.IFcid_middle_name + ' ' + r.IFcid_lname);

	self.ifcid_clean_title := %cleanname%[1..5];
	self.ifcid_clean_fname := %cleanname%[6..25];
	self.ifcid_clean_mname := %cleanname%[26..45];
	self.ifcid_clean_lname := %cleanname%[46..65];
	self.ifcid_clean_name_suffix := %cleanname%[66..70];
	self.ifcid_clean_p_city_name := %cleanaddr%[65..89];
	self.ifcid_clean_v_city_name := %cleanaddr%[90..114];
	self.ifcid_clean_st := if(%cleanaddr%[115..116]='',ziplib.ZipToState2(%cleanaddr%[117..121]),%cleanaddr%[115..116]);
	self.ifcid_clean_zip := %cleanaddr%[117..121];
	self.ifcid_clean_zip4 := %cleanaddr%[122..125];
	self := l;
	self := r;
end;


%pflex_clean_out% := join(inputfile, %flag_connects%,left.inputphone_field = right.ifcid_phone, %tCLEAN%(left, right)) : persist('persist::powerflex_eval::cleaned'); 

#UNIQUENAME(d)
#UNIQUENAME(population_counts)
#UNIQUENAME(Populated_title)
#UNIQUENAME(Populated_fname)
#UNIQUENAME(Populated_mname)
#UNIQUENAME(Populated_lname)
#UNIQUENAME(Populated_name_suffix)
#UNIQUENAME(Populated_p_city_name)
#UNIQUENAME(Populated_v_city_name)
#UNIQUENAME(Populated_st)
#UNIQUENAME(Populated_zip)
#UNIQUENAME(Populated_zip4)
#UNIQUENAME(Populated_ifcid_clean_title)
#UNIQUENAME(Populated_ifcid_clean_fname)
#UNIQUENAME(Populated_ifcid_clean_mname)
#UNIQUENAME(Populated_ifcid_clean_lname)
#UNIQUENAME(Populated_ifcid_clean_name_suffix)
#UNIQUENAME(Populated_ifcid_clean_p_city_name)
#UNIQUENAME(Populated_ifcid_clean_v_city_name)
#UNIQUENAME(Populated_ifcid_clean_st)
#UNIQUENAME(Populated_ifcid_clean_zip)
#UNIQUENAME(Populated_ifcid_clean_zip4)
#UNIQUENAME(pop_table)
#UNIQUENAME(pct_table)
#UNIQUENAME(population_pcts)

%d% := %pflex_clean_out%;

%population_counts% := record
decimal12_4 %Populated_title% := count(group, %d%.title <> '');
decimal12_4 %Populated_fname% := count(group, %d%.fname <> '');
decimal12_4 %Populated_mname% := count(group, %d%.mname <> '');
decimal12_4 %Populated_lname% := count(group, %d%.lname <> '');
decimal12_4 %Populated_name_suffix% := count(group, %d%.name_suffix <> '');
decimal12_4 %Populated_p_city_name% := count(group, %d%.p_city_name <> '');
decimal12_4 %Populated_v_city_name% := count(group, %d%.v_city_name <> '');
decimal12_4 %Populated_st% := count(group, %d%.st <> '');
decimal12_4 %Populated_zip% := count(group, %d%.zip <> '');
decimal12_4 %Populated_zip4% := count(group, %d%.zip4 <> '');
decimal12_4 %Populated_ifcid_clean_title% := count(group, %d%.ifcid_clean_title <> '');
decimal12_4 %Populated_ifcid_clean_fname% := count(group, %d%.ifcid_clean_fname <> '');
decimal12_4 %Populated_ifcid_clean_mname% := count(group, %d%.ifcid_clean_mname <> '');
decimal12_4 %Populated_ifcid_clean_lname% := count(group, %d%.ifcid_clean_lname <> '');
decimal12_4 %Populated_ifcid_clean_name_suffix% := count(group, %d%.ifcid_clean_name_suffix <> '');
decimal12_4 %Populated_ifcid_clean_p_city_name% := count(group, %d%.ifcid_clean_p_city_name <> '');
decimal12_4 %Populated_ifcid_clean_v_city_name% := count(group, %d%.ifcid_clean_v_city_name <> '');
decimal12_4 %Populated_ifcid_clean_st% := count(group, %d%.ifcid_clean_st <> '');
decimal12_4 %Populated_ifcid_clean_zip% := count(group, %d%.ifcid_clean_zip <> '');
decimal12_4 %Populated_ifcid_clean_zip4% := count(group, %d%.ifcid_clean_zip4 <> '');

end;



%population_pcts% := record
decimal12_4 %Populated_title% := count(group, %d%.title <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_fname% := count(group, %d%.fname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_mname% := count(group, %d%.mname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_lname% := count(group, %d%.lname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_name_suffix% := count(group, %d%.name_suffix <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_p_city_name% := count(group, %d%.p_city_name <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_v_city_name% := count(group, %d%.v_city_name <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_st% := count(group, %d%.st <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_zip% := count(group, %d%.zip <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_zip4% := count(group, %d%.zip4 <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_title% := count(group, %d%.ifcid_clean_title <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_fname% := count(group, %d%.ifcid_clean_fname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_mname% := count(group, %d%.ifcid_clean_mname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_lname% := count(group, %d%.ifcid_clean_lname <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_name_suffix% := count(group, %d%.ifcid_clean_name_suffix <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_p_city_name% := count(group, %d%.ifcid_clean_p_city_name <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_v_city_name% := count(group, %d%.ifcid_clean_v_city_name <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_st% := count(group, %d%.ifcid_clean_st <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_zip% := count(group, %d%.ifcid_clean_zip <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
decimal12_4 %Populated_ifcid_clean_zip4% := count(group, %d%.ifcid_clean_zip4 <> '')/count(group, %d%.IFcid_connect_status = 'Connect');
end;

%pop_table% := table(%pflex_clean_out%(IFcid_connect_status = 'Connect'), %population_counts%, few) + table(%pflex_clean_out%(IFcid_connect_status = 'Connect'), %population_pcts%, few);

#UNIQUENAME(matching)

#IF(name = true and addr = true)
	%matching% := parallel(
		output(choosen(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12]), 100), named('Records_with_Last_Name_Match'));
		output(count(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_Last_Name_Match'));
		output(choosen(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12] and p_city_name = ifcid_clean_p_city_name and p_city_name <> ''), 100), 
				named('Records_with_Last_Name_and_City_Match'));
		output(count(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12] and p_city_name = ifcid_clean_p_city_name and p_city_name <> '')), 
				named('Count_Records_with_Last_Name_and_City_Match'));
		output(choosen(%pflex_clean_out%(p_city_name = ifcid_clean_p_city_name and ifcid_clean_lname[1..12] = lname[1..12] and ifcid_clean_fname[1..12] = fname[1..12]), 100), named('Records_with_First_and_Last_Name_and_City_Match'));
		output(count(%pflex_clean_out%(p_city_name = ifcid_clean_p_city_name and ifcid_clean_lname[1..12] = lname[1..12] and ifcid_clean_fname[1..12] = fname[1..12])), named('Count_Records_with_First_and_Last_Name_and_City_Match'));
		output(count(%pflex_clean_out%(err_stat[1..1] = 'E' and ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_Last_Name_Match_Input_AddrCleanError'));
		output(choosen(%pflex_clean_out%(err_stat[1..1] = 'E' and ifcid_clean_zip <> '' and ifcid_clean_lname[1..12] = lname[1..12]), 100), named('Records_with_Last_Name_Match_Input_AddrCleanError_PowerflexHasZip'));
		output(count(%pflex_clean_out%(err_stat[1..1] = 'E' and ifcid_clean_zip <> '' and ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_Last_Name_Match_Input_AddrCleanError_PowerflexHasZip'));
		output(count(%pflex_clean_out%(ifcid_clean_fname[1..12] = fname[1..12] and err_stat[1..1] = 'E' and ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_FirstAndLast_Name_Match_Input_AddrCleanError'));
		output(choosen(%pflex_clean_out%(ifcid_clean_fname[1..12] = fname[1..12] and err_stat[1..1] = 'E' and ifcid_clean_zip <> '' and ifcid_clean_lname[1..12] = lname[1..12]), 100), named('Records_with_FirstAndLast_Name_Match_Input_AddrCleanError_PowerflexHasZip'));
		output(count(%pflex_clean_out%(ifcid_clean_fname[1..12] = fname[1..12] and err_stat[1..1] = 'E' and ifcid_clean_zip <> '' and ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_FirstAndLast_Name_Match_Input_AddrCleanError_PowerflexHasZip')));
#ELSEif(name = true)
	%matching% := parallel(
		output(choosen(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12]), 100), named('Records_with_Last_Name_Match'));
		output(count(%pflex_clean_out%(ifcid_clean_lname[1..12] = lname[1..12])), named('Count_Records_with_Last_Name_Match')));
#ELSE 
	%matching% := output('Name and Address Matching not selected');
#END

results := 
	parallel(
		output(count(inputfile), named('Count_Input_File_Records'));
		output(count(dedup(inputfile, inputphone_field, all)), named('Count_Input_File_Unique_Phones'));
		output(choosen(inputfile, 100), named('Sample_Input_File'));
output('----------');
		output(count(%powerflex_out%), named('Count_Powerflex_Output_File_Records'));
		output(count(dedup(%powerflex_out%, ifcid_phone, all)), named('Count_Powerflex_Output_Unique_Phones'));
		output(choosen(%powerflex_out%, 100), named('Sample_Powerflex_Output_File'));
output('----------');
		output(table(%flag_connects%, {IFcid_connect_status, %count_% := count(group)},IFcid_connect_status , few), named('Connect_Counts'));
		output(%ptype_connects%, named('Connects_by_PhoneTypes'));
		output(%telco_connects%,, 'out::PowerFlex_Telcos_by_Connect_Status_' + WORKUNIT, overwrite, expire(30));
output('----------');
		output(count(%pflex_clean_out%), named('Count_Joined_Records'));
		output(count(dedup(%pflex_clean_out%, ifcid_phone, all)), named('Count_Joined_Unique_Phones'));
		output(%pflex_clean_out%,, 'out::PowerFlex_Joined_' + WORKUNIT, overwrite, expire(30));
output('----------');
%matching%);
endmacro;
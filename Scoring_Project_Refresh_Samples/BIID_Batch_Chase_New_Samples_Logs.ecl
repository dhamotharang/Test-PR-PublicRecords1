// EXPORT BIID_Batch_Chase_New_Samples_Logs := 'todo';
#workunit('name','BIID_Batch');

import IntlIID;
		import  zz_bbraaten, Scoring_Project_Macros, ut, zz_Koubsky_SALT,SALT23;


fileLocation2 := '~bbraaten::chasebiid_clean';
filein2 := '~scoring_project::in::biid_batch_chase_generic_20170330';
fileout :='~bbraaten::in::BIID_Batch_Chase_test';
eyeball := 50;



inputstructure := record
  string name_company;
  string street_addr2;  
	string p_city_name_2;
	string st_2;
  string z5_2;
  string zip4_2;
	string fein;
  string phoneno;
	// string firstname;
  // string middlename;
  // string lastname;
  string Rep_Name;
  string streetaddress;
  string city;
  string state;
  string zip_5;
  string zip_4;
	string ssn;
  string dateofbirth;
  string dlnumber;
  string dlstate;
	// string workphone;
  string email;

	end;

inputData := DATASET(fileLocation2, inputStructure, csv(Heading(1)));
OUTPUT(CHOOSEN(inputData, eyeball), NAMED('inputData'));
output(count(inputData), named('inputData_count'));



Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

OriginalData := DATASET(filein2, Output_structure, thor);
OUTPUT(CHOOSEN(OriginalData, eyeball), NAMED('OriginalData'));
output(count(OriginalData), named('OriginalData_count'));

FindMaxAccount := choosen(sort(OriginalData, -accountnumber), 5);
MaxAccount := max(FindMaxAccount, accountnumber);
output(MaxAccount, named('maxaccount'));



Output_structure batchlay(inputStructure le ) := TRANSFORM
	self.Date_added := (Integer)ut.getdate;
	// self.accountnumber := c + MaxAccount;
	// self.perm_flag := 5;	
	self.customer := 'Chase 1560585';
	self.Source_Info := 'BIID Batch Logs';
  self.firstname := StringLib.StringGetNthWord(le.rep_name, 1);
  self.middlename := if(StringLib.StringGetNthWord(le.rep_name, 3) = '', '', StringLib.StringGetNthWord(le.rep_name, 2));
  self.lastname := if(StringLib.StringGetNthWord(le.rep_name, 3) = '', StringLib.StringGetNthWord(le.rep_name, 2), StringLib.StringGetNthWord(le.rep_name, 3));
  self.Zip := le.z5_2 + le.zip4_2;
		self.history_date := 999999;
		self.historydateyyyymm := 999999;

	self := le;
	SELF := [];
END;




BIID := project(inputData, batchlay(left));
OUTPUT(CHOOSEN(BIID, eyeball), NAMED('BIID_input'));
output(count(BIID), named('BIID_count'));

filteredSSN := BIID(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzip2 := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
filteredzip := filteredzip2(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', z5_2));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));

goodinfo := filteredzip(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in ['']  and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dateofbirth != ''  
											and name_company <> '' and name_company <> 'CO' and street_addr2 != '' and p_city_name_2 != '' and st_2 != '' and z5_2 != ''  
											and phoneno <> '' and fein <> '' );
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo), named('goodinfo_count'));


DedupedData := dedup(goodinfo, name_company, street_addr2, z5_2, fein, ssn, all); 
OUTPUT(CHOOSEN(DedupedData, 300), NAMED('DedupedData'));
output(count(DedupedData), named('DedupedData_count'));



keepers_1_0 := OriginalData(perm_flag = 0);
output(count(keepers_1_0));
keepers_1_1 := OriginalData(perm_flag = 1);
output(count(keepers_1_1));
keepers_1_2 := OriginalData(perm_flag = 2);
output(count(keepers_1_2));
keepers_1_3 := OriginalData(perm_flag = 3);
output(count(keepers_1_3));
keepers_1_4 := OriginalData(perm_flag = 4);
output(count(keepers_1_4));


keepers := sort(keepers_1_0+keepers_1_2+keepers_1_3+keepers_1_4, date_added);
output(count(keepers), named('keepers'));

Output_structure Rearrange(output_structure le ) := TRANSFORM
	self.Perm_Flag := If(le.perm_flag <= 0, 0, le.perm_flag - 1);  	

	self := le;
  self := [];
END;

Reflagged_Logs2 := project(keepers, Rearrange(left));
output(choosen(Reflagged_Logs2, eyeball), named('Reflagged_Logs2'));
output(count(keepers), named('Reflagged_Logs2_count'));

old0 := Reflagged_Logs2(perm_flag = 0);
output(count(old0), named('Reflagged_LogsNew0'));
old1 := Reflagged_Logs2(perm_flag = 1);
output(count(old1), named('Reflagged_LogsNew1'));
old2 := Reflagged_Logs2(perm_flag = 2);
output(count(old2), named('Reflagged_LogsNew2'));
old3 := Reflagged_Logs2(perm_flag = 3);
output(count(old3), named('Reflagged_LogsNew3'));
old4 := Reflagged_Logs2(perm_flag = 4);
output(count(old4), named('Reflagged_LogsNew4'));


New_right := join(Reflagged_Logs2, DedupedData,  left.name_company = right.name_company
		/*not sure if */		and left.street_addr2 = right.street_addr2
		/*this will work*/	and left.z5_2 = right.z5_2
												and left.fein = right.fein
												and left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;

output(New_right, named('New_right'));


// new_large_sample := Reflagged_Logs2 + New_right; //add "new_right" to old dataset;
// output(count(new_large_sample), named('new_large_sample_count'));


// sort_large_sample := Sort(new_large_sample, name_company, Date_added); //sort by date added for dedup

deduped_new := New_right(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
// dedupold:= sort_large_sample(Date_added <> (Integer)ut.getdate);


ut.MAC_Pick_Random(deduped_new,New_5000,5000);   //grabs 5000 of new deduped rocrods;
output(New_5000, named('New_5000'));
output(count(New_5000), named('New_5000_count'));

Output_structure renumber(Output_structure le, integer c) := TRANSFORM
	self.accountnumber := c + (integer)MaxAccount;
	self.perm_flag := 4;	
	self := le;
	SELF := [];
END;

new_records := project(New_5000, renumber(left, counter));
output(choosen(new_records, eyeball), named('new_records'));
output(count(new_records), named('new_records_count'));




New_Test_Sample := Reflagged_Logs2 + new_records ; //adds back to old file;
output(New_Test_Sample, named('New_Test_Sample'));
output(count(New_Test_Sample), named('New_Test_Sample_count'));


Sorted_Sample := Sort(New_Test_Sample, perm_flag, date_added);
OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor,  overwrite);


final_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(final_salt); 
// EXPORT RV_Capone_New_Samples_Logs := 'todo';

#workunit('name','RV_capone_refresh');

import ut, Scoring_Project_Macros, Business_Risk, Scoring_Project_Refresh_Samples, Risk_Indicators, Models;

//needs to be manually ran;
//spray sample from batch, as CSV,
//then will create a refreshed sample of 25k.
//you should only have to change the file names found below.  

filein1 := '~bbraaten::in::rv_capone_20160418';
fileold3 := '~scoring_project::in::riskview_v3_batch_capitalone_attributes_20141112';

// fileout := '~scoring_project::in::riskview_v2_v3_batch_capitalone_attributes_' + ut.getdate;
fileout := '~bbraaten::in::test_RV_capone_full_test';

eyeball := 20;

inputStructure := RECORD
	String First;
	STRING middle;
	STRING last;
	STRING Address;
	STRING Address2;	
	STRING city;
	STRING state;
	STRING Zip5;
	STRING Zip4;
	STRING SSN;
	END;

Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

OriginalDataRvv3 := DATASET(fileold3, Output_structure, thor);
OUTPUT(CHOOSEN(OriginalDataRvv3, all), NAMED('OriginalDataRvv3'));
output(count(OriginalDataRvv3));



FindMaxAccount := choosen(sort(OriginalDataRvv3, -accountnumber), 5);
MaxAccount := max(FindMaxAccount, accountnumber);
output(MaxAccount, named('max_account_rvv3'));



inputData1 := DATASET(filein1, inputStructure, csv(Heading(1)));
OUTPUT(CHOOSEN(inputData1, eyeball), NAMED('Sample_Input'));
output(count(inputData1));



filteredSSN := inputData1(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip5));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));



goodinfo := filteredzip(last not in ['','MARSUPIAL'] and last[1..2] != 'AA' and first not in [''] and Address != '' and city != ''
											and state != '' and zip5 != '' and ssn != '' and ssn != '000000000' and ssn != '0000');
																						
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));

DedupedData := dedup(goodinfo, SSN, all); //sorted by ssn since all blank ssn's have been removed;
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));


keepers_1_0 := OriginalDataRvv3(perm_flag = 0);
output(count(keepers_1_0));
keepers_1_1 := OriginalDataRvv3(perm_flag = 1);
output(count(keepers_1_1));
keepers_1_2 := OriginalDataRvv3(perm_flag = 2);
output(count(keepers_1_2));
keepers_1_3 := OriginalDataRvv3(perm_flag = 3);
output(count(keepers_1_3));
keepers_1_4 := OriginalDataRvv3(perm_flag = 4);
output(count(keepers_1_4));


keepers := sort(keepers_1_0+keepers_1_2+keepers_1_3+keepers_1_4, date_added);
output(keepers);
output(count(keepers), named('keepers'));

Output_structure Rearrange(output_structure l, integer c) := TRANSFORM
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  //subtracting 1 from original permflag;
	self.zip := l.zip[1..5];
	// self.AccountNumber := c ;
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;

Output_structure format_them(inputStructure l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'Capital One';
	self.Source_Info := 'RiskView_Batch_Logs';
	self.Perm_Flag := 4;
	self.AccountNumber := c + MaxAccount;
		self.zip := l.zip5[1..5];
	self.firstname := l.first;
	self.middlename := l.middle;
	self.lastname:= l.last ;
	self.streetaddress :=  l.Address;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Reflagged_Logs := project(keepers, Rearrange(left, counter));
new_perm  := choosen(Reflagged_Logs, 15000);
output(choosen(new_perm, eyeball), named('new_perm'));
output(count(new_perm), named('new_perm_count'));

old0 := new_perm(perm_flag = 0);
output(count(old0), named('Reflagged_LogsNew0'));
old1 := new_perm(perm_flag = 1);
output(count(old1), named('Reflagged_LogsNew1'));
old2 := new_perm(perm_flag = 2);
output(count(old2), named('Reflagged_LogsNew2'));
old3 := new_perm(perm_flag = 3);
output(count(old3), named('Reflagged_LogsNew3'));
old4 := new_perm(perm_flag = 4);
output(count(old4), named('Reflagged_Logsnew4'));

Formatted_New := project(DedupedData, format_them(left, counter));
OUTPUT(CHOOSEN(Formatted_New, eyeball), NAMED('Formatted_New'));
output(count(Formatted_New));


New_right := join(Reflagged_Logs, Formatted_New,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sample := Reflagged_Logs + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new_and_old'));



sort_large_sample := Sort(new_large_sample, ssn, Date_added); //sort by date added for dedup

output(choosen(sort_large_sample, eyeball), named('sorted_new_and_old'));
output(count(sort_large_sample));



deduped_new := sort_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold := sort_large_sample(Date_added <> (Integer)ut.getdate);



ut.MAC_Pick_Random(deduped_new,New_5000,5000);   //grabs 5000 of new deduped rocrods;


New_Test_Sample := dedupold + New_5000 ;
output(choosen(New_Test_Sample, eyeball), named('New_Sample'));
output(count(New_Test_Sample), named('New_count'));

wNew0 := New_Test_Sample(perm_flag = 0);
output(count(wNew0), named('New_Test_SampleNew0'));
wNew1 := New_Test_Sample(perm_flag = 1);
output(count(wNew1), named('New_Test_SampleNew1'));
wNew2 := New_Test_Sample(perm_flag = 2);
output(count(wNew2), named('New_Test_SampleNew2'));
wNew3 := New_Test_Sample(perm_flag = 3);
output(count(wNew3), named('New_Test_SampleNew3'));
wNew4 := New_Test_Sample(perm_flag = 4);
output(count(wNew4), named('New_Test_SampleNew4'));

Sorted_Sample := Sort(New_Test_Sample, accountnumber);

output(choosen(Sorted_Sample, eyeball), named('Sorted_Sample'));



OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor, overwrite);

Sorted_Sample_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(Sorted_Sample_salt); 
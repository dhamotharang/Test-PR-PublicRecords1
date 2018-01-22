// EXPORT CBBL_New_Samples_Logs := 'todo';

import ut, Scoring_Project_Macros, Business_Risk, zz_bbraaten2, Risk_Indicators, Models;

//needs to be manually ran;
//spray sample from batch, as XML,
//then will create a refreshed sample of ~5k.
//keep an eye on the perm_flags in this sample.  Sample size is smaller because it is hard to find inputs.
//refresh 1 more time after 5/25 and add new records with perm_flag #4.
//after that begin to filer our old records by changing code below. 



filein1 := '~bbraaten::in::cbbl_all.xml';
fileold3 := '~scoring_project::in::cbbl_xml_chase_20141216';

// fileout := '~scoring_project::in::cbbl_xml_chase_' + ut.getdate;
fileout := '~bbraaten::in::test_Chase_CBBL_full_test';

eyeball := 20;

inputStructure := RECORD
	STRING _loginid {xpath('_loginid')};
	STRING _timelimit {xpath('_timelimit')};
	STRING account {xpath('account')};
	STRING addr {xpath('addr')};
	STRING appdate {xpath('appdate')};
	STRING apptime {xpath('apptime')};
	STRING city {xpath('city')};
	STRING cmpy {xpath('cmpy')};
	STRING cmpyaddr {xpath('cmpyaddr')};
	STRING cmpycity {xpath('cmpycity')};
	STRING cmpyphone {xpath('cmpyphone')};
	STRING cmpystate {xpath('cmpystate')};
	STRING cmpyzip {xpath('cmpyzip')};
	STRING datapermissionmask {xpath('datapermissionmask')};
	STRING datarestrictionmask {xpath('datarestrictionmask')};
	STRING dob {xpath('dob')};
	STRING drlc {xpath('drlc')};
	STRING fin {xpath('fin')};
	STRING first {xpath('first')};
	STRING hphone {xpath('hphone')};
	STRING income {xpath('income')};
	STRING last {xpath('last')};
	STRING outcometrackingoptout {xpath('outcometrackingoptout')};
	STRING runseed {xpath('runseed')};
	STRING socs {xpath('socs')};
	STRING state {xpath('state')};
	STRING tribcode {xpath('tribcode')};
	STRING zip {xpath('zip')};

/* ********** Engineering Note -- Check the Dataset types below, some might need adjusting ********** */
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways {xpath('gateways/row')};
END;


Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;


original := DATASET(fileold3, Output_structure, thor);
OUTPUT(CHOOSEN(original, all), NAMED('OriginalDataRvv4'));
output(count(original));


FindMaxAccount2 := choosen(sort(original, -accountnumber), 5);
MaxAccount2 := max(FindMaxAccount2, accountnumber);
output(MaxAccount2, named('max_account_rvv2'));


inputData1 := DATASET(filein1, inputStructure,XML('rows/riskwise.riskwisemainbc1o'));
OUTPUT(CHOOSEN(inputData1, eyeball), NAMED('Sample_Input'));
output(count(inputData1));


filteredSSN := inputData1(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', socs));
filteredzip := inputData1(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));



goodinfo := filteredzip(last not in ['','MARSUPIAL'] and last[1..2] != 'AA' and first not in [''] and addr != '' and city != ''
											and state != '' and zip != '' and zip != '00000' and socs != '' and socs != '000000000' and socs != '0000' and socs != '999999999');

keytabledate_added	:=	table(pull(original), {date_added, unsigned8 RecordCount := count(group)}, date_added, few);
keytablepermflag	:=	table(pull(original), {perm_flag, unsigned8 RecordCount := count(group)}, perm_flag, few);
																					
output(keytabledate_added);	
output(keytablepermflag);	
				
				
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));



DedupedData := dedup(goodinfo, socs, all); //sorted by ssn since all blank ssn's have been removed;
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));

//enable for reflagging

// keepers_1_0 := original(perm_flag = 0);
// output(count(keepers_1_0));
// keepers_1_1 := original(perm_flag = 1);
// output(count(keepers_1_1));
// keepers_1_2 := original(perm_flag = 2);
// output(count(keepers_1_2));
// keepers_1_3 := original(perm_flag = 3);
// output(count(keepers_1_3));
// keepers_1_4 := original(perm_flag = 4);
// output(count(keepers_1_4));


// keepers := sort(keepers_1_0+keepers_1_3+keepers_1_4, accountnumber);
// output(keepers);
// output(count(keepers), named('keepers'));

// accountflag := count(keepers);

Output_structure Rearrange(output_structure l, integer c) := TRANSFORM
	// self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  //subtracting 1 from original permflag;  //enable for reflagging

	self.date_added := l.date_added;
	// self.Perm_Flag := If((integer)l.date_added	 = 20140114, 0, if( (integer)l.date_added	 = 20141216, 1, if( (integer)l.date_added	 = 20140820, 2, 9)));  //subtracting 1 from original permflag;
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
	self.Customer := 'Chase';
	self.Source_Info := 'acclogs_scoring';
	self.Perm_Flag := 4;
	self.AccountNumber := c + MaxAccount2;
	self.dateofbirth := l.dob;
	self.homephone := l.hphone;
	self.name_company	:= l.cmpy;
	self.street_addr2 := l.cmpyaddr;
	self.p_city_name_2 := l.cmpycity;
  self.st_2	 := l.cmpystate;
	self.z5_2	:= l.cmpyzip;
	self.phoneno	:= l.cmpyphone;
	self.fein  := l.fin;	
	self.ssn := l.socs;
	self.zip := l.zip;
	self.firstname := l.first;
	self.lastname:= l.last ;
	self.streetaddress :=  l.addr;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Reflagged_Logs := project(original, Rearrange(left, counter));
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


New_right := join(Reflagged_Logs, Formatted_New,  left.ssn = right.ssn, right only); //dataset with ssn's that are not in the old dataset;
new_large_sample := Reflagged_Logs + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new_and_old'));


sort_large_sample := Sort(new_large_sample, accountnumber, Date_added); //sort by date added for dedup

output(choosen(sort_large_sample, eyeball), named('sorted_new_and_old'));
output(count(sort_large_sample));


deduped_new := sort_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold := sort_large_sample(Date_added <> (Integer)ut.getdate);


ut.MAC_Pick_Random(deduped_new,New_5000,5000);   //grabs 20000 of new deduped rocrods;


newflagsort := sort(New_5000, perm_flag);
output(count(newflagsort));
output(choosen(newflagsort, all), named('New_5000'));

New_Test_Sample := dedupold + newflagsort ;
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

keytabledate_added2	:=	table(pull(New_Test_Sample), {date_added, unsigned8 RecordCount := count(group)}, date_added, few);
keytablepermflag2	:=	table(pull(New_Test_Sample), {perm_flag, unsigned8 RecordCount := count(group)}, perm_flag, few);
																					
output(keytabledate_added2);	
output(keytablepermflag2);	


Sorted_Sample := Sort(New_Test_Sample, perm_flag);

output(choosen(Sorted_Sample, all), named('Sorted_Sample'));
// new_refreshed := choosen(Sorted_Sample, 25000);
// output(Sorted_Sample);



OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor, overwrite);

final_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(final_salt); 
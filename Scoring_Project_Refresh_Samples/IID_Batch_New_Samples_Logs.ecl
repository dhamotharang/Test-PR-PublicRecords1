// EXPORT IID_Batch_New_Samples_Logs := 'todo';

#workunit('name','IID_Batch_New_Input_Samples');

import IntlIID;
import ut, Scoring_Project_Macros, Business_Risk, zz_bbraaten2, Risk_Indicators, Models;


//needs to be manually ran;
//spray sample from batch, as XML,
//then will create a refreshed sample of 25k.
//you should only have to change the file names found below.  


fileLocation := '~bbraaten::in::iid_test_2';
filein2 := '~scoring_project::in::instantid_batch_generic_version0_20141013';

// fileout := '~scoring_project::in::instantid_batch_generic_version0_' + ut.getdate;
fileout :='~bbraaten::in::IID_Batch_test_full';

eyeball := 25;

Layout_Batch_In := record
	string	acctno ;
	string	Name_first ;
	string	Name_Middle ;
	string	Name_Last ;
	string  DOB ;
	string	street_addr ;
	string	p_city_name ;
	string	st ;
	string	z5 ;
	string  ssn ;
	string	home_phone;
end;

inputStructure := RECORD
	STRING _batchjobid {xpath('_batchjobid')};
	STRING _batchspecid {xpath('_batchspecid')};
	STRING _transactionid {xpath('_transactionid')};
	STRING companyid {xpath('companyid')};
	STRING datapermissionmask {xpath('datapermissionmask')};
	STRING datarestrictionmask {xpath('datarestrictionmask')};
	STRING dobmatchtype {xpath('dobmatchtype')};
	STRING dobmatchyearradius {xpath('dobmatchyearradius')};
	STRING dobradius {xpath('dobradius')};
	STRING dppapurpose {xpath('dppapurpose')};
	STRING exactaddrmatch {xpath('exactaddrmatch')};
	STRING exactdriverlicensematch {xpath('exactdriverlicensematch')};
	STRING exactfirstnamematch {xpath('exactfirstnamematch')};
	STRING exactfirstnamematchallownicknames {xpath('exactfirstnamematchallownicknames')};
	STRING exactlastnamematch {xpath('exactlastnamematch')};
	STRING exactphonematch {xpath('exactphonematch')};
	STRING exactssnmatch {xpath('exactssnmatch')};
	STRING excludewatchlists {xpath('excludewatchlists')};
	STRING glbpurpose {xpath('glbpurpose')};
	STRING globalwatchlistthreshold {xpath('globalwatchlistthreshold')};
	STRING historydateyyyymm {xpath('historydateyyyymm')};
	STRING iidversionoverride {xpath('iidversionoverride')};
	STRING include_all_watchlist {xpath('include_all_watchlist')};
	STRING include_bes_watchlist {xpath('include_bes_watchlist')};
	STRING include_bis_watchlist {xpath('include_bis_watchlist')};
	STRING include_cftc_watchlist {xpath('include_cftc_watchlist')};
	STRING include_dtc_watchlist {xpath('include_dtc_watchlist')};
	STRING include_eudt_watchlist {xpath('include_eudt_watchlist')};
	STRING include_far_watchlist {xpath('include_far_watchlist')};
	STRING include_fbi_watchlist {xpath('include_fbi_watchlist')};
	STRING include_fcen_watchlist {xpath('include_fcen_watchlist')};
	STRING include_imw_watchlist {xpath('include_imw_watchlist')};
	STRING include_occ_watchlist {xpath('include_occ_watchlist')};
	STRING include_ofac_watchlist {xpath('include_ofac_watchlist')};
	STRING include_osfi_watchlist {xpath('include_osfi_watchlist')};
	STRING include_pep_watchlist {xpath('include_pep_watchlist')};
	STRING include_sdt_watchlist {xpath('include_sdt_watchlist')};
	STRING include_unnt_watchlist {xpath('include_unnt_watchlist')};
	STRING include_wbif_watchlist {xpath('include_wbif_watchlist')};
	STRING includeadditionalwatchlists {xpath('includeadditionalwatchlists')};
	STRING includeallriskindicators {xpath('includeallriskindicators')};
	STRING includecloverride {xpath('includecloverride')};
	STRING includedlverification {xpath('includedlverification')};
	STRING includefraudscores {xpath('includefraudscores')};
	STRING includemsoverride {xpath('includemsoverride')};
	STRING includeofac {xpath('includeofac')};
	STRING includeriskindices {xpath('includeriskindices')};
	STRING includetarguse3220 {xpath('includetarguse3220')};
	STRING industryclass {xpath('industryclass')};
	STRING model {xpath('model')};
	STRING ofaconly {xpath('ofaconly')};
	STRING ofacversion {xpath('ofacversion')};
	STRING poboxcompliance {xpath('poboxcompliance')};
	STRING productcode {xpath('productcode')};
	STRING redflag_version {xpath('redflag_version')};
	STRING redflagsonly {xpath('redflagsonly')};
	STRING targus {xpath('targus')};
	STRING usedobfilter {xpath('usedobfilter')};

	DATASET(Layout_Batch_In) batch_in {xpath('batch_in/row')};
	// DATASET(Risk_Indicators.Layout_Gateways_In) gateways {xpath('gateways/row')};
END;

inputData := DATASET(fileLocation, inputStructure, XML('rows/risk_indicators.instantid_batch'));

OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Input'));

output_lay := RECORD
  unsigned8 date_added;
  string customer;
  string source_info;
  integer perm_flag;
  integer accountnumber;
  string firstname;
  string middlename;
  string lastname;
  string streetaddress;
  string city;
  string state;
  string zip;
  string homephone;
  string ssn;
  string dateofbirth;
  string workphone;
  string income;
  string dlnumber;
  string dlstate;
  string balance;
  string chargeoffd;
  string formername;
  string email;
  string company;
  integer8 historydateyyyymm;
  string placeholder_1;
  string placeholder_2;
  string placeholder_3;
  string placeholder_4;
  string placeholder_5;
  string dppa;
  string glb;
  string drm;
  integer8 history_date;
  string dpm;
  string other2;
  string other3;
  string other4;
 END;


output_lay batchlay(inputStructure l, integer c) := TRANSFORM
	self.accountnumber := c;
	self.perm_flag := 5;	
	self.firstname := l.batch_in[c].Name_first ;
	self.middlename := l.batch_in[c].Name_Middle ;
	self.lastname := l.batch_in[c].Name_Last;
	self.dateofbirth := l.batch_in[c].DOB;
	self.streetaddress := l.batch_in[c].street_addr;
	self.city := l.batch_in[c].p_city_name;
	self.state := l.batch_in[c].st;
	self.zip := l.batch_in[c].z5;
	self.ssn := l.batch_in[c].ssn ;
	self.homephone := l.batch_in[c].home_phone;
	SELF := [];
END;

Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

OriginalData := DATASET(filein2, Output_structure, thor);
OUTPUT(CHOOSEN(OriginalData, all), NAMED('OriginalData'));
output(count(OriginalData));

FindMaxAccount := choosen(sort(OriginalData, -accountnumber), 5);
MaxAccount := max(FindMaxAccount, accountnumber);
output(MaxAccount);

IID := normalize(inputData, count(left.batch_in), batchlay(left, counter));
OUTPUT(CHOOSEN(IID, eyeball), NAMED('IID_input'));
output(count(IID));


filteredSSN := IID(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));


goodinfo := filteredzip(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and streetaddress != '' and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dateofbirth != ''  );
											
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));

DedupedData := dedup(goodinfo, SSN, all); //sorted by ssn since all blank ssn's have been removed;
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));

keepers0 := OriginalData(perm_flag = 0);
output(count(keepers0));
keepers1 := OriginalData(perm_flag = 1);
output(count(keepers1));
keepers2 := OriginalData(perm_flag = 2);
output(count(keepers2));
keepers3 := OriginalData(perm_flag = 3);
output(count(keepers3));
keepers4 := OriginalData(perm_flag = 4);
output(count(keepers4));
keepers := sort(keepers0+keepers2+keepers3+keepers4, accountnumber);
output(keepers);
output(count(keepers), named('keepers'));


Output_structure Rearrange(output_structure l, integer c) := TRANSFORM
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	
	self.zip := l.zip[1..5];
	self.homephone := if(l.homephone[1] = '0', '', l.homephone);
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self := l;
  self := [];
END;

Output_structure format_them(output_lay l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'Generic';
	self.Source_Info := '	Batch_Roxie_Logs';
	self.Perm_Flag := 4;
	self.AccountNumber := c + MaxAccount;
	
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Reflagged_Logs := project(keepers, Rearrange(left, counter));
output(choosen(Reflagged_Logs, eyeball), named('Reflagged_Logs'));
output(count(Reflagged_Logs), named('Reflagged_Count'));

old0 := Reflagged_Logs(perm_flag = 0);
output(count(old0), named('Reflagged_LogsNew0'));
old1 := Reflagged_Logs(perm_flag = 1);
output(count(old1), named('Reflagged_LogsNew1'));
old2 := Reflagged_Logs(perm_flag = 2);
output(count(old2), named('Reflagged_LogsNew2'));
old3 := Reflagged_Logs(perm_flag = 3);
output(count(old3), named('Reflagged_LogsNew3'));
old4 := Reflagged_Logs(perm_flag = 4);
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

Sorted_Sample := Sort(New_Test_Sample, perm_flag, date_added);

output(choosen(Sorted_Sample, eyeball), named('Sorted_Sample'));
new_refreshed := choosen(Sorted_Sample, 25000);


OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor, overwrite);
Sorted_Sample_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(Sorted_Sample_salt); 
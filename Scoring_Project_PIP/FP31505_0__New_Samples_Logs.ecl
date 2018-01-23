// EXPORT FP31505_0__New_Samples_Logs := 'todo';
#workunit('name','FP31505_0 Sample');
import  ut, Scoring_Project_Macros;


filein := '~bbraaten::in::fp31505_0';
originalfile := '~scoring_project::in::fraudpoint_xml_fp31505_0_20160419';
// filein2 := '~Scoring_Project::in::FraudPoint_XML_Generic_FP31505_0_20140408';

fileout := '~bbraaten::test::FP3';
eyeball := 50;

Layout_Attributes_In := record
	string name {xpath('name')};
end;

inputStructure := RECORD
	STRING _blind {xpath('_blind')};
	STRING _clientip {xpath('_clientip')};
	STRING _companyid {xpath('_companyid')};
	STRING _loginid {xpath('_loginid')};
	STRING _queryid {xpath('_queryid')};
	STRING _referencecode {xpath('_referencecode')};
	STRING _timelimit {xpath('_timelimit')};
	STRING _transactionid {xpath('_transactionid')};
	STRING accountnumber {xpath('accountnumber')};
	STRING additionalwatchlists {xpath('additionalwatchlists')};
	STRING addr {xpath('addr')};
	STRING age {xpath('age')};
	STRING channel {xpath('channel')};
	STRING city {xpath('city')};
	STRING customfraudmodel {xpath('customfraudmodel')};
	STRING datapermissionmask {xpath('datapermissionmask')};
	STRING datarestrictionmask {xpath('datarestrictionmask')};
	STRING dateofapplication {xpath('dateofapplication')};
	STRING dateofbirth {xpath('dateofbirth')};
	STRING disallowtarguseid3220 {xpath('disallowtarguseid3220')};
	STRING dlmask_overload {xpath('dlmask_overload')};
	STRING dlmask {xpath('dlmask')};
	STRING dlnumber {xpath('dlnumber')};
	STRING dlstate {xpath('dlstate')};
	STRING dobmask_overload {xpath('dobmask_overload')};
	STRING dobmask {xpath('dobmask')};
	STRING dobradius {xpath('dobradius')};
	STRING dppapurpose {xpath('dppapurpose')};
	STRING email {xpath('email')};
	STRING encode_ {xpath('encode_')};
	STRING excludedmvpii {xpath('excludedmvpii')};
	STRING excludewatchlists {xpath('excludewatchlists')};
	STRING firstname {xpath('firstname')};
	STRING glbpurpose {xpath('glbpurpose')};
	STRING globalwatchlistthreshold {xpath('globalwatchlistthreshold')};
	STRING historydatetimestamp {xpath('historydatetimestamp')};
	STRING historydateyyyymm {xpath('historydateyyyymm')};
	STRING homephone {xpath('homephone')};
	STRING includeadditionalwatchlists {xpath('includeadditionalwatchlists')};
	STRING includeofac {xpath('includeofac')};
	STRING includeriskindices {xpath('includeriskindices')};
	STRING income {xpath('income')};
	STRING industryclass {xpath('industryclass')};
	STRING ipaddress {xpath('ipaddress')};
	STRING isstudent {xpath('isstudent')};
	STRING lastname {xpath('lastname')};
	STRING lnbranded {xpath('lnbranded')};
	STRING locationidentifier {xpath('locationidentifier')};
	STRING middlename {xpath('middlename')};
	STRING model {xpath('model')};
	STRING modelrequests {xpath('modelrequests')};
	STRING namesuffix {xpath('namesuffix')};
	STRING ofaconly {xpath('ofaconly')};
	STRING ofacversion {xpath('ofacversion')};
	STRING otherapplicationidentifier {xpath('otherapplicationidentifier')};
	STRING otherapplicationidentifier2 {xpath('otherapplicationidentifier2')};
	STRING otherapplicationidentifier3 {xpath('otherapplicationidentifier3')};
	STRING ownorrent {xpath('ownorrent')};
	STRING redflag_version {xpath('redflag_version')};
	STRING ssn {xpath('ssn')};
	STRING ssnmask_overload {xpath('ssnmask_overload')};
	STRING ssnmask {xpath('ssnmask')};
	STRING state {xpath('state')};
	STRING streetaddress {xpath('streetaddress')};
	STRING testdataenabled {xpath('testdataenabled')};
	STRING testdatatablename {xpath('testdatatablename')};
	STRING timeofapplication {xpath('timeofapplication')};
	STRING usedobfilter {xpath('usedobfilter')};
	STRING workphone {xpath('workphone')};
	STRING zip {xpath('zip')};

/* ********** Engineering Note -- Check the Dataset types below, some might need adjusting ********** */

	DATASET(Layout_Attributes_In) requestedattributegroups {xpath('requestedattributegroups/row')};
END;

 Output_structure := RECORD
	Scoring_Project_Macros.regression.global_layout;
	Scoring_Project_Macros.regression.pii_layout;
	Scoring_Project_Macros.regression.runtime_layout;
 END;



inputData := DATASET(filein, inputStructure, XML('rows/models.fraudadvisor_service'));
OUTPUT(CHOOSEN(inputData, 200), NAMED('Sample_Input'));
output(count(inputData));

OriginalData := DATASET(originalfile, Output_structure, thor);
OUTPUT(CHOOSEN(OriginalData, 200), NAMED('Sample_Input2'));
output(count(OriginalData));



Test := (inputData(testdataenabled = 'true'));
NotTest := (inputData(testdataenabled <> 'true'));  //test seed enabled data

FindMaxAccount := choosen(sort(OriginalData, -accountnumber), 5);
MaxAccount := max(FindMaxAccount, accountnumber);
output(MaxAccount, named('maxaccount'));


filteredSSN := NotTest(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', ssn));
filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));

//Need First, Last, Address, Phone, SSN, and DOB;


goodinfo := filteredzip(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and StreetAddress != '' and city != ''
											and state != '' and zip != '' and ssn != '' and ssn != '000000000' and ssn != '00000' and dateofbirth != '' and (homephone != '' or workphone != '') );
											
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));



DedupedData := dedup(goodinfo, ssn, all);
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));

// Output_structure Rearrange2(Output_structure l, integer c) := Transform
		// self.Perm_Flag := if(c <= 2000, 0, if(c > 2000 and c < 4001, 1, if(c >= 4001 and c < 6001, 2, if(c >= 6001 and c < 8001, 3, 7))));

	// self:=l;
	// self:=[];
// end;


// Reflagged_Logs := project(OriginalData, Rearrange2(left, counter));

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



keepers := sort(keepers0+keepers2+keepers3, accountnumber);
output(keepers);
output(count(keepers), named('keepers'));

Output_structure Rearrange(Output_structure l, integer c) := Transform
	self.Perm_Flag := If(l.perm_flag <= 0, 0, l.perm_flag - 1);  	

	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;

Output_structure format_them(inputStructure l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'FraudPoint_3_XML_Logs_1051212';
	self.Perm_Flag := 4; 	
	self.AccountNumber := c + (integer)MaxAccount;
		self.drm := l.datarestrictionmask;
	self.glb := l.glbpurpose;
	self.dppa := l.dppapurpose;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;





		Reflagged_Logs2 := project(keepers, Rearrange(left, counter));

output(choosen(Reflagged_Logs2, eyeball), named('Reflagged_Logs2'));
output(count(Reflagged_Logs2), named('Reflagged_Count2'));

old0 := Reflagged_Logs2(perm_flag = 0);
output(count(old0), named('Reflagged_LogsNew0'));
old1 := Reflagged_Logs2(perm_flag = 1);
output(count(old1), named('Reflagged_LogsNew1'));
old2 := Reflagged_Logs2(perm_flag = 2);
output(count(old2), named('Reflagged_LogsNew2'));
old3 := Reflagged_Logs2(perm_flag = 3);
output(count(old3), named('Reflagged_LogsNew3'));
old4 := Reflagged_Logs2(perm_flag = 4);
output(count(old4), named('Reflagged_Logsnew4'));


Formatted_New := project(DedupedData, format_them(left, counter));
OUTPUT(CHOOSEN(Formatted_New, eyeball), NAMED('Formatted_New'));
output(count(Formatted_New));


New_right := join(Reflagged_Logs2, Formatted_New,  left.ssn = right.ssn, right only);  //dataset with ssn's that are not in the old dataset;
new_large_sample := Reflagged_Logs + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new_and_old'));


sort_large_sample := Sort(new_large_sample, ssn, Date_added); //sort by date added for dedup

output(choosen(sort_large_sample, eyeball), named('sorted_new_and_old'));
output(count(sort_large_sample));


deduped_new := sort_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold := sort_large_sample(Date_added <> (Integer)ut.getdate);



ut.MAC_Pick_Random(deduped_new,New_5000,2000);   //grabs 5000 of new deduped rocrods;


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

output(choosen(Sorted_Sample, 10000), named('Sorted_Sample'));


OUTPUT(choosen(Sorted_Sample, 10000),,fileout, thor, overwrite);


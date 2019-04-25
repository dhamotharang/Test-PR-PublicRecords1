// EXPORT ITA_v3_Capone_New_Samples_Logs := 'todo';

//needs to be manually ran;
//spray sample from batch, as CVS,
//BWR will run sample through BS to get and append ssns, then will create a refreshed sample of 25k.
//you should only have to change the file names found below.  

#workunit('name','Capone_ITAv3_refresh');


IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;
import ut, Scoring_Project_Macros, Business_Risk,  Risk_Indicators, Models, zz_Koubsky_SALT, SALT23;

infile := '~bbraaten::in::ita_clean';
fileold3 := '~scoring_project::in::ita_v3_batch_capitalone_attributes_20161208';

// fileout := '~scoring_project::in::ita_v3_batch_capitalone_attributes_' + ut.getdate;
fileout := '~bbraaten::in::test_ITA_v3_capone_full_test';

eyeball := 25;

lay := RECORD
	String Name;
	STRING Address;
	STRING city;
	STRING state;
	STRING Zip5;
	STRING Zip4;
	END;
	
// new_sort := DATASET(infile, lay, csv(Heading(1)));
new_sort := DATASET(infile, lay, csv);
OUTPUT(CHOOSEN(new_sort, eyeball), NAMED('new_sort'));
output(count(new_sort));

tlay := record
	integer3 Accountnumber := 1;
		String Name;
	STRING Address;
	STRING city;
	STRING state;
	STRING Zip5;
	STRING Zip4;
	string ssn;
end;


no_of_records := 10;
// integer retry := retry;
// integer timeout := timeout;
integer threads := 1;
integer version := 41;

 neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;
 roxieIP := RiskWise.shortcuts.staging_fcra_roxieIP;

today := ut.GetDate;
archive_date := 999999;

boolean RemoveFares := false;	// change this to TRUE for FARES filtering
boolean LeadIntegrityMode := false;  // change this to TRUE for LeadIntegrity modeling
string DataRestrictionMask := '0000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 
																								// byte 10 restricts Transunion, 12 restricts ADVO, 13 restricts bureau deceased data
unsigned1 glba := 1;
unsigned1 dppa := 3;

//==================  input file layout  ========================
	layout_input := RECORD
   Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
END;
	

//====================================================
//=============  Service settings ====================
//====================================================
bs_service := 'risk_indicators.Boca_Shell';


layout_input  in_lay(lay le, integer c) := TRANSFORM		
self.Accountnumber :=  c;
  self.firstname := StringLib.StringGetNthWord(le.Name, 1);
  self.middlename := if(StringLib.StringGetNthWord(le.Name, 3) = '', '', StringLib.StringGetNthWord(le.Name, 2));
  self.lastname := if(StringLib.StringGetNthWord(le.Name, 3) = '', StringLib.StringGetNthWord(le.Name, 2), StringLib.StringGetNthWord(le.Name, 3));
self.streetaddress := le.address;
self.city := le.city;
self.state := le.state;
self.zip := le.zip5 + le.zip4;
self.ssn := '';
self.historydateyyyymm := archive_date;

self := le;
self := [];

end;

ds_in := project(new_sort, in_lay(left, counter));
output(count(ds_in));
OUTPUT(CHOOSEN(ds_in, eyeball), NAMED('ds_in'));
								 
l := RECORD
   STRING old_account_number;
  Risk_Indicators.Layout_InstID_SoapCall;
	// boolean adl_based_shell;
END;
	
	
l assignAccount (ds_in le, INTEGER c) := TRANSFORM
  SELF.old_account_number := (STRING)le.AccountNumber;
  SELF.AccountNumber := (STRING)c;
  	
  SELF.GLBPurpose  := glba;
  SELF.DPPAPurpose := dppa;

  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (unsigned)le.historydateyyyymm[..6],
			                                                (unsigned)le.historydateyyyymm
	);
	
  self.historyDateTimeStamp := map(
      (string)le.historydateyyyymm in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', (string)le.historydateyyyymm) => (string)le.historydateyyyymm,
			regexfind('^\\d{8}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm +   ' 00000100',
			regexfind('^\\d{6}$',        (string)le.historydateyyyymm) => (string)le.historydateyyyymm + '01 00000100',		                                                
			                                                (string)le.historydateyyyymm
	);
	
 
  SELF.IncludeScore := true;
  SELF.datarestrictionmask := datarestrictionmask;
  SELF.RemoveFares := RemoveFares;
	self.bsversion := version;
	self.adl_based_shell := true;
  SELF := le;
  SELF := [];
END;
p_f := Distribute(PROJECT(ds_in, assignAccount (LEFT,COUNTER)), random());

OUTPUT(CHOOSEN(p_f, eyeball), NAMED('p_f'));


xlayout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;

xlayout myFail(p_f le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.seq := (unsigned)le.AccountNumber;
	SELF.shell_input.fname := le.FirstName;
	SELF.shell_input.mname := le.MiddleName;
	SELF.shell_input.lname := le.LastName;
	SELF.shell_input.suffix := le.NameSuffix;
	SELF.shell_input.in_streetaddress := le.StreetAddress;
	SELF.shell_input.in_city := le.City;
	SELF.shell_input.in_state := le.State;
	SELF.shell_input.in_zipcode := le.Zip;
	SELF.shell_input.in_country := le.Country;
	SELF.shell_input.ssn := le.SSN;
	SELF.shell_input.dob := le.DateOfBirth;
	SELF.shell_input.age := le.Age;
	SELF.shell_input.dl_number := le.DLNumber;
	SELF.shell_input.dl_state := le.DLState;
	SELF.shell_input.email_address := le.Email;
	SELF.shell_input.ip_address := le.IPAddress;
	SELF.shell_input.phone10 := le.HomePhone;
	SELF.shell_input.wphone10 := le.WorkPhone;
	SELF.shell_input.employer_name := le.EmployerName;
	SELF.shell_input.lname_prev := le.FormerName;
	SELF := [];
END;

s := SOAPCALL (p_f, 
										RiskWise.shortcuts.prod_batch_neutral, 
                    'risk_indicators.boca_shell', 
										{p_f}, 
                    DATASET (xlayout),
                    PARALLEL (2), 
										onFail(myFail (Left)));


riskprocessing.layouts.layout_internal_shell getold(s le, l ri) :=	TRANSFORM
  SELF.AccountNumber := ri.old_account_number;
  SELF := le;
END;

res := JOIN (s,p_f,LEFT.seq=(unsigned)RIGHT.accountnumber,getold(LEFT,RIGHT));
OUTPUT(CHOOSEN(res, eyeball), NAMED('res'));

 Layout2 := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;

layout_input batchlay2(res l) := TRANSFORM
	self.accountnumber := (integer)l.accountnumber;
	self.perm_flag := 5;	
	self.firstname := l.shell_input.fname ;
	self.middlename := l.shell_input.mname ;
	self.lastname := l.shell_input.lname;
	self.dateofbirth := l.shell_input.DOB;
	self.streetaddress := l.shell_input.in_streetaddress;
	self.city := l.shell_input.in_city;
	self.state := l.shell_input.in_state;
	self.zip := l.shell_input.in_zipcode;
	self.ssn	 := l.shell_input.ssn ;
	self.homephone := l.shell_input.phone10;
	SELF := [];
END;

bocatransform := project(res, batchlay2(left));
output(count(bocatransform));
OUTPUT(CHOOSEN(bocatransform, eyeball), NAMED('bocatransform'));



j1 := join(ds_in, bocatransform, (integer)left.accountnumber = (integer)right.accountnumber,
									transform(layout_input , 
							
										self.perm_flag := 5;	
										self.placeholder_1 := right.ssn, self := LEFT, self:= []));
									
									
ssn := j1(placeholder_1 <> '');


Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;

original := DATASET(fileold3, Output_structure, thor);
OUTPUT(CHOOSEN(original, all), NAMED('OriginalDataRvv4'));
output(count(original));


FindMaxAccount2 := choosen(sort(original, -accountnumber), 5);
MaxAccount2 := max(FindMaxAccount2, accountnumber);
output(MaxAccount2, named('max_account_rvv2'));


inputData1 := ssn;


filteredSSN := inputData1(REGEXFIND('(^[0-9]{4}$)|(^[0-9]{3}-?[0-9]{2}-?[0-9]{4}$)|(^[0-9]{9}$)', placeholder_1));
filteredzip := filteredSSN(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));
OUTPUT(CHOOSEN(filteredzip, 200), NAMED('filteredzip'));



goodinfo := filteredzip(lastname not in ['','MARSUPIAL'] and lastname[1..2] != 'AA' and firstname not in [''] and streetaddress != '' and city != ''
											and state != '' and zip != '' and placeholder_1 <>'');																		
											
OUTPUT(CHOOSEN(goodinfo, eyeball), NAMED('goodinfo'));
output(count(goodinfo));

DedupedData := dedup(goodinfo, placeholder_1, all); //sorted by ssn since all blank ssn's have been removed;
OUTPUT(CHOOSEN(DedupedData, eyeball), NAMED('DedupedData'));
output(count(DedupedData));


keepers_1_0 := original(perm_flag = 0);
output(count(keepers_1_0));
keepers_1_1 := original(perm_flag = 1);
output(count(keepers_1_1));
keepers_1_2 := original(perm_flag = 2);
output(count(keepers_1_2));
keepers_1_3 := original(perm_flag = 3);
output(count(keepers_1_3));
keepers_1_4 := original(perm_flag = 4);
output(count(keepers_1_4));

keepers := sort(keepers_1_0+keepers_1_2+keepers_1_3+keepers_1_4, accountnumber);
output(keepers);
output(count(keepers), named('keepers'));

accountflag := count(keepers);

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

Output_structure format_them(output_structure l, integer c) := Transform
	self.Date_added := (Integer)ut.getdate;
	self.Customer := 'Capital One';
	self.Source_Info := 'ITA_Batch_Logs';
	self.Perm_Flag := 4;
	self.AccountNumber := c + MaxAccount2;
	self.history_date := 999999;
	self.historydateyyyymm := 999999;
	self:=l;
	self:=[];
End;


Reflagged_Logs := project(keepers, Rearrange(left, counter));
new_perm  := choosen(Reflagged_Logs, 10000);
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


New_right := join(Reflagged_Logs, Formatted_New,  left.placeholder_1 = right.placeholder_1,	right only); 
																						
new_large_sample := Reflagged_Logs + New_right; //add "new_right" to old dataset;
output(choosen(new_large_sample, eyeball), named('new_and_old'));
output(count(new_large_sample));

sort_large_sample := Sort(new_large_sample, accountnumber, Date_added); //sort by date added for dedup

output(choosen(sort_large_sample, eyeball), named('sorted_new_and_old'));
output(count(sort_large_sample));


deduped_new := sort_large_sample(Date_added = (Integer)ut.getdate);  //seperates new and old records by date;
dedupold := sort_large_sample(Date_added <> (Integer)ut.getdate);


ut.MAC_Pick_Random(deduped_new,New_5000,5001);   //grabs 5000 of new deduped rocrods;

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

Sorted_Sample := Sort(New_Test_Sample, perm_flag);

output(choosen(Sorted_Sample, all), named('Sorted_Sample'));


OUTPUT(choosen(Sorted_Sample, 25000),,fileout, thor, overwrite);

Sorted_Sample_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(Sorted_Sample_salt); 
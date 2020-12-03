
 
IMPORT  Std, NAC_V2; 


EXPORT Process_Internal_Report(STRING100 ncf2_file_name)  := FUNCTION
//  param example 'ncf2_file_name 'ncf2_la01_20201007_195638.dat';


#WORKUNIT('name', 'NAC2 NCF2 Internal Validation Report');

ilfn := '~nac::uber::in::'+ ncf2_file_name;

GroupID :=  STD.Str.ToUpperCase(ncf2_file_name[6..9]);
//  "Onboarding : process NCF2 in prod as if they will go, but stage them at the gate until confirmed they're good."
//  'y' means the file will get processed to a certain point but not get fully ingested, only staged

BOOLEAN IsOnboarding(string gid) := NAC_V2.dNAC2Config(GroupID= STD.Str.ToLowerCase(gid))[1].Onboarding in ['y','Y'];
IsOnboardingMessage := IF(IsOnboarding(GroupID) = FALSE, 
		STD.Str.toUpperCase(GroupID) + ' is in Production, file will be FULLY ingested. ', 
		STD.Str.toUpperCase(GroupID) + ' is onboarding, file is STAGED for file validation only. ');

showIsOnboarding := OUTPUT(IsOnboarding(GroupID), NAMED('IsOnboarding'));
showIsOnboardingMessage := OUTPUT(IsOnboardingMessage, NAMED('Onboarding_Message'));

show_file_name := OUTPUT(ncf2_file_name, NAMED('NCF2_File_Name'));

nac2 := nac_v2.PreprocessNCF2(ilfn);


ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'ncf2', rpt);
ncr2_filename := ModifyFileName(ilfn, 'ncr2');

LF := '\n';
dRow := RECORD
		string130		text;
		string1			eol := LF;
	END;

NCR2 := DATASET(ncr2_filename, dRow, THOR);
show_NCR2 := OUTPUT(CHOOSEN(NCR2, 2000), NAMED('NCR2'));


dsNcd2 := Nac_V2.GetReports(nac2, ilfn).dsNcd2;
show_NCD2 := OUTPUT(CHOOSEN(dsNcd2,2000), NAMED('NCD2')); 

dsNcx2 := Nac_V2.GetReports(nac2, ilfn).dsNcx2;
show_NCX2 := OUTPUT(CHOOSEN(dsNcx2,2000), NAMED('NCX2')); 
 
show_record_codes_count := OUTPUT(SORT(Nac_V2.ExtractRecords(ilfn).Types, RecordCode), NAMED('RecordCodes_In_File'));

clients := Nac_V2.ExtractRecords(ilfn).clients;
show_clients_sample := OUTPUT(CHOOSEN(clients, 100), NAMED('clients_sample'));  

clients_with_bad_end_dates_count := OUTPUT(COUNT(clients(enddate<startdate)), NAMED('clients_with_bad_end_dates_count'));
clients_with_bad_end_dates := OUTPUT(CHOOSEN(clients(enddate<startdate),100),  NAMED('clients_with_bad_end_dates_sample'));


clients_without_cases_count := OUTPUT(COUNT(clients(caseid='')), NAMED('clients_without_cases_count'));
clients_without_cases_sample := OUTPUT(CHOOSEN(clients(caseid=''), 100), NAMED('clients_without_cases_sample'));

cases := Nac_V2.ExtractRecords(ilfn).cases;
show_cases_sample := OUTPUT(CHOOSEN(cases,100), NAMED('cases_sample'));

addresses :=  Nac_V2.ExtractRecords(ilfn).addresses;
show_addresses_sample := OUTPUT(CHOOSEN(addresses,100), NAMED('addresses_sample'));

show_addresses_without_cases_count := OUTPUT(COUNT(addresses(caseid='')), NAMED('addresses_without_cases_count'));
show_addresses_without_cases := OUTPUT(CHOOSEN(addresses(caseid=''),100), NAMED('addresses_without_cases_sample'));

tbl_clients := TABLE(clients, {clientid, caseid, startdate, enddate,  cnt:= COUNT(GROUP)}, clientid, caseid, startdate, enddate);
show_dupicate_client_caseid := OUTPUT( CHOOSEN(SORT(tbl_clients (cnt > 1), -cnt), 2000) , NAMED('dupicate_client_caseid_count'));

dup_ids := PROJECT(tbl_clients(cnt > 1), {LEFT.clientid, LEFT.caseid});
allinfo := JOIN(clients, dup_ids, LEFT.clientid = RIGHT.clientid AND LEFT.caseid = RIGHT.caseid, INNER);
show_duplicates_info := OUTPUT(CHOOSEN(allinfo,2000), NAMED('dupicate_clients'));


report := SEQUENTIAL(
  show_file_name, 
  showIsOnboardingMessage,
  show_record_codes_count,
  show_NCR2,
  show_NCD2,
  show_NCX2,
  show_cases_sample,
  show_clients_sample, 
  clients_with_bad_end_dates_count,
  clients_with_bad_end_dates,
  clients_without_cases_count,
  clients_without_cases_sample,
  show_addresses_sample,
  show_addresses_without_cases_count, 
  show_addresses_without_cases,
  show_dupicate_client_caseid,
  show_duplicates_info
  );

  RETURN report;
END;

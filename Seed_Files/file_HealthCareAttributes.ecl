IMPORT Data_Services,Seed_Files;

r := RECORD
  string20 dataset_name;
  string30 acctno;
  string20 fname;
  string20 lname;
  string5 zipcode;
  string9 ssn;
  string10 phone10;
  string20 accountnumber;
  string3 EstimatedHHSize;
  string2 HHOccupantDescription;
  string3 CensusAveHHSize;
  string10 EstimatedHHIncome;
 END;

//Please rename the input file appropriately
EXPORT file_HealthCareAttributes := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_healthcareattributes', r, CSV(HEADING(single), QUOTE('"')));

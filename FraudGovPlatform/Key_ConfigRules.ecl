Import data_services,doxie;
r:=RECORD
  unsigned8 customerid;
  unsigned8 industrytype;
  string200 field;
  integer1 entitytype;
  string rulename;
  string description;
  string value;
  decimal64_32 low;
  decimal64_32 high;
  integer8 risklevel;
 END;

d	:=dataset([],r);

EXPORT Key_ConfigRules	:= Index(d,{customerid,industrytype,field,entitytype},{d},
																									 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																									 + doxie.Version_SuperKey +'::kel::configrules');

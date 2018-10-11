Import data_services,doxie;

r	:=RECORD
  string200 field;
  integer8 entitytype;
  string value;
  decimal64_32 low;
  decimal64_32 high;
  integer8 risklevel;
  integer8 weight;
  string uidescription;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_WeightingChart	:= Index(d,{field,entitytype},{d},
																	 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																	 + doxie.Version_SuperKey +'::kel::weightingchart');

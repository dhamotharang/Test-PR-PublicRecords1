Import data_services,doxie;

r	:=RECORD
  integer8 customer_id_;
  integer8 industry_type_;
  string100 entity_context_uid_;
  string indicatortype;
  string indicatordescription;
  integer8 risklevel;
  string populationtype;
  integer8 value;
 END;

d	:=dataset([],r);

EXPORT Key_ScoreBreakdown	:= Index(d,{customer_id_,industry_type_,entity_context_uid_},{d},
																									 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																									 + doxie.Version_SuperKey +'::kel::scorebreakdown');																									


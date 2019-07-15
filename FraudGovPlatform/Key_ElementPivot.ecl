Import data_services,doxie;

r	:=RECORD
  integer8 customer_id_;
  integer8 industry_type_;
  string100 entity_context_uid_;
  unsigned8 entityhash;
  string field;
  string200 value;
  string indicatortype;
  string indicatordescription;
  string label;
  string fieldtype;
  unsigned8 risklevel;
  integer8 recs;
 END;

d	:=dataset([],r);

EXPORT Key_ElementPivot	:= Index(d,{customer_id_,industry_type_,entity_context_uid_},{d},
																									 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																									 + doxie.Version_SuperKey +'::kel::elementpivot');
																									


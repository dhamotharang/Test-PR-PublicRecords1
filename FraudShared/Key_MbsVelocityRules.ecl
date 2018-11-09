Import data_services,doxie;
r:=RECORD
  unsigned6 gc_id;
  string60 fragment;
  string60 contributiontype;
  unsigned2 fragment_weight;
  unsigned2 category_weight;
  unsigned6 rulenum;
  unsigned2 mincnt;
  unsigned2 maxtime;
  string20 timeunit;
  string description;
  unsigned8 __internal_fpos__;
 END;

d	:=dataset([],r);

EXPORT Key_MbsVelocityRules(string Platform) := Index(d,{gc_id},{d},
																									 data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									 +Platform	+ '::'+ doxie.Version_SuperKey +'::mbsvelocityrules');
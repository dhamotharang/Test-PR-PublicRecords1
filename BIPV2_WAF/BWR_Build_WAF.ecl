pversion := '';   //yyyymmdd

#workunit ('name', 'Build BIPV2 WAF Key '+pversion);
#OPTION('multiplePersistInstances',FALSE);

BIPV2_WAF.Build_Keys(pversion).All;
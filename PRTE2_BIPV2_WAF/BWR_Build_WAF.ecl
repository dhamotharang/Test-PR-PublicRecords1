pversion := '20170905';   //yyyymmdd

#workunit ('name', 'Build PRTE2_BIPV2_WAF Key '+pversion);
#OPTION('multiplePersistInstances',FALSE);

PRTE2_BIPV2_WAF.Build_Keys(pversion).All;
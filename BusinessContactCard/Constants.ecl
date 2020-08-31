IMPORT iesp;
EXPORT Constants := MODULE
  EXPORT MAX_GROUPID_PER_BDID := 1; //W20140424-163217-1
  EXPORT MAX_CORP2_PER_REC_BDID := 10000; //Max is 593636, second max is 7440 - W20140424-163502
  EXPORT MAX_CORP2_PER_REC_BIP := 25000; //BIP default in JOIN macro
  EXPORT MAX_CONTACTS_PER_REC := 25000; //BIP default in JOIN macro is 25000 and BDID contact key max is 156694 (first 45 top records over 25000) and max LIMIT on JOIN in contact attr is 10000 - W20140424-163621
  EXPORT MAX_PHONESPLUS_PER_REC := iesp.constants.BR.MaxPhonesPlus;//10
  EXPORT MAX_RECS_PER_ACCTNO := 1000; //?
END;

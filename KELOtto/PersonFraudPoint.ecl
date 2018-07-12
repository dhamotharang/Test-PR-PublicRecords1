
PersonFraudPointRec := RECORD
  unsigned6 did;
  string2 v2_sourcerisklevel;
  string3 v2_assocsuspicousidentitiescount;
  string3 v2_assoccreditbureauonlycount;
  string2 v2_validationaddrproblems;
  string2 v2_validationipproblems;
  string2 v2_ipstate;
  string2 v2_ipcountry;
  string2 v2_ipcontinent;
  string3 v2_inputaddrageoldest;
  string2 v2_inputaddrdwelltype;
  string3 v2_divssnidentitycountnew;
  string errorcode;
 END;

EXPORT PersonFraudPointPrep := PULL(DATASET('~foreign::10.173.14.201::thor_data400::base::fraudgov::qa::fraudpoint', PersonFraudPointRec, THOR));

EXPORT PersonFraudPoint := JOIN(KELOtto.CustomerLexId, PersonFraudPointPrep, LEFT.did=(INTEGER)RIGHT.did, TRANSFORM({LEFT.AssociatedCustomerFileInfo, RECORDOF(RIGHT)}, SELF := RIGHT, SELF := LEFT), HASH, KEEP(1));

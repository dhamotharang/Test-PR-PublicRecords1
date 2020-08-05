IMPORT mdr;

EXPORT Constants := MODULE
  // range of scores... 0 (worst) .. DEFAULT_RANGE (best)
  EXPORT UNSIGNED2 DEFAULT_RANGE := 100;

  EXPORT UNSIGNED2 SCORE_THRESHOLD := 30; // score threshold passed into header search modules (through GlobalModule)
  EXPORT UNSIGNED2 RESPONSE_THRESHOLD := 40; // responses scoring below this value are NOT returned

  EXPORT UNSIGNED2 SCORE_THRESHOLD_WATERFALL_PHONES := 74; // 75 and above are good
  
  // tag values for EntityType
  EXPORT type_EntityType := STRING15;
  EXPORT type_EntityType TAG_ENTITY_IND := 'Individual';
  EXPORT type_EntityType TAG_ENTITY_BIZ := 'Business';
  EXPORT type_EntityType TAG_ENTITY_UNK := 'Unknown';

  // tag values used in commonLayout.rollup_key_type. Records the origin
  // of the rollup id column so we can drop RIDs later.
  EXPORT STRING7 TAG_ROLLUP_KEY_DID := 'did';
  EXPORT STRING7 TAG_ROLLUP_KEY_LINKID := 'PowID';
  EXPORT STRING7 TAG_ROLLUP_KEY_RID := 'rid';
  EXPORT STRING7 TAG_ROLLUP_KEY_FDID := 'fdid';
  EXPORT STRING7 TAG_ROLLUP_KEY_FAKEID := 'fakeid';
  // note that MAX_RETURNED_ADDRS is not a hard limit. This is the limit
  // for "normal" circumstances, when the matched address is within this
  // limit. One additional record may be added if the best matching
  // address does not appear within the top MAX_RETURNED_ADDRS results.
  EXPORT UNSIGNED2 DEF_RETURNED_ADDRS := 4;
  EXPORT UNSIGNED2 MAX_RETURNED_ADDRS := DEF_RETURNED_ADDRS + 1;
  EXPORT UNSIGNED2 MAX_RETURNED_NAMES := 5;

  EXPORT TranslationLayout := RECORD
    STRING120 inputRegex;
    STRING120 preferredValue;
  END;

  EXPORT BusinessTranslations := DATASET( [ {'\\bWAL{1,3}(\\s*|-)?MA?RT\\b', 'WAL-MART'},
                                            {'\\bTA?RG[IY]?T\\b', 'TARGET'},
                                            {'\\bHO?ME?(\\s*|-)?DEP(T|O|OT)\\b', 'HOME DEPOT'},
                                            {'\\bAC{1,2}(TOI|RITO)N\\b', 'ACTION'},
                                            {'\\bT[IR]?[IR]?ADO\\b', 'TIRADO'}], TranslationLayout );

  // this set of vendors each has nation-wide coverage and provides good
  // household coverage. They are used to help restrict some searches in
  // mod_partialmatch which might otherwise return too many (dupe) records.
  EXPORT TOP_VENDORS := mdr.sourceTools.set_Util_noWorkPH + // utilities + utilities type Z
                        [ 'EQ', // Equifax header
                          'EN', // Experian header
                          'FP' ]; // FARES - Deeds
  
  //not really a constant, but close enough. this is just insurance in case we want to use the package file to turn off Second Search
  envVarDefault := 'ON';
  envVarName := 'RightAddressSecondSearch';
  EXPORT DO_SECOND_SEARCH := thorlib.getenv(envVarName,envVarDefault) <> 'OFF';//DO_SECOND_SEARCH will be TRUE unless this env Var is set to 'OFF'
END;

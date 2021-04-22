EXPORT Config_BIP := MODULE(BizLinkFull.Config)
  EXPORT city_clean_WheelThreshold := 20;
  /* MAXBLOCKLIMIT is used by the roxie part of the code
   * MAXBLOCKSIZE is used by the thor part of the code
   * The SIZE will be different between the thor and roxie code repositories.
   * BizLinkFull.svcAppend calls both the thor and roxie parts of the code
   * and because of performance issues on roxie, it must use a lower SIZE
   * than what can be used when running on thor. 
   * The LIMIT should be the same on both the thor and roxie code repositories.
   */
  EXPORT L_CNPNAME_ZIP_MAXBLOCKSIZE := 250000;
  EXPORT L_CNPNAME_ZIP_MAXBLOCKLIMIT := 50000;

  EXPORT L_CNPNAME_ST_MAXBLOCKSIZE := 250000;
  EXPORT L_CNPNAME_ST_MAXBLOCKLIMIT := 50000;

  EXPORT L_CNPNAME_FUZZY_MAXBLOCKSIZE := 250000;
  EXPORT L_CNPNAME_FUZZY_MAXBLOCKLIMIT := 50000;

  EXPORT L_CNPNAME_MAXBLOCKSIZE := 250000;
  EXPORT L_CNPNAME_MAXBLOCKLIMIT := 50000;

  EXPORT L_CONTACT_ZIP_MAXBLOCKSIZE:=250000;
  EXPORT L_CONTACT_ZIP_MAXBLOCKLIMIT:=2600;
  EXPORT L_CONTACT_ST_MAXBLOCKSIZE:=250000;
  EXPORT L_CONTACT_ST_MAXBLOCKLIMIT:=2600;

  // Config values used by HACKS
  // HACK03_a_forceCnpNameWeight should be 4 for roxie, -999 for thor. 
  EXPORT HACK03_a_forceCnpNameWeight := -999;
  EXPORT HACK03_b_forceCnpNameWeight := 4;

  EXPORT HACK08_RoxieAddrCnpNameBonus := 400;
  EXPORT HACK08_ThorAddrCnpNameBonus := 0;


END;

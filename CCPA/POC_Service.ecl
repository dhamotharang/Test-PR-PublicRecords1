EXPORT POC_Service() := MACRO  

  g_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (g_mod);
  
  did_in := 0 : STORED('did');
  did_count := 1 : STORED('did_cnt');
  boolean include_pl := FALSE : STORED('IncludePL');
  boolean include_oc := FALSE : STORED('IncludeOC');

  CCPA.Layouts.l_input xtIn(CCPA.Layouts.l_input L, integer c) := TRANSFORM
    SELF.did := L.did+(1000*(c-1)); // random dids
    SELF.seq := c;
  END; 
  dids := normalize(dataset([{did_in}], CCPA.Layouts.l_input), MIN(did_count, 10), xtIn(LEFT, COUNTER));

  mod_pl_recs := MODULE (mod_access)
    EXPORT boolean log_record_source := mod_access.log_record_source AND include_pl;
  END;
  pl_recs_raw := IF(include_pl, CCPA.Raw.getProfLic(dids, mod_pl_recs));
  mod_oc_recs := MODULE (mod_access)
    EXPORT boolean log_record_source := mod_access.log_record_source AND include_oc;
  END;
  oc_recs_raw := IF(include_oc, CCPA.Raw.getOneClick(dids, mod_oc_recs));
  
  CCPA.Layouts.l_out_svc xtOut() := TRANSFORM
    SELF.hit := EXISTS(pl_recs_raw) OR EXISTS(oc_recs_raw);
    SELF.pl_recs := pl_recs_raw;
    SELF.oc_recs := oc_recs_raw;
  END;
  recs := DATASET([xtOut()]);

  IF (recs[1].hit, doxie.compliance.logSoldToTransaction(mod_access));

  //to test if #storing works inside of suppress.MAC_SuppressSource (it doesn't)
  boolean optout_occured := FALSE : STORED('SourceOptoutOccured');
  IF (optout_occured, OUTPUT ('Source optout may have affected results', NAMED ('optout_occured')));

  OUTPUT(recs, NAMED('Results'));
  // OUTPUT (dids, NAMED ('input_dids'));

ENDMACRO;

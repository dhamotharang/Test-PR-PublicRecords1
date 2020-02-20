import doxie, AutoStandardI, STD;

EXPORT DID_Batch_Service_Records(dataset(DidVille.Layout_Did_InBatch) in_recs) := FUNCTION

  // this function is being used directly from the service layer.
  boolean glb_ok := false : stored('GLBData');

  //creating mod_access in place, since other values are also initiated here;
  mod_access_pre := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  mod_access := MODULE(mod_access_pre)
                  EXPORT unsigned1 unrestricted := mod_access_pre.unrestricted | IF (glb_ok, doxie.compliance.ALLOW.GLB, 0);
                END;

  string120 append_l := '' : stored('Appends');
  string120 verify_l := '' : stored('Verify');
  string120 fuzzy_l := '' : stored('Fuzzies');
  boolean   lookups := false : stored('Lookups');
  boolean   livingSits := false : stored('LivingSits');
  boolean   dedup_results_l := true : stored('Deduped');
  string3   thresh_val := '' : stored('AppendThreshold');
  boolean   patriotproc := false : stored('PatriotProcess');
  unsigned1 soap_xadl_version_value := 0 : stored('xADLVersion');
  boolean usePreLab := false : stored('usePreLab');

  // for this service, we are using the nonblank key to ensure the largest
  // majority of first and last names are populated during record retreival
  UseNonBlankKey := TRUE;

  dedup_results := dedup_results_l;// IN ['on','1'];
  appends := STD.Str.ToUpperCase(append_l);
  verify := STD.Str.ToUpperCase(verify_l);
  thresh_num := (unsigned2)thresh_val;
  fuzzy := STD.Str.ToUpperCase(fuzzy_l);

  DidVille.Layout_Did_OutBatch into(DidVille.Layout_Did_InBatch i) := transform
    self.ssn := stringlib.stringfilter(i.ssn,'0123456789');
    self := i;
  end;

  recs := project(in_recs,into(left));

  res1 := didville.did_service_common_function(recs, appends, verify, fuzzy, dedup_results,
                                               thresh_num, mod_access.isValidGLB(), patriotproc, lookups,
                                               livingSits, false, false, mod_access.glb,
                                               mod_access.show_minors,,UseNonBlankKey, mod_access.application_type, soap_xadl_version_value,
                                               IndustryClass_val := mod_access.industry_class);


  Mapkey := DidVille.key_lab_did_mapping;

  string isLabData1 := STD.Str.ToUpperCase(thorlib.getenv('isLabData',''));

  dummyDIDs := [1791860725];

  recs_out := If(usePreLab ,
            Join(res1 , Mapkey,
            (isLabData1='TRUE' or Left.did in dummyDIDs)
            and Keyed(Left.did = right.postLAB_LexID)  ,
                Transform(DidVille.Layout_Did_OutBatch,
                  Self.DID := if(right.preLAB_ADL > 0,
                                 right.preLAB_ADL, left.DID),
                  Self := left),
              left outer, keep(1)),
            res1);

  return recs_out;
END;

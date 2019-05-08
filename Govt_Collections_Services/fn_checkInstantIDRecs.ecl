import Govt_Collections_Services, Risk_Indicators;

EXPORT fn_checkInstantIDRecs (dataset(Layouts.batch_working) ds_batch_in,
                              Govt_Collections_Services.IParams.BatchParams in_mod) := 
															FUNCTION

 BOOLEAN isFCRA :=  FALSE;
 BOOLEAN runSSNCodes := FALSE;
 
 inrec_raw := PROJECT(ds_batch_in,Transforms.xfm_to_inputSSN_BatchIn(LEFT));
 inrec := GROUP(SORT(inrec_raw(ssn != ''),seq),seq);

 ret := Risk_Indicators.iid_getSSNFlags(inrec, //(groupped by seq)
                                        in_mod.dppa, 
						                            in_mod.glb, 
						                            isFCRA, 
						                            runSSNCodes,
						                            Risk_Indicators.iid_constants.default_ExactMatchLevel,
							                          in_mod.DataRestrictionMask);
							

  Layouts.batch_working format_out(Layouts.batch_working le, risk_indicators.Layout_output ri) := 
   TRANSFORM
     mult_id :=	Risk_Indicators.rcSet.isCodeMI(ri.adls_per_ssn_seen_18months);
	   SELF.hri_code := IF(mult_id,'MI','');
	   SELF.hri_desc := IF(mult_id,risk_indicators.getHRIDesc('MI'),'');
	   SELF := le;
   END;

  with_hri_out := JOIN(ds_batch_in,ret, (UNSIGNED4) LEFT.acctno = RIGHT.seq, format_out(LEFT, RIGHT), LEFT OUTER, KEEP(1));

		IF( in_mod.ViewDebugs, 
				OUTPUT( ret, NAMED('ds_risk_ind_recs') ) );		

  RETURN with_hri_out;
END;
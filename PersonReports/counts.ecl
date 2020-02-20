// The purpose is to isolate counts and "has data" for We Also Found feature.
// WARNING: generally, this code is not safe, since a direct did key hits are counted,
// not taking fcra, glb, dppa, etc. factors into account.
// Ideally, all this functionality would be located in corresponded data provider modules.

import $, doxie, corp2, bankruptcyV3, fcra, FFD, PersonReports;

// TODO: check if "personalized" limits must be used in key reads (currently hardcoded)
// TODO: if this attribute persists, then limit "input.count_param" type to the required fields only

export counts (
  dataset (doxie.layout_references) dids,
  doxie.IDataAccess mod_access,
  $.IParam.count_param in_params = MODULE ($.IParam.count_param) END,
  boolean IsFCRA = false,
	dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	DATASET(FFD.Layouts.PersonContextBatchSlim) ds_slim_pc = FFD.Constants.BlankPersonContextBatchSlim
) := MODULE

  shared did := dids[1].did; // only one DID in the input
  //  shared did_set := SET (dids, did); // should be also safe, (did IN did_set) will be used then


  export bankruptcy := module
    key_read := limit (bankruptcyv3.key_bankruptcyV3_did (isFCRA) (keyed (did = ^.did)), 1000, skip);
		//check for fcra/bankrupt_is_ok is performed at key_bankruptcyV3_did index build
		
		bk_clean := join(key_read, BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus(,,isFCRA),
											keyed(left.tmsid = right.tmsid) and left.did = right.did,
											transform(left),
										left only);
		shared bk_recs := if(in_params.bk_suppress_withdrawn, bk_clean, key_read);
		
		// not safe on FCRA side since suppressions are not done
    export unsigned GetCount := count (bk_recs);
    export boolean exists := exists(bk_recs);
  end;

  export corp := module
    shared key_read := if (~IsFCRA, limit (corp2.key_cont_did (keyed (did = ^.did)), 1000, skip));
    export unsigned GetCount := count (key_read);
    export boolean exists := exists (key_read);
  end;

  export dl := module
    shared data_cnt := if (~IsFCRA, doxie.Fn_dl_count (did, 0, mod_access.dppa, mod_access.glb, mod_access.ln_branded), 0);
    export unsigned GetCount := data_cnt;
    export boolean exists := data_cnt > 0;
  end;

  export property := module
    data_cnt := doxie.Fn_comp_prop_count (did, 0, mod_access.dppa, mod_access.glb, mod_access.ln_branded);
    export unsigned GetCount := data_cnt;
//    export boolean exists := data_cnt > 0;

    // unfortunately, I have to do this extremely heavy calculations to ensure consistency
		prop_recs := PersonReports.property_records(dids, mod_access, PROJECT (in_params, $.IParam.property), IsFCRA, flagfile);
    p_assessments := choosen (prop_recs.prop_assessments, 1);
    p_deeds       := choosen (prop_recs.prop_deeds, 1);

    export boolean exists := exists (p_assessments) or exists (p_deeds);
  end;

END;



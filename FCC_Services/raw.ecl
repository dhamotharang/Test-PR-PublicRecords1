// This module provides FCC data in different formats.
// for FCC ids = fcc_seq
IMPORT doxie, doxie_cbrs, FCC, ut;


EXPORT raw := MODULE
  // Batch - Gets FCC IDs by did (grouped by acctno)
  EXPORT Get_ids_from_dids_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids) := function

    res := JOIN (DEDUP (SORT (in_dids, did), did), FCC.key_fcc_did,
                 keyed (left.did = right.did),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.fcc_seq := Right.fcc_seq),
                 KEEP (Constants.FCC_PER_DID));

		RETURN res; // no deduping, since did - seq is bijection
	END;
	
  EXPORT layouts.id Get_ids_from_dids (DATASET (doxie.layout_references) dids) := FUNCTION
    dids_batch := GROUP (SORTED (PROJECT (dids, doxie.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_dids_batch (dids_batch));
  END;


  // Batch - Gets FCC IDs by bdid (grouped by acctno)
  EXPORT Get_ids_from_bdids_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function

    res := JOIN (DEDUP (SORT (in_bdids, bdid), bdid), FCC.key_fcc_bdid,
                 keyed (left.bdid = right.bdid),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.fcc_seq := Right.fcc_seq),
                 KEEP (Constants.FCC_PER_BDID));

		RETURN DEDUP (res, fcc_seq, ALL); //need to dedup: several bdids can refer to one fcc_seq
	END;
	
  EXPORT layouts.id Get_ids_from_bdids (DATASET (doxie_cbrs.layout_references) bdids) := FUNCTION
    bdids_batch := GROUP (SORTED (PROJECT (bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_bdids_batch (bdids_batch));
  END;


  // =============================================
  // Returns FCC data as part of the report
  // =============================================
  EXPORT EMBEDDED_VIEW := MODULE

    // Batch - by sequence number: main call - all other methods use this function
    shared by_id_batch (GROUPED DATASET (layouts.id) in_ids, string32 appType) := function
      res := FCC_Services.GetFCCByID (in_ids,appType);
      return PROJECT (res, layouts.EmbeddedOutput);
    end;	

    // Batch - by bdid
    shared by_bdid_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids, string32 appType) := function
      return by_id_batch (Get_ids_from_bdids_batch (in_bdids),appType);
    end;


    // by sequence number
    export by_id (DATASET (layouts.id) in_ids, string32 appType) := function
		  return UNGROUP (by_id_batch (GROUP (SORTED (in_ids, acctno), acctno),appType));
    end;
	
    // by bdid
    export by_bdid (DATASET (doxie_cbrs.layout_references) in_bdids, string32 appType) := function
      ds_batch := GROUP (SORTED (PROJECT (in_bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
      return UNGROUP (by_bdid_batch (ds_batch, appType));
    end;
	END;
	

  // ==========================================================================
  // Returns FCC data in search view (same as embedded view)
  // ==========================================================================
	EXPORT SEARCH_VIEW := MODULE
    // by sequence number
    export by_id (DATASET (layouts.id) in_ids, string32 appType) := function
      res := EMBEDDED_VIEW.by_id (in_ids, appType);
      return PROJECT (res, layouts.SearchOutput);
    end;
	END;

	
  // ================================================================
  // Returns FCC data in the stand-alone source view (report) 
  // ================================================================
	EXPORT SOURCE_VIEW := MODULE
    // by sequence number batch
    shared by_id_batch (GROUPED DATASET (layouts.id) in_ids, string32 appType) := function
      res := FCC_Services.GetSourceByID (in_ids, appType);
      return PROJECT (res, layouts.SourceOutput);
    end;	

    // by sequence number
		export by_id (DATASET (layouts.id) in_ids, string32 appType) := function
      return UNGROUP (by_id_batch (GROUP (SORTED (in_ids, acctno), acctno),appType));
		end;

	  // by bdid
    export by_bdid (DATASET (doxie_cbrs.layout_references) in_bdids, string32 appType) := function
      return by_id (Get_ids_from_bdids (in_bdids),appType);
    end;
	END;


// ========================================================
// Returns FCC's info in a view most close to the vendor's
// ========================================================

	EXPORT DATA_VIEW := MODULE
    // by sequence number
		export by_id (dataset(layouts.id) in_ids) := function

      res := JOIN (in_ids, FCC.key_fcc_seq,
                   keyed (Left.fcc_seq = Right.fcc_seq),
                   transform (layouts.DataOutput, SELF := Right),
                   KEEP (1)); 

      return res;
		end;

	  // by bdid
    export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids) := function
      return by_id (Get_ids_from_bdids (in_bdids));
    end;
	END;

END;
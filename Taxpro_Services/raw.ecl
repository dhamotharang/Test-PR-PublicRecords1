// This module provides TAXPRO data in different formats.
// for TAXPRO ids = account number
IMPORT doxie, doxie_cbrs, TAXPRO, ut;

EXPORT raw := MODULE
  // Batch - Gets TAXPRO IDs by did (grouped by acctno)
  EXPORT Get_ids_from_dids_batch (GROUPED DATASET (doxie.layout_references_acctno) in_dids) := function

    res := JOIN (DEDUP (SORT (in_dids, did), did), TAXPRO.Key_DID,
                 keyed (left.did = right.did),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.tmsid := Right.tmsid),
                 LIMIT (Constants.TAXPRO_PER_DID, SKIP));

		RETURN DEDUP (res, tmsid, ALL);
	END;
	
  EXPORT layouts.id Get_ids_from_dids (DATASET (doxie.layout_references) dids) := FUNCTION
    dids_batch := GROUP (SORTED (PROJECT (dids, doxie.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_dids_batch (dids_batch));
  END;


  // Batch - Gets TAXPRO IDs by bdid (grouped by acctno)
  EXPORT Get_ids_from_bdids_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function

    res := JOIN (DEDUP (SORT (in_bdids, bdid), bdid), TAXPRO.Key_BDID,
                 keyed (left.bdid = right.bdid),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.tmsid := Right.tmsid),
                 LIMIT (Constants.TAXPRO_PER_BDID, SKIP));

		RETURN DEDUP (res, tmsid, ALL);
	END;
	
  EXPORT layouts.id Get_ids_from_bdids (DATASET (doxie_cbrs.layout_references) bdids) := FUNCTION
    bdids_batch := GROUP (SORTED (PROJECT (bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_bdids_batch (bdids_batch));
  END;


  // =============================================
  // Returns TAXPRO data as part of the report
  // =============================================
  EXPORT EMBEDDED_VIEW := MODULE

    // Batch - by account_number: main call - all other methods use this function
    shared by_id_batch (GROUPED DATASET (layouts.id) in_ids) := function
      res := TAXPRO_Services.GetTAXPROByID (in_ids);
      return PROJECT (res, layouts.EmbeddedOutput);
    end;	

    // Batch - by bdid
    shared by_bdid_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function
      return by_id_batch (Get_ids_from_bdids_batch (in_bdids));
    end;


    // by account_number
    export by_id (DATASET (layouts.id) in_ids) := function
		  return UNGROUP (by_id_batch (GROUP (SORTED (in_ids, acctno), acctno)));
    end;
	
    // by bdid
    export by_bdid (DATASET (doxie_cbrs.layout_references) in_bdids) := function
      ds_batch := GROUP (SORTED (PROJECT (in_bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
      return UNGROUP (by_bdid_batch (ds_batch));
    end;
	END;
	

  // ==========================================================================
  // Returns TAXPRO data in search view 
  // ==========================================================================
	EXPORT SEARCH_VIEW := MODULE
    // by account_number
    export by_id (DATASET (layouts.id) in_ids) := function
      // ids_grp := GROUP (SORTED (in_ids, acctno), acctno);
      // res := UNGROUP (DeadcoV2_Services.GetDeadcoByID (ids_grp));
      res := EMBEDDED_VIEW.by_id (in_ids);
      return PROJECT (res, layouts.SearchOutput);
    end;
	END;

	
  // ================================================================
  // Returns TAXPRO data in the stand-alone source or report view 
  // ================================================================
  //TODO: check if batch is needed
	EXPORT SOURCE_VIEW := MODULE
    // by account_number
		export by_id (dataset(layouts.id) in_ids) := function
      res := EMBEDDED_VIEW.by_id (in_ids);
      return PROJECT (res, layouts.SourceOutput);
		end;

	  // by bdid
    export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids) := function
      return by_id (Get_ids_from_bdids (in_bdids));
    end;
	END;

  //TODO: check if batch is needed
	EXPORT DATA_VIEW := MODULE
    // by account_number
		export by_id (dataset(layouts.id) in_ids) := function
      res := EMBEDDED_VIEW.by_id (in_ids);
      return PROJECT (res, layouts.DataOutput);
		end;

	  // by bdid
    export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids) := function
      return by_id (Get_ids_from_bdids (in_bdids));
    end;
	END;

END;
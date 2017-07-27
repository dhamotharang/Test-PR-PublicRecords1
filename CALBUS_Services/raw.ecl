// This module provides CALBUS data in different formats.
// for CALBUS ids = account number
IMPORT doxie_cbrs, CALBUS, ut;

CALBUS_PER_BDID := 100;

EXPORT raw := MODULE

  // Batch - Gets CALBUS IDs by bdid (grouped by acctno)
  EXPORT Get_ids_from_bdids_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function

    res := JOIN (DEDUP (SORT (in_bdids, bdid), bdid), CALBUS.Key_Calbus_BDID,
                 keyed (left.bdid = right.bdid),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.account_number := Right.account_number),
                 LIMIT (CALBUS_PER_BDID, SKIP));

		RETURN DEDUP (res, account_number, ALL);
	END;
	
  EXPORT layouts.id Get_ids_from_bdids (DATASET (doxie_cbrs.layout_references) bdids) := FUNCTION
    bdids_batch := GROUP (SORTED (PROJECT (bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_bdids_batch (bdids_batch));
  END;


  // =============================================
  // Returns CALBUS data as part of the report
  // =============================================
  EXPORT EMBEDDED_VIEW := MODULE

    // Batch - by account_number: main call - all other methods use this function
    shared by_id_batch (GROUPED DATASET (layouts.id) in_ids) := function
      res := CALBUS_Services.GetCalbusByID (in_ids);
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
  // Returns CALBUS data in search view 
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
  // Returns CALBUS data in the stand-alone source or report view 
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
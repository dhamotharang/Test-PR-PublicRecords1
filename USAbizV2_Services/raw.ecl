// This module provides USABIZ data in different formats.
// ids = ABI number for USABIZ

IMPORT doxie_cbrs, InfoUSA, ut;

EXPORT raw := MODULE

  // Batch - Gets USABIZ IDs by bdid (grouped by acctno)
  EXPORT Get_ids_from_bdids_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function

    res := JOIN (DEDUP (SORT (in_bdids, bdid), bdid), InfoUSA.Key_ABIUS_bdid,
                 keyed (left.bdid = right.bdid),
                 transform (layouts.id, Self.acctno := Left.acctno, Self.abi_number := Right.abi_number),
                 LIMIT (ut.limits.USABIZ_ABI_PER_BDID, SKIP));

		RETURN DEDUP (SORT (res, RECORD), RECORD);
	END;
	
  EXPORT layouts.id Get_ids_from_bdids (DATASET (doxie_cbrs.layout_references) bdids) := FUNCTION
    bdids_batch := GROUP (SORTED (PROJECT (bdids, doxie_cbrs.layout_references_acctno), acctno), acctno);
    RETURN UNGROUP (Get_ids_from_bdids_batch (bdids_batch));
  END;


  // =============================================
  // Returns USABIZ data as part of the report
  // =============================================
  EXPORT EMBEDDED_VIEW := MODULE

    // Batch - by abi_number: main call - all other methods use this function
    shared by_id_batch (GROUPED DATASET (layouts.id) in_ids) := function
      res := USAbizV2_Services.GetUsabizByID (in_ids);
      return PROJECT (res, layouts.EmbeddedOutput);
    end;	

    // Batch - by bdid
    shared by_bdid_batch (GROUPED DATASET (doxie_cbrs.layout_references_acctno) in_bdids) := function
      return by_id_batch (Get_ids_from_bdids_batch (in_bdids));
    end;


    // by abi_number
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
  // Returns USABIZ data in search view 
  // ==========================================================================
	EXPORT SEARCH_VIEW := MODULE

    // by abi_number
    export by_id (DATASET (layouts.id) in_ids) := function

      ids_grp := GROUP (SORTED (in_ids, acctno), acctno);
      res := UNGROUP (USAbizV2_Services.GetUsabizByID (ids_grp));
      return PROJECT (res, layouts.SearchOutput);
    end;
	END;

	
  // ================================================================
  // Returns USABIZ data in the stand-alone source or report view 
  // ================================================================
  //TODO: check if batch is needed
	EXPORT SOURCE_VIEW := MODULE
    // by abi_number
		export by_id (dataset(layouts.id) in_ids) := function

      // have to dedup in case of invalid input; grouping is formal (unless batch)
      ds_grp := GROUP (SORTED (DEDUP (in_ids, ALL), acctno), acctno);

      res := USAbizV2_Services.GetUsabizByID (ds_grp); // ReportSearchShared
      return PROJECT (UNGROUP (res), layouts.SourceOutput);
		end;

	  // by bdid
    export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids) := function
      return by_id (Get_ids_from_bdids (in_bdids));
    end;
	END;

  //TODO: check if batch is needed
	EXPORT DATA_VIEW := MODULE
    // by abi_number
		export by_id (dataset(layouts.id) in_ids) := function

      // have to dedup in case of invalid input; grouping is formal (unless batch)
      ds_grp := GROUP (SORTED (DEDUP (in_ids, ALL), acctno), acctno);

      res := GetDataSourceByID (ds_grp);
      return UNGROUP (res);
		end;

	  // by bdid
    export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids) := function
      return by_id (Get_ids_from_bdids (in_bdids));
    end;
	END;

END;
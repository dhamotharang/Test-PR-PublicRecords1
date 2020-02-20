import SANCTN, doxie, suppress, ut, census_data, codes;

// SANCTN ID = batch_number + incident_number

EXPORT raw := MODULE

  // ==========================================================================
  // Returns SANCTN data in search view 
  // ==========================================================================
	EXPORT SEARCH_VIEW := MODULE

    // Batch - SANCTN by IDs: main call - all other methods should this function
    export by_id_batch (GROUPED DATASET (Sanctn_services.layouts.id) in_ids,
                        doxie.IDataAccess mod_access) := function
      res := Sanctn_Services.GetDataSourceByID (in_ids, mod_access);
      return PROJECT (res, layouts.EmbeddedOutput);
    end;	


    // returns SANCTN incidents by ID
    export by_id (DATASET (Sanctn_services.layouts.id) in_ids,
		              doxie.IDataAccess mod_access) := function

      ids_grp := GROUP (SORTED (in_ids, acctno), acctno);
      res := UNGROUP (by_id_batch (ids_grp, mod_access)); 

      return PROJECT (res, layouts.SearchOutput);
    end;
	END;


  // =============================================
  // Returns the SANCTN data as part of the report
  // =============================================
  EXPORT REPORT_VIEW := SEARCH_VIEW;

	
  // ================================================================
  // Returns the SANCTN data in the stand-alone source or report view 
  // ================================================================
	EXPORT SOURCE_VIEW := SEARCH_VIEW;

END;
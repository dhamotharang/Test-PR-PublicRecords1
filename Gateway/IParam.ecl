IMPORT BatchShare, doxie, Gateway;

EXPORT IParam := MODULE

	// DidVille.Did_Batch_Service_Raw() params not in BatchShare.IParam.BatchParams
	EXPORT DidVilleParams := INTERFACE(BatchShare.IParam.BatchParams)
		EXPORT STRING120 Appends := '';
		EXPORT STRING3   AppendThreshold := '';
		EXPORT BOOLEAN   Deduped := FALSE;
		EXPORT BOOLEAN   IncludeRanking := FALSE;
		EXPORT BOOLEAN   PatriotProcess := FALSE;
		EXPORT STRING120 Verify := '';
	END;

	// an (optional) convenience method for initializing most common input criteria
	EXPORT getDidVilleParams() := FUNCTION

		in_mod := MODULE(PROJECT(BatchShare.IParam.getBatchParams(),DidVilleParams,OPT))
			EXPORT STRING120 Appends          := ''    : STORED('Appends');
			EXPORT STRING3   AppendThreshold  := ''    : STORED('AppendThreshold');
			EXPORT BOOLEAN   Deduped          := FALSE : STORED('Deduped');
			EXPORT BOOLEAN   IncludeRanking   := FALSE : STORED('IncludeRanking');
			EXPORT BOOLEAN   PatriotProcess   := FALSE : STORED('PatriotProcess');
			EXPORT STRING120 Verify           := ''    : STORED('Verify');
			// BatchShare.IParam.getBatchParams() does not currently initialize
			EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
		END;

		RETURN in_mod;
	END;

  // for gateway calls (Gateway.SOAPCALL_XXX()) made from libraries.
  //  -- this mod_access is not fully compliant (use with caution)
  EXPORT GetGatewayModAccess(unsigned1 glb_purpose, unsigned1 dppa_purpose) := FUNCTION
    mod_access := MODULE(Doxie.IDataAccess)
      EXPORT glb := glb_purpose;
      EXPORT dppa := dppa_purpose;
      // EXPORT DataRestrictionMask := drm;
      // EXPORT DataPermissionMask := dpm;
    END;
    RETURN mod_access;
  END;


END;

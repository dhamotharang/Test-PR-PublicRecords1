EXPORT Constants :=
MODULE

  // Defaults
  EXPORT Defaults :=
  MODULE
		EXPORT UNSIGNED1 MaxResultsPerAcctno := 5;
		EXPORT UNSIGNED1 NumberofInspections := 1;
		                  //////////////////////////////////////////////
											// only get this number of rows (7500) and (7500) per match join in the kfetch 
	                    // since we are in batch mode and don't want to overload roxie.
											// value pertains to a parameterized 'keep' value downstream in linking code
		EXPORT UNSIGNED4 MaxBHLinkidsDBA := 7500;
		EXPORT UNSIGNED4 MaxBHLinkidsBest := 7500;
		EXPORT REAL OFAC_ONLY_GlobalWatchListThreshold := 0.89;
	END;

  EXPORT SingleView :=
  MODULE
    EXPORT UNSIGNED4 MaxLinkedPerRequest := 2000;
    EXPORT UNSIGNED2 MaxResultsPerAcctno := 5;
    EXPORT UNSIGNED2 MaxLinkedPerAcctno := 25;

    // Record Types
    EXPORT STRING1 LinkingRecordType := 'L';
    EXPORT STRING1 BusinessRecordType := 'B';
    EXPORT STRING1 ContactRecordType := 'C';
  END;
	
	EXPORT Limits :=
  MODULE
		EXPORT UNSIGNED2 MaxCorps             := 10000;
		EXPORT UNSIGNED1 MaxResultsPerSection := 9;
		EXPORT UNSIGNED1 MaxResultsRegisteredAgents := 10;
    // Executives - days to go back to treat as current
    EXPORT INTEGER2 TwoYearsInDays        := -730;
		EXPORT UNSIGNED4 MAXProps             := 10000;
		EXPORT UNSIGNED4 MAXUccs              := 10000;
		EXPORT UNSIGNED4 MAXDivCert           := 10000;
		EXPORT UNSIGNED4 MAXOshair            := 10000;
  END;
	
	EXPORT MVR :=
	MODULE
	 EXPORT STRING1 VEH_OWNER		 		:= '1';
	 //EXPORT STRING1 VEH_LESSOR			:= '2';
	 EXPORT STRING1 VEH_REGISTRANT 	:= '4';	 
	 EXPORT STRING1 VEH_LESSEE			:= '5';
  END;		 
	
	EXPORT UCC :=
	MODULE
	 EXPORT string1 DEBTOR       := 'D'; // On both
  END;	 
  
  // Property source_code values
  EXPORT Property :=
  MODULE
    EXPORT Party :=
    MODULE
      EXPORT STRING1 Owner       := 'O';
      EXPORT STRING1 CareOfOwner := 'C';
      EXPORT STRING1 Borrower    := 'B';
      EXPORT STRING1 Seller      := 'S';
    END;
    
    EXPORT Address :=
    MODULE
      EXPORT STRING1 Property        := 'P';
      EXPORT STRING1 OwnerMailing    := 'O';
      EXPORT STRING1 BorrowerMailing := 'B';
      EXPORT STRING1 SellerMailing   := 'S';
    END;
  END;   
END;
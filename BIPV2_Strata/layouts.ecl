import BIPV2_PostProcess;
EXPORT layouts := 
MODULE
	EXPORT layout_Businesses := record
		STRING40 US_Businesses;
		UNSIGNED Build_Value;
    UNSIGNED CountGroup 	;//:= Build_Value;		
	END;
	EXPORT layout_Demographics := record
		STRING40 Header_Element;
		DECIMAL5_2 Active;
		DECIMAL5_2 InActive;
	END;
	
	EXPORT layout_Demographics_Strata := record
		STRING40 Header_Element;
		UNSIGNED Active_Percent;
		UNSIGNED InActive_Percent;
    unsigned countgroup;
	END;
  
//  export fieldstats := recordof(BIPV2_PostProcess.fieldstats_prox.active_fieldStats);  //should be same for each id here
  EXPORT laysegmentation := 
  record
      string10	idName      ;
      unsigned6 id          ;
      integer   reccnt      ;
      string2   core        ;		// TC = tri core, DC = Dual Core, TS = trusted source, SS := Single Trusted Source
      string2   emergingCore;	  // Trusted source singleton
      string2   inactive    ;		// RI - Reported as inactive, NA - Inactive due to no activity
  end;
  export Id_Integrity := {
   string   Identifier
  ,string   Parent_ID
  ,unsigned countgroup
  ,unsigned uniques
  ,unsigned null0  
  ,unsigned unbased0  
  ,unsigned DuplicateRids0    := 0
  ,unsigned DidsNoRid0        := 0 
  ,unsigned DidsAboveRid0     := 0 
  ,unsigned belowparent0
  ,unsigned twoparents0
  ,unsigned DidsMultiParent0  := 0
  ,unsigned ParentNoDid0      := 0
  ,unsigned ParentAboveDid0   := 0
  };
  
  export Gold_Seleid_Orgid_Persistence := {string version,string statname,string statvalue};

  export Gold_Seleid_Orgid_Persistence_rollup := 
  record
    string version;
    string Gold_Seleids_new	                 ;
    string Gold_Seleids_old	                 ;
    string Gold_Seleids_in_common	           ;
    string Gold_Seleids_with_same_orgid	     ;
    string Gold_Seleids_with_same_ultid	     ;
    string Gold_Seleids_with_different_orgid ;
    string Gold_Seleids_with_different_ultid ;
    string Pct_Gold_Seleids_with_same_orgid	 ;
    string Pct_Gold_Seleids_with_same_ultid	 ;
  end;
  
END;

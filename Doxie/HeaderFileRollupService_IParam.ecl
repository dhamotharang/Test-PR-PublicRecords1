IMPORT AutoKeyI, AutoStandardI, BIPV2, iesp, Suppress;

EXPORT HeaderFileRollupService_IParam := 
  MODULE
  
  	EXPORT ta1_IParams := 
      INTERFACE
        EXPORT STRING   DLNumber        := '';
        EXPORT STRING   DLState         := '';
        EXPORT BOOLEAN  reduced_data    := FALSE;
        EXPORT BOOLEAN  allow_wildcard  := FALSE;
        EXPORT BOOLEAN  allow_date_seen := FALSE;
        EXPORT STRING   pname           := '';
        EXPORT INTEGER  date_last_seen  := 0;
        EXPORT INTEGER  date_first_seen := 0;
      END;
    
    EXPORT ta2_IParams := 
      INTERFACE
        EXPORT STRING32      application_type_val    := Suppress.Constants.ApplicationTypes.DEFAULT;
        EXPORT STRING        DataPermissionMask      := AutoStandardI.Constants.DataPermissionMask_default;
        EXPORT BOOLEAN       Include_BusinessCredit  := FALSE;
        EXPORT BOOLEAN       Include_PhonesFeedback  := FALSE;
        EXPORT BOOLEAN       Include_AddressFeedback := FALSE;
        EXPORT SET OF STRING Include_SourceList      := [];    // keeping name in sync with IncludeSourceList in Doxie.HeaderSource_Service
        EXPORT BOOLEAN       Smart_Rollup            := FALSE;
        EXPORT UNSIGNED6     SeleId                  := 0;
        EXPORT UNSIGNED6     OrgId                   := 0;
        EXPORT UNSIGNED6     UltId                   := 0;
      END;
     
  END;
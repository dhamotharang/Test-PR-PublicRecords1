export Constants := MODULE
  export boolean DID_APPEND_LOCAL := TRUE;
  export unsigned DID_SCORE_THRESHOLD := 80;

  export Targus := MODULE
    EXPORT GLOBAL_SID := 23121; // hard-coded here, but coming from Orbit.
    EXPORT UNSIGNED1 SECTION_ID_REQ := 1; 
    EXPORT SECTION_ID_RESP := ENUM(UNSIGNED1, PDE_SEARCH_RESULT = 1, VE_ENHANCED_DATA = 2); 
  END;
  
END;


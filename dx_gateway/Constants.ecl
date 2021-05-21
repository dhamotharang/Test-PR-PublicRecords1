EXPORT Constants := MODULE

  EXPORT BOOLEAN DID_APPEND_LOCAL := TRUE;
  EXPORT UNSIGNED DID_SCORE_THRESHOLD := 80;

  EXPORT Targus := MODULE
    EXPORT GLOBAL_SID := 23121; // hard-coded here, but coming from Orbit.
    EXPORT UNSIGNED1 SECTION_ID_REQ := 1;
    EXPORT SECTION_ID_RESP := ENUM(UNSIGNED1, PDE_SEARCH_RESULT = 1, VE_ENHANCED_DATA = 2, US_PDE_SEARCH_RESULT = 3);
    EXPORT SECTION_CNT_RESP := 3; // # of sections in response with PII data, as defined on the line above.
  END;

  EXPORT Netwise := MODULE
    EXPORT GLOBAL_SID_EMAIL := 28411; // hard-coded here, but coming from Orbit.
  END;

  EXPORT SocialMediaLocator := MODULE
    EXPORT GLOBAL_SID := 28431; // hard-coded here, but coming from Orbit.
  END;

  EXPORT QSent := MODULE
    EXPORT GLOBAL_SID := 28421;
  END;

  EXPORT NetAcuity := MODULE
    EXPORT GLOBAL_SID := 28481;
  END;

  EXPORT CaAvmReport := MODULE
    EXPORT GLOBAL_SID := 28471; // hard-coded here, but coming from Orbit.
  END;

  EXPORT Avm := MODULE
    EXPORT GLOBAL_SID := 28511 ; // hard-coded here, but coming from Orbit.
  END;

  EXPORT AccudataCallerID := MODULE
    EXPORT GLOBAL_SID := 28141; // hard-coded here, but coming from Orbit.
  END;

  EXPORT IconectivElep := MODULE
    EXPORT GLOBAL_SID := 28961; // hard-coded here, but coming from Orbit (item# 56604, created on 04/07/2021).
  END;

END;

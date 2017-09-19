EXPORT Constants :=
MODULE

  EXPORT Limits :=
  MODULE
		EXPORT UNSIGNED2 MaxATFPerDID 		 	 := 200; // atf_services.constants.MAX_RECS_PER_ATF_ID
		EXPORT UNSIGNED2 MaxAircraftsPerDID  := 1000; // ut.limits.AIRCRAFTS_PER_DID
		EXPORT UNSIGNED2 MaxAirmenPerDID 		 := 200; // ut.limits.AIRMAN_PER_DID
		EXPORT UNSIGNED2 MaxAirmanCertificates := 100; // ut.limits.AIRMAN_CERTIFICATES_MAX
    EXPORT UNSIGNED2 MaxBKParties        := 200;
    EXPORT UNSIGNED1 MaxBankruptcyPerDID := 1000; 
    EXPORT UNSIGNED2 MaxDeathPerDID 		 := 100;
		EXPORT UNSIGNED2 MaxEmailPerDID      := 100; 
    EXPORT UNSIGNED2 MaxGongPerDID 		 	 := 100;    
		EXPORT UNSIGNED2 MaxInfutorPerDID    := 100; 
    EXPORT UNSIGNED1 MaxLiensPerDID      := 50;
    EXPORT UNSIGNED2 MaxCCWPerDID     	 := 50; // ut.limits.CCW_PER_DID
    EXPORT UNSIGNED2 MaxHuntersPerDID    := 350; // ut.limits.HUNTERS_PER_DID
    EXPORT UNSIGNED2 MaxLiens            := 1000;
    EXPORT UNSIGNED2 MaxOverrides        := 100;
    EXPORT UNSIGNED2 MaxPAWPerDID        := 100;
    EXPORT UNSIGNED2 MaxProfLicensePerDID:= 100;
    EXPORT UNSIGNED2 MaxPropPerDID       := 100;
    EXPORT UNSIGNED2 MaxPropSearchPerFID := 50;
		EXPORT UNSIGNED2 MaxStudentPerDID    := 100; 
    EXPORT UNSIGNED2 MaxThrivePerDID     := 1000;
    EXPORT UNSIGNED2 MaxUCCPerDID        := 1000;
  END;
 
END;
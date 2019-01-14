IMPORT DueDiligence;


EXPORT DataInterface := MODULE

      EXPORT iRegisteredBusiness := INTERFACE
        EXPORT BOOLEAN includeRegisteredBusinessHit;
        EXPORT BOOLEAN includeSICNAICS;
        EXPORT BOOLEAN includeRegisteredAgents;
        EXPORT BOOLEAN includeAll;
      END;
      
      
      EXPORT iHeader := INTERFACE
        EXPORT BOOLEAN includeFirstLastSeen;
        EXPORT BOOLEAN includeAllSources;
        EXPORT BOOLEAN includeCreditSources;
        EXPORT BOOLEAN includeShellSources;		
        EXPORT BOOLEAN includeFirstSeenFromNonCreditSources;
        EXPORT BOOLEAN includeOperatingLocataions;
        EXPORT BOOLEAN includeBusinessStructure;
        EXPORT BOOLEAN includeSICNAICS;
        EXPORT BOOLEAN includeFirstSeenCleanedInputAddress;
        EXPORT BOOLEAN includeFEIN;
        EXPORT BOOLEAN includeIncorporatedWithLooseLaws;
        EXPORT BOOLEAN includeUniquePowIDsForASeleID;
        EXPORT BOOLEAN includeIfFoundInHeaderData;
        EXPORT BOOLEAN includeAll;
      END;
      
      
      EXPORT iSOS := INTERFACE
        EXPORT BOOLEAN includeIncorporationDate;
        EXPORT BOOLEAN includeCorporateFilingDate;
        EXPORT BOOLEAN includeOperatingLocataions;
        EXPORT BOOLEAN includeSICNAICS;
        EXPORT BOOLEAN includeFilingStatuses;
        EXPORT BOOLEAN includeIncorporatedWithLooseLaws;
        EXPORT BOOLEAN includeRegisteredAgents;
        EXPORT BOOLEAN includeAll;
      END;
END;
IMPORT FLAccidents;

  dsNtlAccidentsBase := FLAccidents.Files_NtlAccidents.DS_BASE_NtlAccidents;

  Layout_eCrash.Consolidation_AgencyOri tNtlAccToeCrash(dsNtlAccidentsBase L ) := TRANSFORM
 		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);
		SELF := L;
		SELF := [];
  END;
  dsNtlAccidentsToeCrashBase := PROJECT(dsNtlAccidentsBase, tNtlAccToeCrash(LEFT));
	
EXPORT Map_NtlAccidents_To_eCrashConsolidation := dsNtlAccidentsToeCrashBase;

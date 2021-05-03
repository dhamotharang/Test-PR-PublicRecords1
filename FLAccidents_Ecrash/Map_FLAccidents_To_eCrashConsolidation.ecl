IMPORT FLAccidents;

  dsFLAccidentsBase := FLAccidents.aid_files.flcrashConsolidationBase;

  Layout_eCrash.Consolidation_AgencyOri tFlAccToeCrash(dsFLAccidentsBase L ) := TRANSFORM
 		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);
		SELF.is_Terminated_Agency := FALSE;
		SELF.allow_Sale_Of_Component_Data := TRUE;
		SELF := L;
		SELF := [];
  END;
  dsFLAccidentsToeCrashBase := PROJECT(dsFLAccidentsBase, tFlAccToeCrash(LEFT));
	
EXPORT Map_FLAccidents_To_eCrashConsolidation := dsFLAccidentsToeCrashBase;
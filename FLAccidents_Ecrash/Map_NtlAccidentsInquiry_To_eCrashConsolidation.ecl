IMPORT FLAccidents;

  dsNtlAccidentsInquiryBase := FLAccidents.Files_NtlAccidentsInquiry.DS_BASE_NtlAccidentsInquiry;

  Layout_eCrash.Consolidation_AgencyOri tNtlAccInqToeCrash(dsNtlAccidentsInquiryBase L ) := TRANSFORM
 		SELF.Releasable := '1'; 	
		SELF.is_Suppressed := '0'; 	
		SELF.Citation_Details := ROW([], Layout_Infiles_Fixed.Citations_ChildRec);
		SELF.is_Terminated_Agency := FALSE;
		SELF.allow_Sale_Of_Component_Data := TRUE;
		SELF := L;
		SELF := [];
  END;
  dsNtlAccidentsInqToeCrashBase := PROJECT(dsNtlAccidentsInquiryBase, tNtlAccInqToeCrash(LEFT));
	
EXPORT Map_NtlAccidentsInquiry_To_eCrashConsolidation := dsNtlAccidentsInqToeCrashBase;
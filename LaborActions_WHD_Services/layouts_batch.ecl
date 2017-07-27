import LaborActions_WHD;

EXPORT layouts_batch := MODULE

	EXPORT Batch_in := RECORD
		STRING20  acctno       := '';
		UNSIGNED6 bdid         := 0;
		STRING120 comp_name    := '';
		STRING10  prim_range   := '';
		STRING2   predir       := '';
		STRING28  prim_name    := '';
		STRING4   addr_suffix  := '';
		STRING2   postdir      := '';
		STRING10  unit_desig   := '';
		STRING8   sec_range    := '';
		STRING25  p_city_name  := '';
		STRING2   st           := '';
		STRING5   z5           := '';
	END;

	EXPORT layout_for_batch_records := RECORD
		STRING20 acctno             := '0';
		UNSIGNED2 comp_name_penalty :=  0;
		UNSIGNED2 address_penalty   :=  0;
		LaborActions_WHD.layouts.keybuild;
	END;
	
	EXPORT Batch_out := RECORD
		STRING20 acctno := '0';
		UNSIGNED8 Date_FirstSeen;
		UNSIGNED8 Date_LastSeen;
		UNSIGNED6 bdid 	:= 0;
		STRING5	  DartID;
		UNSIGNED8 DateAdded;
		UNSIGNED8 DateUpdated;
		STRING30	Website;
		STRING2	  State;
		STRING10	CaseID;
		STRING150 EmployerName;
		STRING50	Address1;
		STRING30	City;
		STRING2	  EmployerState;
		STRING10	ZipCode;
		STRING10	NAICSCode;
		UNSIGNED4	Summary_TotalViolations;
		UNSIGNED4	Summary_BW_TotalAgreedAmount;
		UNSIGNED4	Summary_CMP_TotalAssessments;
		UNSIGNED4	Summary_EE_TotalViolations;
		UNSIGNED4	Summary_EE_TotalAgreedCount;

		STRING10	CaseID_1;
		UNSIGNED4	TotalViolations_1;
		UNSIGNED4	BW_TotalAgreedAmount_1;
		UNSIGNED4	CMP_TotalAssessments_1;
		UNSIGNED4	EE_TotalViolations_1;
		UNSIGNED4	EE_TotalAgreedCount_1;
		STRING200 Violations_Summary_1;
		
		STRING10	CaseID_2;
		UNSIGNED4	TotalViolations_2;
		UNSIGNED4	BW_TotalAgreedAmount_2;
		UNSIGNED4	CMP_TotalAssessments_2;
		UNSIGNED4	EE_TotalViolations_2;
		UNSIGNED4	EE_TotalAgreedCount_2;
		STRING200 Violations_Summary_2;

		STRING10	CaseID_3;
		UNSIGNED4	TotalViolations_3;
		UNSIGNED4	BW_TotalAgreedAmount_3;
		UNSIGNED4	CMP_TotalAssessments_3;
		UNSIGNED4	EE_TotalViolations_3;
		UNSIGNED4	EE_TotalAgreedCount_3;
		STRING200 Violations_Summary_3;

		STRING10	CaseID_4;
		UNSIGNED4	TotalViolations_4;
		UNSIGNED4	BW_TotalAgreedAmount_4;
		UNSIGNED4	CMP_TotalAssessments_4;
		UNSIGNED4	EE_TotalViolations_4;
		UNSIGNED4	EE_TotalAgreedCount_4;
		STRING200 Violations_Summary_4;

		STRING10	CaseID_5;
		UNSIGNED4	TotalViolations_5;
		UNSIGNED4	BW_TotalAgreedAmount_5;
		UNSIGNED4	CMP_TotalAssessments_5;
		UNSIGNED4	EE_TotalViolations_5;
		UNSIGNED4	EE_TotalAgreedCount_5;
		STRING200 Violations_Summary_5;
	END;
END;
EXPORT WUID_Macro(new_Tag, old_Tag, cond, email_list):=FUNCTIONMACRO

EXPORT Layout_Person_FCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA;
	STRING G_ProcErrorCode;
END;

EXPORT Layout_Person_NonFCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA;
	STRING G_ProcErrorCode;
END;

EXPORT Layout_Business_NonFCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING G_ProcErrorCode;
END;

#workunit('name', 'MAS KAT Run Compare');

unique_id:='p_inpacct';

Person_NonFCRA_dset1:=DATASET( WORKUNIT(new_Tag,'Filtered_output'), Layout_Person_NonFCRA);
Person_NonFCRA_dset2:=DATASET( WORKUNIT(old_Tag,'Filtered_output'), Layout_Person_NonFCRA);

Person_FCRA_dset1:=DATASET( WORKUNIT(new_Tag,'Filtered_output'), Layout_Person_FCRA);
Person_FCRA_dset2:=DATASET( WORKUNIT(old_Tag,'Filtered_output'), Layout_Person_FCRA);

Business_dset1:=DATASET( WORKUNIT(new_Tag,'Filtered_output'), Layout_Business_NonFCRA);
Business_dset2:=DATASET( WORKUNIT(old_Tag,'Filtered_output'), Layout_Business_NonFCRA);


Person_NonFCRA_Distribution_comparison_report:=Kel_Shell_QA_UI.UI_PSI_Compare_Macro(unique_id,
																																										Person_NonFCRA_dset1,
																																										Person_NonFCRA_dset2,
																																										new_Tag,
																																										old_Tag,
																																										email_list);

Person_FCRA_Distribution_comparison_report:=Kel_Shell_QA_UI.UI_PSI_Compare_Macro(unique_id,
																																										Person_FCRA_dset1,
																																										Person_FCRA_dset2,
																																										new_Tag,
																																										old_Tag,
																																										email_list);
																																										
Business_Distribution_comparison_report:=Kel_Shell_QA_UI.UI_PSI_Compare_Macro(unique_id,
																																										Business_dset1,
																																										Business_dset2,
																																										new_Tag,
																																										old_Tag,
																																										email_list);
																																										
RETURN MAP(cond='Person_NonFCRA' =>Person_NonFCRA_Distribution_comparison_report,
    cond='Person_FCRA' => Person_FCRA_Distribution_comparison_report,
		Business_Distribution_comparison_report
		);

ENDMACRO;
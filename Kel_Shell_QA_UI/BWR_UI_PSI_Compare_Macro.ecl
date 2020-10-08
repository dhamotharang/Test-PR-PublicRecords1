Layout_Person_FCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA;
	STRING G_ProcErrorCode;
END;

Layout_Person_NonFCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_NonFCRA;
	STRING G_ProcErrorCode;
END;

Layout_Business_NonFCRA := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING G_ProcErrorCode;
END;

new_Tag:='W20200915-111742';
old_Tag:='W20200915-111742';

unique_id:='p_inpacct';

dset1:=DATASET( WORKUNIT(new_Tag,'Filtered_output'), Layout_Person_NonFCRA);
dset2:=DATASET( WORKUNIT(old_Tag,'Filtered_output'), Layout_Person_NonFCRA);

Distribution_comparison_report:=Kel_Shell_QA_UI.UI_PSI_Compare_Macro(unique_id,dset1,dset2,new_Tag,old_Tag);
Distribution_comparison_report;


EXPORT BWR_UI_PSI_Compare_Macro := 'todo';
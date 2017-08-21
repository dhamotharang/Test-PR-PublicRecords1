EXPORT Layouts := MODULE

	EXPORT Input := RECORD
    STRING AddOnCode;
    STRING PrimaryCode;
		// Both dates come in as MM/DD/YYYY format
		STRING Effective_Date;
		STRING Termination_Date;
	END;

	EXPORT Input_Plus := RECORD
    Input;
		BOOLEAN TerminationDateValid := FALSE;
	END;

	EXPORT Alpharetta_Base := RECORD
	  STRING50 Filename;
    STRING5  PROC_CD_1;
    STRING5  PROC_CD_2;
	END;

	EXPORT Base := RECORD
    STRING5   PROC_CD_1;
    STRING5   PROC_CD_2;
		STRING8   Effective_Date;
		STRING8   Termination_Date;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
	END;

	EXPORT Reference_Add_On_For_Customer_base := RECORD
		Base - [dt_vendor_first_reported, dt_vendor_last_reported];
	END;

	EXPORT Reference_Add_On_diff := RECORD
		TYPEOF(Base.PROC_CD_1)        NEW_PROC_CD_1;
		TYPEOF(Base.PROC_CD_1)        OLD_PROC_CD_1;
		TYPEOF(Base.PROC_CD_2)        NEW_PROC_CD_2;
		TYPEOF(Base.PROC_CD_2)        OLD_PROC_CD_2;
		TYPEOF(Base.Effective_Date)   NEW_Effective_Date;
		TYPEOF(Base.Effective_Date)   OLD_Effective_Date;
		TYPEOF(Base.Termination_Date) NEW_Termination_Date;
		TYPEOF(Base.Termination_Date) OLD_Termination_Date;
	END;

	EXPORT Reference_Add_On_new_only := RECORD
		TYPEOF(Base.PROC_CD_1)        NEW_PROC_CD_1;
		TYPEOF(Base.PROC_CD_2)        NEW_PROC_CD_2;
		TYPEOF(Base.Effective_Date)   NEW_Effective_Date;
		TYPEOF(Base.Termination_Date) NEW_Termination_Date;
	END;

	EXPORT Reference_Add_On_old_only := RECORD
		TYPEOF(Base.PROC_CD_1)        OLD_PROC_CD_1;
		TYPEOF(Base.PROC_CD_2)        OLD_PROC_CD_2;
		TYPEOF(Base.Effective_Date)   OLD_Effective_Date;
		TYPEOF(Base.Termination_Date) OLD_Termination_Date;
	END;

END;

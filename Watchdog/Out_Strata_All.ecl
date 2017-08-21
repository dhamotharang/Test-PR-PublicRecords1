export Out_Strata_All( dataset( recordof( Watchdog.Layout_Best )) a) := module


stat1RecFmt := RECORD
 CountGroup									 := count(group);

	string nogrouping := 'nogrouping';
	SSN_CountNonBlank := sum(group,if(a.SSN != '',1,0));
	Lname_CountNonBlank := sum(group,if(a.lname != '',1,0));
	Fname_CountNonBlank := sum(group,if(a.fname != '',1,0));
	Mname_CountNonBlank := sum(group,if(a.mname != '',1,0));
	NmSuffix_CountNonBlank := sum(group,if(a.name_suffix != '',1,0));
	Phone_CountNonBlank := sum(group,if( a.phone != '',1,0));
	Prim_Range_CountNonBlank := sum(group,if( a.prim_range != '',1,0));
	Predir_CountNonBlank := sum(group,if( a.predir != '',1,0));
	Prim_name_CountNonBlank := sum(group,if(a.prim_name != '',1,0));
	Suffix_CountNonBlank := sum(group,if(a.suffix != '',1,0));
	Postdir_CountNonBlank :=sum(group,if(a.postdir != '',1,0));
	Unit_Desig_CountNonBlank := sum(group,if(a.unit_desig != '',1,0));
	Sec_Range_CountNonBlank := sum(group,if(a.sec_range != '',1,0));
	City_Name_CountNonBlank := sum(group,if(a.city_name != '',1,0));
    State_CountNonBlank := sum(group,if(a.st != '',1,0));
	Zip_CountNonBlank := sum(group,if(a.zip != '',1,0));
	Zip4_CountNonBlank := sum(group,if(a.zip4 != '',1,0));
	DOB_CountNonBlank := sum(group,if(a.dob != 0,1,0));
	DOD_CountNonBlank := sum(group,if(a.dod != '',1,0));
	Prpt_Deed_ID_CountNonBlank := sum(group,if(a.Prpty_Deed_ID != '',1,0));
	BK_CC_CaseNo_CountNonBlank := sum(group,if(a.Bkrupt_CrtCode_CaseNo != '',1,0));
	Main_Count_CountNonBlank := sum(group,if(a.main_count != 0,1,0));
	Search_Count_CountNonBlank := sum(group,if(a.search_count != 0,1,0));
	VehicleNum_CountNonBlank := sum(group,if(a.Vehicle_vehnum != '',1,0));
	DL_number_CountNonBlank := sum(group,if(a.dl_number != '',1,0));
	Bdid_CountNonBlank := sum(group,if(a.bdid != '',1,0));
END;

export stats_all := Table(a,stat1RecFmt,few);
end;
a := dataset('persist::watchdog_joined',layout_best,flat);

stat1RecFmt := RECORD
	run_date := a.run_date;
	SSN := COUNT(GROUP,a.SSN != '');
	Lname := COUNT(GROUP,a.lname != ''); 
	Fname := COUNT(GROUP,a.fname != ''); 
	Mname := COUNT(GROUP,a.mname != '');
	NmSuffix := COUNT(GROUP,a.name_suffix != '');
	Phone := COUNT(GROUP, a.phone != '');
	Prim_Range := COUNT(GROUP, a.prim_range != '');
	Predir := COUNT(GROUP, a.predir != '');
	Prim_name := COUNT(GROUP,a.prim_name != '');
	Suffix := COUNT(GROUP,a.suffix != '');
	Postdir := COUNT(GROUP,a.postdir != '');
	Unit_Desig := COUNT(GROUP,a.unit_desig != '');
	Sec_Range := COUNT(GROUP,a.sec_range != '');
	City_Name := COUNT(GROUP,a.city_name != '');
    State := COUNT(GROUP,a.st != '');
	Zip := COUNT(GROUP,a.zip != '');
	Zip4 := COUNT(GROUP,a.zip4 != '');
	DOB := COUNT(GROUP,a.dob != 0);
	DOD := COUNT(GROUP,a.dod != '');
	Prpt_Deed_ID := COUNT(GROUP,a.Prpty_Deed_ID != '');
	BK_CC_CaseNo := COUNT(GROUP,a.Bkrupt_CrtCode_CaseNo != '');
	Main_Count := COUNT(GROUP,a.main_count != 0);
	Search_Count := COUNT(GROUP,a.search_count != 0);
	VehicleNum := COUNT(GROUP,a.Vehicle_vehnum != '');
	DL_number := count(group,a.dl_number != '');
	Bdid := count(group,a.bdid != '');
END;

export Stats1_best_x_date := TABLE(a,stat1RecFmt,run_date,FEW);
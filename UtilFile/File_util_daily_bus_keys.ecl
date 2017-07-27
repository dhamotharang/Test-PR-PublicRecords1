import ut;

Util_daily_bus_recs := UtilFile.Util_daily_bus_with_bdid;
//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
r_new := record
		UtilFile.Layout_util_daily_bus_out;
		unsigned6 did_temp;
end;

//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did
r_new t_reformat(Util_daily_bus_recs L) := TRANSFORM
	SELF.did_temp := (unsigned6)L.did;
	SELF := L;
END;

p1 := PROJECT(Util_daily_bus_recs, t_reformat(LEFT));

//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(p1,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 
export File_util_daily_bus_keys := PROJECT(PhSuppressed2,transform(UtilFile.Layout_util_daily_bus_out,self := left));
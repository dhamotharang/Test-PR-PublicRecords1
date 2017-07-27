import doxie, ut;

p_TEMP := utilfile.daily_fdid;

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did

r_new := RECORD
	utilfile.Layout_DID_Out;
	unsigned6 did_temp;
END;

r_new t_reformat(p_TEMP L) := TRANSFORM
	SELF.did_temp := (unsigned6)L.did;
	SELF := L;
END;
p1 := PROJECT(p_TEMP, t_reformat(LEFT));

//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(p1,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 

p := PROJECT(PhSuppressed2,transform(utilfile.Layout_DID_Out,self := left));

//************************************************************************************************************	

export Key_Util_Daily_Id := INDEX(p, {id},{p},'~thor_data400::key::utility::daily.id_'+doxie.Version_SuperKey);
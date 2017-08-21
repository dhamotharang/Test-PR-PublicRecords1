/*2016-12-09T01:00:30Z (Wendy Ma)

*/
Import Data_Services, doxie, ut, header_services;

daily := utilfile.daily_fdid;

utility_in := utilfile.file_supplemental.out_supp;

end_fdid := count(utilfile.daily_fdid);

utilfile.Layout_DID_Out t(utilfile.Layout_DID_Out le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := i + end_fdid;
	SELF := le;
END;
supp_ds_in := PROJECT(utility_in, t(LEFT, COUNTER));

p_TEMP := daily + supp_ds_in;


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

p := PROJECT(PhSuppressed2,transform(utilfile.Layout_DID_Out, self.ssn := '',self := left));

//************************************************************************************************************	


export Key_Util_Daily_FDid := INDEX(p,{fdid},{p},Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::utility::daily.fdid_'+doxie.Version_SuperKey);
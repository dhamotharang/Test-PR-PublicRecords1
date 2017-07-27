import RoxieKeyBuild,bankrupt,ut,autokey,doxie,header_services;
export proc_build_util_keys(string filedate) := 
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(utilfile.key_address,
                          '~thor_data400::key::utility_address','~thor_data400::key::utility::'+filedate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_V2('~thor_data400::key::utility_address','~thor_data400::key::utility::'+filedate+'::address',mv_addr);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(utilfile.key_did,
                          '~thor_data400::key::utility_did','~thor_data400::key::utility::'+filedate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_V2('~thor_data400::key::utility_did','~thor_data400::key::utility::'+filedate+'::did',mv_did);

r :=
RECORD
	utilfile.Layout_DID_Out;
	integer zero := 0;
END;


r_new :=
RECORD
	utilfile.Layout_DID_Out;
	unsigned6 did_temp;
END;

header_services.Supplemental_Data.mac_verify('file_utility_inj.thor',Utilfile.Layout_DID_Out,read);
 
utility_in := read();

end_fdid := count(utilfile.daily_fdid);

utilfile.Layout_DID_Out t(utilfile.Layout_DID_Out le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := i + end_fdid;
	SELF := le;
END;
supp_ds_in := PROJECT(utility_in, t(LEFT, COUNTER));

supp_ds := utilfile.daily_fdid + supp_ds_in;

//***********************************CODE TO SUPRESS WA CELL PHONES********************************************
//Base search file needs to be reformated before using ut.mac_suppress_by_phonetype because does not accept the casting of did
r_new t_reformat(supp_ds L) := TRANSFORM
	SELF.did_temp := (unsigned6)L.did;
	SELF := L;
END;
p1 := PROJECT(supp_ds, t_reformat(LEFT));

//Supress WA Cell Phones
ut.mac_suppress_by_phonetype(p1,work_phone,st,PhSuppressed1,true,did_temp);
ut.mac_suppress_by_phonetype(PhSuppressed1,phone,st,PhSuppressed2,true,did_temp);

//Reformat back to the standard format layout of the Base search file 

p := PROJECT(supp_ds,transform(r,self := left));

//************************************************************************************************************	

UtilFile.Mac_Build_Local(p,fname,mname,lname,
						ssn,
						dob,
						phone,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						fdid,
						'~thor_data400::key::utility::daily.',filedate,act,,['-']);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(utilfile.Key_Util_Daily_FDID,'~thor_data400::key::utility::daily.fdid','~thor_data400::key::utility::'+filedate+'::daily.fid',big_build1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(utilfile.Key_Util_Daily_DID,'~thor_data400::key::utility::daily.did','~thor_data400::key::utility::'+filedate+'::daily.did',big_build2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(utilfile.Key_Util_Daily_id,'~thor_data400::key::utility::daily.id','~thor_data400::key::utility::'+filedate+'::daily.id',big_build3);

RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::utility::daily.fdid','~thor_data400::key::utility::'+filedate+'::daily.fid',big_build4);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::utility::daily.did','~thor_data400::key::utility::'+filedate+'::daily.did',big_build5);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::utility::daily.id','~thor_data400::key::utility::'+filedate+'::daily.id',big_build6);

return sequential(act,parallel(bk_addr,bk_did,big_build1,big_build2,big_build3),
						parallel(mv_addr,mv_did,big_build4,big_build5,big_build6));

end;

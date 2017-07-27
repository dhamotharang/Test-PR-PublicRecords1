import RoxieKeyBuild, AutokeyB2, ut, autokey, doxie, header_services,AutoKeyI;

export proc_build_util_bus_keys(string filedate) := 
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(utilfile.key_bus_address,
                          '~thor_data400::key::utility::bus::address','~thor_data400::key::utility::bus::'+filedate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_V2('~thor_data400::key::utility::bus::address','~thor_data400::key::utility::bus::'+filedate+'::address',mv_addr);

Util_daily_bus_recs := UtilFile.Util_daily_bus_with_bdid;

//start util bus autokeys
r := RECORD
	UtilFile.Layout_util_daily_bus_out;
	integer zero := 0;
	string  blank := '';
END;

File_Autokeys := project(Util_daily_bus_recs, transform(r, self := left));

// holds logical base name for a autokeys.
logicalname := '~thor_data400::key::utility::daily::bus::'+ filedate + '::autokey::';

// holds key base name for autokeys 
keyname     := '~thor_data400::key::utility::daily::bus::autokey::@version@::';

skip_set    := ['C','F'];

autokey.mac_useFakeIDs 
	(File_Autokeys, 
	ds_withFakeID_AKB,  
	proc_build_payload_key_AKB, 
	keyname, 
	logicalname, 
	zero, 
	bdid, 
	true, 
	'AK', 
	unsigned6, 
	false, 
	false, 
	zero) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
ds_inLayoutMaster_AKB :=  
project( 
	ds_forLayoutMaster_AKB, 
	transform( 
		 autokey.layouts.master, 
		self.inp.fname := left.blank; 
		 self.inp.mname := left.blank; 
		 self.inp.lname := left.blank; 
		 self.inp.ssn := if((integer)left.zero=0,'',(string9)left.zero); 
		 self.inp.dob := (integer)left.zero; 
		 self.inp.phone := (string10)left.zero; 
		 self.inp.prim_name := left.blank; 
		 self.inp.prim_range := left.blank; 
		 self.inp.st := left.blank; 
		 self.inp.city_name := left.blank; 
		 self.inp.zip := (string6)left.blank; 
		 self.inp.sec_range := left.blank; 
		 self.inp.states := left.zero; 
		 self.inp.lname1 := left.zero; 
		 self.inp.lname2 := left.zero; 
		 self.inp.lname3 := left.zero; 
		 self.inp.city1 := left.zero; 
		 self.inp.city2 := left.zero; 
		 self.inp.city3 := left.zero; 
		 self.inp.rel_fname1 := left.zero; 
		 self.inp.rel_fname2 := left.zero; 
		 self.inp.rel_fname3 := left.zero; 
		 self.inp.lookups := left.zero; 
		 self.inp.DID := (unsigned6)left.zero; 
		 self.inp.bname := left.Company_Name; 
		 self.inp.fein := if((integer)left.zero=0,'',(string9)left.zero); 
		 self.inp.bphone := (string10)left.phone; 
		 self.inp.bprim_name := left.prim_name; 
		 self.inp.bprim_range := left.prim_range; 
		 self.inp.bst := left.st; 
		 self.inp.bcity_name := left.p_city_name; 
		 self.inp.bzip := (string5)left.zip; 
		 self.inp.bsec_range := left.sec_range; 
		 self.inp.BDID := (unsigned6)left.bdid; 
		 self.FakeID := left.FakeID; 
		 self.p := []; 
		 self.b := []; 
	 ) 
); 
	  
	 
mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := keyname; 
	export string L_inlogical := logicalname; 
	export boolean L_diffing := false; 
	export boolean L_Biz_useAllLookups := true; 
	export boolean L_Indv_useAllLookups := true; 
	export boolean L_by_lookup := true; 
	export boolean L_skipaddrnorm := false; 
	export boolean L_skipB2behavior := false; 
	export boolean L_useOnlyRecordIDs := true; 
	export boolean L_useFakeIDs := true; 
	export boolean L_AddCities := true; 
	export integer L_Biz_favor_lookup := 0; 
	export integer L_Indv_favor_lookup := 0; 
	export integer L_Rep_addr := 4; 
	export set of string1 L_build_skip_set  := skip_set; 
end; 
	 
bld_auto_keys :=  
	parallel(proc_build_payload_key_AKB, 
	AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild) 
); 


RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(utilfile.Key_Util_Daily_Bus_BDID,'~thor_data400::key::utility::daily::bus::bdid','~thor_data400::key::utility::'+filedate+'::daily::bus::bdid',bk_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(utilfile.Key_Util_Daily_Bus_Id,'~thor_data400::key::utility::daily::bus::id','~thor_data400::key::utility::'+filedate+'::daily::bus::id',bk_id);

RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::utility::daily::bus::bdid','~thor_data400::key::utility::'+filedate+'::daily::bus::bdid',mv_bdid);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::utility::daily::bus::id','~thor_data400::key::utility::'+filedate+'::daily::bus::id',mv_id);

return sequential(parallel(bk_addr, bld_auto_keys, bk_bdid, bk_id),
									parallel(mv_addr, mv_bdid, mv_Id));
end;
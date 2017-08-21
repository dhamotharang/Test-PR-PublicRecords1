import AutoKeyB2, fcra, PRTE, PRTE_CSV, ut ,autokey,AutoKeyI; 

export proc_build_Bankruptcy_autokeys(string filedate, boolean isFCRA = false) := function



b := PRTE_CSV.Bankruptcy_file_autokey;
		 
// Constants
	export ak_keyname := if(isFCRA,
													PRTE_CSV._Dataset().prte_thor_cluster_files+'key::bankruptcy::autokey::fcra::',
													PRTE_CSV._Dataset().prte_thor_cluster_files+'key::bankruptcy::autokey::');
	export ak_logical := if(isFCRA,
													PRTE_CSV._Dataset().prte_thor_cluster_files+'key::bankruptcy::' + filedate + '::autokey::fcra::',
													PRTE_CSV._Dataset().prte_thor_cluster_files+'key::bankruptcy::' + filedate + '::autokey::');

autokey.mac_useFakeIDs 
	(b, 
	ds_withFakeID_AKB,  
	proc_build_payload_key_AKB, 
	ak_keyname, 
	ak_logical, 
	intDID, 
	intbdid, 
	true, 
	'AK', 
	unsigned6, 
	false, 
	false, 
	zero,
	false) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
ds_inLayoutMaster_AKB :=  
	project( 
		ds_forLayoutMaster_AKB, 
		transform( 
			autokey.layouts.master, 
			self.inp.fname := left.person_name.fname; 
			self.inp.mname := left.person_name.mname; 
			self.inp.lname := left.person_name.lname; 
			self.inp.ssn := if((integer)left.ssn=0,'',(string9)left.ssn); 
			self.inp.dob := (integer)left.zero; 
			self.inp.phone := (string10)left.zero; 
			self.inp.prim_name := left.person_addr.prim_name; 
			self.inp.prim_range := left.person_addr.prim_range; 
			self.inp.st := left.person_addr.st; 
			self.inp.city_name := left.person_addr.v_city_name; 
			self.inp.zip := (string6)left.person_addr.zip5; 
			self.inp.sec_range := left.person_addr.sec_range; 
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
			self.inp.lookups := left.party_bits; 
			self.inp.DID := (unsigned6)left.intDID; 
			self.inp.bname := left.cname; 
			self.inp.fein := if((integer)left.tax_id=0,'',(string9)left.tax_id); 
			self.inp.bphone := (string10)left.zero; 
			self.inp.bprim_name := left.company_addr.prim_name; 
			self.inp.bprim_range := left.company_addr.prim_range; 
			self.inp.bst := left.company_addr.st; 
			self.inp.bcity_name := left.company_addr.v_city_name; 
			self.inp.bzip := (string5)left.company_addr.zip5; 
			self.inp.bsec_range := left.company_addr.sec_range; 
			self.inp.BDID := (unsigned6)left.intbdid; 
			self.FakeID := left.FakeID;
			self.p := [];
			self.b := []; 
			) 
	 ); 
	  
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := ''; 
	export string L_inlogical := ak_logical; 
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
	export set of string1 L_build_skip_set  := []; 
	export boolean L_UseNewPreferredFirst:= true;
	export boolean L_processCompoundNames:= true;
	end; 
	 
	
build_custom_ak := MODULE (AutoKeyI.BuildI_Indv.ibuild)
	export BuildI_Indv_Custom1_keybuild(autokeyi.InterfaceForBuild in_mod)	:= PRTE.BK_MCustomAutokeyBuild.RedactedSSNName.keybuild(in_mod);

end;	

	
outaction :=  
	parallel(
		proc_build_payload_key_AKB, 
		AutokeyB2.Fn_Build._Build(mod_AKB, build_custom_ak, AutoKeyI.BuildI_Biz.DoBuild)
	); 

/*	 
AutoKeyB2.MAC_AcceptSK_to_QA(BankruptcyV2.Constants(filedate, isFCRA).ak_keyname, mymove)

retval := 
	sequential(
		outaction,
		mymove,
		MCustomAutokeyBuild.RedactedSSNName.keymoveQA(mod_AKB)
	);
*/
 
return outaction;

end;



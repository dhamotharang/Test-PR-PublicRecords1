import AutoKeyB2,ln_propertyv2,ln_propertyv2_Fast,autokey,AutoKeyI,ut; 

export proc_build_autokeys(string filedate,boolean isFast) := function

ak_dataset := Constants.ak(isFast).data_set;
ak_keyname := Constants.ak(isFast).keyname;
ak_logical := Constants.ak(isFast).logical(filedate);
ak_skipSet := Constants.ak(isFast).skipSet;
ak_typeStr := Constants.ak(isFast).typeStr;

kfullkey:=index(LN_PropertyV2.Key_Property_Payload,'~thor_data400::key::ln_propertyv2::autokey::payload_qa');
kdeltakey:=index(LN_PropertyV2.Key_Property_Payload,'~thor_data400::key::property_fast::autokey::payload_qa');
sMaxFID := if(isFast,MAX(kfullkey+kdeltakey,fakeid),0);	

// DF-28905, added forcePromotion to true due to recent changes on autokey.mac_useFakeIDs, logical file was not being moved to QA on a delta build
autokey.mac_useFakeIDs(ak_dataset, ds_withFakeID_AKB, proc_build_payload_key_AKB, ak_keyname, ak_logical, DID, bdid, true, ak_typeStr, unsigned6, false, false, zero,false,isFast,sMaxFID,true) 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
ds_inLayoutMaster_AKB := project(ds_forLayoutMaster_AKB, transform(autokey.layouts.master, self.inp.fname := left. person_name.fname; self.inp.mname := left.person_name.mname; 
self.inp.lname := left.person_name.lname; self.inp.ssn := if((integer)left.app_SSN=0,'',(string9)left.app_SSN); 
self.inp.dob := (integer)left.zero; self.inp.phone := (string10)left.phone; self.inp.prim_name := left.person_addr.prim_name; 
self.inp.prim_range := left.person_addr.prim_range; self.inp.st := left.person_addr.st; self.inp.city_name := left.person_addr.v_city_name;
 self.inp.zip := (string6)left.person_addr.zip5; self.inp.sec_range := left.person_addr.sec_range; 
 self.inp.states := left.zero; self.inp.lname1 := left.zero; self.inp.lname2 := left.zero; 
 self.inp.lname3 := left.zero; self.inp.city1 := left.zero; self.inp.city2 := left.zero;
 self.inp.city3 := left.zero; self.inp.rel_fname1 := left.zero; self.inp.rel_fname2 := left.zero; 
 self.inp.rel_fname3 := left.zero; self.inp.lookups := left.lookups; self.inp.DID := (unsigned6)left.DID; 
 self.inp.bname := left.cname; self.inp.fein := if((integer)left.app_tax_id=0,'',(string9)left.app_tax_id); 
 self.inp.bphone := (string10)left.bphone; self.inp.bprim_name := left. company_addr.prim_name; 
 self.inp.bprim_range := left.company_addr.prim_range; self.inp.bst := left.company_addr.st; 
 self.inp.bcity_name := left.company_addr.v_city_name; self.inp.bzip := (string5)left.company_addr.zip5; 
 self.inp.bsec_range := left.company_addr.sec_range; self.inp.BDID := (unsigned6)left.bdid; self.FakeID := left.FakeID; 
 self.p := []; self.b := []; ) ); 
 
//****** APPEND BUSINESS PREFERRED NAMES *******

LN_PropertyV2_Fast.mac_append_bus_preferred(ds_inLayoutMaster_AKB, append_preferred)

mod_AKB := module(AutokeyB2.Fn_Build.params) 
export dataset(autokey.layouts.master) L_indata := append_preferred; 
export string L_inkeyname := ak_keyname; 
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
export set of string1 L_build_skip_set := ak_skipSet;
export boolean L_UseNewPreferredFirst := true;

 end; 
 
outaction := parallel(proc_build_payload_key_AKB, AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild) );
 
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove)

retval := sequential(outaction,if(NOT(isFast),mymove),LN_PropertyV2_Fast.verify_fakeid_are_unique,output('No Duplicate FakeID'));  // IIR-2644 check duplicate fakeID
return retval;

end;

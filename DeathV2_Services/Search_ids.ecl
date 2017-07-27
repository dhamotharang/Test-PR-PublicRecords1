
import autokeyb,doxie_cbrs,doxie,doxie_raw, business_header;

export Search_ids(
	boolean includeDeepDive = true, 
	boolean isMoxie = false) := 
FUNCTION

doxie.MAC_Header_Field_Declare()

outrec := deathV2_Services.layouts.search_id;

//***** AUTOKEY PEICE
byak := deathv2_services.Autokey_ids;

//***** DIDs
mdid 				:= (unsigned6) did_value;
m_did   		:= dataset([mdid], doxie.layout_references);
bydid 			:= deathv2_services.raw.get_death_ids.from_dids(m_did);
searchByDid := mdid != 0;

dd_dids := if(includeDeepDive, doxie.Get_Dids(true,true));
by_dd_did := deathv2_services.raw.get_death_ids.from_dids(dd_dids);

//***** BY DEATH ID
searchByDeathID := StateDeathID_value <> '';
bydeathID := dataset([{StateDeathID_value}],deathv2_services.layouts.death_id);

//***** BY DOD
bydod := deathv2_services.dod_ids.result;

//***** BY DOB
bydob := deathv2_services.dob_ids.result;

//***** DO I HAVE INPUT THAT PRECLUDES MY NEED FOR AUTOKEYS
skip_ak := pname_value = '' and prange_value = '' and ssn_value = '' and //the goal here is to only skip autokeys in favor of a date if we have only (valid)date + (zip or state or name)
					 (deathv2_services.dod_ids.valid_input((string8)dod_value) or 
					  deathv2_services.dob_ids.valid_input((string8)dob_val) or
						StateDeathID_value <> ''); 

//***** ALL IDS FOUND USING A SEARCH CRITERIA OTHER THAN DID OR DEATHID
ids := if(not skip_ak, byak) +
			 bydod +
			 bydob +
			 project(by_dd_did, 	transform(outrec, self.isDeepDive := TRUE,  self := left));

bydeathid_ids := project(bydeathID, transform(outrec, self.isDeepDive := FALSE, self := left));
bydid_ids 		:= project(bydid, transform(outrec, self.isDeepDive := FALSE,  self := left));

//***** BUG63016: MAKING RESULTS MUTUALLY EXCLUSIVE BASED ON SEARCH CRITERIA
all_ids := MAP(searchByDeathID 	=> bydeathid_ids,
							 searchByDid 			=> bydid_ids,							 
							 ids);
							 
return dedup(sort(all_ids, state_death_id, if(isDeepDive, 1, 0)), state_death_id);

END;
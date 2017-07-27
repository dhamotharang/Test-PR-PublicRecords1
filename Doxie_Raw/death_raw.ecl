//============================================================================
// Attribute: Death_raw.  Used by view source service and comp-report.
// Function to get death records by did or bdid. Based on Doxie.deathfile_records.
// Return layout: Doxie_Raw.Layout_Death_Raw.
//============================================================================

import DeathV2_Services, doxie, suppress, ut;

export death_raw(
    dataset(Doxie.layout_references) dids = dataset([], Doxie.layout_references),
		dataset(DeathV2_Services.layouts.death_id) death_ids = dataset([],DeathV2_Services.layouts.death_id),
	  unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		string6 ssn_mask_value = 'NONE',
		boolean checkRNA = false
) := FUNCTION

ids_from_dids := DeathV2_Services.raw.get_death_ids.FROM_DIDS(dids,checkRNA);

all_ids := dedup(sort(ids_from_dids + death_ids,state_death_id),state_death_id);

rep := DeathV2_Services.raw.get_report.FROM_DEATH_IDS(all_ids, 
																								 '');  //i will do my own ssn_masking at the bottom because i also need the unmasked field

outrec := doxie_raw.Layout_Death_Raw;


res := project(rep, transform(outrec,
															self.age_at_death := ut.Age ((unsigned8)left.dob8,(unsigned8)left.dod8),
															self.county_name := if(left.state='' and left.fipscounty ='', '', left.county_name),
															self.did := (string)((integer)(left.did)),
															self := left
															));


suppress.MAC_Mask(res, msk, ssn, '', true, false, false, true);

return sort(msk(dateVal=0 OR (unsigned3)(dod8[1..6]) <= dateVal), whole record);
END;
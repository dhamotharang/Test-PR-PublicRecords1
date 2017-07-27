//============================================================================
// Attribute: State_Death_raw.  Used by view source service and comp-report.
// Function to get state death records by did or bdid. Based on doxie.key_StateDeath_master_did records.
// Return layout: Doxie_Raw.Layout_State_Death_Raw.
//============================================================================

import Doxie, doxie_crs, suppress;

export state_death_raw(
  dataset(Doxie.layout_references) dids,
	unsigned3 dateVal      = 0,
  unsigned1 dppa_purpose = 0,
  unsigned1 glb_purpose  = 0,
	string6 ssn_mask_value = 'NONE'
) := FUNCTION

kd := doxie.key_StateDeath_master_did;

Doxie_Raw.Layout_State_Death_Raw join_tran(kd l):= transform
  self.age_at_death := ((unsigned)((unsigned8)l.dod - (unsigned8)l.dob)) div 10000;
	self.county_name  := if(l.state = '' and l.fips_county = '', '', l.county_name);
	self.did          := (string)((integer)(L.did));
	self              := l;	
end;

out_f := join(dids, kd,
    left.did = right.l_did and (dateVal = 0 OR (unsigned3)(right.dod[1..6]) <= dateVal),
    join_tran(right));

suppress.MAC_Mask(out_f, results_cleaned, ssn, blank, true, false);

return sort(results_cleaned, whole record);
END;
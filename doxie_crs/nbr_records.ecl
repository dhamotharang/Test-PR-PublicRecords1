// doxie_crs.nbr_records
//
// This retrieves a batch of header records for a given person, and
// turns them into an ordered list of neighbors.


// Test this code by running against an SSN:
//
//		#STORED('SSN', 123456789)
//		OUTPUT(doxie_crs.nbr_records)
//
// or a DID, or any of the other criteria available in CRS.


// This is as good a place as any to define a few terms, and explain
// what some of the parameters actually specify...
//
//		A "target address" is an address where the subject lives or
//		used to live.
//
//		"Max_Neighborhoods" specifies the number of target addresses
//		around which we'll look for neighbors.  If unspecified, it
//		defaults to 4.
//
//		"Neighbors_PerAddress" specifies the number of neighboring
//		addresses we'll look for around each target address.  It has
//		no default value, and in fact if it's <= 0 then we won't
//		even bother looking for neighbors at all.
//(this is actually a number of addresses around subject's, so better name would be "Neighborhoods_PerAddress"?)

//		"Neighbors_Per_NA" specifies the maximum number of neighbors
//		we'll look for at each neighboring address.  If unspecified,
//		it defaults to 3.
//
//		A "current neighbor" is still living at his respective neighboring
//		address, as indicated by a recency of <= 3mos in the dt_last_seen.
//
//		An "historic neighbor" has an overlap >0 with the subject.  In other
//		words, they are or were living near eachother at some point in time.

import doxie_crs, doxie, ut;

// snag header records
doxie.MAC_Selection_Declare();
doxie.MAC_Header_Field_Declare();
headerRecs := doxie.Comp_Subject_Addresses_wrap.addresses;

// convert to target record type
rawTargetRecs := project(headerRecs, doxie.layout_nbr_targets);
// OUTPUT(rawTargetRecs, named('rawTargetRecs')); // DEBUG

// quick reduction if we really don't want to be here
filtHR := rawTargetRecs(Neighbors_PerAddress>0);

// reduce header recs down to targets
targetRecs := doxie.nbr_records_targets(filtHR, Max_Neighborhoods);
// OUTPUT(targetRecs, named('targetRecs')); // DEBUG

// then find the corresponding neighbor records
nbr_records_mode(string1 mode) := doxie.nbr_records(
	targetRecs,
	mode,
	
	// attrs declared in doxie.MAC_Selection_Declare
	Max_Neighborhoods,
	Neighbors_PerAddress,
	Neighbors_Per_NA,
	Neighbor_Recency,
	industry_class_value,
	GLB_Purpose,
	DPPA_Purpose,
	probation_override_value,
	no_scrub,
	glb_ok,
	dppa_ok,
	
	// attrs declared in doxie.MAC_Header_Field_Declare
	ssn_mask_value,,,
  neighbors_proximity // generally, the radius of neighbors' units: houses, or appartments or etc.
);

// generate current/historic neighbors as specified
noResults := DATASET([], doxie.layout_nbr_records);
nbr_records_curr := IF(
	Include_Neighbors_val, // doxie.MAC_Selection_Declare
	nbr_records_mode('C'),
	noResults
);
nbr_records_hist := IF(
	Include_HistoricalNeighbors_val, // doxie.MAC_Selection_Declare
	nbr_records_mode('H'),
	noResults
);

both := nbr_records_curr + nbr_records_hist;
ut.PermissionTools.GLB.mac_FilterOutMinors(both,bothfil,,,dob)

export nbr_records := bothfil;

import header, doxie, ut, AutoHeaderI, AutoStandardI, AutoheaderV2;
doxie.MAC_Header_Field_Declare() //PII
doxie.MAC_Selection_Declare()

mod_access := doxie.compliance.GetGlobalDataAccessModule ();
// search header by address
tempmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
  // I can blank some specific fields here to ease up a cleaning a little, if needed.
end;
ds_search := AutoheaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempmod);
ds_slim_search := project (ds_search, AutoheaderV2.layouts.lib_search);
// full cleaning
ds_search_clean := AutoheaderV2.LIBCALL_conversions.CleanSearchInputDataset (ds_slim_search);
addr_matches := AutoHeaderV2.fetch_address (ds_search_clean); // by default allowed to fail

addr_matches_d := dedup(sort(addr_matches,did),did);

UncleanSearchRecs := JOIN(addr_matches_d,doxie.Key_Header,
												KEYED(LEFT.did = RIGHT.s_did)
												and (prange_value = '' OR RIGHT.prim_range = prange_value)
												and doxie.StripOrdinal(RIGHT.prim_name) = pname_value
												and RIGHT.st = state_value
												and (zip_val = '' or (integer4)RIGHT.zip in zip_value)
												and (city_value = '' or RIGHT.city_name = city_value),
                        transform (header.Layout_Header, Self := Right),
                        limit (ut.limits.HEADER_PER_DID, skip)); // formality, to avoid a warning

header.MAC_GlbClean_Header(UncleanSearchRecs,SearchRecs, , , mod_access);
SortedSearchRecs := SORT(SearchRecs	
												,prim_range
												,predir
												,prim_name
												,suffix
												,postdir
												,unit_desig
												,sec_range
												,city_name
												,st
												,zip
												,zip4
												);

	SearchRecs doMatchingRecsRollup (SearchRecs l, SearchRecs r) := TRANSFORM
		SELF.dt_first_seen := if ( l.dt_first_seen=0 
																or r.dt_first_seen<>0
																and r.dt_first_seen < l.dt_first_seen,
																r.dt_first_seen,
																l.dt_first_seen);
		SELF.dt_last_seen := if ( l.dt_last_seen=0 
																or r.dt_last_seen<>0
																and r.dt_last_seen > l.dt_last_seen,
																r.dt_last_seen,
																l.dt_last_seen);
		SELF := r;
	END;

	RolledMatchingRecs := ROLLUP(SortedSearchRecs
																				,doMatchingRecsRollup(LEFT,RIGHT)
																				,prim_range
																				,predir
																				,prim_name
																				,suffix
																				,postdir
																				,unit_desig
																				,sec_range
																				,city_name
																				,st
																				,zip
																				,zip4
																				);

// transform targets to format needed by neighbor code
doxie.layout_nbr_targets addTargetSeq(RolledMatchingRecs L, integer C) := transform
	self.seqTarget := C;
	self := L;
end;
nbrTargets := PROJECT(RolledMatchingRecs, addTargetSeq(LEFT,COUNTER));

// retrieve current neighbors around specified targets
nbrs := doxie.nbr_records(
	nbrTargets,
	'C',
	Max_Neighborhoods,
	Neighbors_PerAddress,
	Neighbors_Per_NA,
	Neighbor_Recency,
	,,,
	false,  // this service does not need to apply RNA glb restrictions because the neighbors are the subject
  mod_access
);

// expand to include fields required (but ignored) below
xNbrRec := RECORD
	nbrs;
	unsigned6 s_did;
	string1 pflag1 := '';
	string1 pflag2 := '';
	string1 pflag3 := '';
	unsigned3 dt_vendor_last_reported := 0;
	unsigned3 dt_vendor_first_reported := 0;
	unsigned3 dt_nonglb_last_seen := 0;
	string1 rec_type := '';
	string1 vendor_id := '';
	string1 cbsa := '';
	string1 jflag1 := '';
	string1 jflag2 := '';
	string1 jflag3 := '';
	// unsigned8   RawAID := 0; removed because nbrs is a doxie.layout_nbr_records which now includes this field
	string1 valid_dob := '';
	unsigned6 hhid := 0;
	string1 listed_name := '';
	string1 listed_phone := '';
	unsigned4 dod := 0;
	string1 death_code := '';
	unsigned4 lookup_did := 0;
END;
xNbrRec doNbrXpand(nbrs L) := transform
	self := L;
	self.s_did := (integer) L.did;
end;
NeighborRecs := PROJECT(nbrs, doNbrXpand(LEFT));

// header.MAC_GlbClean_Header(UncleanNeighborRecs,NeighborRecs);

XformedNeighborRecs := CHOOSEN(NeighborRecs, 500);
doxie.layout_presentation doRollupPresentationTransform (recordof(NeighborRecs) l) := TRANSFORM
	SELF.penalt := 0;
	SELF.num_compares := 0;
	SELF.glb := false;
	SELF.dppa := false;
	SELF := l;
	self :=[];
END;

pre_rollup_presentation := project(XformedNeighborRecs,doRollupPresentationTransform(LEFT));
export Fetch_Header_File_Neighbor := doxie.rollup_presentation(pre_rollup_presentation,,true)[1].Results;


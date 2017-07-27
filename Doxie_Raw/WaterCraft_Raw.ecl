//============================================================================
// Attribute: WaterCraft_Raw.  Used by view source service and comp-report.
// Function to get water craft records by did or bdid.  Based on Doxie/watercraft_records.
// Return value: Dataset with layout doxie_crs/layout_watercraft_report.
//============================================================================

import census_data, codes, doxie, doxie_crs, watercraft, ut, suppress, MDR;

doxie.mac_header_Field_declare();

export WaterCraft_Raw(
    dataset(Doxie.layout_references) dids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
    string10 ofcl_num = '', // not used
    string30 hull_num = '', // not used
    string50 vesl_nam = '', // not used
    string120 comp_name_value = '',
	dataset(Doxie.Layout_ref_bdid) bdids,
	unsigned3 max_num_watercrafts = 10000,
	boolean include_non_regulated_sources = false
) := FUNCTION

b_key := watercraft.key_watercraft_bdid;
c_key := watercraft.key_watercraft_cid ();
d_key := watercraft.key_watercraft_did ();
s_key := watercraft.key_watercraft_sid ();
w_key := watercraft.key_watercraft_wid ();

doxie_crs.layout_watercraft_report get_search(s_key r) := transform
	self.nondmvsource := r.source_code=MDR.sourceTools.src_infutor_watercraft;
	self.owners := [];
	self.lienholders := []; 
	self.engines := [];
	self := r;
end;

//get watercraft key and state origin by did
wid_st_record := record
	string2	state_origin := '';
	string30	watercraft_key := '';
	string30  sequence_key := '';
end;

wid_st_record get_wid_st1(d_key r) := transform
	self := r;
end; 

wid_st_recs1 := join(dids(did > 0),d_key,keyed(left.did = right.l_did),get_wid_st1(right),KEEP(50));

//get watercraft key and state origin by bdid
wid_st_record get_wid_st2(b_key r) := transform
	self := r;
end; 

wid_st_recs2 := join(bdids(bdid > 0),b_key,keyed(left.bdid = right.l_bdid),get_wid_st2(right),keep(50));

//get search records by watercraft_key and state_origin
by_did_raw := join(wid_st_recs1,s_key,
                   keyed(left.state_origin = right.state_origin and
			          left.watercraft_key = right.watercraft_key and
								left.sequence_key = right.sequence_key) and
								((include_non_regulated_sources and ~doxie.DataRestriction.InfutorWC) or right.source_code != MDR.sourceTools.src_infutor_watercraft),
			    get_search(right), LIMIT(50,SKIP));

by_bdid_raw := join(wid_st_recs2,s_key,
                    keyed(left.state_origin = right.state_origin and
			           left.watercraft_key = right.watercraft_key and
								 left.sequence_key = right.sequence_key) and
								 ((include_non_regulated_sources and ~doxie.DataRestriction.InfutorWC) or right.source_code != MDR.sourceTools.src_infutor_watercraft),
			     get_search(right), LIMIT(50,SKIP));

search_recs_raw := by_bdid_raw + by_did_raw;

//add dppa restriction and sort
// Don't need a separate call for ut.dppa_ok(dppa_purpose) since RNA flag isn't being passed
search_recs_srt := sort(search_recs_raw(watercraft.sDPPA_ok(state_origin,dppa_purpose)),
												state_origin, watercraft_key, sequence_key);
search_recs_dep := dedup(search_recs_srt, state_origin, watercraft_key, sequence_key);

//get owner records by state_origin, watercraft_key and sequence key
wid_owner_record := record
    	string30	watercraft_key := '';
	string30	sequence_key := '';
	string2	state_origin := '';
	doxie_crs.layout_watercraft_owner;
end;

wid_owner_record get_wid_owner(s_key r) := transform
	self := r;
end;

owner_recs_raw := join(search_recs_dep,s_key,
                   keyed(left.state_origin = right.state_origin and
				     left.watercraft_key = right.watercraft_key and
					left.sequence_key = right.sequence_key),
			     get_wid_owner(right), keep(100));

owner_recs_srt := sort(owner_recs_raw, state_origin, watercraft_key, sequence_key,
                                       fname, mname,lname,company_name);

owner_recs_dep := dedup(owner_recs_srt, state_origin, watercraft_key, sequence_key,
                                        fname, mname,lname,company_name);
								
wid_owner_record dc_them(owner_recs_dep l, Census_Data.Key_Fips2County r) := transform
	self.county_name := r.county_name;
	self := l;
end;

Census_Data.MAC_Fips2County_Keyed(owner_recs_dep, st, county, county_name, owner_recs_unmsk)

doxie.MAC_PruneOldSSNs(owner_recs_unmsk, owner_recs_unmsk_pruned, ssn, did);
suppress.mac_mask(owner_recs_unmsk_pruned, owner_recs_0, ssn, blank, true, false);
																																																															
//get coast guard records
doxie_crs.layout_watercraft_report get_coastguard(search_recs_dep l,c_key r) := transform
	self.watercraft_key := l.watercraft_key;
	self.sequence_key := l.sequence_key;
	self.state_origin := l.state_origin; 
	self.vessel_number := r.official_number;
	self := r;
	self := l;
end;

coast_recs := join(search_recs_dep, c_key,
                   keyed(left.state_origin = right.state_origin) and
			          keyed(left.watercraft_key = right.watercraft_key) and
			          keyed(left.sequence_key = right.sequence_key),
			    get_coastguard(left,right), left outer, LIMIT(50,SKIP));

//get watercraft records
doxie_crs.layout_watercraft_report_append get_main(coast_recs l,w_key r) := transform
	self.watercraft_key := l.watercraft_key;
	self.sequence_key := l.sequence_key;
	self.state_origin := l.state_origin; 
	self.rec_type := map(r.history_flag = '' => 'Current',
	                     r.history_flag = 'E' => 'Expired',
					 r.history_flag = 'H' => 'Historical',
					 '');
     self := r;
	self := l;
end;

main_recs_0 := join(coast_recs, w_key,
                  keyed(left.state_origin = right.state_origin) and
			         keyed(left.watercraft_key = right.watercraft_key) and
			         keyed(left.sequence_key = right.sequence_key),
			   get_main(left,right), left outer, LIMIT(50,SKIP));

main_recs := choosen(main_recs_0(dateVal = 0 OR (unsigned3)(purchase_date[1..6]) <= dateVal),max_num_watercrafts);

//normalize lienholder records			   	   
watercraft_lien_rec := record
     string30	watercraft_key;
	string30	sequence_key;
	string2	state_origin;
     doxie_crs.layout_watercraft_lien;
end;

watercraft_lien_rec norm_liens(main_recs l, integer cnt) := transform
	self.lien_name := choose(cnt,l.lien_1_name,l.lien_2_name);
	self.lien_address_1 := choose(cnt,l.lien_1_address_1,l.lien_2_address_1);
	self.lien_address_2 := choose(cnt,l.lien_1_address_2,l.lien_2_address_2);
	self.lien_city := choose(cnt,l.lien_1_city,l.lien_2_city);
	self.lien_state := choose(cnt,l.lien_1_state,l.lien_2_state);
	self.lien_zip := choose(cnt,l.lien_1_zip,l.lien_2_zip);
	self := l;
end;

raw_w_liens := normalize(main_recs,2,norm_liens(left,counter));

srt_w_liens := sort(raw_w_liens(lien_name<>'' or 
                                lien_address_1<>'' or 
						  lien_address_2 <> ''), record);

dep_w_liens_0 := dedup(srt_w_liens, record);

//normalize engine records
watercraft_engine_rec := record
	string30	watercraft_key;
	string30	sequence_key;
	string2	state_origin;
     doxie_crs.layout_watercraft_engine;
end;

watercraft_engine_rec norm_engines(main_recs l, integer cnt) := transform
	self.watercraft_hp := choose(cnt,l.watercraft_hp_1,l.watercraft_hp_2,l.watercraft_hp_3);
	self.engine_make := choose(cnt,l.engine_make_1,l.engine_make_2,l.engine_make_3);
	self.engine_model := choose(cnt,l.engine_model_1,l.engine_model_2,l.engine_model_3);
	self := l;
end;

raw_w_engines := normalize(main_recs,3,norm_engines(left,counter));

srt_w_engines := sort(raw_w_engines(watercraft_hp <> '' or 
                                    engine_make <> '' or 
						      engine_model <> ''), record);

dep_w_engines_0 := dedup(srt_w_engines, record);

owner_recs_1 := project(
	owner_recs_0,
	transform(
		{
			owner_recs_0.state_origin,
			owner_recs_0.watercraft_key,
			owner_recs_0.sequence_key,
			dataset(doxie_crs.layout_watercraft_owner) owners},
		self.owners := project(dataset(left),doxie_crs.layout_watercraft_owner),
		self := left));
		
owner_recs := rollup(owner_recs_1,
	transform(
		recordof(owner_recs_1),
		self.owners := left.owners + right.owners,
		self := left),
	state_origin,
	watercraft_key,
	sequence_key);

dep_w_liens_1 := project(
	dep_w_liens_0,
	transform(
		{
			dep_w_liens_0.state_origin,
			dep_w_liens_0.watercraft_key,
			dep_w_liens_0.sequence_key,
			dataset(doxie_crs.layout_watercraft_lien) lienholders},
		self.lienholders := project(dataset(left),doxie_crs.layout_watercraft_lien),
		self := left));
		
dep_w_liens := rollup(dep_w_liens_1,
	transform(
		recordof(dep_w_liens_1),
		self.lienholders := left.lienholders + right.lienholders,
		self := left),
	state_origin,
	watercraft_key,
	sequence_key);

dep_w_engines_1 := project(
	dep_w_engines_0,
	transform(
		{
			dep_w_engines_0.state_origin,
			dep_w_engines_0.watercraft_key,
			dep_w_engines_0.sequence_key,
			dataset(doxie_crs.layout_watercraft_engine) engines},
		self.engines := project(dataset(left),doxie_crs.layout_watercraft_engine),
		self := left));
		
dep_w_engines := rollup(dep_w_engines_1,
	transform(
		recordof(dep_w_engines_1),
		self.engines := left.engines + right.engines,
		self := left),
	state_origin,
	watercraft_key,
	sequence_key);

main_seed := project(main_recs,
	transform(
		doxie_crs.layout_watercraft_report,
		self.state_origin_full := codes.GENERAL.STATE_LONG(left.state_origin),
		self := left));

main_plus_owners := join(main_seed,owner_recs,
	left.state_origin = right.state_origin and
	left.watercraft_key = right.watercraft_key and
	left.sequence_key = right.sequence_key,
	transform(
		doxie_crs.layout_watercraft_report,
		self.owners := right.owners,
		self := left),
	left outer);

main_plus_lhs := join(main_plus_owners,dep_w_liens,
	left.state_origin = right.state_origin and
	left.watercraft_key = right.watercraft_key and
	left.sequence_key = right.sequence_key,
	transform(
		doxie_crs.layout_watercraft_report,
		self.lienholders := right.lienholders,
		self := left),
	left outer);

final_recs := join(main_plus_lhs,dep_w_engines,
	left.state_origin = right.state_origin and
	left.watercraft_key = right.watercraft_key and
	left.sequence_key = right.sequence_key,
	transform(
		doxie_crs.layout_watercraft_report,
		self.engines := right.engines,
		self := left),
	left outer);

out_recs := final_recs; 

return sort(out_recs,-sequence_key);
END;
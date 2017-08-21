export fnAddPersistentRecordID_Party(dataset(recordof(uccv2.layout_ucc_common.layout_party_with_aid)) in_ds) := function

//W20130604-160207
//the workunit above shows the analysis of the fields needs to create a unique record_id
//a few other comments:
//1)
//it also shows that there are ~12M duplicate records in the file, as evident in the counts comparing ta10 & ta1
//...since they're complete dupes (except for things like process_date, etc) we should be okay assigning the same ID
//2)
//some non-displayable fields do make some records unique, those are listed below
//dt_first_seen-dt_last_seen-dt_vendor_first_reported-dt_vendor_last_reported-process_date-name_score-did_score-geo_lat-geo_long-cr_sort_sz-lot-lot_order-geo_match-geo_blk-cart-err_stat
//i did not feel it necessary to assign another unique ID just because the name_score was different
//3)
//Result5 shows that when you exclude those fields listed above and dedup on the entire record, there are no IDs associated with more than 1 record



 recordof(in_ds) xform1(in_ds le) := transform
  self.persistent_record_id := hash64(
     le.tmsid
		+le.rmsid
 		+le.Orig_name
		+le.Orig_lname
		+le.Orig_fname
		+le.Orig_mname
		+le.Orig_suffix
		+le.duns_number
		+le.hq_duns_number
		+le.ssn
		+le.fein
		+le.Incorp_state
		+le.corp_number
		+le.corp_type
		+le.Orig_address1
		+le.Orig_address2
		+le.Orig_city
		+le.Orig_state
		+le.Orig_zip5
		+le.Orig_zip4
		+le.Orig_country
		+le.Orig_province
		+le.Orig_postal_code
		+le.foreign_indc
		+le.Party_type
		+le.company_name
		+le.title
		+le.fname
		+le.mname
		+le.lname
		+le.name_suffix
		+le.prim_range
		+le.prim_name
		+le.suffix
		+le.postdir
		+le.unit_desig
		+le.sec_range
		+le.p_city_name
		+le.zip5
		+le.did
		);															
  self := le;
 end;

 p1 := project(in_ds(persistent_record_id=0),xform1(left));
 
 concat := in_ds(persistent_record_id>0) + p1;

 return concat;

end;
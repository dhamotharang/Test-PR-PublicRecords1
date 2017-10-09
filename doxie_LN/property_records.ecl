IMPORT doxie_ln, doxie, fcra, doxie_crs, suppress, ffd;


EXPORT property_records (
  DATASET (doxie.layout_best) ds_best, 
  DATASET (doxie.Layout_Comp_Addresses) ds_addresses = DATASET ([], doxie.Layout_Comp_Addresses),
	dataset (doxie.layout_NameDID) ds_names = DATASET ([], doxie.layout_NameDID),
  boolean IsFCRA = false,
	boolean skipAddressRollup = false,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = ffd.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := FUNCTION

Doxie.MAC_Header_Field_Declare(IsFCRA);
doxie.MAC_Selection_Declare();

// Pre-calculate fares-id (required for fsra-side): 'dids' - single record, 
// used in subsequent subcalls to avoid querying non-fcra data in fsra-side.
dids := PROJECT (ds_best, transform (Doxie.layout_references, SELF := Left));

prop_ids := doxie_ln.property_ids (
              dids, DATASET ([], Doxie.Layout_ref_bdid),
              dateVal, dppa_purpose, glb_purpose, ln_branded_value,	probation_override_value,
              Include_PriorProperties_val, Use_CurrentlyOwnedProperty_value,
              ds_addresses, ds_names, IsFCRA,, skipAddressRollup,application_type_value);

// Get deeds/assessments by fares_id (only "good" records are taken at fcra-side)
deed_crs := doxie_ln.deed_records_crs (prop_ids, IsFCRA, flagfile, nonSS, slim_pc_recs, inFFDOptionsMask);
asses_crs := doxie_ln.asses_records_crs (prop_ids, IsFCRA, flagfile, nonSS, slim_pc_recs, inFFDOptionsMask);

base_property := doxie_ln.make_property_records(asses_crs, deed_crs, , ds_best, IsFCRA, nonss, flagfile, slim_pc_recs, inFFDOptionsMask);


std_property :=  base_property(~doxie.DataRestriction.Fares OR ln_fares_id[1] <>'R');

string8 pick_date(string8 sd,string8 rd) := if((integer)sd > 0, sd, rd);

//sort owned property records by property address, fares_id, compare_date(DESC)  
//We're going to prefer Fares because it has more data
srt_property_o := sort(
	std_property(current),
	address_ace_zip,address_prim_name,address_prim_range,
	address_suffix,address_predir,address_postdir,address_sec_range,
	source_code, record_type,
	-compare_date,-doxie_ln.get_LNFirst(ln_fares_id),-ln_fares_id);	  

//dedup owned property records by property address, owner-seller-code, but preserve valid link to address if one exists			
dep_property_o := rollup(
	srt_property_o,
	transform(recordof(srt_property_o),
						self.address_seq_no := MAX (left.address_seq_no, right.address_seq_no),
						self := left),
	address_ace_zip,address_prim_name,address_prim_range,
	address_suffix,address_predir,address_postdir,address_sec_range,
	source_code, record_type);
	
//remove the ever-lived record where there is more recently owned record at same address
std_property keepl(std_property l) := transform
	self := l;
end;

lmt_property_l := 
		 join(std_property(not current,source_code='O'), dep_property_o,
	     left.address_seq_no = right.address_seq_no and
			 left.compare_date < right.compare_date, keepl(left), left only);

//sort even-lived address property records by address seq number, refi_flag, compare_date(DESC)  
srt_property_l := sort(lmt_property_l,
  address_seq_no,refi_flag,-compare_date, -doxie_ln.get_LNFirst(ln_fares_id),-ln_fares_id);	   

//dedup by owned-lived flag, property address, owner-seller-code				
dep_property_l := dedup(srt_property_l,address_seq_no);

//pick only the most recent to have address_seq_no
both := dep_property_l + dep_property_o;

prop_cln :=
	iterate(
		group(
			sort(both(address_seq_no > 0), address_seq_no, -compare_date, if(current, 0, 1)),
			address_seq_no
		),
		transform(
			doxie_crs.layout_property_ln,
			self.address_seq_no := if(left.address_seq_no <> 0, -1, right.address_seq_no),
			self := right
		)
	)
	+ both(address_seq_no <= 0);

//combine 	  
property_records := 
	sort(prop_cln, if(current, 0, 1),	-compare_date, -pick_date(sale_date, recording_date), ln_fares_id);

// FOR DEBUG
// output(srt_property_l, named('srt_property_l'));	
// output(srt_property_l, named('srt_property_l'));	
// output(dep_property_l, named('dep_property_l'));	
// output(srt_property_o, named('srt_property_o'));	
// output(dep_property_o, named('dep_property_o'));	
// output(std_property, named('std_property'));	
// output(asses_crs, named('asses_crs'));	
// output(deed_crs, named('deed_crs'));	
// output(base_property, named('base_property'));	
// output(std_property, named('std_property'));	
// output(ds_addresses, named('ds_addresses'));	
// output(pid_reg, named('pid_reg'));	
// output(ln_branded_value, named('ln_branded_value'));	
// output(pid_calc, named('pid_calc'));	

RETURN property_records;

END;
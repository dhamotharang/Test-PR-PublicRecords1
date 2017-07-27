import doxie_ln, doxie, fcra, suppress, ffd;

EXPORT deed_records_crs (
  DATASET (doxie_ln.layout_property_ids) ds_prop_ids,
  boolean IsFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = ffd.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := FUNCTION

Doxie.MAC_Header_Field_Declare(IsFCRA);

all_deeds := doxie_ln.deed_records (
  ds_prop_ids,
	dateVal,
	ln_branded_value,
  100,
  IsFCRA, flagfile, nonSS, 
	slim_pc_recs,inFFDOptionsMask);

//sort by owned-lived flag, property address, owner_seller_code, record_date(des)
srt_deeds := sort(all_deeds(property_full_street_address<>''),current,
                           property_full_street_address,
                           source_code,-recording_date,-property_address_unit_number,ln_fares_id,-address_seq_no);

//dedup by owned-lived flag, property address, owner_seller_code						
dep_deeds := dedup(srt_deeds,current,
                   property_full_street_address,source_code);

RETURN dep_deeds;
END;
						 
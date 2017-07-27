//this program is to select the latest assessment records for a subject 
// solely used in doxie_ln/property_records
import doxie_ln, doxie, fcra, suppress, ffd;

EXPORT asses_records_crs (
  DATASET (doxie_ln.layout_property_ids) ds_prop_ids,
  boolean IsFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := FUNCTION

doxie.MAC_Header_Field_Declare(IsFCRA)

all_asses := doxie_ln.asses_records(
      ds_prop_ids,
      dateVal,
      ln_branded_value, 100,
      IsFCRA, flagfile, nonSS, 
			slim_pc_recs, inFFDOptionsMask);

//sort by owned-lived flag, property address, owner-seller-code, tax_year(DESC)
srt_asses := sort(all_asses(property_full_street_address<>''),current,
                  property_full_street_address,source_code,-tax_year,
									-assessed_value_year, -market_value_year,
									-property_unit_number,ln_fares_id,-address_seq_no);
		
//dedup by owned-lived flag, property address, owner-seller-code		
dep_asses := dedup(srt_asses,current,
                   property_full_street_address,source_code);		
		
RETURN dep_asses;
END;
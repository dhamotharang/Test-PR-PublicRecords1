//============================================================================
// Attribute: header_raw.  Used by view source service. 
// Function to get dl records by did.  Based on Doxie.header_records.
// Return layout: dataset of type Doxie.Key_Header.
//============================================================================

import lib_ziplib,ut,header,mdr,drivers,suppress, Doxie, FCRA;

export Header_Raw(
  dataset(Doxie.layout_references) dids,
  unsigned3 dateVal = 0,
  unsigned1 dppa_purpose = 0,
  unsigned1 glb_purpose = 0,
  string6 ssn_mask_value = 'NONE',
  boolean ln_branded_value = false,
  boolean probation_override_value = false,
  boolean IsFCRA = false
//	string5 industry_class_value
) := FUNCTION

doxie_raw.Layout_HeaderRawBatchInput tra_for_Batch(dids l) := transform
	self.input.seq := 0;
	self.input.did := l.did;
	self.input.dateVal := dateVal;
	self.input.dppa_purpose := dppa_purpose;
	self.input.glb_purpose := glb_purpose;
	self.input.ssn_mask_value := ssn_mask_value;
	self.input.ln_branded_value := ln_branded_value;

	self.input.probation_override_value := probation_override_value;
	//self.industry_class_value := industry_class_value;
	self := [];
end;

for_batch := group ( SORTED (project(dids, tra_for_Batch(left)), input.seq), input.seq);

ds_header_raw := limit(doxie_raw.Header_Raw_batch(for_batch), ut.limits.HEADER_BATCH_LIMIT, FAIL(11, doxie.ErrorCodes(11)))(did > 0);

// use FCRA filtering for fcra-neutral-side queries
ds_header := IF (~IsFCRA, ds_header_raw, ds_header_raw (~FCRA.Restricted_Header_Src (src, vendor_id[1])));

from_batch := UNGROUP (ds_header);

outrec := doxie_raw.Layout_HeaderRawOutput;

ut.MAC_Slim_Back(from_Batch, outrec, outf)

return outf;

END;
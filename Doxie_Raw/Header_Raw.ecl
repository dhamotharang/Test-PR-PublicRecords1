//============================================================================
// Attribute: header_raw.  Used by view source service. 
// Function to get dl records by did.  Based on Doxie.header_records.
// Return layout: dataset of type Doxie.Key_Header.
//============================================================================

import lib_ziplib,ut,header,mdr,drivers,suppress, Doxie, FCRA;

export Header_Raw(
  dataset(Doxie.layout_references) dids,
  doxie.IDataAccess mod_access,
  boolean IsFCRA = false
) := FUNCTION

doxie_raw.Layout_HeaderRawBatchInput tra_for_Batch(dids l) := transform
	self.input.seq := 0;
	self.input.did := l.did;
	self.input.dateVal := mod_access.date_threshold;
	self.input.dppa_purpose := mod_access.dppa;
	self.input.glb_purpose := mod_access.glb;
	self.input.ssn_mask_value := mod_access.ssn_mask;
	self.input.ln_branded_value := mod_access.ln_branded;

	self.input.probation_override_value := mod_access.probation_override;
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
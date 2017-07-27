//============================================================================
// Attribute: dl_raw.  Used by view source service and comp-report. 
//   Based on Doxie.dl_Search_Local.
// Function to get dl records by did.
// Return layout: Doxie.Layout_DLSearch.
//============================================================================
import doxie, doxie_raw;

export DL_raw(
	dataset(Doxie.layout_references) dids,
	unsigned3	dateVal = 0,
	unsigned1	dppa_purpose = 0,
	unsigned1	glb_purpose = 0,
	boolean		ln_branded_value = false,
	STRING1		race_value = '',
	STRING1		gender_value = '',
	unsigned2	current_year = 0,
	integer		find_year_low = 0,
	integer		find_year_high = 0,
	string2		state_value = '',
	unsigned8	MaxResults_val = Doxie_Raw.maxResults,
	unsigned8	MaxResultsThisTime_val = Doxie_Raw.maxResults,
	boolean		random_value = false,
	string24	dl_value = '',
	string6		ssn_mask_value = 'NONE',
	boolean		dl_mask_value = false
) := FUNCTION

	// Return V2 data
	return Doxie_Raw.DLV2_Raw_Legacy(dids, dl_value);

END;
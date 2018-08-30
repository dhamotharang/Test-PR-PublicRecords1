//============================================================================
// Attribute: Targus_Raw.  Used by view source service.
// Function to get Targus records by did. 
// Return layout: targus.Layout_Consumer_out
//============================================================================

import Doxie, Targus, census_data, D2C;

export Targus_Raw(
    dataset(Doxie.layout_references) dids,
	   unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		  string5 industry_class = ''
) := FUNCTION

isCNSMR := industry_class = D2C.Constants.CNSMR; 
kt := Targus.Key_Targus_DID;

// is pubdate the best date to use for dateVal check??? 
out_f_info := join(dids,kt,
    left.did=right.did and (dateVal=0 OR (unsigned3)(right.pubdate[1..6]) <= dateVal),
    TRANSFORM(doxie_raw.Layout_Targus_raw, self := right));
		
out_f := if(~isCNSMR, out_f_info);

//Populate county_name.
census_data.MAC_Fips2County_Keyed(out_f,st,county,county_name,f2);
return sort(f2, whole record);
END;
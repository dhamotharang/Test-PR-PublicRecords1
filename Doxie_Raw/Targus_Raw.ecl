//============================================================================
// Attribute: Targus_Raw.  Used by view source service.
// Function to get Targus records by did. 
// Return layout: targus.Layout_Consumer_out
//============================================================================

import Doxie, Targus, census_data, D2C, suppress;

export Targus_Raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

// is pubdate the best date to use for dateVal check??? 
out_info := join(dids,Targus.Key_Targus_DID,
    left.did=right.did and (mod_access.date_threshold=0 OR (unsigned3)(right.pubdate[1..6]) <= mod_access.date_threshold),
    TRANSFORM(right));
out_suppressed := suppress.MAC_SuppressSource(out_info,mod_access);		
out_filtered := if(~mod_access.isConsumer(), project(out_suppressed,doxie_raw.Layout_Targus_raw));

//Populate county_name.
census_data.MAC_Fips2County_Keyed(out_filtered,st,county,county_name,out_final);
return sort(out_final, whole record);
END;
//============================================================================
// Attribute: WhoIs_Raw.  Used by view source service and comp-report.
// Function to get net domain records by did.
// Return value: dataset with layout Domains.layout_whois_base.
//============================================================================

import doxie, domains, doxie_crs, ut;

export WhoIs_raw(
    dataset(doxie.layout_references) dids,
    dataset(doxie.layout_ref_bdid) bdids = dataset([], doxie.layout_ref_bdid), // not used anymore
    string45 domain_val = '', // not used anymore
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0
) := FUNCTION

bydid := join (dids, domains.key_Whois_Did, 
               keyed (left.did = right.d),
               transform (doxie_crs.layout_Whois, Self := Right),
               LIMIT (ut.limits.DOMAINS_PER_DID_LIMIT, SKIP));

domains_res := bydid (dateVal = 0 OR (unsigned3)(date_first_seen[1..6]) <= dateVal);

return sort (domains_res, -date_last_seen, domain_name, record);
END;

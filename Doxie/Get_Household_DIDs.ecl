//
// This function takes a list of DIDs, then performs the double bounce to get all of the DIDs for the 
// corresponding households.
//

import doxie, ut;

export Get_Household_DIDs(DATASET(doxie.layout_references) indids) := FUNCTION;

r := record
  unsigned6 did;
  unsigned6 hhid;
  end;
  
r take_r(doxie.key_did_hdid le) := transform
  self.did := le.did;
  self.hhid := le.hhid_relat;
  end;  

hh := join(indids,doxie.key_did_hdid,left.did=right.did and right.ver = 1,take_r(right), LIMIT (ut.limits.HHID_PER_PERSON, SKIP));

hh_ddp := dedup(sort(hh, hhid),hhid);

r take_r2(doxie.key_hhid_did le) := transform
  self.did:=le.did;
  self.hhid:=le.hhid_relat;
  end;

// might need another constant PERSON_PER_HHID
new_dids := join(hh_ddp,doxie.key_hhid_did,left.hhid=right.hhid_relat and right.ver = 1,take_r2(right), LIMIT (ut.limits.HHID_PER_PERSON, SKIP));

RETURN new_dids;
END;
IMPORT ut, didville, CJM_Misc;

// DID Business Contacts using Name, Company Zip
// Determine if located within Inner Radius, and Unique within Outer Radius

UNSIGNED1 inner_radius := 50;
UNSIGNED1 outer_radius := 100;

// Sequence the contact records
Layout_BC_Temp := RECORD
UNSIGNED4 seq;
Layout_Business_Contact_Full;
END;

bc := File_Business_Contacts;

Layout_BC_Temp SeqContacts(Layout_Business_Contact_Full L, UNSIGNED4 cnt) := TRANSFORM
SELF.seq := cnt;
SELF := L;
END;

bc_seq := PROJECT(bc(did = 0), SeqContacts(LEFT, COUNTER));

// Project to InBatch Format
didville.Layout_Did_InBatch InitContacts(Layout_BC_Temp L) := TRANSFORM
SELF.ssn := (QSTRING9)IF(L.ssn <> 0, INTFORMAT(L.ssn, 9, 1), '');
SELF.dob := '';
SELF.phone10 := (QSTRING10)IF(L.phone <> 0, INTFORMAT(L.phone, 9, 1), '');
SELF.suffix := L.name_suffix;
SELF.prim_range := L.company_prim_range;
SELF.predir := L.company_predir;
SELF.prim_name := L.company_prim_name;
SELF.addr_suffix := L.company_addr_suffix;
SELF.postdir := L.company_postdir;
SELF.unit_desig := L.company_unit_desig;
SELF.sec_range := L.company_sec_range;
SELF.p_city_name := L.city;
SELF.st := L.company_state;
SELF.z5 := (QSTRING5)IF(L.company_zip <> 0, INTFORMAT(L.company_zip, 5, 1), '');
SELF.zip4 := (QSTRING4)IF(L.company_zip4 <> 0, INTFORMAT(L.company_zip4, 4, 1), '');
SELF := L;
END;

bc_zip_init := PROJECT(bc_seq, InitContacts(LEFT));

CJM_Misc.MAC_DID_Zip(bc_zip_init, inner_radius, outer_radius, bc_zip_match)

bc_zip_match_dist := DISTRIBUTE(bc_zip_match(confidence >= 90), HASH(seq));
bc_seq_dist := DISTRIBUTE(bc_seq, HASH(seq));

Layout_Business_Contact_Full AssignDID(Layout_BC_Temp L, DidVille.Layout_DID_Zip_Out R) := TRANSFORM
SELF.did := IF(R.did <> 0, R.did, L.did);
SELF := L;
END;

bc_did_assign := JOIN(bc_seq_dist,
                      bc_zip_match_dist,
                      LEFT.seq = RIGHT.seq,
                      AssignDID(LEFT, RIGHT),
                      LEFT OUTER,
                      LOCAL);

//EXPORT BC_DID_Zip := bc_did_assign + bc(did <> 0);
EXPORT BC_DID_Zip := bc_did_assign(did<>0);
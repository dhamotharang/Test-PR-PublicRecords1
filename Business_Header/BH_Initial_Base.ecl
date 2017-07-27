IMPORT Bankrupt, Gong, ut, UCC, Corporate, YellowPages, Domains;

file_bh_previous := Business_Header.File_Business_Header_Previous;

Business_Header.Layout_Business_Header InitPrevious(file_bh_previous l) := transform
SELF.group1_id := 0;
SELF.vendor_id := IF(L.source not in Set_Source_Vendor_Id_Unique, '', L.vendor_id);
self := l;
end;

BH_Previous := project(file_bh_previous(Business_Header.BH_Fix_Filter), InitPrevious(left));

// Business Header Combined Sources
BH_Init_Sources := if(Business_Header.BH_Init_Flag,
                      Business_Header.BH_Init,
					  Business_Header.BH_Init + BH_Previous);

// Select Matching Domain Records
Domains_Init := Domains.Whois_As_Business_Header(zip<>0);

COUNT(Domains_Init);

ut.MAC_Sequence_Records(Domains_Init, rcid, Domains_Seq)

Domains_Dist := DISTRIBUTE(Domains_Seq, HASH(zip, TRIM(prim_name), TRIM(prim_range)));

// Remove most of the Domain name brokers
ut.MAC_Remove_Withdups_Local(Domains_Dist, HASH(zip, TRIM(prim_name), TRIM(prim_range)), 4000, Domains_Dist_Reduced)

BH_Init_Dedup := DEDUP(BH_Init_Sources(zip<>0), company_name, zip, prim_name, prim_range, sec_range, ALL);
BH_Init_Dist := DISTRIBUTE(BH_Init_Dedup, HASH(zip, TRIM(prim_name), TRIM(prim_range)));

Business_Header.Layout_Business_Header SelectDomains(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := TRANSFORM
SELF := L;
END;

// Match Businesses to Domain Records to filter out garbage
Domains_Match := JOIN(Domains_Dist_Reduced,
                      BH_Init_Dist,
                        LEFT.zip = RIGHT.zip AND
                        LEFT.prim_name = RIGHT.prim_name AND
                        LEFT.prim_range = RIGHT.prim_range AND
                        ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                        ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) <= 35,
                      SelectDomains(LEFT, RIGHT),
                      LOCAL);

COUNT(Domains_Match);

Domains_Match_Dedup := DEDUP(Domains_Match, rcid, ALL);

COUNT(Domains_Match_Dedup);

// Append Businesses and Domains
BH_Append := BH_Init_Sources + Domains_Match_Dedup;

COUNT(BH_Append);

// Initialize IDs - Zero the RCID and BDID before initial sequencing
Business_Header.Layout_Business_Header InitIDs(Business_Header.Layout_Business_Header L) := TRANSFORM
SELF.rcid := 0;
SELF.bdid := 0;
SELF.fein := if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
SELF := L;
END;

BH_Append_Init := PROJECT(BH_Append, InitIDs(LEFT));

// Do a preliminary rollup/merge to reduce the number of dups
// This is done as an alternative to MAC_Remove_WithDups only in building
// the inital base to avoid losing information.

BH_Append_Dist := DISTRIBUTE(BH_Append_Init, HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source), TRIM(source_group), TRIM(company_name)));
BH_Append_Sort := SORT(BH_Append_Dist, zip, prim_range, prim_name, source, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
BH_Append_Rollup := ROLLUP(BH_Append_Sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
                      left.source = right.source and
                      left.source_group = right.source_group and
			          left.company_name = right.company_name and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    Business_Header.TRA_Merge_Business_Headers(LEFT, RIGHT),
                    LOCAL);

COUNT(BH_Append_Rollup);

// Distribute to get event distribution before sequencing
BH_Append_Rollup_Dist := DISTRIBUTE(BH_Append_Rollup, HASH(TRIM(company_name), zip));

// Initialize ids
ut.MAC_Sequence_Records_2(BH_Append_Rollup_Dist, rcid, bdid, BH_Seq)

//****** Perform initial rollup on sequenced records
Layout_BH_Slim := RECORD
  unsigned6 rcid;
  unsigned6 bdid;
  string2   source;
  qstring34 source_group;
  string3   pflag;
  qstring120 company_name;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  string2   state;
  unsigned3 zip;
  unsigned6 phone;
  unsigned4 fein;
END;

//****** Slim down the business headers
Layout_BH_Slim SlimBH(Business_Header.Layout_Business_Header L) := TRANSFORM
SELF := L;
END;


BH_Slim := PROJECT(BH_Seq, SlimBH(LEFT)); 

//-- Transform that assigns the right record id as old_rid and the left record id as new_rid
//	 Sets flag to RU1 (rule 1)
Business_Header.Layout_PairMatch Assign_RID(Layout_BH_Slim L, Layout_BH_Slim R) := TRANSFORM
  self.old_rid := R.rcid;
  self.new_rid := L.rcid;
  self.pflag := 1;
END;

//****** Join the business header file to itself
//	     Keep the lower record id as the new_rid
BH_Match := join(BH_Slim,
                 BH_Slim,
			     left.zip = right.zip and
			       left.prim_name = right.prim_name and
			       left.prim_range = right.prim_range and
                   left.source = right.source and
                   left.source_group = right.source_group and
			       left.company_name = right.company_name and
                   left.rcid < right.rcid and
			       ut.NNEQ(left.sec_range,right.sec_range) and
                   (left.phone = 0 OR right.phone = 0 OR left.phone = right.phone) and
			       (left.fein = 0 OR right.fein = 0 OR left.fein = right.fein),
                 Assign_RID(left,right));
                
BH_Match_Sort := SORT(DISTRIBUTE(BH_Match, old_rid), old_rid, new_rid, LOCAL);

BH_RID_Rollup := DEDUP(BH_Match_Sort, old_rid, LOCAL);

COUNT(BH_RID_Rollup);

ut.MAC_Patch_Id(BH_Seq, rcid, BH_RID_Rollup, old_rid, new_rid, BH_Patched)

// Merge Business Header Records within Source
Business_Header.MAC_Merge_ByRid(BH_Patched, BH_Merged)

EXPORT BH_Initial_Base := BH_Merged : PERSIST('TEMP::BH_Initial_Base');
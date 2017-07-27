import ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring81 clean_company_name;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
unsigned6 phone;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Temp L) := transform
self.clean_company_name := ut.CleanCompany(L.company_name);
self := L;
end;

Phone_Match_Init := project(BH_File(source <> 'W' and isMatchablePhone(phone) and phone != 9999999999),
                            InitMatchFile(left));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
self.bdid1 := L.bdid;
self.bdid2 := R.bdid;
self.match_type := 'NP';
end;

Phone_Match_Dedup := dedup(Phone_Match_Init, phone, bdid, zip, clean_company_name, all);

Phone_Match_Dist := distribute(Phone_Match_Dedup, hash(phone));

/*
ut.MAC_Remove_Withdups_Local(Phone_Match_Dist, hash(phone), 1200, Phone_Match_Dist_Reduced)
*/

Phone_Matches := join(Phone_Match_Dist,
                      Phone_Match_Dist,
                      left.phone = right.phone and
                      left.bdid > right.bdid and 
            (
  (not(left.source = 'GG' or right.source = 'GG') and
  ((UT.CompanySimilar100(left.clean_company_name, right.clean_company_name) <= 30 and
		ut.StringSimilar100(left.clean_company_name[41..80], right.clean_company_name[41..80]) //check secondary words
		<= 50)
   OR
   (Business_Header.Address_Match(left.zip, right.zip, left.prim_range, right.prim_range, left.prim_name, right.prim_name, left.sec_range, right.sec_range)
      and ut.CompanySimilar100(left.clean_company_name, right.clean_company_name) < 40)))
  OR
  ((left.source = 'GG' or right.source = 'GG') and
    left.clean_company_name = right.clean_company_name)
            ),
                      MatchBH(left, right),
                      local);

Phone_Matches_Dedup := DEDUP(Phone_Matches, bdid1, bdid2, all);

export BH_Relative_Match_Name_Phone := Phone_Matches_Dedup : persist('TMTEMP::BH_Relative_Match_Name_Phone');
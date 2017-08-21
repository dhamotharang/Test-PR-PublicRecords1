import ut;

// Initialize match file
BH_File := Business_Header.File_Business_Header_Base;

Layout_BH_Match := record
unsigned6 rcid;
unsigned6 bdid;             // Seisint Business Identifier
string2   source;           // Source file type
qstring120 company_name;
qstring120 match_company_name;
qstring20 match_branch_unit;
qstring25 match_geo_city;
qstring10 prim_range;
qstring28 prim_name;
qstring8  sec_range;
unsigned3 zip;
end;

Layout_BH_Match InitMatchFile(Business_Header.Layout_Business_Header_Base L) := transform
self := L;
end;

Company_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Business_Header.Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..7] = 'PO BOX ' and
                                 (integer)(prim_name[8..LENGTH((string)prim_name)]) <> 0) or
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0)),
                          InitMatchFile(left));


Business_Header.Layout_PairMatch MatchBH(Layout_BH_Match L, Layout_BH_Match R, unsigned1 match) := transform
self.old_rid := L.bdid;
self.new_rid := R.bdid;
self.pflag := match;
end;

// Match Rule 4 - Match Company Name and Address
Company_Match_Dedup := dedup(Company_Match_Init, match_company_name, match_branch_unit, match_geo_city, zip, prim_range, prim_name, bdid, all);

Company_Match_Dist := distribute(Company_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Remove_Withdups_Local(Company_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, Company_Match_Dist_Reduced)

boolean CompanyMatchSource(string2 source1, string120 company1,
                           string2 source2, string120 company2) := 
                            ( not(source1 = 'GG' or source2 = 'GG') and
                              UT.CompanySimilar100(company1,company2) <= 10)
                            or
                            ( (source1 = 'GG' or source2 = 'GG') and
                              company1 = company2);

NameAddr_Matches := join(Company_Match_Dist_Reduced,
                         Company_Match_Dist_Reduced, 
						 left.zip = right.zip and
                           left.prim_name = right.prim_name and
                           left.prim_range = right.prim_range and
                           left.match_branch_unit = right.match_branch_unit and
                           left.match_geo_city = right.match_geo_city and
						   left.bdid > right.bdid and
                         CompanyMatchSource(left.source, left.match_company_name,
                                            right.source, right.match_company_name),
                         MatchBH(left, right, 4),
                         local);

NameAddr_Matches_Dedup := dedup(NameAddr_Matches, new_rid, old_rid, all);
count(NameAddr_Matches_Dedup);
					
// Match Company Name and Address Subnames
boolean CompanyMatchSubname(string120 company1, string120 company2, integer length_threshold, real ratio) := FUNCTION
string81 cleancompany1 := ut.CleanCompany(company1);
string81 cleancompany2 := ut.CleanCompany(company2);
integer company1_length := length(trim(company1));
integer company2_length := length(trim(company2));
// Calculate length of primary words for clean company names
integer cleancompany1_length := length(trim(datalib.companyclean(company1)[1..40]));
integer cleancompany2_length := length(trim(datalib.companyclean(company2)[1..40]));

// Check for one company name as a substring of another and length >= ratio
                        return((company1_length >= length_threshold and
						 company2_length >= length_threshold and
						if(company1_length < company2_length,
						       company1_length/company2_length >= ratio,
							  company2_length/company1_length >= ratio) and
                              (stringlib.stringfind(trim(company1), trim(company2), 1) > 0 or
						 stringlib.stringfind(trim(company2), trim(company1), 1) > 0))
						 or
                              (cleancompany1_length >= length_threshold and
						 cleancompany2_length >= length_threshold and
						if(cleancompany1_length < cleancompany2_length,
						       cleancompany1_length/cleancompany2_length >= ratio,
							  cleancompany2_length/cleancompany1_length >= ratio) and
						 (stringlib.stringfind(trim(cleancompany1), trim(cleancompany2), 1) > 0 or
						 stringlib.stringfind(trim(cleancompany2), trim(cleancompany1), 1) > 0)));
END;

NameAddr_Subname_Matches := join(Company_Match_Dist_Reduced,
                                 Company_Match_Dist_Reduced, 
						   left.zip = right.zip and
                                   left.prim_name = right.prim_name and
                                   left.prim_range = right.prim_range and
                                   left.match_branch_unit = right.match_branch_unit and
                                   left.match_geo_city = right.match_geo_city and
 						     left.bdid > right.bdid and
                                   CompanyMatchSubname(left.company_name,
                                                       right.company_name,
											10,
											0.65),
                                 MatchBH(left, right, 6),
                                 local);

NameAddr_Subname_Matches_Dedup := dedup(NameAddr_Subname_Matches, new_rid, old_rid, all);

count(NameAddr_Subname_Matches_Dedup);
						   
// Get new subname matches
Subname_Matches := join(NameAddr_Matches_Dedup,
                        NameAddr_Subname_Matches_Dedup,
				    left.new_rid = right.new_rid and
				    left.old_rid = right.old_rid,
				    transform(Business_Header.Layout_PairMatch, self := right),
				    right only,
				    hash);
				    
count(Subname_Matches);

// check for previous error case
output(Subname_Matches(new_rid in [156785600,77679031] or old_rid in [156785600,77679031]));

// Get a sample
bhb := Business_Header.File_Business_Header_Best;

Subname_Match_Sample := enth(Subname_Matches, 500);

layout_subname_match := record
unsigned6 bdid1 := 0;
string120 company_name1 := '';
unsigned6 bdid2 := 0;
string120 company_name2 := '';
end;

Subname_Sample1 := join(bhb,
                        Subname_Match_Sample,
				    left.bdid = right.old_rid,
				    transform(layout_subname_match,
				              self.bdid1 := left.bdid,
						    self.company_name1 := left.company_name,
						    self.bdid2 := right.new_rid),
				    lookup);
				    
Subname_Sample2 := join(bhb,
                        Subname_Sample1,
				    left.bdid = right.bdid2,
				    transform(layout_subname_match,
						    self.company_name2 := left.company_name,
						    self := right),
				    lookup);
				    
output(Subname_Sample2, all);

// Append group ids and count how many are in different groups
layout_group_match := record
unsigned6 bdid1;
unsigned6 group_id1 := 0;
unsigned6 bdid2;
unsigned6 group_id2 := 0;
end;

bhg := Business_Header.File_Super_Group;

Subname_GroupID1 := join(bhg,
                         Subname_Matches,
					left.bdid = right.old_rid,
					transform(layout_group_match,
					          self.bdid1 := right.old_rid,
							self.group_id1 := left.group_id,
							self.bdid2 := right.new_rid),
					hash);
					
Subname_GroupID2 := join(bhg,
                         Subname_GroupID1,
					left.bdid = right.bdid2,
					transform(layout_group_match,
							self.group_id2 := left.group_id,
							self := right),
					hash);

count(Subname_GroupID2);
count(Subname_GroupID2(group_id1 = group_id2));
count(Subname_GroupID2(group_id1 <> group_id2));

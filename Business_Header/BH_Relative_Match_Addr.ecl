import ut, Advo;

EXPORT BH_Relative_Match_Addr(

	 dataset(Layout_Business_Header_Temp)			pBH_Basic_Match_ForRels		= BH_Basic_Match_ForRels	()
	,dataset(Advo.Layouts.Layout_Common_Out)	pAdvoBase									= Advo.Files().base.businessheader
	,string																		pPersistname							= persistnames().BHRelativeMatchAddr													
	,boolean																	pShouldRecalculatePersist	= true													

) :=
function

// Initialize match file
BH_File := pBH_Basic_Match_ForRels;

//Identify which addresses are multi 
Multi_Advo := pAdvoBase(rec_type='H');

LayoutMultiAddr := record
  Business_Header.File_Business_Header.prim_name;
  Business_Header.File_Business_Header.predir;
  Business_Header.File_Business_Header.prim_range;
  Business_Header.File_Business_Header.addr_suffix;
  Business_Header.File_Business_Header.zip;
  String2 rec_type;
end;

LayoutMultiAddr BuildMulitAddr(Advo.Layouts.Layout_Common_Out L) := TRANSFORM
  self.prim_name := L.prim_name;
  self.predir := L.predir;
	self.prim_range := L.prim_range;
	self.addr_suffix := L.addr_suffix;
	self.zip := (unsigned3) L.zip;
	self.rec_type := L.rec_type;
end;

Multi_Addr := PROJECT(Multi_Advo, BuildMulitAddr(LEFT));
InitDistMultiAddr := distribute(Multi_Addr, HASH32(zip, trim(prim_name), trim(prim_range)));
DistMultiAddr := dedup(sort(InitDistMultiAddr, prim_name, predir, prim_range, addr_suffix, zip, local), prim_name, predir, prim_range, addr_suffix, zip, local);

Layout_Business_Header_Temp InitMatchFile(Layout_Business_Header_Temp L) := transform
  self := L;
end;

// Eliminate those BHs with invalid addresses
Addr_Match_Init := project(BH_File(zip<>0, prim_name <> '', prim_name not in Bad_Address_List,
                              (integer)prim_range <> 0 or 
                                 (prim_name[1..3] in ['RR ', 'HC '] and
                                 (integer)(prim_name[4..LENGTH((string)prim_name)]) <> 0) and
																 (integer)sec_range <> 0), //only RR and HC if valid sr
                              InitMatchFile(left));

// Add the address type to the BH record
LayoutBusinessHeaderWithType := record
  string2 rec_type;
	BH_File;
end;

LayoutBusinessHeaderWithType MatchMulti(Layout_Business_Header_Temp L, 
                                        LayoutMultiAddr R) := transform
  self.rec_type := R.rec_type;
  self := L;
end;

DistAddrMatchInit := distribute(Addr_Match_Init, HASH32(zip, trim(prim_name), trim(prim_range)));
Addr_Match_Init_Type := JOIN(DistAddrMatchInit,
                     DistMultiAddr, 
										 left.zip = right.zip and
                     left.prim_name = right.prim_name and
										 left.predir = right.predir and 
                     left.prim_range = right.prim_range and
										 left.addr_suffix = right.addr_suffix,
                     MatchMulti(left, right),
										 LEFT OUTER,
										 local);

//Reduce the dataset to just those fields required to match via addr
Layout_BH_Match := record
  unsigned6 bdid;             // Seisint Business Identifier
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  unsigned3 zip;
  string2 rec_type;
end;

Layout_BH_Match InitMatch(LayoutBusinessHeaderWithType L) := transform
  self := L;
end;

Addr_Match_prelim := project(Addr_Match_Init_Type, InitMatch(left));

Business_Header.Layout_Relative_Match MatchBH(Layout_BH_Match L, Layout_BH_Match R) := transform
  self.bdid1 := L.bdid;
  self.bdid2 := R.bdid;
  self.match_type := 'AD';
end;

Addr_Match_Dedup := dedup(Addr_Match_prelim, zip, prim_range, prim_name, bdid, all);
Addr_Match_Dist := distribute(Addr_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));
ut.MAC_Split_Withdups_Local(Addr_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 500, Addr_Match_Dist_Reduced, Addr_Match_Remainder)

// Identify those bdids matching via addr
Addr_Matches := JOIN(Addr_Match_Dist_Reduced,
                     Addr_Match_Dist_Reduced, 
										 left.zip = right.zip and
                     left.prim_name = right.prim_name and
                     ((integer)left.prim_range <> 0 and left.prim_range = right.prim_range) and
										 left.bdid > right.bdid and
										 left.sec_range = right.sec_range  and //must have valid match on sr
										 (left.rec_type != 'H' or (left.sec_range != '' AND left.sec_range = right.sec_range ))//and if highrise, sr must be populated and match
                     ,MatchBH(left, right),
                     local);
Addr_Matches_Dedup := dedup(Addr_Matches, bdid1, bdid2, all);

BH_Relative_Match_Addr_persisted := Addr_Matches_Dedup 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Match_Addr_persisted
																										, persists().BHRelativeMatchAddr
									);
return returndataset;

end;
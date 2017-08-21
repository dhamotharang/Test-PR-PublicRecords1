import ut, Advo;

export BH_Relative_Group_Addr(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_ForRels			= BH_Basic_Match_ForRels	()
	,dataset(Advo.Layouts.Layout_Common_Out)	pAdvoBase									= Advo.Files().base.built()
	,string																pPersistname								= persistnames().BHRelativeGroupAddr													
	,boolean															pShouldRecalculatePersist		= true													

) := FUNCTION
 
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
  self.prim_range := if((integer)l.prim_range <> 0, l.prim_range, l.sec_range); //make sec range group if no prim name
  self := L;
end;

Addr_Match_Prelim := project(Addr_Match_Init_Type, InitMatch(left));

Addr_Match_Dedup := dedup(Addr_Match_Prelim, zip, prim_range, prim_name, bdid, all);

Addr_Match_Dist := distribute(Addr_Match_Dedup, hash(zip, trim(prim_name), trim(prim_range)));

ut.MAC_Split_Withdups_Local(Addr_Match_Dist, hash(zip, trim(prim_name), trim(prim_range)), 4000, Addr_Match_Dist_Reduced, Addr_Match_Remainder)

Layout_Addr_Match_Group := record
  unsigned6 group_id;
  Layout_BH_Match;
end;

Layout_Addr_Match_Group InitRemainder(Layout_BH_Match l) := transform
  self.group_id := l.bdid;
  self := l;
end;

Addr_Match_Remainder_Init := project(Addr_Match_Remainder, InitRemainder(left));

Addr_Match_Remainder_Sort := sort(Addr_Match_Remainder_Init(rec_type != 'H'), zip, prim_name, prim_range, group_id, local);
Addr_Match_Remainder_Grp := group(Addr_Match_Remainder_Sort, zip, prim_name, prim_range, local);

Addr_Match_Remainder_Multi_Sort := sort(Addr_Match_Remainder_Init(rec_type = 'H' and sec_range != ''), zip, prim_name, prim_range, sec_range, group_id, local);
Addr_Match_Remainder_Multi_Grp := group(Addr_Match_Remainder_Multi_Sort, zip, prim_name, prim_range, sec_range, local);

Layout_Addr_Match_Group SetGroupId(Layout_Addr_Match_Group l, Layout_Addr_Match_Group r) := transform
  self.group_id := if(l.group_id = 0, r.group_id, l.group_id);
  self := r;
end;

Addr_Match_Remainder_Iter := group(iterate(Addr_Match_Remainder_Grp, SetGroupId(left, right)));
Addr_Match_Remainder_Multi_Iter := group(iterate(Addr_Match_Remainder_Multi_Grp, SetGroupId(left, right)));

Addr_Match_Remainder_Iter_Full := Addr_Match_Remainder_Iter + Addr_Match_Remainder_Multi_Iter;

Business_Header.Layout_Relative_Match FormatRelativeGroup(Layout_Addr_Match_Group L) := transform
  self.match_type := 'AD';
  self.bdid1 := l.group_id;
  self.bdid2 := l.bdid;
end;

Addr_Relative_Group := project(Addr_Match_Remainder_Iter_Full, FormatRelativeGroup(left));

BH_Relative_Group_Addr_persisted := Addr_Relative_Group 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Group_Addr_persisted
																										, persists().BHRelativeGroupAddr
									);
return returndataset;

end;
Import Lending_Tree, ut, property, header, didville, did_add, Header_Slimsort, WatchDog, AID, lib_stringlib, NID, lib_DataLib, address;

/*RUN as below if longform and shortform layouts are same:
LongForm: Lending_Tree.Build_LT_ShortForm(â€˜LngForm_YYYYMMDDâ€™);
ShortForm: Lending_Tree.Build_LT_ShortForm(â€˜SrtForm_YYYYMMDDâ€™);

As update date is used for processid and its used as UpdateDate[9..16] for date.
*/


Export  Build_LT_ShortForm(String UpdateDate) := Function
#option('multiplePersistInstances',FALSE);
// Mod := Lending_Tree.Lay_ShortForm;
//DateConversion Function for Complete Date
fmt_dateMMDDYYYY(string s) := FUNCTION
	Pos:= If(StringLib.stringfind(s,' ',1) > 0, StringLib.stringfind(s,' ',1), 0);
	s1 := s[1..pos];
	regex := '([0-9]+)/([0-9]+)/([0-9]{4})(.*)';
	month := Regexfind(regex, s, 1);
	day := Regexfind(regex, s, 2);
	year := Regexfind(regex, s, 3);

Date := If(Length(Trim(month)) = 1, '0' + Trim(month), month) + 
			 If(Length(Trim(day)) = 1, '0' + Trim(day), day) +
			 year;
Return Date;
End;

// AID  Code:
Lay_ShortForm.Lay_AidPrep prepAID(Lending_Tree.File_LT_Input_Raw.infile L) := Transform

		Self.prep_addr_line1 := ut.fn_addr_clean_prep(StringLib.StringCleanSpaces( trim(l.AddressLine1, Left, Right)), 'first');
		Self.prep_addr_line_last	:=	ut.fn_addr_clean_prep(StringLib.StringCleanSpaces(if( trim(l.City, Left, Right) !='',
																																						  trim(l.City, Left, Right) + ', ' + trim(l.State, Left, Right) + ' ' +  trim(l.PostalCode, Left, Right),
																																						  trim(l.State, Left, Right) + ' ' + trim(l.PostalCode, Left, Right))), 'last');	
		Self := L;
		Self := [];
end;

preppedAID := project(Lending_Tree.File_LT_Input_Raw.infile, prepAID(Left));
// Clean address using the AID macro
HasAddress := trim(preppedAID.prep_addr_line1, Left, Right) <> '' and trim(preppedAID.prep_addr_line_last, Left, Right) <> '';
								
dWith_address	:= preppedAID(HasAddress);
dWithout_address	:= preppedAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, RawAid, dwithAID, lFlags);
withAID := dwithAID;

// Populate the clean address fields from the AID cleaned address Records
Lay_ShortForm.Layout_Cleaned	popCleanAddr(withAID L) := Transform		
		Self.Cln_CompleteDate := fmt_dateMMDDYYYY(L.CompleteDate); 
		Self.prim_range := L.aidwork_acecache.prim_range;
		Self.predir := L.aidwork_acecache.predir;
		Self.prim_name := L.aidwork_acecache.prim_name;
		Self.addr_suffix := L.aidwork_acecache.addr_suffix;
		Self.postdir := L.aidwork_acecache.postdir;
		Self.unit_desig := L.aidwork_acecache.unit_desig;
		Self.sec_range := L.aidwork_acecache.sec_range;
		Self.p_city_name := L.aidwork_acecache.p_city_name;
		Self.v_city_name := L.aidwork_acecache.v_city_name;
		Self.st := L.aidwork_acecache.st;
		Self.zip5 := L.aidwork_acecache.zip5;
		Self.zip4 := L.aidwork_acecache.zip4;
		Self.cart := L.aidwork_acecache.cart;
		Self.cr_sort_sz := L.aidwork_acecache.cr_sort_sz;
		Self.lot := L.aidwork_acecache.lot;
		Self.lot_order := L.aidwork_acecache.lot_order;
		Self.dbpc := L.aidwork_acecache.dbpc;
		Self.chk_digit := L.aidwork_acecache.chk_digit;
		Self.rec_type := L.aidwork_acecache.rec_type;
		Self.county := L.aidwork_acecache.county;
		Self.geo_lat := L.aidwork_acecache.geo_lat;
		Self.geo_long := L.aidwork_acecache.geo_long;
		Self.msa := L.aidwork_acecache.msa;
		Self.geo_blk := L.aidwork_acecache.geo_blk;
		Self.geo_match := L.aidwork_acecache.geo_match;
		Self.err_stat := L.aidwork_acecache.err_stat;
		Self.RawAid := L.aidwork_acecache.cleanaid;
		Self := L;		 
		Self := [];
end;

// Add back the filtered blank address Records to the rest of the file
dsAid := project(withAID, popCleanAddr(Left)) + 
										project(dWithout_address, Transform(Lay_ShortForm.Layout_Cleaned, Self := Left, Self := [])) : persist('~Persist::LendingTree_'+updateDate+'::Aid');

// BorrowerName NID
NID.Mac_CleanParsedNames(dsAid, Cln_dsNid, firstname:=BorrowerFirstName, 
																				middlename:=BorrowerMiddleName,
																				lastname:=BorrowerLastName, 
																				namesuffix:=Brtemp_suffix,
																				includeInRepository := true, 
																				normalizeDualNames := true);
clnd_dsNid := Cln_dsNid;
dsNid_cln := Project(clnd_dsNid, Transform(Lay_ShortForm.Layout_Cleaned, Self.Borrower_nid := Left.Nid; 
																							Self.clnBorrower_title := Left.cln_title;
																							Self.clnBorrower_fname := Left.cln_fname;
																							Self.clnBorrower_mname := Left.cln_mname;
																							Self.clnBorrower_lname := Left.cln_lname;
																							Self.clnBorrower_name_suffix := Left.cln_suffix;
																							Self.clnBorrower_name_type := Left.nametype;
																							Self.clnBorrower_fullname := Left.fullname;
																							Self.BorrowerPreferredFname := If(DataLib.PreferredFirstNew(Self.clnBorrower_fname, true) <> '', 
																																							ut.fnTrim2Upper(DataLib.PreferredFirstNew(Self.clnBorrower_fname, true)), '');
																							Self := Left; Self := [];)) : persist('~Persist::LendingTree_'+updateDate+'::Nid');


invalid_ssns := ['', '000000000', '111111111', '123456789', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '987654321', '999999999'];
dsNid := dsNid_cln(UnformattedBorrowerSSN not in invalid_ssns);
dsNid0 := dsNid_cln(UnformattedBorrowerSSN in invalid_ssns);


 // Appending Did with BorrowerName, SSN and address for valid SSN's
matchset := ['A', 'Z', 'S'];
did_Add.MAC_Match_Flex(dsNid, matchset,
					UnformattedBorrowerSSN, 
					'', clnBorrower_fname, clnBorrower_mname, clnBorrower_lname, clnBorrower_name_suffix,
					prim_range, prim_name, sec_range, zip5, st, '',
					BorrowerDid,
					Lay_ShortForm.Layout_Cleaned,
					true, BorrowerDid_Score,
					75,
					dsBrDid);
dsDid := dsBrDid : persist('~Persist::LendingTree_'+updateDate+'::dsDid');

///////////////////////////////////////////////////////////////////////////
dsWithDid := dsDid(BorrowerDid <> 0);
dsWoDid := dsDid(BorrowerDid = 0);


distNid0 := Distribute(dsNid0, Hash32(zip5, prim_name, prim_range));
distLtDeeds := distribute(Lending_Tree.File_LT_Deeds(prop_zip <> '' and prop_prim_name  <> '' and lname <> ''), Hash32(prop_zip, prop_prim_name, prop_prim_range)):Persist('~Persist::LendingTree_'+updateDate+'::file_lt_deeds'); // // distribute on File_LT_Deeds file
output(choosen(distLTDeeds,100));
distDid := distribute(dsWithDid(zip5 <>'' or prim_name <>''), Hash32(zip5, prim_name, prim_range)); // distribute on with did file
distWoDid := distribute(dsWoDid(zip5 <>'' or prim_name <>''), Hash32(zip5, prim_name, prim_range)); // distribute on without did file

Lay_ShortForm.Lay_MatchScore j_stuff (Lending_Tree.Layout_LT_Deeds L, Lay_ShortForm.Layout_Cleaned R) := Transform
    Self.nd_mortgage_loan_type_code := L.second_mortgage_loan_type_code;
    Self.nd_deed_type := L.second_deed_type;
    Self := L;
	Self := R;
	Self := [];
end;

////////////
 // ---- dsNid
////////////

// Deeds join with did and address fields for with Did file
DeedJoinWDid := join(distLtDeeds, distDid, Left.prop_zip = Right.zip5 
													and Left.prop_prim_name = Right.prim_name 
													and Left.prop_prim_range = Right.prim_range 
													and Left.did = Right.BorrowerDid, 
													j_stuff(Left,Right), inner, local);
// Deeds join with last name and address fields for with Did file
DeedJoinwwoDid := join(distLtDeeds, distDid, Left.prop_zip = Right.zip5 
													and Left.prop_prim_name = Right.prim_name 
													and Left.prop_prim_range = Right.prim_range 
													and  trim(ut.fnTrim2Upper(Left.lname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_lname), Left, Right)
													and (trim(ut.fnTrim2Upper(Left.fname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_fname), Left, Right)
													or trim(ut.fnTrim2Upper(Left.pref_Fname), Left, Right) = trim(ut.fnTrim2Upper(Right.BorrowerPreferredFname), Left, Right)),
													j_stuff(Left,Right), inner, local);

JoinBoth := Join(DeedJoinWDid, DeedJoinwwoDid, Left.BorrowerDid = Right.BorrowerDid, Right only);
// Deeds join with last name and address fields for without Did file
DeedJoinWoDid := join(distLtDeeds, distWoDid, Left.prop_zip = Right.zip5 
													and Left.prop_prim_name = Right.prim_name 
													and Left.prop_prim_range = Right.prim_range 
													and trim(ut.fnTrim2Upper(Left.lname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_lname), Left, Right) 
													and (trim(ut.fnTrim2Upper(Left.fname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_fname), Left, Right)
													or trim(ut.fnTrim2Upper(Left.pref_Fname), Left, Right) = trim(ut.fnTrim2Upper(Right.BorrowerPreferredFname), Left, Right)),
													j_stuff(Left, Right), inner, local);

fAfterJoinDeed0 := DeedJoinWDid + JoinBoth + DeedJoinWoDid;


/////////////
 // ---- dsNid0
/////////////

DeedJoinNid0 := join(distLtDeeds, distNid0, Left.prop_zip = Right.zip5 
													and Left.prop_prim_name  = Right.prim_name 
													and Left.prop_prim_range = Right.prim_range 
													and trim(ut.fnTrim2Upper(Left.lname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_lname), Left, Right) 
													and (trim(ut.fnTrim2Upper(Left.fname), Left, Right) = trim(ut.fnTrim2Upper(Right.clnBorrower_fname), Left, Right)
													or trim(ut.fnTrim2Upper(Left.pref_Fname), Left, Right) = trim(ut.fnTrim2Upper(Right.BorrowerPreferredFname), Left, Right)),
													j_stuff(Left,Right), inner, local);

fAfterJoinDeed := fAfterJoinDeed0 +  DeedJoinNid0 : persist('~Persist::LendingTree_'+updateDate+'::fAfterJoinDeed');


lkp_matchList := Lending_Tree.File_LT_Input_Raw.matchList;	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Lay_ShortForm.Lay_MatchScore xMchJoin(Lay_ShortForm.Lay_MatchScore L, Lay_ShortForm.Lay_matchList R) := Transform
		Self.mch_score := If(trim( ut.fnTrim2Upper(L.lender_last_name), left, right) = trim(ut.fnTrim2Upper(R.lender_last_name), left, right),101,L.borrowerdid_score);
		//Self.mch_score := If(trim( ut.fnTrim2Upper(L.lender_last_name), left, right) = trim(ut.fnTrim2Upper(R.lender_last_name), left, right),101);
		Self := L;
		Self := [];
		
End;

mch_join := join(Distribute(fAfterJoinDeed(lender_last_name<>''), hash32(LenderName)), lkp_matchList,
																	trim(ut.fnTrim2Upper(Left.LenderName), left, right) = trim(ut.fnTrim2Upper(Right.LT_Referral), left, right), 
																	xMchJoin(Left, Right), Left Outer, Lookup,Local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// lkp_nomatchList := Lending_Tree.File_LT_Input_Raw.nomatchList;
// Lay_ShortForm.Lay_MatchScore xnoMchJoin(Lay_ShortForm.Lay_MatchScore L, Lay_ShortForm.Lay_nomatchList R) := Transform
		// Self.mch_score := If(trim( ut.fnTrim2Upper(L.lender_last_name), left, right) = trim(ut.fnTrim2Upper(R.lender_last_name), left, right),0, L.mch_score);
		// Self := L;
		// Self := [];
// End;

// no_mch_join:= join(Distribute(mch_join(lender_last_name<>''), hash32(LenderName)), lkp_nomatchList,
																					 // trim(ut.fnTrim2Upper(Left.LenderName), left, right) = trim(ut.fnTrim2Upper(Right.doNotMatch), left, right), 
																					 // xnoMchJoin(Left, Right), Left Outer, Lookup,Local);

fnMatchScore := mch_join(mch_score >= 75);

MatchFile_DtFilter := fnMatchScore((Integer)Recording_date_yyyymmdd > (Integer) Cln_CompleteDate);
//outputting in vendor required format
tempLay := Record
integer process_id := 0;
Lay_ShortForm.OutLayout;
End;

MatchFile := Project(MatchFile_DtFilter, tempLay);
SrtFile := Sort(MatchFile,QFormUID,mortgage_date);
DedupFile := Dedup(MatchFile,QFormUID);
ut.MAC_Sequence_Records(DedupFile, process_id, Seq_MatchFile);
FinalOutFile := Project(Seq_MatchFile, Transform(Lay_ShortForm.OutLayout, Self.ProcessId := updateDate[9..16]+'_'+intformat(Left.process_id,6,1), Self := Left));
//Result := output(FinalOutFile, , '~thor400::LendingtTree_'+UpdateDate+'OutFile.CSV' , CSV(Heading(single), Separator('\t')), overwrite);
Result := output(FinalOutFile, , '~thor400::LendingtTree_'+UpdateDate+'OutFile.CSV' , CSV(Heading(single), Quote('"'), Separator(',')), overwrite);

Return Result;
End;

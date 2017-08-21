Import didville, did_add, Header_Slimsort, ut, WatchDog, AID, lib_stringlib, NID, Address;

Export Proc_Build_Base := Function
//APPENDING NID
Lay_clnName_InFile := Record
		CellPhone_Owners.Layout.In_CellPhoneOwners;
		// clean name fields
		String50	FirstName;
		String1	MiddleName;
		String100	SurName;
		String5 NameSuffix;
End;

File_ClnName := Project(CellPhone_Owners.File_In_CellPhoneOwners, Transform(Lay_clnName_InFile, 
																											Self.Date_First_Seen := Left.Appended_First_Date;
																											Self.Date_Last_Seen :=  Left.Appended_Last_Date;
																											Self.Vendor_First_Reported := Left.SubfileFiledate[1..8];
																											Self.Vendor_Last_Reported := Left.SubfileFiledate[1..8];
																											Self.FirstName := Left.Appended_First_Name;
																											Self.MiddleName := Left.Appended_Middle_Name;
																											Self.SurName := Left.Appended_Surname;
																											Self := Left;
																											Self := [];));
																						
NID.Mac_CleanParsedNames(File_ClnName, cln_NameFile, firstname:=FirstName, 
																									middlename:=MiddleName, 
																									lastname:=SurName, 															
																									namesuffix:=NameSuffix,
																									includeInRepository := true, 
																									normalizeDualNames := true);
ClnName_PhoneOwner := cln_NameFile;
LayNid_CellPhoneOwners_tmp := Record
	  CellPhone_Owners.Layout.In_CellPhoneOwners;
	  string1 nametype_nm;
	  string5 cln_title_nm;
	  string20 cln_fname_nm;
	  string20 cln_mname_nm;
	  string20 cln_lname_nm;
	  string5 cln_suffix_nm;
End;

LayNid_CellPhoneOwners_tmp xform_name(ClnName_PhoneOwner L) := Transform
Self.nametype_nm := L.nametype;
Self.cln_title_nm := L.cln_title;
Self.cln_fname_nm := L.Cln_fname;
Self.cln_mname_nm:= L.Cln_mname;
Self.cln_lname_nm:= L.Cln_lname;
Self.cln_suffix_nm := L.Cln_suffix;
Self := L;
Self := [];
End;
File_NID_Name := Project(ClnName_PhoneOwner, xform_name(Left));

NID.Mac_CleanFullNames (File_NID_Name, cln_NameCompFile, field := appended_company_name, includeInRepository := true, normalizeDualNames := true);
File_NID_Comp := cln_NameCompFile;

CellPhone_Owners.Layout.NID_CellPhoneOwners xform_comp(File_NID_Comp L) := Transform
Self.nametype := If(L.nametype_nm in ['', 'I'], L.nametype, L.nametype_nm);
Self.cln_title := If(L.cln_title_nm = '', L.cln_title, L.cln_title_nm);
Self.cln_fname :=If( L.Cln_fname_nm = '',L.Cln_fname, L.Cln_fname_nm);
Self.cln_mname := If(L.Cln_mname_nm = '', L.Cln_mname, L.Cln_mname_nm);
Self.cln_lname :=If( L.Cln_lname_nm = '', L.Cln_lname, L.Cln_lname_nm);
Self.cln_suffix := If(L.Cln_suffix_nm= '', L.Cln_suffix, L.Cln_suffix_nm);
Self := L;
Self := [];
End;

File_NID_CellPhoneOwners := Project(File_NID_Comp, xform_comp(Left)) ;

//APPENDING AID
Lay_PrepAID_InFile := Record
 			Unsigned8 raw_aid := 0;  
			CellPhone_Owners.Layout.NID_CellPhoneOwners;
			string100   prep_addr_line1 := '';
			string50	prep_addr_line_last := '';
End;

Lay_PrepAID_InFile prepAID(ClnName_PhoneOwner L) := transform
		prep_addrLine1 := StringLib.StringCleanSpaces( trim(L.Appended_Street_Number,left,right) + ' ' +
																									trim(L.Appended_Pre_Directional,left,right) + ' ' +
																									trim(L.Appended_Street_Name,left,right) + ' ' +
																									trim(L.Appended_Street_Suffix,left,right) + ' ' +
																									trim(L.Appended_Post_Directional,left,right) + ' ' +
																									trim(L.Appended_Unit_Designator,left,right) + ' ' +
																									trim(L.Appended_Unit_Number,left,right));
		
		// self.prep_addr_line1 :=prep_addrLine1;
		self.prep_addr_line1 := ut.fn_addr_clean_prep(if(prep_addrLine1 = '', '', prep_addrLine1), 'first');
		prep_addr_LineLast	:=	StringLib.StringCleanSpaces(if(trim(L.Appended_City,left,right) !='',
																													trim(L.Appended_City,left,right) + ', ' + trim(L.Appended_State_Code,left,right) + ' ' + trim(L.Appended_Zip_Code,left,right),
																													trim(L.Appended_State_Code,left,right) + ' ' + trim(L.Appended_Zip_Code,left,right)));	
		// self.prep_addr_line_last	:=	prep_addr_LineLast;
		self.prep_addr_line_last	:=	ut.fn_addr_clean_prep(If(prep_addr_LineLast = '', '', prep_addr_LineLast), 'last');
		self := L;
		Self := [];
end;					
preppedAID := project(ClnName_PhoneOwner,prepAID(left));

HasAddress := trim(preppedAID.prep_addr_line1,left,right) != '' and trim(preppedAID.prep_addr_line_last,left,right) != '';
dWith_address	:= preppedAID(HasAddress);
dWithout_address	:= preppedAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
withAID := dwithAID;

// Populate the clean address fields from the AID cleaned address records
CellPhone_Owners.Layout.AID_CellPhoneOwners	popCleanAddr(withAID l) := transform		
	self.street_pre_direction		:= L.aidwork_acecache.predir;
	self.street_post_direction		:= L.aidwork_acecache.postdir;
	self.street_number				:= L.aidwork_acecache.prim_range;
	self.street_name					:= L.aidwork_acecache.prim_name;
	self.street_suffix			   		 := L.aidwork_acecache.addr_suffix;
	self.unit_number					:= L.aidwork_acecache.sec_range;
	self.unit_designation				:= L.aidwork_acecache.unit_desig;
	self.city			            := L.aidwork_acecache.p_city_name;
	Self.v_city_name 		:= L.aidwork_acecache.v_city_name;	
	self.state						:= L.aidwork_acecache.st;
	self.zip5						:= L.aidwork_acecache.zip5;
	self.zip4						:= L.aidwork_acecache.zip4;	
	Self.cart					 	:= L.aidwork_acecache.cart;
	Self.cr_sort_sz 			:= L.aidwork_acecache.cr_sort_sz;
	Self.lot 						:= L.aidwork_acecache.lot;
	Self.lot_order 			:= L.aidwork_acecache.lot_order;
	Self.dbpc 					:= L.aidwork_acecache.dbpc;
	Self.chk_digit 				:= L.aidwork_acecache.chk_digit;
	Self.rec_type 				:= L.aidwork_acecache.rec_type;
	Self.county 				:= L.aidwork_acecache.county;
	Self.geo_lat				 	:= L.aidwork_acecache.geo_lat;
	Self.geo_long 				:= L.aidwork_acecache.geo_long;
	Self.msa 						:= L.aidwork_acecache.msa;
	Self.geo_blk				:= L.aidwork_acecache.geo_blk;
	Self.geo_match 			:= L.aidwork_acecache.geo_match;
	Self.err_stat 				:= L.aidwork_acecache.err_stat;
	Self.raw_aid 				:=  L.aidwork_recordid;
	self  := L;		 
end;

ClnAidAddr := project(withAID, popCleanAddr(left));
NoAddr := project(dWithout_address,transform(CellPhone_Owners.Layout.AID_CellPhoneOwners, self := left, self := []));

// Add back the filtered blank address records to the rest of the file
dAID_Cleaned_Addr := ClnAidAddr + NoAddr;
File_AID_CellPhoneOwners := sort(distribute(dAID_Cleaned_Addr, hash32(Appended_Phone, street_number, street_name, city, state, zip5)), record, local);

//File_AID_CellPhoneOwners := Project(File_NID_CellPhoneOwners, Transform(CellPhone_Owners.Layout.AID_CellPhoneOwners, Self := Left; Self := [];));
//APPENDING DID
Lay_PrepDID_InFile := Record
			CellPhone_Owners.Layout.AID_CellPhoneOwners;
			temp_suffix := '';
End;

Lay_PrepDID_InFile trans(File_AID_CellPhoneOwners L) := transform
	self.Appended_Phone := If(L.Appended_Phone<>'', stringlib.stringfilter(L.Appended_Phone,'0123456789'), '');
	self := L;
	end;
allData      := project(File_AID_CellPhoneOwners, trans(left));

matchset_did := ['A','P'];
did_Add.MAC_Match_Flex(allData,matchset_did,
												'',
												'',
												cln_fname,
												cln_mname,
												cln_lname,
												cln_suffix,
												street_number,
												street_name,
												unit_number,
												zip5,
												state,
												Appended_Phone,
												did,
												CellPhone_Owners.Layout.DID_CellPhoneOwners,
												true, did_score,
												75,
												dsWithADL);
File_DID_CellPhoneOwners := dsWithADL;


//APPENDING BDID
Lay_BDID_CellPhoneOwners_slim := Record
		integer8 BDID := 0;
		integer8	BDID_Score := 0;
		CellPhone_Owners.Layout.DID_CellPhoneOwners;
		String500 cln_Company;
End;

Lay_BDID_CellPhoneOwners_slim PrepBDID_InFile(File_DID_CellPhoneOwners L) := Transform
		Self.cln_Company := If(L.nametype = 'B' and L.Appended_Company_Name = '', 
															StringLib.StringCleanSpaces(L.Appended_First_Name+ ' ' + L.Appended_Surname),
															If(L.Appended_Company_Name <> '', StringLib.StringCleanSpaces(L.Appended_Company_Name), ''));
		Self := L;
		Self := [];
End;

File_PrepBDID := Project(File_DID_CellPhoneOwners, PrepBDID_InFile(Left));
matchset_bdid	:=	['A','P'];
Business_Header_SS.MAC_Match_Flex(File_PrepBDID, matchset_bdid,
											 cln_Company, Street_number, Street_name,  Zip5, Unit_number, State, Appended_Phone, foo,
											 BDID,
											 Lay_BDID_CellPhoneOwners_slim,
											 true, BDID_Score, //these should default to zero in definition
											 rFile_BDID_CellPhoneOwners, , 75,//dids with a score below threshold will be dropped here.
											 );
File_BDID_CellPhoneOwners	:=	PROJECT(rFile_BDID_CellPhoneOwners, CellPhone_Owners.Layout.BDID_CellPhoneOwners);

// preRollup_CellPhoneOwners := File_BDID_CellPhoneOwners; //1st update
preRollup_CellPhoneOwners := File_BDID_CellPhoneOwners + CellPhone_Owners.File_Base_CellPhoneOwners; //from 2nd update

//ROLLUP CODE
Srt_dsProcessed := Sort(Distribute(preRollup_CellPhoneOwners, Hash32(Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name, 
																																			Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number, 
																																			Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
																																			Appended_Phone_Score, Prepaid_Phone_Flag)), 
																	Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name,
																	Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number,
																	Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
																	Appended_Phone_Score, Prepaid_Phone_Flag, Local);

CellPhone_Owners.Layout.BaseLayout xRollupDea(CellPhone_Owners.Layout.BaseLayout L, CellPhone_Owners.Layout.BaseLayout R) := Transform
		Self.Date_First_Seen := If ((integer)L.Date_First_Seen < (integer)R.Date_First_Seen, L.Date_First_Seen, R.Date_First_Seen);		
		Self.Date_Last_Seen := If ((integer)L.Date_Last_Seen > (integer)R.Date_Last_Seen, L.Date_Last_Seen, R.Date_Last_Seen);
		Self.Vendor_first_reported := If((integer) L.Vendor_First_reported < (integer)R.Vendor_First_reported, L.Vendor_First_reported, R.Vendor_First_reported);
		Self.Vendor_Last_reported := If((integer) L.Vendor_Last_reported > (integer)R.Vendor_Last_reported, L.Vendor_Last_reported, R.Vendor_Last_reported);
		Self := L;
End;
 RollupProcessed	:= rollup(Srt_dsProcessed, xRollupDea(left,right), 
																			Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name, 
																			Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number, 
																			Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
																			Appended_Phone_Score, Prepaid_Phone_Flag, local);

Final_RollupProcess :=Dedup(Sort(Distribute(RollupProcessed, 
																				Hash32(Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name, 
																								Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number, 
																								Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
																								Appended_Phone_Score, Prepaid_Phone_Flag)),
															Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name,
															Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number, 
															Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
															Appended_Phone_Score, Prepaid_Phone_Flag, Local),
													Appended_First_Name, Appended_Middle_Name, Appended_Surname, Appended_Company_Name, 
													Street_pre_direction, Street_post_direction, Street_number, Street_name, Street_suffix, Unit_number, 
													Unit_designation, Zip5, Zip4, City, State, Appended_Phone, Appended_Phone_Type, Appended_Telco_Name,
													Appended_Phone_Score, Prepaid_Phone_Flag, Local);
// Result := output(Final_RollupProcess, ,'~thor_data400::base::CellPhoneOwners_'+thorlib.wuid(), __compressed__, overwrite);
// Return Result;

Return Final_RollupProcess;

End;
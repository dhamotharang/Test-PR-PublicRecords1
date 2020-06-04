Import didville, did_add, Header_Slimsort, ut, WatchDog, AID, lib_stringlib, Address, STD;

Export Proc_Build_Base(String Filedate) := Function

InFile := BadAddresses.Map_BadAddresses_Raw.File_SeqNum_in(~REGEXFIND('affected|completion',address,NOCASE) and trim(Address) <> ' '); 

Layouts.AID_prep xAid(InFile L) := Transform
		Self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(if(L.address = '', '', L.address), 'first');
		
		Self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(L.City
																					+	IF(L.City <> '',', ','') + L.state, 'last');
		Self := L;
		Self := [];
End;
File_PreAid := Project(InFile, xAid(Left));

unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
AID.MacAppendFromRaw_2Line(File_PreAid,
															Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, AID,
															rsCleanAID, lAIDFlags);
 Processed := rsCleanAID;


BadAddresses.Layouts.Lay_Base xAidConversion(Processed L) := transform
		Self.Status := 'C'; //might change from the 1st update thru Rollup
		Self.date_first_seen := L.Added_Date;
		Self.date_last_seen := L.Added_Date;
		Self.date_first_reported := filedate[1..8];
		Self.date_last_reported := filedate[1..8];
		Self.rawaid := L.aidwork_rawaid;
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
		Self.zip := L.aidwork_acecache.zip5;
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
		Self := L;
		Self := [];
End;

NewBase := Project(Processed, xAidConversion(Left));

Old_Base := Project(BadAddresses.File_BadAddresses_Base, Transform(BadAddresses.Layouts.Lay_Base, Self.Status := 'H'; Self := Left;));
AllBaseFiles := NewBase+Old_Base;

Srt_AllBaseFiles := Sort(Distribute(AllBaseFiles, Hash32(Address, City, Added_Date)),  Address, City, -Added_Date, Local);

BadAddresses.Layouts.Lay_Base xRollupDcf(BadAddresses.Layouts.Lay_Base L, BadAddresses.Layouts.Lay_Base R) := Transform
		Self.date_first_seen := If ((integer)L.date_first_seen < (integer)R.date_first_seen, L.date_first_seen, R.date_first_seen);		
		Self.date_last_seen := If ((integer)L.date_last_seen > (integer)R.date_last_seen, L.date_last_seen, R.date_last_seen);
		Self.date_first_reported := If ((integer)L.date_first_reported < (integer)R.date_first_reported, L.date_first_reported, R.date_first_reported);		
		dateLastReported := If ((integer)L.date_last_reported > (integer)R.date_last_reported, L.date_last_reported, R.date_last_reported);
		Self.date_last_reported :=dateLastReported;
		Self.Status := If((integer)filedate >= (integer)dateLastReported , 'C', 'H');
		Self := L;
End;
RollupBase	:= rollup(Srt_AllBaseFiles, xRollupDcf(left,right), Address, City, Added_Date, local );
Rollup_Base :=Dedup(Sort(Distribute(RollupBase, Hash32(Address, City, Added_Date)), Address, City, Added_Date, Local), Address, City, Added_Date, Local);
Return Rollup_Base;
End;
Import  ut, AID, DID_Add, header_slimsort, address, lib_StringLib, NID, DEA; 

Export Proc_Build_Preprocess(String Filedate) := Function
 NID.Mac_CleanFullNames (DEA.file_DEA_In, cln_File_Dea, field := Address1, includeInRepository := true, normalizeDualNames := true);
 NidFile_Dea := cln_File_Dea;
 
 // Drug Schedules:
DrugSchedules(String DrgSch ) := Function
		Ds1 := If(StringLib.stringfind(DrgSch,'1',1) > 0, '1', ' ');
		Ds22_2 := If(StringLib.stringfind(DrgSch,'22',1) > 0 or 
										StringLib.stringfind(DrgSch,'2',1) > 0 and ~StringLib.stringfind(DrgSch,'2N',1) > 0, '2', ' ');
		Ds2N := If(StringLib.stringfind(DrgSch,'2N',1) > 0, '2N', ' ');
		Ds33_3 := If(StringLib.stringfind(DrgSch,'33',1) > 0 or
										StringLib.stringfind(DrgSch,'3',1) > 0 and ~StringLib.stringfind(DrgSch,'3N',1) > 0, '3', ' ');
		Ds3N := If(StringLib.stringfind(DrgSch,'3N',1) > 0, '3N', ' ');
		Ds4 := If(StringLib.stringfind(DrgSch,'4',1) > 0, '4', ' ');
		Ds5 := If(StringLib.stringfind(DrgSch,'5',1) > 0, '5', ' ');
		
		Return StringLib.StringCleanSpaces(Ds1+ ' '+ Ds22_2 + Ds2N + ' ' +Ds33_3 + Ds3N + ' ' + Ds4 + ' ' + Ds5);
End;
DEA.Layout.AID_prep xDEA_ClnName(NidFile_Dea L) := Transform
		Self.date_first_reported := Filedate[1..8];				
		Self.date_last_reported := Filedate[1..8];		
		Self.fname :=L.cln_fname;
		Self.mname :=L.cln_mname;
		Self.lname :=L.cln_lname;
		Self.Name_suffix :=L.cln_suffix;
		Self.title :=L.cln_title;
		Self.Drug_Schedules := DrugSchedules(L.Drug_Schedules);
		
address_ := If(ut.isNumeric(L.address3[1]),  L.address3 + L.address4, L.address4);				
				
		Self.Append_Prep_Address_Situs			:=	address.fn_addr_clean_prep(if(address_ = '', '', address_), 'first');
		Self.Append_Prep_Address_Last_Situs	:=	address.fn_addr_clean_prep(L.Address5
																					+	IF(L.Address5 <> '',', ','') + L.state
																					+	' ' + L.Zip_Code, 'last');
		Self.is_company_flag := If(L.nameType = 'B', 1, 0);		
		Self.cname := If(L.NameType = 'B', StringLib.StringCleanSpaces(Stringlib.StringtoUpperCase(L.Address1)), if((unsigned)L.Address2 = 0, StringLib.StringCleanSpaces(Stringlib.StringtoUpperCase(L.Address2)), ''));
		Self := L;
		Self := [];
End;
File_Dea_PreAid := Project(NidFile_Dea, xDEA_ClnName(Left));

unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
AID.MacAppendFromRaw_2Line(File_Dea_PreAid,
															Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, AID,
															rsCleanAID, lAIDFlags);
 Processed := rsCleanAID;


DEA.Layout.DEA_In_PreProcessed xAidConversion(Processed L) := transform
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
		Self.cln_address :=Stringlib.StringCleanSpaces(L.aidwork_acecache.prim_range + 
																						L.aidwork_acecache.predir + 
																						L.aidwork_acecache.prim_name + 
																						L.aidwork_acecache.addr_suffix + 
																						L.aidwork_acecache.postdir + 
																						L.aidwork_acecache.unit_desig + 
																						L.aidwork_acecache.sec_range + 
																						L.aidwork_acecache.p_city_name + 
																						L.aidwork_acecache.v_city_name + 
																						L.aidwork_acecache.st + 
																						L.aidwork_acecache.zip5 + 
																						L.aidwork_acecache.zip4);
		Self := L;
		Self := [];
End;

	New_Processed := Project(Processed, xAidConversion(Left));
	Old_Processed := Project(DEA.File_DEAv2, Transform(DEA.Layout.DEA_In_PreProcessed, 
																									Self.cln_address :=StringLib.StringCleanSpaces(
																																		Left.prim_range + 
																																		Left.predir + 
																																		Left.prim_name + 
																																		Left.addr_suffix + 
																																		Left.postdir + 
																																		Left.unit_desig + 
																																		Left.sec_range + 
																																		Left.p_city_name + 
																																		Left.v_city_name + 
																																		Left.st + 
																																		Left.zip + 
																																		Left.zip4 );
																									Self := Left;
																									Self := [];));
													
DeaECL_Preprocess := 	New_Processed + Old_Processed : persist('~persist::dea::preprocess');
Return DeaECL_Preprocess;
End;
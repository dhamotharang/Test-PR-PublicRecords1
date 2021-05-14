// Re-create AID file everytime the build is run so it refreshes the raw id.
// This AID file will maintain wht unique address fields clean and AID addresses.
import AID,lib_stringlib,ut,_Control,address;
export Proc_BK_AID(string filedate, boolean useaid = true) := function
	// daily
	main_daily := bankruptcyv2.File_Bankruptcy_main_in;
	search_daily := bankruptcyv2.File_Bankruptcy_search_in;
	
	// Populate addres_line_1 and last fields to the common layout.
	
	BankruptcyV2.Layout_BK_AID getMainAddress(main_daily l) := transform
		self.tmsid := l.tmsid;
		self.process_date := l.process_date;
		self.file_flag := 'M';
		self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(l.trusteeAddress,left,right));
		self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.trusteecity,left,right) + if(l.trusteecity <> '',', ',''),left)
									+ trim(l.trusteestate,left,right) + ' ' + trim(l.trusteezip,left,right));
		self.clean_address := transfer(l.clean_address,address.Layout_Clean182);
		self.AID_clean_address := [];
	end;
	
	MainAddress := project(main_daily,getMainAddress(left));
	
	BankruptcyV2.Layout_BK_AID getSearchAddress(Search_daily l) := transform
		self.tmsid := l.tmsid;
		self.process_date := l.process_date;
		self.file_flag := 'S';
		self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_Addr1,left,right));
		self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.orig_city,left,right) + if(l.orig_city <> '',', ',''),left)
									+ trim(l.orig_st,left,right) + ' ' + trim(l.orig_zip5,left,right));
		self.clean_address := transfer(l.clean_address,address.Layout_Clean182);
		self.AID_clean_address := [];
	end;
	
	SearchAddress := project(Search_daily,getSearchAddress(left));
	
	// Full file
	
	main_full := bankruptcyv2.file_bankruptcy_main_v3;
	search_full := bankruptcyv2.file_bankruptcy_search_v3;
	
	BankruptcyV2.Layout_BK_AID getMainFullAddress(main_full l) := transform
		self.tmsid := l.tmsid;
		self.process_date := l.process_date;
		self.file_flag := 'M';
		self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(l.trusteeAddress,left,right));
		self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.trusteecity,left,right) + if(l.trusteecity <> '',', ',''),left)
									+ trim(l.trusteestate,left,right) + ' ' + trim(l.trusteezip,left,right));
		self.clean_address.prim_range := l.prim_range;
		self.clean_address.predir := l.predir;
		self.clean_address.prim_name := l.prim_name;
		self.clean_address.addr_suffix := l.addr_suffix;
		self.clean_address.postdir := l.postdir;
		self.clean_address.unit_desig := l.unit_desig;
		self.clean_address.sec_range := l.sec_range;
		self.clean_address.p_city_name := l.p_city_name;
		self.clean_address.v_city_name := l.v_city_name;
		self.clean_address.st := l.st;
		self.clean_address.zip := l.zip;
		self.clean_address.zip4 := l.zip4;
		self.clean_address.cart := l.cart;
		self.clean_address.cr_sort_sz := l.cr_sort_sz;
		self.clean_address.lot := l.lot;
		self.clean_address.lot_order := l.lot_order;
		self.clean_address.dbpc := l.dbpc;
		self.clean_address.chk_digit := l.chk_digit;
		self.clean_address.rec_type := l.rec_type;
		self.clean_address.county := l.county;
		self.clean_address.geo_lat := l.geo_lat;
		self.clean_address.geo_long := l.geo_long;
		self.clean_address.msa := l.msa;
		self.clean_address.geo_blk := l.geo_blk;
		self.clean_address.geo_match := l.geo_match;
		self.clean_address.err_stat := l.err_stat;
		self.AID_clean_address := [];
	end;
	
	FullMainAddress := project(main_full,getMainFullAddress(left));
	
	BankruptcyV2.Layout_BK_AID getSearchFullAddress(Search_full l) := transform
		self.tmsid := l.tmsid;
		self.process_date := l.process_date;
		self.file_flag := 'S';
		self.address_line_1 := lib_StringLib.StringLib.StringToUpperCase(trim(l.orig_Addr1,left,right));
		self.address_line_last := lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.orig_city,left,right) + if(l.orig_city <> '',', ',''),left)
									+ trim(l.orig_st,left,right) + ' ' + trim(l.orig_zip5,left,right));
		self.clean_address.prim_range := l.prim_range;
		self.clean_address.predir := l.predir;
		self.clean_address.prim_name := l.prim_name;
		self.clean_address.addr_suffix := l.addr_suffix;
		self.clean_address.postdir := l.postdir;
		self.clean_address.unit_desig := l.unit_desig;
		self.clean_address.sec_range := l.sec_range;
		self.clean_address.p_city_name := l.p_city_name;
		self.clean_address.v_city_name := l.v_city_name;
		self.clean_address.st := l.st;
		self.clean_address.zip := l.zip;
		self.clean_address.zip4 := l.zip4;
		self.clean_address.cart := l.cart;
		self.clean_address.cr_sort_sz := l.cr_sort_sz;
		self.clean_address.lot := l.lot;
		self.clean_address.lot_order := l.lot_order;
		self.clean_address.dbpc := l.dbpc;
		self.clean_address.chk_digit := l.chk_digit;
		self.clean_address.rec_type := l.rec_type;
		self.clean_address.county := l.county;
		self.clean_address.geo_lat := l.geo_lat;
		self.clean_address.geo_long := l.geo_long;
		self.clean_address.msa := l.msa;
		self.clean_address.geo_blk := l.geo_blk;
		self.clean_address.geo_match := l.geo_match;
		self.clean_address.err_stat := l.err_stat;
		self.AID_clean_address := [];
	end;
	
	FullSearchAddress := project(Search_full,getSearchFullAddress(left));
	
	FullAddress := dedup(
						sort(
							distribute(
								MainAddress + SearchAddress 
								+ BankruptcyV2.File_BK_AID, // remove for first run
								// + FullMainAddress + FullSearchAddress, //Comment after first run
								hash(tmsid)
								),
								tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
								),
						tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
						);
	
	unsigned4 setAIDflags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	AID.MacAppendFromRaw_2Line(FullAddress, address_line_1, address_line_last, Append_RawAID, addresscleaned, setAIDflags);

	// There are cases where the address_line_last and address_line_1 are blank 
	// but the clean addresses are populated, so the if condition below will resolve 
	// those records.

	BankruptcyV2.Layout_BK_AID getAID(addresscleaned l) := transform
		
		self.Append_RawAID := l.AIDWork_RawAID;
		self.AID_Clean_Address.zip := if(l.address_line_last = '' and l.address_line_1 = '',
											l.clean_address.zip,l.AIDWork_ACECache.zip5);
		self.AID_Clean_Address.prim_range := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.prim_range,l.AIDWork_ACECache.prim_range);
self.AID_Clean_Address.predir := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.predir,l.AIDWork_ACECache.predir);
self.AID_Clean_Address.prim_name := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.prim_name,l.AIDWork_ACECache.prim_name);
self.AID_Clean_Address.addr_suffix := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.addr_suffix,l.AIDWork_ACECache.addr_suffix);
self.AID_Clean_Address.postdir := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.postdir,l.AIDWork_ACECache.postdir);
self.AID_Clean_Address.unit_desig := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.unit_desig,l.AIDWork_ACECache.unit_desig);
self.AID_Clean_Address.sec_range := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.sec_range,l.AIDWork_ACECache.sec_range);
self.AID_Clean_Address.p_city_name := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.p_city_name,l.AIDWork_ACECache.p_city_name);
self.AID_Clean_Address.v_city_name := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.v_city_name,l.AIDWork_ACECache.v_city_name);
self.AID_Clean_Address.st := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.st,l.AIDWork_ACECache.st);
self.AID_Clean_Address.zip4 := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.zip4,l.AIDWork_ACECache.zip4);
self.AID_Clean_Address.cart := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.cart,l.AIDWork_ACECache.cart);
self.AID_Clean_Address.cr_sort_sz := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.cr_sort_sz,l.AIDWork_ACECache.cr_sort_sz);
self.AID_Clean_Address.lot := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.lot,l.AIDWork_ACECache.lot);
self.AID_Clean_Address.lot_order := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.lot_order,l.AIDWork_ACECache.lot_order);
self.AID_Clean_Address.dbpc := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.dbpc,l.AIDWork_ACECache.dbpc);
self.AID_Clean_Address.chk_digit := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.chk_digit,l.AIDWork_ACECache.chk_digit);
self.AID_Clean_Address.rec_type := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.rec_type,l.AIDWork_ACECache.rec_type);
self.AID_Clean_Address.county := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.county,l.AIDWork_ACECache.county);
self.AID_Clean_Address.geo_lat := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.geo_lat,l.AIDWork_ACECache.geo_lat);
self.AID_Clean_Address.geo_long := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.geo_long,l.AIDWork_ACECache.geo_long);
self.AID_Clean_Address.msa := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.msa,l.AIDWork_ACECache.msa);
self.AID_Clean_Address.geo_blk := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.geo_blk,l.AIDWork_ACECache.geo_blk);
self.AID_Clean_Address.geo_match := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.geo_match,l.AIDWork_ACECache.geo_match);
self.AID_Clean_Address.err_stat := if (l.address_line_1 = '' and l.address_line_last = '',l.clean_address.err_stat,l.AIDWork_ACECache.err_stat);

		self := l;		
	end;	
	
	GetAIDCleanAddress := project(addresscleaned,getAID(left));
	
	// ======== begin
	// Following section will be used when there are issues with AID
	// files. In such scenarios, pass in false as useaid parameter value
	// it will then use the clean fields from BK base fike to populate AID fields,
	// instead of using AID files.
	
	FullDailyAddress := dedup(
						sort(
							distribute(
								MainAddress + SearchAddress, // remove for first run
								// + FullMainAddress + FullSearchAddress, //Comment after first run
								hash(tmsid)
								),
								tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
								),
						tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
						);
	
	
	BankruptcyV2.Layout_BK_AID getCleanedAddressfromBase(FullDailyAddress l) := transform
		
		self.Append_RawAID := 0;
		self.AID_Clean_Address.zip := l.clean_address.zip;
		self.AID_Clean_Address.prim_range := l.clean_address.prim_range;
self.AID_Clean_Address.predir := l.clean_address.predir;
self.AID_Clean_Address.prim_name := l.clean_address.prim_name;
self.AID_Clean_Address.addr_suffix := l.clean_address.addr_suffix;
self.AID_Clean_Address.postdir := l.clean_address.postdir;
self.AID_Clean_Address.unit_desig := l.clean_address.unit_desig;
self.AID_Clean_Address.sec_range := l.clean_address.sec_range;
self.AID_Clean_Address.p_city_name := l.clean_address.p_city_name;
self.AID_Clean_Address.v_city_name := l.clean_address.v_city_name;
self.AID_Clean_Address.st := l.clean_address.st;
self.AID_Clean_Address.zip4 := l.clean_address.zip4;
self.AID_Clean_Address.cart := l.clean_address.cart;
self.AID_Clean_Address.cr_sort_sz := l.clean_address.cr_sort_sz;
self.AID_Clean_Address.lot := l.clean_address.lot;
self.AID_Clean_Address.lot_order := l.clean_address.lot_order;
self.AID_Clean_Address.dbpc := l.clean_address.dbpc;
self.AID_Clean_Address.chk_digit := l.clean_address.chk_digit;
self.AID_Clean_Address.rec_type := l.clean_address.rec_type;
self.AID_Clean_Address.county := l.clean_address.county;
self.AID_Clean_Address.geo_lat := l.clean_address.geo_lat;
self.AID_Clean_Address.geo_long := l.clean_address.geo_long;
self.AID_Clean_Address.msa := l.clean_address.msa;
self.AID_Clean_Address.geo_blk := l.clean_address.geo_blk;
self.AID_Clean_Address.geo_match := l.clean_address.geo_match;
self.AID_Clean_Address.err_stat := l.clean_address.err_stat;

		self := l;		
	end;	
	
		
	GetCleanAddressfromDailyBase := project(FullDailyaddress,getCleanedAddressfromBase(left));
	
	GetCleanAddressfromBase := dedup(
						sort(
							distribute(
								GetCleanAddressfromDailyBase 
								+ BankruptcyV2.File_BK_AID, // remove for first run
								// + FullMainAddress + FullSearchAddress, //Comment after first run
								hash(tmsid)
								),
								tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
								),
						tmsid,process_date,file_flag,address_line_1,address_line_last,clean_address.prim_range,
clean_address.predir,
clean_address.prim_name,
clean_address.addr_suffix,
clean_address.postdir,
clean_address.unit_desig,
clean_address.sec_range,
clean_address.p_city_name,
clean_address.v_city_name,
clean_address.st,
clean_address.zip,
clean_address.zip4,
clean_address.cart,
clean_address.cr_sort_sz,
clean_address.lot,
clean_address.lot_order,
clean_address.dbpc,
clean_address.chk_digit,
clean_address.rec_type,
clean_address.county,
clean_address.geo_lat,
clean_address.geo_long,
clean_address.msa,
clean_address.geo_blk,
clean_address.geo_match,
clean_address.err_stat,local
						);
	
	GetCleanAddress := if (useaid, GetAIDCleanAddress, GetCleanAddressfromBase);
	
	// ====== end 
	
  // Validate bad clean address records.
	
	badcount := count(BankruptcyV2.File_BK_AID(trim(AID_Clean_Address.err_stat,left,right) = 'U000'));
	totalcount := count(BankruptcyV2.File_BK_AID);
	
	GetBadCleanAddress := if ((badcount / totalcount) > .01,sequential(
					 if(_Control.ThisEnvironment.Name != 'Prod_Thor',fileservices.sendemail('Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
			'Bankruptcy Process failure:ERROR:' + ut.GetDate,
			'More than 1% of Bankruptcy records have clean addresses with value U000\n'),
			fileservices.sendemail('Joseph.Lezcano@lexisnexis.com,Vesa.Niemela@lexisnexis.com,Lisa.Simmons@lexisnexis.com,Mike.Schumacher@lexisnexis.com,Brian.Dunnam@lexisnexis.com,Victor.tavernini@lexisnexis.com,Jeff.Torres@lexisnexis.com,afterhourssupport@lexisnexis.com,Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
			'Bankruptcy Process failure:ERROR:' + ut.GetDate,
			'More than 1% of Bankruptcy records have clean addresses with value U000\n')),
					 fail('Process Abort: More than 1% of the records have clean addresses with value U000')),
										output('No bad clean address')					
													);
	
	outfile := if (fileservices.superfileexists('~thor_data400::base::bankruptcy::aid'),
					if(fileservices.findsuperfilesubname('~thor_data400::base::bankruptcy::aid','~thor_data400::base::bankruptcy::'+filedate+'::aid') = 0,
					output(GetCleanAddress,,'~thor_data400::base::bankruptcy::'+filedate+'::aid',overwrite,__COMPRESSED__),
					// sequential
						// (
						// fileservices.clearsuperfile('~thor_data400::base::bankruptcy::aid'),
						// output(GetCleanAddress,,'~thor_data400::base::bankruptcy::'+filedate+'::aid',overwrite,__COMPRESSED__)
						// )
						// )
						output('~thor_data400::base::bankruptcy::'+filedate+'::aid' + ' exists already')),
					output(GetCleanAddress,,'~thor_data400::base::bankruptcy::'+filedate+'::aid',overwrite,__COMPRESSED__)	
						
					);
	
	// Superfile transactions - creates superfiles if it doesn't exist.
	
	superfiletransactions := sequential(
									if(not fileservices.superfileexists('~thor_data400::base::bankruptcy::aid'),
										fileservices.createsuperfile('~thor_data400::base::bankruptcy::aid')),
									if(not fileservices.superfileexists('~thor_data400::base::bankruptcy::aid_father'),
										fileservices.createsuperfile('~thor_data400::base::bankruptcy::aid_father')),
									if(not fileservices.superfileexists('~thor_data400::base::bankruptcy::aid_delete'),
										fileservices.createsuperfile('~thor_data400::base::bankruptcy::aid_delete')),
										fileservices.addsuperfile('~thor_data400::base::bankruptcy::aid_delete','~thor_data400::base::bankruptcy::aid_father',,true),
										fileservices.clearsuperfile('~thor_data400::base::bankruptcy::aid_father'),
										fileservices.addsuperfile('~thor_data400::base::bankruptcy::aid_father','~thor_data400::base::bankruptcy::aid',,true),
										fileservices.clearsuperfile('~thor_data400::base::bankruptcy::aid'),
										fileservices.addsuperfile('~thor_data400::base::bankruptcy::aid','~thor_data400::base::bankruptcy::'+filedate+'::aid'),
									fileservices.clearsuperfile('~thor_data400::base::bankruptcy::aid_delete',true)

									); 
	retval := sequential(outfile,superfiletransactions,GetBadCleanAddress) : success(fileservices.sendemail('Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
			'Bankruptcy AID:SUCCESS:' + ut.GetDate,
			'BK AID Complete')),
			failure(fileservices.sendemail('Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
			'Bankruptcy AID:FAILED:' + ut.GetDate,
			'BK AID Failed. Check WU'));
	
	return retval;
	
end;
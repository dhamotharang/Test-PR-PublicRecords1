#workunit('name', 'V12 Build');

IMPORT	ut
				, AID
				, DID_Add
				, header_slimsort
				, address
				, lib_StringLib
				, idl_header
				,	NID
				, STD
				,PRTE2; //using a cleaning function in this repository;
				
EXPORT proc_build_base(STRING version) := FUNCTION

	//Clean invalid characters from input fields
	PRTE2.CleanFields(V12.files.V12_epostal_in, dsCleanOut);

	V12.layouts.V12_base tFormatEpostalFields(V12.layouts.V12_epostal_in pInput) := TRANSFORM
		self.sequence											:=	ut.CleanSpacesAndUpper(pInput.sequence);
		ClnFirstName											:= IF(REGEXFIND('(^ZZZ+|^HTTP)',STD.Str.CleanSpaces(pInput.first_name)),'',pInput.first_name);
		ClnLastName												:= IF(REGEXFIND('(^ZZZ+|^HTTP)',STD.Str.CleanSpaces(pInput.last_name)),'',pInput.last_name);
		self.first_name										:=	STD.Str.CleanSpaces(REGEXREPLACE('[^a-zA-Z]',ClnFirstName,' '));
		self.last_name										:=	STD.Str.CleanSpaces(REGEXREPLACE('[^a-zA-Z]',ClnLastName,' '));
		self.address_1										:=	STD.Str.CleanSpaces(REGEXREPLACE('[^a-zA-Z0-9_]',pInput.address_1,' '));
		self.address_2										:=	STD.Str.CleanSpaces(REGEXREPLACE('[^a-zA-Z0-9_]',pInput.address_2,' '));
		self.city													:=	STD.Str.CleanSpaces(regexreplace('[^a-zA-Z]',pInput.city,' '));
		self.state												:=	STD.Str.CleanSpaces(regexreplace('[^a-zA-Z]',pInput.state,''));
		self.zip_code											:=	regexreplace('[^0-9]',pInput.zip_code,'');
		self.email												:=	STD.Str.CleanSpaces(pInput.email);
		self.optout												:=	false;
		self.hardbounce										:= 	false;
		self.DID              						:=	0;
		self.RawAID												:=	0;
		self.Process_Date 								:=	thorlib.wuid()[2..9];
		self.date_first_seen							:=  version[1..8];
		self.date_last_seen								:=  version[1..8];
		self.Date_Vendor_First_Reported 	:=	version[1..8];
		self.Date_Vendor_Last_Reported 		:=	version[1..8];
		self.current_rec									:=	true;
		self															:=	pInput;
		self															:=	[];
	END;

	//Filter input file
	epostalInputFile	:= Project(dsCleanOut(STD.Str.Find(first_name, '|', 1) = 0 and  STD.Str.Find(last_name, '|', 1) = 0 and STD.Str.Find(city, '|', 1) = 0), tFormatEpostalFields(LEFT));
	fEpostalInput := epostalInputFile(trim(first_name,all) != '' AND trim(last_name,all) != '');
	
		//Append Record ID and full_name
	tempV12_layout := RECORD
		V12.layouts.V12_base;
		string full_name;
	END;
	
	tempV12_layout appendRecID(fEpostalInput pInput) := TRANSFORM
		self.persistent_record_id := HASH64(TRIM(pInput.first_name)
																				+TRIM(pInput.last_name)
																				+TRIM(pInput.address_1)
																				+TRIM(pInput.address_2)
																				+TRIM(pInput.city)
																				+TRIM(pInput.state)
																				+TRIM(pInput.zip_code)
																				+TRIM(pInput.email));
		self.full_name := TRIM(pInput.first_name,left,right)+' '+TRIM(pInput.last_name,left,right);
		self								:=	pInput;
	end;
	
	dRecordID	:=	project(fEpostalInput,appendRecID(left));
	

	
		NID.Mac_CleanParsedNames(dRecordID, FileClnName, 
														firstname:=First_Name, lastname:=Last_Name, middlename := clean_mname, namesuffix := clean_name_suffix
														,includeInRepository:=true, normalizeDualNames:=false, useV2 := true);
	

	InputFileClnName	:= Project(FileClnName, TRANSFORM(V12.layouts.V12_base,
																										self.clean_title				:=	left.cln_title;
																										self.clean_fname				:=	left.cln_fname;
																										self.clean_mname				:=	left.cln_mname;
																										self.clean_lname				:=	left.cln_lname;
																										self.clean_name_suffix	:=	left.cln_suffix;
																										SELF := LEFT));
																										
		//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	V12.layouts.V12_base tProjectAIDClean_prep(V12.layouts.V12_base pInput) := TRANSFORM
	  clnFullAddr	:= StringLib.StringCleanSpaces(pInput.address_1 +' '+ pInput.address_2);
		self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(clnFullAddr, 'first');
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.zip_code, 'last');
		self := pInput;
	END;

	rsAIDCleanName	:= PROJECT(InputFileClnName ,tProjectAIDClean_prep(LEFT));
	
	rsAID_NoAddr		:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) = '' OR TRIM(Append_Prep_Address_Last_Situs) = '');
	rsAID_Addr			:=	rsAIDCleanName(TRIM(Append_Prep_Address_Situs) != '' AND TRIM(Append_Prep_Address_Last_Situs) != '');
	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);	
	
	V12.layouts.V12_base tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.clean_prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.clean_predir               := pInput.aidwork_acecache.predir;
    SELF.clean_prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := pInput.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.clean_st                   := pInput.aidwork_acecache.st;
    SELF.clean_zip                  := pInput.aidwork_acecache.zip5;
    SELF.clean_zip4                 := pInput.aidwork_acecache.zip4;
    SELF.clean_cart                 := pInput.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := pInput.aidwork_acecache.lot;
    SELF.clean_lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.clean_county               := pInput.aidwork_acecache.county;
    SELF.clean_geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.clean_msa                  := pInput.aidwork_acecache.msa;
    SELF.clean_geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               			:= pInput.aidwork_rawaid;
    SELF  													:= pInput;		
	END;

	V12.layouts.V12_base tProjectNoAddrClean(rsAID_NoAddr pInput) := TRANSFORM

		cl_addr			:= Address.CleanAddress182('', TRIM(pInput.city) + ' ' + TRIM(pInput.state) + ' ' + TRIM(pInput.zip_code));
	
		SELF.clean_prim_range  	:=  cl_addr[1..10];
		SELF.clean_predir  			:=  cl_addr[11..12];
		SELF.clean_prim_name  	:=  cl_addr[13..40];
		SELF.clean_addr_suffix  :=  cl_addr[41..44];
		SELF.clean_postdir  		:=  cl_addr[45..46];
		SELF.clean_unit_desig  	:=  cl_addr[47..56];
		SELF.clean_sec_range  	:=  cl_addr[57..64];
		SELF.clean_p_city_name  :=  cl_addr[65..89];
		SELF.clean_v_city_name  :=  cl_addr[90..114];
		SELF.clean_st  					:=  cl_addr[115..116];
		SELF.clean_zip  				:=  cl_addr[117..121];
		SELF.clean_zip4  				:=  cl_addr[122..125];
		SELF.clean_cart  				:=  cl_addr[126..129];
		SELF.clean_cr_sort_sz  	:=  cl_addr[130];
		SELF.clean_lot  				:=  cl_addr[131..134];
		SELF.clean_lot_order  	:=  cl_addr[135];
		SELF.clean_dbpc  				:=  cl_addr[136..137];
		SELF.clean_chk_digit  	:=  cl_addr[138];
		SELF.clean_rec_type  		:=  cl_addr[139..140];
		SELF.clean_county  			:=  cl_addr[141..145];
		SELF.clean_geo_lat  		:=  cl_addr[146..155];
		SELF.clean_geo_long  		:=  cl_addr[156..166];
		SELF.clean_msa  				:=  cl_addr[167..170];
		SELF.clean_geo_blk  		:=  cl_addr[171..177];
		SELF.clean_geo_match  	:=  cl_addr[178];
		SELF.clean_err_stat  		:=  cl_addr[179..182];
		
    SELF  									:= pInput;		
	END;	
	
	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tProjectNoAddrClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr;
	
	//Clean Base file to remove invalid characters
	PRTE2.CleanFields(V12.files.V12_base, ClnBaseOut);
	
	//Set Base current_rec = false. Only records in recent file are current
	ResetBase	:= PROJECT(ClnBaseOut, TRANSFORM(V12.layouts.V12_base, SELF.current_rec := false; SELF := LEFT));
	
	BOOLEAN basefileexists	:=	NOTHOR(fileservices.GetSuperFileSubCount(V12.thor_cluster + 'base::V12')) > 0; 
	
	BasePlusIn	:=	IF(basefileexists, rsCleanAIDGood + ResetBase, rsCleanAIDGood);
																													
	BaseDist	:=	SORT(DISTRIBUTE(BasePlusIn, HASH(first_name
																						+last_name
																						+address_1
																						+address_2
																						+city
																						+state
																						+zip_code
																						+email)),
															first_name,last_name,address_1,address_2,zip_code,email,-Date_Vendor_Last_Reported,LOCAL);
															
	V12.layouts.V12_base  rollupXform(V12.layouts.V12_base L, V12.layouts.V12_base R) := transform
		self.Process_Date    := IF(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.date_first_seen := IF(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := IF(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self.Date_Vendor_First_Reported := IF(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := IF(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);
		self.sequence						:= IF(l.sequence = '',r.sequence,l.sequence);
		self.clean_title				:=	IF(l.clean_title = '',r.clean_title,l.clean_title);
		self.clean_fname				:=	IF(l.clean_fname = '',r.clean_fname,l.clean_fname);
		self.clean_mname				:=	IF(l.clean_mname = '',r.clean_mname,l.clean_mname);
		self.clean_lname				:=	IF(l.clean_lname = '',r.clean_lname,l.clean_lname);
		self.clean_name_suffix	:=	IF(l.clean_name_suffix = '',r.clean_name_suffix,l.clean_name_suffix);
		self.current_rec        :=  IF(L.Process_Date > R.Process_Date, L.current_rec, R.current_rec);
		self := L; 
	end;
															
	//Roll it up
	BaseRollup := ROLLUP(BaseDist,rollupXform(LEFT,RIGHT),
																LEFT.first_name = RIGHT.first_name
																AND LEFT.last_name = RIGHT.last_name
																AND LEFT.address_1 = RIGHT.address_1
																AND LEFT.address_2 = RIGHT.address_2
																AND LEFT.zip_code = RIGHT.zip_code
																AND LEFT.email = RIGHT.email, LOCAL);

	//Flip names before DID process
	ut.mac_flipnames(BaseRollup,clean_fname,clean_mname,clean_lname,rsAIDCleanFlipNames);

	matchset :=['A','Z'];

	did_Add.MAC_Match_Flex(rsAIDCleanFlipNames, matchset,
													foo, foo, clean_fname, clean_mname, clean_lname, clean_name_suffix, 
													clean_prim_range, clean_prim_name, clean_sec_range, clean_zip, clean_st, foo,
													DID,   			
													V12.layouts.V12_base, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID);

	RETURN rsCleanAID_DID;

END;
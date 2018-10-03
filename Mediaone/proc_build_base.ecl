IMPORT Mediaone, ut, address, DID_Add, AID, AID_Support, codes, PRTE2, STD, NID;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
//#STORED('did_add_force','thor');

EXPORT proc_build_base(STRING8 version) := FUNCTION
  infile:=mediaone.file_mediaone.file;
	
	//Clean invalid characters from input fields
	PRTE2.CleanFields(infile, dsCleanOut);
	
  layout_name_clean:=RECORD
    RECORDOF(infile);
    STRING5 clean_title;
    STRING20 clean_fname;
    STRING20 clean_mname;
    STRING20 clean_lname;
    STRING5 clean_name_suffix;
    STRING3 clean_name_score;
    STRING addr1;
    STRING addr2;
    UNSIGNED8 RawAID:=0;
    STRING8 date_vendor_first_reported;
    STRING8 date_vendor_last_reported ;
    STRING8 date_first_seen;
    STRING8 date_last_seen;
  END;
	
	//Send names to cleaner
		fmtsin := [
		'%m/%d/%Y',
		'%Y-%m-%d',
		'%Y%m%d'
	];
	fmtout := '%Y%m%d';
	
	layout_name_clean tPrep(dsCleanOut L):= TRANSFORM
    SELF.date_vendor_first_reported := version;
    SELF.date_vendor_last_reported  := version;
    SELF.date_first_seen            := STD.Date.ConvertDateFormatMultiple(L.date_time,fmtsin,fmtout);
    SELF.date_last_seen             := SELF.date_first_seen;
    SELF	:= L;
		SELF	:= [];
	END;
	
	PrepFile:=PROJECT(dsCleanOut,tPrep(LEFT));
	
	NID.Mac_CleanParsedNames(PrepFile, FileClnName, 
													firstname:=fname, lastname:=lname, middlename := clean_mname, namesuffix := clean_name_suffix
													,includeInRepository:=false, normalizeDualNames:=false, useV2 := true);
	
	//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B'];
	InvName_flags	:= ['I']; //Invalid Name
	
	ClnName	:= PROJECT(FileClnName, TRANSFORM(layout_name_clean,
																						BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																																(LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != '');
																						SELF.clean_title				:=	IF(IsName, LEFT.cln_title, '');
																						SELF.clean_fname				:=	IF(IsName, LEFT.cln_fname, LEFT.fname);
																						SELF.clean_mname				:=	IF(IsName, LEFT.cln_mname, '');
																						SELF.clean_lname				:=	IF(IsName, LEFT.cln_lname, LEFT.lname);
																						SELF.clean_name_suffix	:=	IF(IsName, LEFT.cln_suffix, '');
																						SELF := LEFT));

	layout_name_clean PrepAddr(ClnName L):=TRANSFORM
		tempcity								:= IF(REGEXFIND('[0-9]',L.city),'',L.city);
		SELF.city								:= ut.CleanSpacesAndUpper(tempcity);
    tempzip									:= IF(REGEXFIND('[A-Z]',L.zip,NOCASE),'',L.zip);
		SELF.zip								:= TRIM(tempzip,LEFT,RIGHT);
		tempSt									:= IF(REGEXFIND('[A-Z]',L.zip,NOCASE),L.zip,L.state);
		ValidState							:= codes.valid_st(tempST);
    SELF.state							:= ut.CleanSpacesAndUpper(IF(codes.valid_st(tempST),tempST,''));
		addrs1 := If(regexfind('[@]', L.address), '', L.address);
    SELF.addr1:=	Address.fn_addr_clean_prep(ut.CleanSpacesAndUpper(REGEXREPLACE('[+"]',addrs1,' ')),'first');
    SELF.addr2:=  Address.fn_addr_clean_prep(
																			trim(SELF.city,left,right) + if(SELF.city <> '',', ',' ') + trim(SELF.state,left,right) + ' ' + trim(SELF.zip,left,right
																			),'last');
    SELF:=L;
	END;
	pAddrPrep	:=PROJECT(ClnName,PrepAddr(LEFT));
	
	rsAID_NoAddr := pAddrPrep(address = '' or city = '' or state = '' or zip = '');
	rsAID_Addr	 := pAddrPrep(address != '' or state != '' or zip != '');

  // Call the AID macro to get the cleaned address information
  UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
  AID.MacAppendFromRaw_2Line(rsAID_Addr,addr1,addr2,RawAID,rsCleanAID,lAIDAppendFlags);
	
  // Get standardized Name and Address fields
  mediaone.file_base.layout tAddressClean(rsCleanAID L):=TRANSFORM
    SELF.DID                 := 0;
    SELF.DID_Score           := 0;
    SELF.clean_prim_range    := L.aidwork_acecache.prim_range;
    SELF.clean_predir        := L.aidwork_acecache.predir;
    SELF.clean_prim_name     := L.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix   := L.aidwork_acecache.addr_suffix;
    SELF.clean_postdir       := L.aidwork_acecache.postdir;
    SELF.clean_unit_desig    := L.aidwork_acecache.unit_desig;
    SELF.clean_sec_range     := L.aidwork_acecache.sec_range;
    SELF.clean_p_city_name   := L.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name   := L.aidwork_acecache.v_city_name;
    SELF.clean_st            := L.aidwork_acecache.st;
    SELF.clean_zip           := L.aidwork_acecache.zip5;
    SELF.clean_zip4          := L.aidwork_acecache.zip4;
    SELF.clean_cart          := L.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz    := L.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot           := L.aidwork_acecache.lot;
    SELF.clean_lot_order     := L.aidwork_acecache.lot_order;
    SELF.clean_dbpc          := L.aidwork_acecache.dbpc;
    SELF.clean_chk_digit     := L.aidwork_acecache.chk_digit;
    SELF.clean_rec_type      := L.aidwork_acecache.rec_type;
    SELF.clean_county        := L.aidwork_acecache.county;
    SELF.clean_geo_lat       := L.aidwork_acecache.geo_lat;
    SELF.clean_geo_long      := L.aidwork_acecache.geo_long;
    SELF.clean_msa           := L.aidwork_acecache.msa;
    SELF.clean_geo_blk       := L.aidwork_acecache.geo_blk;
    SELF.clean_geo_match     := L.aidwork_acecache.geo_match;
    SELF.clean_err_stat      := L.aidwork_acecache.err_stat;
    SELF.aid                 := L.aidwork_rawaid;
    SELF                     := L;
    SELF                     := [];
  END;
	
	mediaone.file_base.layout tNoAddressClean(rsAID_NoAddr L):= TRANSFORM
		cl_addr	:= Address.CleanAddress182(L.addr1, TRIM(L.city) + ' ' + TRIM(L.state) + ' ' + TRIM(L.Zip));
		SELF.DID                := 0;
    SELF.DID_Score          := 0;
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
		SELF  									:= 	L;
		SELF                    := [];
	END;
	
  rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tAddressClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, tNoAddressClean(LEFT));
	
	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr;

  // Find DIDs with a score of 75 or better
  matchset:=['A','D','P','Z'];  
  DID_Add.MAC_Match_Flex(rsCleanAIDGood,matchset,foo,DOB,clean_fname,
    clean_mname,clean_lname,clean_name_suffix,clean_prim_range,
    clean_prim_name,clean_sec_range,clean_zip,
    clean_st,phone,DID,mediaone.file_base.layout,true,DID_Score,75,with_did);
		
  basefile := DISTRIBUTE(with_did,HASH32(email));

  // merge the new data with the existing basefile.  Then roll it up on the
  // email and name fields, keeping the pertinent first and last date information
  mergeddata:=SORT(basefile+Mediaone.file_base.file,email,clean_fname,clean_mname,clean_lname);
  Mediaone.file_base.layout rollitup(Mediaone.file_base.layout L,Mediaone.file_base.layout R):=TRANSFORM
    SELF.date_first_seen:=IF(L.date_first_seen<R.date_first_seen,L.date_first_seen,R.date_first_seen);
    SELF.date_last_seen:=IF(L.date_last_seen>R.date_last_seen,L.date_last_seen,R.date_last_seen);
    SELF.date_vendor_first_reported:=IF(L.date_vendor_first_reported<R.date_vendor_first_reported,L.date_vendor_first_reported,R.date_vendor_first_reported);
    SELF.date_vendor_last_reported:=IF(L.date_vendor_last_reported>R.date_vendor_last_reported,L.date_vendor_last_reported,R.date_vendor_last_reported);
    SELF:=IF(L.date_vendor_last_reported>R.date_vendor_last_reported,L,R);
  END;
  BOOLEAN basefileexists:= nothor(fileservices.GetSuperFileSubCount('~thor::base::mediaone'))>0;
  newbasefile:=DISTRIBUTE(IF(basefileexists,ROLLUP(mergeddata,rollitup(LEFT,RIGHT),email,clean_fname,clean_mname,clean_lname,LOCAL),basefile),HASH32(email));

  RETURN newbasefile;
END;

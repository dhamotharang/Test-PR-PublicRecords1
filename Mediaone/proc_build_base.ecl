IMPORT Mediaone,ut,address,DID_Add,header_slimsort,AID,AID_Support,codes;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base(STRING8 version) := FUNCTION
  infile:=mediaone.file_mediaone.file;
	
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

	layout_name_clean tCleanName(infile L):=TRANSFORM
    clean_name              := if(length(TRIM(TRIM(L.fname)+' '+TRIM(L.lname)))=0,'',address.CleanPersonFML73(TRIM(TRIM(L.fname)+' '+TRIM(L.lname))));
		tempcity								:= IF(REGEXFIND('[0-9]',L.city),'',L.city);
		SELF.city								:= ut.CleanSpacesAndUpper(tempcity);
    tempzip									:= IF(REGEXFIND('[A-Z]',L.zip,NOCASE),'',L.zip);
		SELF.zip								:= TRIM(tempzip,LEFT,RIGHT);
		tempSt									:= IF(REGEXFIND('[A-Z]',L.zip,NOCASE),L.zip,L.state);
		ValidState							:= codes.valid_st(tempST);
    SELF.state							:= ut.CleanSpacesAndUpper(IF(codes.valid_st(tempST),tempST,''));
    SELF.clean_title        := clean_name[ 1.. 5];
    SELF.clean_fname        := clean_name[ 6..25];
    SELF.clean_mname        := clean_name[26..45];
    SELF.clean_lname        := clean_name[46..65];
    SELF.clean_name_suffix  := clean_name[66..70];
    SELF.clean_name_score   := clean_name[71..73];
		addrs1 := If(regexfind('[@]', L.address), '', L.address);
    SELF.addr1:=	ut.fn_addr_clean_prep(ut.CleanSpacesAndUpper(REGEXREPLACE('[+"]',addrs1,' ')),'first');
    SELF.addr2:=  ut.fn_addr_clean_prep(
																			trim(SELF.city,left,right) + if(SELF.city <> '',', ',' ') + trim(SELF.state,left,right) + ' ' + trim(SELF.zip,left,right
																			),'last'); 
    SELF.date_vendor_first_reported := version;
    SELF.date_vendor_last_reported  := version;
    SELF.date_first_seen            := Mediaone.fn_format_date(L.date_time);
    SELF.date_last_seen             := SELF.date_first_seen;
    SELF:=L;
	END;
	cleaned_name:=PROJECT(infile,tCleanName(LEFT));
	
	no_address := PROJECT(cleaned_name(address = '' and state = '' and zip = ''),TRANSFORM(mediaone.file_base.layout,SELF:=LEFT;SELF:=[];));
	has_address := cleaned_name(address != '' or state != '' or zip != '');

  // Call the AID macro to get the cleaned address information
  UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
  AID.MacAppendFromRaw_2Line(has_address,addr1,addr2,RawAID,cleaned_name_aid,lAIDAppendFlags);
	
  // Get standardized Name and Address fields
  mediaone.file_base.layout tAddressClean(cleaned_name_aid L):=TRANSFORM
    SELF.DID                        := 0;
    SELF.DID_Score                  := 0;
    SELF.clean_prim_range           := L.aidwork_acecache.prim_range;
    SELF.clean_predir               := L.aidwork_acecache.predir;
    SELF.clean_prim_name            := L.aidwork_acecache.prim_name;
    SELF.clean_addr_suffix          := L.aidwork_acecache.addr_suffix;
    SELF.clean_postdir              := L.aidwork_acecache.postdir;
    SELF.clean_unit_desig           := L.aidwork_acecache.unit_desig;
    SELF.clean_sec_range            := L.aidwork_acecache.sec_range;
    SELF.clean_p_city_name          := L.aidwork_acecache.p_city_name;
    SELF.clean_v_city_name          := L.aidwork_acecache.v_city_name;
    SELF.clean_st                   := L.aidwork_acecache.st;
    SELF.clean_zip                  := L.aidwork_acecache.zip5;
    SELF.clean_zip4                 := L.aidwork_acecache.zip4;
    SELF.clean_cart                 := L.aidwork_acecache.cart;
    SELF.clean_cr_sort_sz           := L.aidwork_acecache.cr_sort_sz;
    SELF.clean_lot                  := L.aidwork_acecache.lot;
    SELF.clean_lot_order            := L.aidwork_acecache.lot_order;
    SELF.clean_dbpc                 := L.aidwork_acecache.dbpc;
    SELF.clean_chk_digit            := L.aidwork_acecache.chk_digit;
    SELF.clean_rec_type             := L.aidwork_acecache.rec_type;
    SELF.clean_county               := L.aidwork_acecache.county;
    SELF.clean_geo_lat              := L.aidwork_acecache.geo_lat;
    SELF.clean_geo_long             := L.aidwork_acecache.geo_long;
    SELF.clean_msa                  := L.aidwork_acecache.msa;
    SELF.clean_geo_blk              := L.aidwork_acecache.geo_blk;
    SELF.clean_geo_match            := L.aidwork_acecache.geo_match;
    SELF.clean_err_stat             := L.aidwork_acecache.err_stat;
    SELF.aid                        := L.aidwork_rawaid;
    SELF                            := L;
    SELF                            := [];
  END;
  cleaned_name_address:=PROJECT(cleaned_name_aid,tAddressClean(LEFT))+no_address;

  // Find DIDs with a score of 75 or better
  matchset:=['A','D','P','Z'];  
  DID_Add.MAC_Match_Flex(cleaned_name_address,matchset,foo,DOB,clean_fname,
    clean_mname,clean_lname,clean_name_suffix,clean_prim_range,
    clean_prim_name,clean_sec_range,clean_zip,
    clean_st,phone,DID,mediaone.file_base.layout,true,DID_Score,75,with_did);
  basefile:=DISTRIBUTE(with_did,HASH32(email));

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

import address,evaluation_data;

addr_clean := Address.File_Address_Cache;

d:=evaluation_data.file_compid_base;

Address.layout_address_cache slimit(d l) := TRANSFORM
  self.addr1:=map	(l.rec_tp='1' =>	trim(l.compid.DRVR_CURR_ADDR+l.compid.DRVR_CURR_APT_NUM,all)
					,l.rec_tp='2' =>	trim(l.compid.DRVR_PRIOR_ADDR1+l.compid.DRVR_PRIOR_APT_NUM1,all)
					,l.rec_tp='3' =>	trim(l.compid.DRVR_PRIOR_ADDR2+l.compid.DRVR_PRIOR_APT_NUM2,all)
					,					trim(l.compid.DRVR_PRIOR_ADDR3+l.compid.DRVR_PRIOR_APT_NUM3,all)	);
  self.addr2:=map	(l.rec_tp='1' =>	trim(l.compid.DRVR_CURR_CITY_NAME+l.compid.DRVR_CURR_STATE_CODE+l.compid.DRVR_CURR_ZIP_NUM,all)
					,l.rec_tp='2' =>	trim(l.compid.DRVR_PRIOR_CITY_NAME1+l.compid.DRVR_PRIOR_STATE_CODE1+l.compid.DRVR_PRIOR_ZIP_NUM1,all)
					,l.rec_tp='3' =>	trim(l.compid.DRVR_PRIOR_CITY_NAME2+l.compid.DRVR_PRIOR_STATE_CODE2+l.compid.DRVR_PRIOR_ZIP_NUM2,all)
					,					trim(l.compid.DRVR_PRIOR_CITY_NAME3+l.compid.DRVR_PRIOR_STATE_CODE3+l.compid.DRVR_PRIOR_ZIP_NUM3,all)	);
  self.clean:=	l.prim_range
				+l.predir
				+l.prim_name
				+l.addr_suffix
				+l.postdir
				+l.unit_desig
				+l.sec_range
				+l.p_city_name
				+l.v_city_name
				+l.st
				+l.zip5
				+l.zip4
				+l.cart
				+l.cr_sort_sz
				+l.lot
				+l.lot_order
				+l.dpbc
				+l.chk_digit
				+l.rec_type
				+l.ace_fips_st
				+l.county
				+l.geo_lat
				+l.geo_long
				+l.msa
				+l.geo_blk
				+l.geo_match
				+l.err_stat;
end;

cache:=project(d,slimit(left));
// cacheDIS:=distribute(cache + addr_clean,hash(addr1,addr2));
cacheDIS:=distribute(cache,hash(trim(addr1,all),trim(addr2,all)));
cacheSTD:=sort(cacheDIS,addr1,addr2,local);
cacheDDP:=dedup(cacheSTD,addr1,addr2,local);
// export cache_addresses := cacheDDP :persist('~thor_data400::compid::address_cache');
export cache_addresses := dataset('~thor_data400::compid::address_cache',recordof(cacheDDP),flat);
export Proc_Prep_KeyBuild(dataset(nppes.Layouts.KeyBuildFirst) pKeyFile) := function

nppes.Layouts.KeyBuild_BIP  tNormalizeRecs(pKeyFile L, unsigned cnt) := transform   
   self.clean_norm_address  	 := if(cnt=1,L.clean_mailing_address,
											 L.clean_location_address);   											   								
   self := L;
   self := [];
   end;
   
   //normalize the records to get only 1 address in each new record
   normRecs	:= normalize(pKeyfile,2,tNormalizeRecs(left,counter));
   
   // output(normRecs);
   
   normRecsWithAddrs	:=	normRecs(trim(clean_norm_address.prim_range+
											clean_norm_address.predir+
											clean_norm_address.prim_name+
											clean_norm_address.addr_suffix+
											clean_norm_address.postdir+
											clean_norm_address.unit_desig+
											clean_norm_address.sec_range+
											clean_norm_address.p_city_name+
											clean_norm_address.v_city_name+
											clean_norm_address.st+
											clean_norm_address.zip+
											clean_norm_address.zip4+
											clean_norm_address.cart+
											clean_norm_address.cr_sort_sz+
											clean_norm_address.lot+
											clean_norm_address.lot_order+
											clean_norm_address.dbpc+
											clean_norm_address.chk_digit+
											clean_norm_address.rec_type+
											clean_norm_address.fips_state+
											clean_norm_address.fips_county+
											clean_norm_address.geo_lat+
											clean_norm_address.geo_long+
											clean_norm_address.msa+
											clean_norm_address.geo_blk+
											clean_norm_address.geo_match+
											clean_norm_address.err_stat,left,right)!= '');	
											
		dsSort := sort(distribute(normRecsWithAddrs,hash32(npi)),record,local);
		
		dsDedup := dedup(dsSort,record,local);				
								         
		return dsDedup;				
		end;
	   
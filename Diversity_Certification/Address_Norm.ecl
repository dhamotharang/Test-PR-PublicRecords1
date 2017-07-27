export Address_Norm ( string									pversion
										  ,dataset(Layouts.KeyBuild)	pBase			= files(pversion).KeyBuild(sizeof(files(pversion).KeyBuild)<=4096)
										 ):=	FUNCTION
	
		Diversity_Certification.Layouts.Auto_KeyBuild tNormalizeAddress(Diversity_Certification.Layouts.keybuild l, unsigned1 cnt)	:=	transform
			self.prim_range		:=	choose(cnt	,l.m_prim_range	,l.p_prim_range);
			self.predir				:=	choose(cnt	,l.m_predir,l.p_predir);
			self.prim_name		:=	choose(cnt	,l.m_prim_name,l.p_prim_name);
			self.addr_suffix	:=	choose(cnt	,l.m_addr_suffix,l.p_addr_suffix);
			self.postdir			:=	choose(cnt	,l.m_postdir,l.p_postdir);
			self.unit_desig		:=	choose(cnt	,l.m_unit_desig,l.p_unit_desig);
			self.sec_range		:=	choose(cnt	,l.m_sec_range,l.p_sec_range);		
			self.p_city_name	:=	choose(cnt	,l.m_p_city_name,l.p_p_city_name);	
			self.v_city_name	:=	choose(cnt	,l.m_v_city_name,l.p_v_city_name);	
			self.st						:=	choose(cnt	,l.m_st,l.p_st);	
			self.zip					:=	choose(cnt	,l.m_zip,l.p_zip);
			self.zip4					:=	choose(cnt	,l.m_zip4,l.p_zip4);	
			self.cart					:=	choose(cnt	,l.m_cart	,l.p_cart);
			self.cr_sort_sz		:=	choose(cnt	,l.m_cr_sort_sz,l.p_cr_sort_sz);	
			self.lot					:=	choose(cnt	,l.m_lot,l.p_lot);				
			self.lot_order		:=	choose(cnt	,l.m_lot_order,l.p_lot_order);
			self.dbpc					:=	choose(cnt	,l.m_dbpc,l.p_dbpc);	
			self.chk_digit		:=	choose(cnt	,l.m_chk_digit,l.p_chk_digit);	
			self.rec_type			:=	choose(cnt	,l.m_rec_type,l.p_rec_type);
			self.fips_state		:=	choose(cnt	,l.m_fips_state,l.p_fips_state);	
			self.fips_county	:=	choose(cnt	,l.m_fips_county,l.p_fips_county);	
			self.geo_lat			:=	choose(cnt	,l.m_geo_lat,l.p_geo_lat	);	
			self.geo_long			:=	choose(cnt	,l.m_geo_long,l.p_geo_long	);	
			self.msa					:=	choose(cnt	,l.m_msa,l.p_msa);	
			self.geo_blk			:=	choose(cnt	,l.m_geo_blk,l.p_geo_blk);	
			self.geo_match		:=	choose(cnt	,l.m_geo_match,l.p_geo_match);
			self.err_stat			:=	choose(cnt	,l.m_err_stat,l.p_err_stat);
			self							:=	l;					 
	end;
		
			dNormAddress			:= 	normalize(pBase, if((trim(left.m_prim_range,left,right)  = trim(left.p_prim_range,left,right) and
																								 trim(left.m_prim_name,left,right)   = trim(left.p_prim_name,left,right) and
																								 trim(left.m_p_city_name,left,right) = trim(left.p_p_city_name,left,right) and
																								 trim(left.m_st,left,right)          = trim(left.p_st,left,right) and
																								 trim(left.m_zip,left,right)         = trim(left.p_zip,left,right)) or
																								(trim(left.p_p_city_name) + trim(left.p_st) + trim(left.p_zip) = '')
																								,1,2),tNormalizeAddress(left,counter)) : persist('persist::DivCert::NormalizeKeys');
										 
			DivCert_Sort := dedup(SORT(dNormAddress, record), record);
	
	return DivCert_Sort;
end;
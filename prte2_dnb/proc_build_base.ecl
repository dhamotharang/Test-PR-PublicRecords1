IMPORT  prte2_dnb,PromoteSupers,prte2, ut, std, address, aid;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

prte2.CleanFields(Files.dnb_In, dnb_Clean);		
	dnb_new := dnb_Clean(cust_name != '');
  dnb_old := dnb_Clean(cust_name = '');
	
	dnb_new_clean_address := PRTE2.AddressCleaner(		dnb_new, 					// Record set with addresses to be cleaned
																										['street','mail_address'],  			// Set of fields containing address line 1
																										['citystatezip','mail_citystatezip'],  			// Set of fields containing address line 2
																										['city','mail_city'],										 			// Set of fields containing city
																										['state','mail_state'],										 			// Set of fields containing state
																										['zip_code','mail_zip_code'],										 			// Set of fields containing zip
																										['clean_address','mail_clean_address'],		 			// Target fields for Address.Layout_Clean182_fips	
																										['admin_rawaid','mail_rawaid1']) ;	   			// Target fields for rawaids
																							
	Layouts.Layout_DNB_Base_Plus xform_dnb(dnb_new_clean_address l) := Transform 
		self := l.clean_address;
		self.dpbc := l.clean_address.dbpc;
		self.county := l.clean_address.fips_county;
		self.rawaid := l.admin_rawaid;
		SELF.mail_prim_range  :=  l.mail_clean_address.prim_range;
		SELF.mail_predir      :=  l.mail_clean_address.predir;
		SELF.mail_prim_name   :=  l.mail_clean_address.prim_name;
		SELF.mail_addr_suffix :=  l.mail_clean_address.addr_suffix;
		SELF.mail_postdir     :=  l.mail_clean_address.postdir;
		SELF.mail_unit_desig  :=  l.mail_clean_address.unit_desig;
		SELF.mail_sec_range   :=  l.mail_clean_address.sec_range;
		SELF.mail_p_city_name :=  l.mail_clean_address.p_city_name;
		SELF.mail_v_city_name :=  l.mail_clean_address.v_city_name;
		SELF.mail_state       :=  l.mail_clean_address.st;
		SELF.mail_zip        :=  l.mail_clean_address.zip;
		SELF.mail_zip4	      :=	l.mail_clean_address.zip4;
		SELF.mail_cart	      :=	l.mail_clean_address.cart;
		SELF.mail_cr_sort_sz	:=	l.mail_clean_address.cr_sort_sz;
		SELF.mail_lot	        :=	l.mail_clean_address.lot;
		SELF.mail_lot_order	  :=	l.mail_clean_address.lot_order;
		SELF.mail_dbpc	      :=	l.mail_clean_address.dbpc;
		SELF.mail_chk_digit	  :=	l.mail_clean_address.chk_digit;
		SELF.mail_rec_type	  :=	l.mail_clean_address.rec_type;
		SELF.mail_county	    :=	l.mail_clean_address.fips_county;
		SELF.mail_geo_lat	    :=	l.mail_clean_address.geo_lat;
		SELF.mail_geo_long	  :=	l.mail_clean_address.geo_long;
		SELF.mail_msa	        :=	l.mail_clean_address.msa;
		SELF.mail_geo_blk	    :=	l.mail_clean_address.geo_blk;
		SELF.mail_geo_match	  :=	l.mail_clean_address.geo_match;
		SELF.mail_err_stat	  :=	l.mail_clean_address.err_stat;
		SELF.mail_rawaid    :=  l.mail_rawaid1;
		
		self.bdid						:= Prte2.fn_AppendFakeID.bdid(l.business_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, L.cust_name);
		
		vLinkingIds := Prte2.fn_AppendFakeID.LinkIds(L.business_name, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip, L.cust_name);
		self.powid	:= vLinkingIds.powid;
		self.proxid	:= vLinkingIds.proxid;
		self.seleid	:= vLinkingIds.seleid;
		self.orgid	:= vLinkingIds.orgid;
		self.ultid	:= vLinkingIds.ultid;
		self := l;
	end;
	
	dnb_clean_new := PROJECT(	dnb_new_clean_address, xform_dnb(left));
	dnb_old_prepped := PROJECT( dnb_old, 
															Transform(layouts.Layout_DNB_Base_Plus, self.dpbc := left.dbpc, self.county := left.fips_county, self := left));

  dnb_combined := dnb_clean_new + dnb_old_prepped;
	
	PromoteSupers.MAC_SF_BuildProcess(dnb_combined,'~PRTE::BASE::dnb', writefile)
	
Return writefile;
END;
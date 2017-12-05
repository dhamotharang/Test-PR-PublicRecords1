IMPORT  PromoteSupers,PRTE2,Address, aid, std, ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

	PRTE2.CleanFields(Files.VotersV2_IN, clean_df);
	df := clean_df(cust_name != '');

	voters_new_clean_address := PRTE2.AddressCleaner(		df, 					// Record set with addresses to be cleaned
																														['res_addr1','mail_addr1' ],  			// Set of fields containing address line 1
																														['street_address_2', 'mail_street_addr2'],  			// Set of fields containing address line 2
																														['res_city', 'mail_city'],										 			// Set of fields containing city
																														['res_state', 'mail_state'],										 			// Set of fields containing state
																														['res_zip', 'mail_zip'],										 			// Set of fields containing zip
																														['clean_address', 'clean_mail_addr'],		 			// Target fields for Address.Layout_Clean182_fips	
																														['admin_rawaid', 'mail_rawaid']) ;	   			// Target fields for rawaids
																														
	Layouts.Base_ext xform_clean(voters_new_clean_address l) := transform
				fullname := STD.Str.CleanSpaces(l.first_name) + ' ' + STD.Str.CleanSpaces(l.middle_name) + ' ' + STD.Str.CleanSpaces(l.last_name);
				clean_name 						:= Address.CleanPersonFML73(fullname);
				self.title 						:= Address.CleanNameFields(clean_name).title;
				self.fname 						:= Address.CleanNameFields(clean_name).fname;
				self.mname 						:= Address.CleanNameFields(clean_name).mname;
				self.lname 						:= Address.CleanNameFields(clean_name).lname;
				self.name_suffix := Address.CleanNameFields(clean_name).name_suffix;
				self.did := prte2.fn_AppendFakeID.did(self.fname, self.lname, l.link_ssn, l.link_dob, l.cust_name);
				SELF.mail_prim_range  :=  l.clean_mail_addr.prim_range;
				SELF.mail_predir      :=  l.clean_mail_addr.predir;
				SELF.mail_prim_name   :=  l.clean_mail_addr.prim_name;
				SELF.mail_addr_suffix :=  l.clean_mail_addr.addr_suffix;
				SELF.mail_postdir     :=  l.clean_mail_addr.postdir;
				SELF.mail_unit_desig  :=  l.clean_mail_addr.unit_desig;
				SELF.mail_sec_range   :=  l.clean_mail_addr.sec_range;
				SELF.mail_p_city_name :=  l.clean_mail_addr.p_city_name;
				SELF.mail_v_city_name :=  l.clean_mail_addr.v_city_name;
				SELF.mail_st        :=  l.clean_mail_addr.st;
				SELF.mail_ace_zip       :=  l.clean_mail_addr.zip;
				SELF.mail_zip4	      :=	l.clean_mail_addr.zip4;
				SELF.mail_cart	      :=	l.clean_mail_addr.cart;
				SELF.mail_cr_sort_sz	:=	l.clean_mail_addr.cr_sort_sz;
				SELF.mail_lot	        :=	l.clean_mail_addr.lot;
				SELF.mail_lot_order	  :=	l.clean_mail_addr.lot_order;
				SELF.mail_dpbc	      :=	l.clean_mail_addr.dbpc;
				SELF.mail_chk_digit	  :=	l.clean_mail_addr.chk_digit;
				SELF.mail_rec_type	  :=	l.clean_mail_addr.rec_type;
				SELF.mail_ace_fips_st	:=	l.clean_mail_addr.fips_state;
				SELF.mail_county	    :=	l.clean_mail_addr.fips_county;
				SELF.mail_geo_lat	    :=	l.clean_mail_addr.geo_lat;
				SELF.mail_geo_long	  :=	l.clean_mail_addr.geo_long;
				SELF.mail_msa	        :=	l.clean_mail_addr.msa;
				SELF.mail_geo_blk	    :=	l.clean_mail_addr.geo_blk;
				SELF.mail_geo_match	  :=	l.clean_mail_addr.geo_match;
				SELF.mail_err_stat	  :=	l.clean_mail_addr.err_stat;
				SELF.ace_fips_st :=  l.clean_address.fips_state;
				SELF.mail_fips_county := l.clean_address.fips_county;
				self 	:= l.clean_address;
				Self.phone:=if(l.phone = '0','',l.phone); 
				temp_st := if(trim(l.source_state,right,left) <> '',l.source_state,
	                      if(trim(l.st,left,right) <> '',l.st,l.mail_st));
			
				self.rid        := hash64(temp_st, l.vendor_id, self.lname, self.name_suffix, self.fname, self.mname, 
																														l.name_type, l.dob, l.addr_type, self.prim_range, self.prim_name, self.predir,
																														self.addr_suffix, self.postdir, self.unit_desig, self.sec_range, self.p_city_name,
																														self.st, self.zip, l.file_acquired_date);
				self	:= l;
	end;

	dfbase := PROJECT(voters_new_clean_address, xform_clean(left)) + 
											PROJECT(clean_df(cust_name = ''), 
																			transform(Layouts.Base_ext,
																													Self.phone:=if(left.phone = '0','',left.phone),
																													SELF:=Left));
						
	PromoteSupers.MAC_SF_BuildProcess(dfbase,constants.Base_VotersV2, writefile);

	return writefile;

END;
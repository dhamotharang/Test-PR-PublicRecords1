IMPORT  PRTE2_PAW,PromoteSupers, std, prte2, ut;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
	PRTE2.CleanFields(Files.file_paw_IN, CleanPAW);

	df_paw_infile := PROJECT(CleanPAW, TRANSFORM(	layouts.layout_base,
												SELF.company_title := std.str.cleanspaces(left.company_name),
												self.company_name := TRIM(stringlib.StringToUpperCase(left.company_name),left,right),
												self.domain 	:= TRIM(stringlib.StringToUpperCase(regexfind('[@](.*)',left.email_address,1)),left,right),
												self.Did			:=	Prte2.fn_AppendFakeID.did(left.fname, left.lname, left.link_ssn, left.link_dob, left.cust_name);	
												self.bdid 		:= prte2.fn_AppendFakeID.bdid(left.company_name,	left.company_PRIM_RANGE,left.Company_PRIM_NAME, left.Company_CITY, left.Company_state, left.Company_ZIP, left.Cust_name);
												vLinkingIds		:=	prte2.fn_AppendFakeID.LinkIds(Left.company_name, Left.link_fein, Left.link_inc_date, 
																																															Left.company_prim_range, Left.company_prim_name, Left.company_sec_range, Left.company_city, 
																																															Left.company_state, Left.company_zip, Left.cust_name);
																																																
											self.powid		:= vLinkingIds.powid;
											self.proxid		:= vLinkingIds.proxid;
											self.seleid		:= vLinkingIds.seleid;
											self.orgid		:= vLinkingIds.orgid;
											self.ultid		:= vLinkingIds.ultid;
											
											SELF := left,
											self := []));

	
	df_paw_reformat := project(df_paw_infile, transform(layouts.layout_base,
														self.contact_id 		:= hash64(left.did,
																													left.bdid,
																													left.ssn,
																													left.company_name,
																													left.company_prim_range,
																													left.company_predir,
																													left.company_prim_name,
																													left.company_addr_suffix,
																													left.company_unit_desig,
																													left.company_sec_range,
																													left.company_city,
																													left.company_state,
																													left.company_zip,
																													left.company_title,
																													left.company_phone,
																													left.company_fein,
																													left.fname,
																													left.mname,
																													left.lname,
																													left.name_suffix,
																													left.prim_range,
																													left.predir,
																													left.prim_name,
																													left.addr_suffix,
																													left.unit_desig,
																													left.sec_range,
																													left.city,
																													left.state,
																													left.zip,
																													left.phone,
																													left.email_address,
																													left.source);
										self := left;
										));

	PromoteSupers.MAC_SF_BuildProcess(df_paw_reformat,'~PRTE::BASE::paw', writefile_paw_basefile);

	sequential(writefile_paw_basefile);

	Return 'success';
END;
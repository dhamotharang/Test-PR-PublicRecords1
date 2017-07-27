import dnb_feinv2, dnb_feinv2_services, AutoStandardI;

export fn_get_dnb_fein_tmsid_boolean(
	dataset(dnb_feinv2_services.layout_tmsid_ext) in_tmsids0,
	unsigned in_limit
	) :=
		function
			// GO GET THE TMSIDS TO USE
			// in_tmsids := dnb_feinv2_services.ids(in_parms);
			in_tmsids := in_tmsids0;
			
			// RETRIEVE RECORDS FROM THE DNB FEIN DATA BY TMSID. ADD PENALTY AND
			// DEEP-DIVE INFORMATION AT JOIN TIME.
			temp_records := join(
				in_tmsids,
				dnb_feinv2.key_dnb_fein_tmsid,
				keyed(left.tmsid = right.tmsid),
				transform(
					dnb_feinv2_services.layouts.layout_flat,
					tempmodindv := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
						export boolean allow_wildcard := false;
						export string city_field := right.v_city_name;
						export string city2_field := '';
						export string county_field := '';
						export string did_field := '';
						export string dob_field := '';
						export string fname_field := '';
						export string lname_field := '';
						export string mname_field := '';
						export string phone_field := '';
						export string pname_field := right.prim_name;
						export string postdir_field := right.postdir;
						export string prange_field := right.prim_range;
						export string predir_field := right.predir;
						export string ssn_field := '';
						export string state_field := right.st;
						export string suffix_field := right.addr_suffix;
						export string zip_field := right.zip;
					end;
					tempmodbizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
						export string cname_field := right.clean_cname;
					end;
					tempmodbdid := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
						export string bdid_field := right.bdid;
					end;
					tempmodfein := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
						export string fein_field := right.fein;
					end;
					self.penalt :=
						AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempmodindv) +
						AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname) +
						AutoStandardI.LIBCALL_PenaltyI_BDID.val(tempmodbdid) +
						AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodfein);
					self := right,
					self := left),
				keep(1000));
			
			// DEDUP BY EVERYTHING EXCEPT DATE LAST SEEN
			temp_records_dedup := dedup(sort(temp_records,record),record,except date_last_seen,right);
			
			// NOW, SORT BY TMSID AND COMPANY NAME (THE TWO ROLLUP LEVELS)
			temp_records_sort := sort(temp_records_dedup,tmsid,orig_company_name);
			
			// ROLL UP ADDRESSES BY TMSID AND COMPANY NAME
			temp_name_addr_roll := rollup(
				group(temp_records_sort,tmsid,orig_company_name),
				group,
				transform(
					dnb_feinv2_services.layouts.layout_rollup_address,
					self.penalt := min(rows(left),penalt),
					self.addresses := project(
						choosen(
							sort(rows(left),-date_last_seen,record),
							dnb_feinv2_services.constants.ADDRESSES_PER_PARTY),
						dnb_feinv2_services.layouts.layout_address),
					self := left));
			
			// ROLL UP PARTIES BY TMSID
			temp_rollup_roll := rollup(
				group(temp_name_addr_roll,tmsid),
				group,
				transform(
					dnb_feinv2_services.layouts.layout_rollup,
					self.penalt := min(rows(left),penalt),
					self.parties := project(
						choosen(
							sort(rows(left),-date_last_seen,record),
							dnb_feinv2_services.constants.PARTIES_PER_TMSID),
						dnb_feinv2_services.layouts.layout_party),
					self := left));
			
			// RETURN THE ROLLED UP OUTPUT
			return temp_rollup_roll;
		end;
		
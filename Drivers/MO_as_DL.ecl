basic_in := drivers.File_Mo_BascData_Raw;
issue_in := drivers.File_Mo_icissu_raw;

basic_dist := distribute(basic_in, hash(UNIQUE_KEY));
basic_sort := sort(basic_dist,UNIQUE_KEY,STREET,CITY,STATE,ZIP,COUTY_MODL,HEIGHT,WEIGHT,EYES,LIC_EXP_DATE,ID_EXP_DATE,CLASS,OPER_STATUS,COMM_STATUS,SCHL_BUS_STATUS,STOP_ACTIVITY,HOLD_ACTION,ID_CARD_IC,LIC_IC,PERMIT_IND,DONOR_IND,MULTI_IC,DECEASED_IND,SPEC_HANDLG,LIS_HIST,MICRO_FILM,DOC_DATE,NA_USER_ID,LUPT_DATE,RDP_TDP_CD,PEND_ACTION,MUST_TEST,RDPA_ELIG,LIC_ISS_CD,ISS_DATE,PREV_CLASS,OPEN_MI,PDPS_PTR,LIS_PTR,WALKIN_DATE,DPPA_CODE,Lastname,Firstname,Middlename,NAME,CLN,BIRTHDATE,SEX,RECORD_TYPE,USER_ID_DRV,LUPDT_BD,process_date,local);
basic_dedup:= dedup(basic_sort,UNIQUE_KEY,STREET,CITY,STATE,ZIP,COUTY_MODL,HEIGHT,WEIGHT,EYES,LIC_EXP_DATE,ID_EXP_DATE,CLASS,OPER_STATUS,COMM_STATUS,SCHL_BUS_STATUS,STOP_ACTIVITY,HOLD_ACTION,ID_CARD_IC,LIC_IC,PERMIT_IND,DONOR_IND,MULTI_IC,DECEASED_IND,SPEC_HANDLG,LIS_HIST,MICRO_FILM,DOC_DATE,NA_USER_ID,LUPT_DATE,RDP_TDP_CD,PEND_ACTION,MUST_TEST,RDPA_ELIG,LIC_ISS_CD,ISS_DATE,PREV_CLASS,OPEN_MI,PDPS_PTR,LIS_PTR,WALKIN_DATE,DPPA_CODE,Lastname,Firstname,Middlename,NAME,CLN,BIRTHDATE,SEX,RECORD_TYPE,USER_ID_DRV,LUPDT_BD,local);
issue_dist := distribute(issue_in, hash(D_NO_UNIQUE_ID_ISKEY));
issue_sort := sort(issue_dist,D_NO_UNIQUE_ID_ISKEY,D_DA_DATE_ADDED_ISKEY,D_DA_PURGE_ISKEY,D_CD_SPECIAL_ISKEY,D_NA_USER_ID_ISKEY,D_DA_PROCESS_ISKEY,D_CD_RECORD_TYPE_ISHIS,D_CD_TRANS_TYPE_ISHIS,D_CD_TRANS_CHG_ISHIS,D_NO_SEQUENTIAL_YY_ISHIS,D_NO_SEQUENTIAL_OFFICE_ISHIS,D_NO_SEQUENTIAL_JUL_ISHIS,D_NO_SEQUENTIAL_NO1_ISHIS,D_NO_SEQUENTIAL_NO2_ISHIS,D_DA_EXPIRATION_ISHIS,D_CD_CLASS_ISHIS,D_CD_ENDORSEMENTS_X_ISHIS,D_CD_RESTRICTIONS_X_ISHS,D_NO_TEST_NUMBER_ISHIS,D_NO_MICROFILM_ISHIS,D_DA_MICROFILM_ISHIS,D_DA_PROCESS_ISHIS,D_DA_LICENSE_MAILED_ISHIS,D_CD_PROCESS_ISHIS,D_CD_PROCESS_REASON_ISHIS,D_DA_RETAKE_ISSUED_ISHIS,D_CD_RETAKE_ISHIS,D_DA_LAST_UPDATE_ISHIS,D_NA_USER_ID_ISHIS,D_CD_COMPACT_TYPE_ISCPS,D_DA_SURRENDER_ISCPS,D_NA_STATE_ISCPS,D_CD_SURRENDER_TYPE_ISCPS,D_NO_OS_LICENSE_NO_ISCPS,D_DA_PROCESS_ISCPS,D_NA_USER_ID_ISCPS,D_CD_COMPACT_TYPE_ISCPS_1,D_DA_SURRENDER_ISCPS_1,D_NA_STATE_ISCPS_1,D_CD_SURRENDER_TYPE_ISCPS_1,D_NO_OS_LICENSE_NO_ISCPS_1,D_DA_PROCESS_ISCPS_1,D_NA_USER_ID_ISCPS_1,process_date,local);
issue_dedup:= dedup(issue_sort,D_NO_UNIQUE_ID_ISKEY,D_DA_DATE_ADDED_ISKEY,D_DA_PURGE_ISKEY,D_CD_SPECIAL_ISKEY,D_NA_USER_ID_ISKEY,D_DA_PROCESS_ISKEY,D_CD_RECORD_TYPE_ISHIS,D_CD_TRANS_TYPE_ISHIS,D_CD_TRANS_CHG_ISHIS,D_NO_SEQUENTIAL_YY_ISHIS,D_NO_SEQUENTIAL_OFFICE_ISHIS,D_NO_SEQUENTIAL_JUL_ISHIS,D_NO_SEQUENTIAL_NO1_ISHIS,D_NO_SEQUENTIAL_NO2_ISHIS,D_DA_EXPIRATION_ISHIS,D_CD_CLASS_ISHIS,D_CD_ENDORSEMENTS_X_ISHIS,D_CD_RESTRICTIONS_X_ISHS,D_NO_TEST_NUMBER_ISHIS,D_NO_MICROFILM_ISHIS,D_DA_MICROFILM_ISHIS,D_DA_PROCESS_ISHIS,D_DA_LICENSE_MAILED_ISHIS,D_CD_PROCESS_ISHIS,D_CD_PROCESS_REASON_ISHIS,D_DA_RETAKE_ISSUED_ISHIS,D_CD_RETAKE_ISHIS,D_DA_LAST_UPDATE_ISHIS,D_NA_USER_ID_ISHIS,D_CD_COMPACT_TYPE_ISCPS,D_DA_SURRENDER_ISCPS,D_NA_STATE_ISCPS,D_CD_SURRENDER_TYPE_ISCPS,D_NO_OS_LICENSE_NO_ISCPS,D_DA_PROCESS_ISCPS,D_NA_USER_ID_ISCPS,D_CD_COMPACT_TYPE_ISCPS_1,D_DA_SURRENDER_ISCPS_1,D_NA_STATE_ISCPS_1,D_CD_SURRENDER_TYPE_ISCPS_1,D_NO_OS_LICENSE_NO_ISCPS_1,D_DA_PROCESS_ISCPS_1,D_NA_USER_ID_ISCPS_1,local);

drivers.layout_dl make_mo(basic_in l, issue_in r) := transform
	//self.did:= 0 ;
	//self.Preglb_did:= 0 ;
    self.dt_first_seen := (unsigned8)l.process_date div 100;
    self.dt_last_seen := (unsigned8)l.process_date div 100;
    self.dt_vendor_first_reported := (unsigned8)l.process_date div 100;
    self.dt_vendor_last_reported := (unsigned8)l.process_date div 100;
	self.orig_state := 'MO';
	self.history :='';
	self.name := trim(l.firstname) + ' ' + trim(l.middlename) + ' ' + trim(l.lastname) + ' ' + trim(l.name);
	self.addr1 := l.street;
	self.city := l.city;
	self.state := l.state;
	self.zip := l.zip;
	self.dob := (unsigned4)l.birthdate;
	self.race := '';
	self.sex_flag := l.sex;
	self.license_type := if(r.D_CD_RECORD_TYPE_ISHIS <> 'L', r.D_CD_RECORD_TYPE_ISHIS, r.D_CD_CLASS_ISHIS);
	self.attention_flag := l.donor_ind;
	self.dod := '';
	self.restrictions := r.D_CD_RESTRICTIONS_X_ISHS;
	self.orig_expiration_date := if(r.D_DA_EXPIRATION_ISHIS='' or r.D_DA_EXPIRATION_ISHIS='00000000' or r.D_DA_EXPIRATION_ISHIS='99999999',
									0,
									(unsigned4)r.D_DA_EXPIRATION_ISHIS
								   ); 
	self.orig_issue_date := 0; 		//what goes here
	self.lic_issue_date := (unsigned4)r.D_DA_LICENSE_MAILED_ISHIS;
	self.expiration_date := 0;		//what goes here
	self.active_date := 0;			//what goes here
	self.inactive_date := 0;		//what goes here
	self.lic_endorsement := r.D_CD_ENDORSEMENTS_X_ISHIS;
	self.motorcycle_code := '';
	self.dl_number := l.cln;
	self.ssn := '';
	self.age := '';
	self.privacy_flag := l.DPPA_Code;
	self.driver_edu_code := '';
	self.dup_lic_count:= '';
	self.rcd_stat_flag:= '';
	self.height := l.height;
	self.hair_color:= '';
	self.eye_color:= l.eyes;
	self.weight := l.weight;
	self.oos_previous_dl_number := r.D_NO_OS_LICENSE_NO_ISCPS;
	self.oos_previous_st := If( r.D_CD_COMPACT_TYPE_ISCPS = '1', r.D_NA_STATE_ISCPS, '');
	/*self.title;
	self.fname;
	self.mname;
	self.lname;
	self.name_suffix;
	self.cleaning_score;
	self.addr_fix_flag := '';
	self.prim_range;
	self.predir;
	self.prim_name;
	self.suffix;
	self.postdir;
	self.unit_desig;
	self.sec_range;
	self.p_city_name;
	self.v_city_name;
	self.st;
	self.zip5;
	self.zip4;
	self.cart;
	self.cr_sort_sz;
	self.lot;
	self.lot_order;
	self.dpbc := '';
	self.chk_digit;
	self.rec_type;
	self.ace_fips_st := '';
	self.county;
	self.geo_lat;
	self.geo_long;
	self.msa := '';
	self.geo_blk;
	self.geo_match;
	self.err_stat;*/
	self.status := '';
	self.issuance := r.D_CD_TRANS_TYPE_ISHIS;
	self.address_change := '';
	self.name_change := '';
	self.dob_change := '';
	self.sex_change := '';
	self.old_dl_number := '';
	self.dl_key_number:= r.D_NO_Unique_ID_ISKEY;

	self := l;

end;

export MO_as_DL := join(basic_dedup, issue_dedup,
						left.unique_key = right.D_NO_UNIQUE_ID_ISKEY,
						make_mo(left, right),
						left outer,
						local) : persist(Drivers.Cluster + 'Persist::DrvLic_MO_as_DL');
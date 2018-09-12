IMPORT Address,BIPV2,BipV2_Best,BIPV2_Build,DCA,ExecAtHomeV2,Gong,
       PAW,ProfileBooster,Std,watchdog;       

EXPORT Transforms := 
MODULE
    
  EXPORT BIPV2.IDFunctions.rec_SearchInput xfmFormatInput(ExecAtHomeV2.Layouts.layoutBatchIn l) := 
  TRANSFORM
    UNSIGNED1 region      := address.Components.Country.US; 
    addr2                 := Address.Addr2FromComponents(l.city, l.st, l.zip);
    cleanAddr             := Address.GetCleanAddress(l.business_address, addr2, region).results;
    SELF.company_name     := l.business_name; 
    SELF.prim_range       := cleanAddr.prim_range;
    SELF.prim_name        := cleanAddr.prim_name;
    SELF.zip5             := IF (l.zip <> '', l.zip, cleanAddr.zip);
    SELF.sec_range        := cleanAddr.sec_range;
    SELF.city             := IF(cleanAddr.v_city <> '',
                                cleanAddr.v_city,		                  
                                l.city);
    SELF.state            := IF(l.st <> '',
                                l.st,
                                cleanAddr.state);
    SELF.phone10          := Std.Str.Filter(l.phone,'0123456789');
    SELF.fein             := Std.Str.Filter(l.fein,'0123456789');
    SELF.acctno           := l.acctno;
    SELF.zip_radius_miles := ExecAtHomeV2.Constants.BIP_MAX_MILE_RADIUS;
    SELF                  := [];
  END;

  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddMktBestFields(ExecAtHomeV2.Layouts.SearchSlimLayout l, 
                                                                 BipV2_Best.Key_LinkIds.kfetch2_layout r) := 
  TRANSFORM
    SELF.Acctno := l.acctno;
    SELF.UltID := r.UltID;
	  SELF.OrgID := r.OrgID;
	  SELF.SELEID := r.SELEID;
	  SELF.ProxID := r.ProxID;
	  SELF.POWID := r.POWID;
	  SELF.EmpID := r.EmpID;
	  SELF.DotID := r.DotID;
    SELF.bdid := r.company_bdid;
    SELF.business_best_company_name := r.company_name[1].company_name;  
    SELF.business_best_prim_range := r.company_address[1].company_prim_range;  
    SELF.business_best_predir := r.company_address[1].company_predir;
    SELF.business_best_prim_name := r.company_address[1].company_prim_name;
    SELF.business_best_addr_suffix := r.company_address[1].company_addr_suffix;
    SELF.business_best_postdir := r.company_address[1].company_postdir;
    SELF.business_best_unit_desig := r.company_address[1].company_unit_desig;
    SELF.business_best_sec_range := r.company_address[1].company_sec_range;
    SELF.business_best_city := r.company_address[1].address_v_city_name;
    SELF.business_best_state := r.company_address[1].company_st;
    SELF.business_best_zip := r.company_address[1].company_zip5;
    SELF.business_best_zip4 := r.company_address[1].company_zip4;
    SELF.business_best_phone := r.company_phone[1].company_phone;  
    SELF.business_best_sic_code := r.sic_code[1].company_sic_code1;
    SELF.business_best_fein := r.company_fein[1].company_fein;
    SELF := [];
  END;

  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddMktContactFields(ExecAtHomeV2.Layouts.expandedLayout l, 
                                                                    RECORDOF(BIPV2_Build.key_contact_linkids.kFetchMarketing) r) := 
  TRANSFORM
    SELF.did := r.contact_did;
    SELF.company_title := r.contact_job_title_derived; 
    SELF.business_decision_maker_flag := IF(r.Executive_ind,'Y','');  
    SELF.business_owner_flag := IF(r.contact_job_title_derived = ExecAtHomeV2.Constants.OWNER,'Y',''); 
    SELF.person_best_phone := r.contact_phone;
    SELF.dob := (STRING8)r.contact_dob;  
    SELF.bdid := IF(l.bdid = 0,r.company_bdid,l.bdid);
    SELF := l;
  END;  

  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmGetPawData(ExecAtHomeV2.Layouts.SearchSlimLayout l, 
                                                           RECORDOF(paw.Key_LinkIDs.kFetch) r) := 
  TRANSFORM
    SELF.Acctno := l.acctno;
    SELF.UltID := l.UltID;
	  SELF.OrgID := l.OrgID;
	  SELF.SELEID := l.SELEID;
	  SELF.ProxID := l.ProxID;
	  SELF.POWID := l.POWID;
	  SELF.EmpID := l.EmpID;
	  SELF.DotID := l.DotID;
    SELF.did := r.did;
    SELF.bdid := r.bdid;
    SELF.company_title := r.company_title;  
    SELF.business_owner_flag := IF(r.company_title = ExecAtHomeV2.Constants.OWNER,'Y','');
    SELF.person_best_fname := r.fname;
    SELF.person_best_mname := r.mname;
    SELF.person_best_lname := r.lname;
    SELF.person_best_name_suffix := r.name_suffix;
    SELF.person_prim_range := r.prim_range;
    SELF.person_predir := r.predir;
    SELF.person_prim_name := r.prim_name;
    SELF.person_suffix := r.addr_suffix;
    SELF.person_postdir := r.postdir;
    SELF.person_unit_desig := r.unit_desig;
    SELF.person_sec_range := r.sec_range;
    SELF.person_best_city := r.city;
    SELF.person_best_state := r.state;
    SELF.person_best_zip := r.zip;
    SELF.person_best_zip4 := r.zip4;
    SELF.person_addr_dt_last_seen := r.dt_last_seen;
    SELF.person_best_phone := r.phone; 
    SELF.person_best_phone_active := r.active_phone_flag;
    SELF.ssn := r.ssn;
    SELF.emailAddress := r.email_address;
    SELF.business_best_company_name := r.company_name;
    SELF.business_best_prim_range := r.company_prim_range;
    SELF.business_best_predir := r.company_predir;
    SELF.business_best_prim_name := r.company_prim_name;
    SELF.business_best_addr_suffix := r.company_addr_suffix;
    SELF.business_best_postdir := r.company_postdir;
    SELF.business_best_unit_desig := r.company_unit_desig;
    SELF.business_best_sec_range := r.company_sec_range;
    SELF.business_best_city := r.company_city;
    SELF.business_best_state := r.company_state;
    SELF.business_best_zip := r.company_zip;
    SELF.business_best_zip4 := r.company_zip4;
    SELF.business_best_phone := r.company_phone;
    SELF.business_best_fein := r.company_fein;
    SELF.sourceCode := r.source;
    SELF.dt_last_seen := r.dt_last_seen;
    SELF := [];
  END;
  
  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddWatchdogFields(ExecAtHomeV2.Layouts.expandedLayout l, 
                                                                  watchdog.Layout_best_flags r) := 
  TRANSFORM
    SELF.person_best_fname := r.fname;
    SELF.person_best_mname := r.mname;
    SELF.person_best_lname := r.lname;
    SELF.person_best_name_suffix := r.name_suffix;
    SELF.person_prim_range := r.prim_range;
    SELF.person_predir := r.predir;
    SELF.person_prim_name := r.prim_name;
    SELF.person_suffix := r.suffix;
    SELF.person_postdir := r.postdir;
    SELF.person_unit_desig := r.unit_desig;
    SELF.person_sec_range := r.sec_range;
    SELF.person_best_city := r.city_name;
    SELF.person_best_state := r.st;
    SELF.person_best_zip := r.zip;
    SELF.person_best_zip4 := r.zip4;
    SELF.person_addr_dt_last_seen := (STRING8)r.addr_dt_last_seen;
    SELF.dob := IF(r.dob != 0,
                   (STRING8)r.dob,
                   l.dob);
    SELF.person_best_phone := IF(l.person_best_phone != '', //precedence: Marketing fetch, gong, watchdog 
                                 l.person_best_phone, 
                                 r.phone); 
    SELF.watchdogPhone := l.person_best_phone = '';  
    SELF.ssn := r.ssn;
    SELF := l;
  END;

  EXPORT ProfileBooster.Layouts.Layout_PB_In xfmToProfileBoosterInput(ExecAtHomeV2.Layouts.expandedLayout l, 
                                                                      INTEGER c) :=
  TRANSFORM
    SELF.AcctNo := l.acctno;
    SELF.seq := c;
    SELF.LexID := l.did;
    SELF.Name_First := l.person_best_fname;
    SELF.Name_Middle := l.person_best_mname;
    SELF.Name_Last := l.person_best_lname;
    SELF.Name_Suffix := l.person_best_name_suffix;
    SELF.ssn := l.ssn;
    SELF.dob := l.dob;  
    SELF.phone10 := l.person_best_phone;
    SELF.streetnumber := l.person_prim_range;
    SELF.streetpredirection := l.person_predir;
    SELF.streetname := l.person_prim_name;
    SELF.streetsuffix := l.person_suffix;
    SELF.streetpostdirection := l.person_postdir;
    SELF.unitdesignation := l.person_unit_desig;
    SELF.unitnumber := l.person_sec_range;
    SELF.street_addr := Address.Addr1FromComponents(l.person_prim_range, l.person_predir, 
                                                    l.person_prim_name,l.person_suffix, 
                                                    l.person_postdir, l.person_unit_desig, 
                                                    l.person_sec_range);
    SELF.City_name := l.person_best_city;
    SELF.st := l.person_best_state;
    SELF.z5 := l.person_best_zip;
    SELF.country := 'UNITED STATES';
    SELF := [];
  END;
    
  // Profile Booster fields
  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddProfileBoosterFields(ExecAtHomeV2.Layouts.expandedLayout l,
                                                                        ProfileBooster.Layouts.Layout_PB_BatchOut r) :=
  TRANSFORM
    SELF.Age := IF(r.attributes.version1.ProspectAge = '-1',
                   '',r.attributes.version1.ProspectAge);
    SELF.Gender := IF(r.attributes.version1.ProspectGender = '0',  
                      '', r.attributes.version1.ProspectGender);
    SELF.MaritalStatus := IF(r.attributes.version1.ProspectMaritalStatus = '0', 
                             '', r.attributes.version1.ProspectMaritalStatus);
    SELF.estimated_home_income_predictor := r.attributes.version1.ProspectEstimatedIncomeRange;
    SELF.ProspectDeceased := r.attributes.version1.ProspectDeceased;
    SELF.ProspectCollegeAttended := r.attributes.version1.ProspectCollegeAttended;
    SELF.ResCurrBusinessCnt := IF(r.attributes.version1.ResCurrBusinessCnt = '-1',
                                  '',r.attributes.version1.ResCurrBusinessCnt);
    SELF.ResInputBusinessCnt := IF(r.attributes.version1.ResInputBusinessCnt = '-1',
                                   '',r.attributes.version1.ResInputBusinessCnt);
    SELF.CrtRecCnt := r.attributes.version1.CrtRecCnt;
    SELF.CrtRecCnt12Mo := r.attributes.version1.CrtRecCnt12Mo;
    SELF.CrtRecLienJudgCnt := r.attributes.version1.CrtRecLienJudgCnt;
    SELF.CrtRecLienJudgCnt12Mo := r.attributes.version1.CrtRecLienJudgCnt12Mo;
    SELF.CrtRecBkrptCnt := r.attributes.version1.CrtRecBkrptCnt;
    SELF.CrtRecBkrptCnt12Mo := r.attributes.version1.CrtRecBkrptCnt12Mo;
    SELF.OccProfLicense := r.attributes.version1.OccProfLicense;
    SELF.OccProfLicenseCategory := r.attributes.version1.OccProfLicenseCategory;
    SELF.OccBusinessAssociation := r.attributes.version1.OccBusinessAssociation;
    SELF.OccBusinessAssociationTime := IF(r.attributes.version1.OccBusinessAssociationTime = '-1',
                                          '',r.attributes.version1.OccBusinessAssociationTime);
    SELF.household_Income_Identifier := r.attributes.version1.HHEstimatedIncomeRange;
    SELF.HHOccBusinessAssocMmbrCnt := r.attributes.version1.HHOccBusinessAssocMmbrCnt;
    SELF.RaAOccBusinessAssocMmbrCnt := r.attributes.version1.RaAOccBusinessAssocMmbrCnt;
    SELF.dwelling_type := IF(r.attributes.version1.ResCurrDwellType = '-1',
                             '',r.attributes.version1.ResCurrDwellType);
    SELF.HouseholdCount := r.attributes.version1.HHCnt;
    SELF.HHTeenagerMmbrCnt := r.attributes.version1.HHTeenagerMmbrCnt;  
	  SELF.HHYoungAdultMmbrCnt := r.attributes.version1.HHYoungAdultMmbrCnt;  
	  SELF.HHMiddleAgemmbrCnt := r.attributes.version1.HHMiddleAgemmbrCnt;  
	  SELF.HHSeniorMmbrCnt := r.attributes.version1.HHSeniorMmbrCnt;  
	  SELF.HHElderlyMmbrCnt := r.attributes.version1.HHElderlyMmbrCnt;
    SELF := l;
  END;

  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddGongPhoneFields(ExecAtHomeV2.Layouts.expandedLayout l,
                                                                   RECORDOF(Gong.Key_History_Did) r) :=
  TRANSFORM
    phoneToUse := IF(l.watchdogPhone AND r.phone10 != '', //precedence: Marketing fetch, gong, watchdog 
                     r.phone10,
                     l.person_best_phone); 
    SELF.person_best_phone := phoneToUse;
    // the following r.phone10 = phoneToUse should always be true if the current_flag is true
    // the check is precautionary in case there is a glitch in the data updates 
    SELF.person_best_phone_active := IF(r.current_flag AND r.phone10 = phoneToUse,
                                        'Y','');
    SELF.hhid := r.hhid;
    SELF := l;    
  END;
  
  EXPORT ExecAtHomeV2.Layouts.expandedLayout xfmAddDCAFields(ExecAtHomeV2.Layouts.expandedLayout l,
                                                             RECORDOF(DCA.Key_DCA_BDID) r) :=
  TRANSFORM
    SELF.Sales := r.sales;
    SELF.EmployeeCnt := r.emp_num;
    SELF.business_best_phone := IF(l.business_best_phone = '', 
                                   r.phone, 
                                   l.business_best_phone);
    SELF.business_best_sic_code := IF(l.business_best_sic_code = '', 
                                      r.sic1,
                                      l.business_best_sic_code);
    SELF.emailAddress := r.e_mail; 
    SELF.OrgType := r.type_orig;
    SELF := l;
  END;
END;
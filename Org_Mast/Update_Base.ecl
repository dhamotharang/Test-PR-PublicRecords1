import Address, std,
ut, DID_Add, Business_Header, Business_Header_SS, NID, AID,
Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility;

Today := Std.Date.SecondsToString(std.date.CurrentSeconds(true), '%Y%m%d%H%M%S');
EXPORT Update_Base (STRING filedate, boolean pUseProd = true) := module


 EXPORT	Org_Mast.layouts.Organization_Base ReplaceLNFID_with_LNPID(Org_Mast.layouts.Organization_Base/*with_lnpid*/  L) := TRANSFORM
				 self.LNFID            := L.LNPID;
				 SELF						 			 := L;
				 //SELF 								 := [];
 END;

 EXPORT	Org_Mast.layouts.POS_Base ReplaceLNFID_with_LNPID_POS(Org_Mast.layouts.POS_Base/*with_lnpid*/  L) := TRANSFORM
				 self.LNFID            := if(L.LNFID = 0 and L.LNPID > 0, L.LNPID, L.LNFID) ;
				 SELF						 			 := L;
				 //SELF 								 := [];
 END;

 EXPORT	Org_Mast.layouts.AHA_Base ReplaceLNFID_with_LNPID_AHA(Org_Mast.layouts.AHA_Base/*with_lnpid*/  L) := TRANSFORM
				 self.LNFID            := if(L.LNFID = 0 and L.LNPID > 0, L.LNPID, L.LNFID) ;
				 SELF						 			 := L;
				 //SELF 								 := [];
 END;

 EXPORT HashItem(STRING item, BOOLEAN lastItem = false) :=
		IF(lastItem, trim(item, LEFT, RIGHT), (trim(item, LEFT, RIGHT) + ','));

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type	:= 'H';
				SELF							:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;

	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
		AID.MacAppendFromRaw_2Line(pBaseFile,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     := L.aidwork_rawaid;
			SELF.ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := STRINGlib.STRINGfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := STRINGlib.STRINGfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := STRINGlib.STRINGfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(STRINGlib.STRINGfilterout(STRINGlib.STRINGtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(STRINGlib.STRINGfilterout(STRINGlib.STRINGtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.st        	  := L.aidwork_acecache.st;
			SELF.zip       		:= L.aidwork_acecache.zip5;
			//SELF.zip        := L.aidwork_acecache.zip5;
			SELF.fips_st    := L.aidwork_acecache.county[1..2];
			SELF.fips_county:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;

	EXPORT Clean_name (pBaseFile, pLayout_base, useFull = false) := FUNCTIONMACRO
		#IF(useFull)
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, clean_company_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		#else
		NID.Mac_CleanParsedNames(pBaseFile, cleanNames
														, firstname:=first,middlename:=middle,lastname:=last,namesuffix:=suffix
														, includeInRepository:=TRUE, normalizeDualNames:=FALSE
													);
		#end
		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');

		pLayout_base tr(cleanNames L) := TRANSFORM
			SELF.fname 				:= IF(l.nameType='P',L.cln_fname,'');
			SELF.mname 				:= IF(l.nameType='P',L.cln_mname,'');
			SELF.lname 				:= IF(l.nameType='P',L.cln_lname,'');
			SELF.name_suffix 	:= IF(l.nameType='P',fGetSuffix(L.cln_suffix),'');
			SELF            	:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;

	EXPORT Clean_AHA_name (pBaseFile, pLayout_base) := FUNCTIONMACRO
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, HOSPITAL_NAME
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		RETURN (cleanNames);
	ENDMACRO;

	EXPORT Clean_POS_name (pBaseFile, pLayout_base) := FUNCTIONMACRO
		NID.Mac_CleanFullNames(pBaseFile,   cleanNames
														, FACILITY_NAME
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE);
		RETURN (cleanNames);
	ENDMACRO;


//////////////function definition	////////////////////////////////////////////////////////////////////////////////////////////
		fn_organization_rollup(dataset(Org_Mast.layouts.organization_base) d):= FUNCTION

			d1:=distribute(d, hash(LNFID));

			new_base_s := SORT(d1   //in HMS, there is a note - do not list hms_piid
				,LNFID
				,NAME
				,ADDRESS1
				,ADDRESS2
				,CITY
				,STATE
				,ZIP
				,ZIP4
				,PHONE1
				,PHONE2
				,FAX
				,LID
				,AGID
				,CBSA_CODE
				,LATITUDE
				,LONGITUDE
				,FACTYPE
				,ORG_TYPE_CODE
				,ORGTYPE
				,LN_GP_SPEC1
				,LN_GP_SPEC2
				,NCPDP
				,VENDIBILITY
				,AHA_ID
				,DEA
				,DEA_SCHEDULE
				,DEA_EXPIRATION_DATE
				,DEA_BUSINESS_ACT_CODE
				,DEA_BUSINESS_ACT_SUBCODE
				,NPI
				,NPI_STATUS
				,Provider_Number
				,LOCAL);

			Org_Mast.layouts.organization_base t_rollup(new_base_s L, new_base_s R) := TRANSFORM
				SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
				SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);

				SELF.date_first_seen := 0; // vendors not reporting this value for Org_Mast
				SELF.date_last_seen  := 0; // vendors not reporting this value for Org_Mast

				// sum_L := L.addr + L.dob + L.ssn + L.lic + L.dea + L.npi + L.sanc;
				// sum_R := R.addr + R.dob + R.ssn + R.lic + R.dea + R.npi + R.sanc;

				SELF.LNFID  := if(l.date_vendor_last_reported > r.date_vendor_last_reported, l.LNFID, r.LNFID);

				// SELF	:= map(
									 // l.record_type='C' and r.record_type='C' and sum_L > sum_R => L
									// ,l.record_type='C' and r.record_type='C' and sum_L < sum_R => R
									// ,l.record_type='H' and r.record_type='H' and sum_L > sum_R => L
									// ,l.record_type='H' and r.record_type='H' and sum_L < sum_R => R
									// ,l.record_type='C' => L
									// , R
								// );

				SELF	:= IF(L.record_type = 'C', L, R);
			END;

			base_organization_rup := ROLLUP(new_base_s    // NOTE in HMS: do not use HMS_piid
				, LEFT.LNFID 												= RIGHT.LNFID
				AND	LEFT.NAME                       =	RIGHT.NAME
				AND LEFT.ADDRESS1        						=	RIGHT.ADDRESS1
				AND LEFT.ADDRESS2        						=	RIGHT.ADDRESS2
				AND LEFT.CITY            						=	RIGHT.CITY
				AND LEFT.STATE           						=	RIGHT.STATE
				AND LEFT.ZIP             						=	RIGHT.ZIP
				AND LEFT.ZIP4            						=	RIGHT.ZIP4
				AND LEFT.PHONE1          						=	RIGHT.PHONE1
				AND LEFT.PHONE2          						=	RIGHT.PHONE2
				AND LEFT.FAX             						=	RIGHT.FAX
				AND LEFT.LID             						=	RIGHT.LID
				AND LEFT.AGID            						=	RIGHT.AGID
				AND LEFT.CBSA_CODE       						=	RIGHT.CBSA_CODE
				AND LEFT.LATITUDE        						=	RIGHT.LATITUDE
				AND LEFT.LONGITUDE       						=	RIGHT.LONGITUDE
				AND LEFT.FACTYPE         						=	RIGHT.FACTYPE
				AND LEFT.ORG_TYPE_CODE   						=	RIGHT.ORG_TYPE_CODE
				AND LEFT.ORGTYPE         						=	RIGHT.ORGTYPE
				AND LEFT.LN_GP_SPEC1     						=	RIGHT.LN_GP_SPEC1
				AND LEFT.LN_GP_SPEC2     						=	RIGHT.LN_GP_SPEC2
				AND LEFT.NCPDP           						=	RIGHT.NCPDP
				AND LEFT.VENDIBILITY     						=	RIGHT.VENDIBILITY
				AND LEFT.AHA_ID  			   						=	RIGHT.AHA_ID
				AND LEFT.DEA                 				=	RIGHT.DEA
				AND LEFT.DEA_SCHEDULE        				=	RIGHT.DEA_SCHEDULE
				AND LEFT.DEA_EXPIRATION_DATE 				=	RIGHT.DEA_EXPIRATION_DATE
				AND LEFT.DEA_BUSINESS_ACT_CODE   		=	RIGHT.DEA_BUSINESS_ACT_CODE
				AND LEFT.DEA_BUSINESS_ACT_SUBCODE		=	RIGHT.DEA_BUSINESS_ACT_SUBCODE
				AND LEFT.NPI        						 		=	RIGHT.NPI
				AND LEFT.NPI_STATUS 								=	RIGHT.NPI_STATUS
				AND LEFT.Provider_Number       				  		=	RIGHT.Provider_Number
				,t_rollup(LEFT,RIGHT)
				,LOCAL);

			dist := DISTRIBUTE(base_organization_rup, HASH(LNFID));

			RETURN dist;
		END;
//////////////end function definition	//////////////////////////////////////////////////////////////


	EXPORT Organization_Base := FUNCTION
//#if (false)
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
	  //hist_base	:= Mark_history(Org_Mast.Files(filedate,pUseProd).organization_base.built, layouts.organization_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).organization;

    //Clean Address
		clean_address := Clean_addr(std_input, Org_Mast.layouts.Organization_base);
		//clean_address := dataset('~thor400_data::PERSIST::org_master::Org_Base0::'+filedate, layouts.organization_base, THOR);


		//Add to previous base
    base_and_update := if(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).organization_lBaseTemplate_built)) = 0
			 ,clean_address
			 ,clean_address/* + project(hist_base, Org_Mast.layouts.organization_base)*/);              //Individuals built superfile has subfiles



		base_and_update_dist := DISTRIBUTE(base_and_update, HASH(LNFID));//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base1::'+filedate);


//////////////////////////////////////////////////////////////////////////////////////

		AHA_file := DISTRIBUTE(Files().AHA_base.built, HASH(LNFID));
		base_aha	:= JOIN(  fn_organization_rollup(base_and_update_dist),AHA_file
				,LEFT.LNFID = RIGHT.LNFID
				,TRANSFORM(Org_Mast.layouts.organization_base
					,SELF.AHA_ID         := RIGHT.AHA_ID
		,SELF.AHA_REGION_CODE := RIGHT.AHA_REGION_CODE
		,SELF.AHA_STATE_CODE := RIGHT.AHA_STATE_CODE
		,SELF.AHA_HOSPITAL_NUMBER := RIGHT.AHA_HOSPITAL_NUMBER
		,SELF.DT_BEGIN_DATE := RIGHT.DT_BEGIN_DATE
		,SELF.DT_REPORT_BEGIN_MONTH := RIGHT.DT_REPORT_BEGIN_MONTH
		,SELF.DT_REPORT_BEGIN_DAY := RIGHT.DT_REPORT_BEGIN_DAY
		,SELF.DT_REPORT_BEGIN_YEAR := RIGHT.DT_REPORT_BEGIN_YEAR
		,SELF.DT_END_DATE := RIGHT.DT_END_DATE
		,SELF.DT_REPORT_END_MONTH := RIGHT.DT_REPORT_END_MONTH
		,SELF.DT_REPORT_END_DAY := RIGHT.DT_REPORT_END_DAY
		,SELF.DT_REPORT_END_YEAR := RIGHT.DT_REPORT_END_YEAR
		,SELF.DAYS_OPEN := RIGHT.DAYS_OPEN
		,SELF.FISCAL_YEAR_PERIOD := RIGHT.FISCAL_YEAR_PERIOD
		,SELF.FISCAL_MONTH := RIGHT.FISCAL_MONTH
		,SELF.FISCAL_DAY := RIGHT.FISCAL_DAY
		,SELF.FISCAL_BEGIN_YEAR := RIGHT.FISCAL_BEGIN_YEAR
		,SELF.CONTROL_CODE := RIGHT.CONTROL_CODE
		,SELF.SERVICE_CODE := RIGHT.SERVICE_CODE
		,SELF.SERVICE_DESC := RIGHT.SERVICE_DESC
		,SELF.HOSP_REST_TO_CHILDREN := RIGHT.HOSP_REST_TO_CHILDREN
		,SELF.SHORT_LONG_CODE := RIGHT.SHORT_LONG_CODE
		,SELF.HOSP_TYPE_CODE := RIGHT.HOSP_TYPE_CODE
		,SELF.HOSPITAL_NAME := RIGHT.HOSPITAL_NAME
		,SELF.NAME_CHIEF_ADMINSTRATOR := RIGHT.NAME_CHIEF_ADMINSTRATOR
		,SELF.STREET_ADDRESS := RIGHT.STREET_ADDRESS
		,SELF.CITY := RIGHT.CITY
		,SELF.STATE_CODE := RIGHT.STATE_CODE
		,SELF.ZIP_CODE := RIGHT.ZIP_CODE
		,SELF.STATE_ABBR := RIGHT.STATE_ABBR
		,SELF.AREA_CODE := RIGHT.AREA_CODE
		,SELF.PHONE_NUMBER := RIGHT.PHONE_NUMBER
		,SELF.RESP_CODE := RIGHT.RESP_CODE
		,SELF.COMM_HOSPITAL_CODE := RIGHT.COMM_HOSPITAL_CODE
		,SELF.BED_SIZE_CODE := RIGHT.BED_SIZE_CODE
		,SELF.SYSTEM_MEMBER := RIGHT.SYSTEM_MEMBER
		,SELF.SUBSIDARY_OPER := RIGHT.SUBSIDARY_OPER
		//,SELF.NPI := RIGHT.NPI
		,SELF.NPI_NUMBER := RIGHT.NPI_NUMBER
		,SELF.AHA_CLUSTER_CODE := RIGHT.AHA_CLUSTER_CODE
		,SELF.SYSTEM_ID := RIGHT.SYSTEM_ID
		,SELF.SYSTEM_NAME := RIGHT.SYSTEM_NAME
		,SELF.SYSTEM_ADDRESS := RIGHT.SYSTEM_ADDRESS
		,SELF.SYSTEM_CITY := RIGHT.SYSTEM_CITY
		,SELF.SYSTEM_STATE := RIGHT.SYSTEM_STATE
		,SELF.SYSTEM_ZIP_CODE := RIGHT.SYSTEM_ZIP_CODE
		,SELF.SYSTEM_AREA_CODE := RIGHT.SYSTEM_AREA_CODE
		,SELF.SYSTEM_TELEPHONE_NUMBER := RIGHT.SYSTEM_TELEPHONE_NUMBER
		,SELF.SYSTEM_PRIMARY_CONTACT := RIGHT.SYSTEM_PRIMARY_CONTACT
		,SELF.SYSTEM_CONTACT_TITLE := RIGHT.SYSTEM_CONTACT_TITLE
		,SELF.COMMUNITY_FLAG := RIGHT.COMMUNITY_FLAG
		,SELF.MEDICARE_PROVIDER_ID := RIGHT.MEDICARE_PROVIDER_ID
		,SELF.LATITUDE := RIGHT.LATITUDE
		,SELF.LONGITUDE := RIGHT.LONGITUDE
		,SELF.COUNTY_NAME := RIGHT.COUNTY_NAME
		,SELF.CBSA_NAME := RIGHT.CBSA_NAME
		,SELF.CBSA_TYPE := RIGHT.CBSA_TYPE
		,SELF.CBSA_CODE := RIGHT.CBSA_CODE
		,SELF.MODIFIED_FIPS_COUNTY_CODE := RIGHT.MODIFIED_FIPS_COUNTY_CODE
		,SELF.FIPS_STATE_COUNTY_CODE := RIGHT.FIPS_STATE_COUNTY_CODE
		,SELF.FIPS_STATE_CODE := RIGHT.FIPS_STATE_COUNTY_CODE
		,SELF.FIPS_COUNTY_CODE := RIGHT.FIPS_COUNTY_CODE
		,SELF.CITY_RANKING := RIGHT.CITY_RANKING
		,SELF.ACCREDITATION := RIGHT.ACCREDITATION
		,SELF.CANCER_PROGRAM := RIGHT.CANCER_PROGRAM
		,SELF.RESIDENCY_TRAINING := RIGHT.RESIDENCY_TRAINING
		,SELF.MEDICAL_SCHOOL_AFFL := RIGHT.MEDICAL_SCHOOL_AFFL
		,SELF.HOSP_CONTL := RIGHT.HOSP_CONTL
		,SELF.ACCREDIATION_BY_COMMISION := RIGHT.ACCREDIATION_BY_COMMISION
		,SELF.MEMBER_OF_COUNCIL := RIGHT.MEMBER_OF_COUNCIL
		,SELF.ACCREDIDATION_BY_HEALTHCARE := RIGHT.ACCREDIDATION_BY_HEALTHCARE
		,SELF.INTERNSHIP_APPROVED := RIGHT.INTERNSHIP_APPROVED
		,SELF.RESIDENCY_APPROVED := RIGHT.RESIDENCY_APPROVED
		,SELF.CATHOLIC_CHRUCH_OPER := RIGHT.CATHOLIC_CHRUCH_OPER
		,SELF.CRITICAL_ACCESS_HOSP := RIGHT.CRITICAL_ACCESS_HOSP
		,SELF.RURAL_REFERRAL_CENTER := RIGHT.RURAL_REFERRAL_CENTER
		,SELF.SOLE_COMMUNITY_PROVIDER := RIGHT.SOLE_COMMUNITY_PROVIDER
		,SELF.Teach := RIGHT.Teach

					,SELF:=LEFT
					 )
				,LEFT OUTER
				,LOCAL);
		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base3::'+filedate);

///////////////////////////////////////////////////////////////////////////////////////////////

		DEA_file := DISTRIBUTE(Files().DEA_base.built, HASH(LNFID));
		base_dea	:= JOIN(fn_organization_rollup(base_aha), DEA_file
				,LEFT.LNFID = RIGHT.LNFID
				,TRANSFORM(Org_Mast.layouts.organization_base
					,SELF.DEA                       := RIGHT.DEA
					,SELF.DEA_SCHEDULE              := RIGHT.DEA_SCHEDULE
					,SELF.DEA_EXPIRATION_DATE       := RIGHT.DEA_EXPIRATION_DATE
					,SELF.DEA_BUSINESS_ACT_CODE     := RIGHT.DEA_BUSINESS_ACT_CODE
					,SELF.DEA_BUSINESS_ACT_SUBCODE  := RIGHT.DEA_BUSINESS_ACT_SUBCODE
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);
		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base4::'+filedate);

///////////////////////////////////////////////////////////////////////////////////////////////

		Crosswalk_file := DISTRIBUTE(Files().Crosswalk_base.built, HASH(LNFID));
		base_crosswalk	:= JOIN(fn_organization_rollup(base_dea), Crosswalk_file
				,LEFT.LNFID = RIGHT.LNFID
				,TRANSFORM(Org_Mast.layouts.organization_base
					,SELF.SOURCE           := RIGHT.SOURCE
					,SELF.PRIMARY_ID       := RIGHT.PRIMARY_ID
					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);
		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base5::'+filedate);

///////////////////////////////////////////////////////////////////////////////////////////////

		POS_file := DISTRIBUTE(Files().pos_base.built, HASH(LNFID));
		base_pos	:= JOIN(fn_organization_rollup(base_crosswalk), POS_file
				,LEFT.LNFID = RIGHT.LNFID
				,TRANSFORM(Org_Mast.layouts.organization_base
					,SELF.Provider_Number          := RIGHT.Provider_Number
					//Insert all new fields from POS here
					,SELF.POS_Facility_Name := RIGHT.Facility_Name
					,SELF.POS_ADDRESS := RIGHT.ADDRESS
					,SELF.POS_CITY := RIGHT.CITY
					,SELF.POS_STATE := RIGHT.STATE
					,SELF.POS_ZIP_CODE := RIGHT.ZIP_CODE
					,SELF.POS_Phone := RIGHT.Phone
					,SELF.POS_Program_Terminaion_Code := RIGHT.Program_Terminaion_Code

					,SELF:=LEFT)
				,LEFT OUTER
				,LOCAL);
		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base6::'+filedate);

//3/28/2016 - Now NPI comes in as one of the columns in Organization file and it need not get the value sform the NPI file.
		NPI_file := DISTRIBUTE(Files().NPI_base.built, HASH(LNFID));
   		base_npi	:= JOIN(fn_organization_rollup(base_pos), NPI_file
   				,LEFT.LNFID = RIGHT.LNFID
   				,TRANSFORM(Org_Mast.layouts.organization_base
   					//,SELF.NPI            := LEFT.NPI						// Note that Org file now has its own NPI value
   					//SELF.NPI_STATUS     := RIGHT.NPI_STATUS
   					,SELF:=LEFT)
   				,LEFT OUTER
   				,LOCAL); 		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base2::'+filedate,SINGLE );

		pos_rup := PROJECT(fn_organization_rollup(base_npi),Org_Mast.Layouts.organization_base);
		//:PERSIST('~thor400_data::PERSIST::org_master::Org_Base7::'+filedate);


///////////////////////////////////////////////////////////////////////////////////////////////

		Org_Mast.layouts.Organization_Base GetSourceRID(pos_rup rup) := TRANSFORM
			SELF.source_rid := HASH(hashmd5(
							TRIM(rup.NAME											) + ','
						+	TRIM(rup.ADDRESS1 								) + ','
						+	TRIM(rup.ADDRESS2 								) + ','
						+	TRIM(rup.CITY     								) + ','
						+	TRIM(rup.STATE    								) + ','
						+	TRIM(rup.ZIP      								) + ','
						+	TRIM(rup.ZIP4     								) + ','
						+	TRIM(rup.PHONE1   								) + ','
						+	TRIM(rup.PHONE2   								) + ','
						+	TRIM(rup.FAX      								) + ','
						+	TRIM(rup.LID      								) + ','
						+	TRIM(rup.AGID     								) + ','
						+	TRIM(rup.CBSA_CODE								) + ','
						+	TRIM(rup.FACTYPE      						) + ','
						+	TRIM(rup.ORG_TYPE_CODE						) + ','
						+	TRIM(rup.ORGTYPE      						) + ','
						+	TRIM(rup.LN_GP_SPEC1  						) + ','
						+	TRIM(rup.LN_GP_SPEC2  						) + ','
						+	TRIM(rup.NCPDP        						) + ','
						+	TRIM(rup.VENDIBILITY  						) + ','
						+	TRIM(rup.AHA_ID										) + ','
						+	TRIM(rup.DEA                  		) + ','
						+	TRIM(rup.DEA_SCHEDULE         		) + ','
						+	TRIM(rup.DEA_EXPIRATION_DATE  		) + ','
						+	TRIM(rup.DEA_BUSINESS_ACT_CODE    ) + ','
						+	TRIM(rup.DEA_BUSINESS_ACT_SUBCODE ) + ','
						+	TRIM(rup.NPI       								) + ','
						+	TRIM(rup.NPI_STATUS								) + ','
						+	TRIM(rup.Provider_Number										) + ','
						+	TRIM(rup.SOURCE    								) + ','
						+	TRIM(rup.PRIMARY_ID								)));
			SELF											:= rup;
		END;

	d_rid	:= PROJECT(pos_rup, GetSourceRID(LEFT));


	//bdid_matchset := ['A','P'];
	bdid_matchset := ['A'];
	Business_Header_SS.MAC_Add_BDID_Flex
			(d_rid
			,bdid_matchset
			,NAME
			,clean_prim_range
			,clean_prim_name
			,clean_zip
			,clean_sec_range
			,clean_st
			,PHONE1
			,foo
			,bdid
			,Org_Mast.layouts.organization_base
			,true
			,bdid_score
			,d_bdid
			,
			,
			,
			,//BIPV2.xlink_version_set
			,
			,
			,p_city_name
			,
			,
			,
			,
			,src
			,source_rid
			,
			);

	Health_Facility_Services.mac_get_best_lnpid_on_thor (
			 d_bdid
			,LNPID
			,name
			,clean_prim_range
			,clean_prim_name
			,clean_sec_range
			,v_city_name //clean_p_city_name
			,clean_st
			,ZIP
			,//sanc_tin
			,//tin1
			,PHONE1 //prac_phone1
			,FAX
			,//sanc_sancst
			,//sanc_licnbr
			,DEA //Input_DEA_NUMBER
			,//prac1_key//group_key
			,NPI //npi_num
			,//clia_num
			,//medicare_fac_num
			,//Input_MEDICAID_NUMBER
			,//ncpdp_id
			,//taxonomy
			,BDID
			,//SRC
			,source_rid //SOURCE_RID
			,dLnpidOut
			,false
			,30
			);

		with_lnpid:=dLnpidOut(lnpid>0);
		OUTPUT(COUNT(with_lnpid), NAMED('ct_with_lnpid'));
		no_lnpid:=dLnpidOut(lnpid=0);
		OUTPUT(COUNT(no_lnpid), NAMED('ct_no_lnpid'));

/*
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			no_lnpid
			,LNPID
			,//FNAME
			,//MNAME
			,//LNAME
			,//name_suffix
			,//GENDER
			,PRIM_Range
			,PRIM_Name
			,SEC_RANGE
			,v_city_name
			,ST
			,ZIP
			,//clean_SSN
			,//clean_DOB
			,PHONE1
			,//LIC_STATE
			,//LIC_Num_in
			,//TAX_ID
			,DEA
			,//group_key
			,NPI
			,//UPIN
			,//DID
			,BDID
			,//SRC
			,//SOURCE_RID
			,result,false,38
			);

			//result2 := result:PERSIST('~thor400_data::PERSIST::org_master::Org_Base9b::'+filedate);

		// Replace LNFID with LNPID where available. Otherwise leave LNFID as is
		result := Project( with_lnpid, ReplaceLNFID_with_LNPID(LEFT));

		RETURN result + no_lnpid;
*/
	//Return base_and_update_dist;
	return dLnpidOut;//base_aha;
	END;

	EXPORT affiliations_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).affiliations_base.built, layouts.affiliations_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).affiliations;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).affiliations_lBaseTemplate_built)) = 0
											,std_input
											,std_input+ hist_base);


 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID));

		new_base_s := SORT(new_base_d
										,LNFID
										,HMS_PIID
										,FACTYPE
										,LOCAL);

		Layouts.affiliations_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.LNFID	= RIGHT.LNFID
										AND LEFT.HMS_PIID		= RIGHT.HMS_PIID
										AND LEFT.FACTYPE 		= RIGHT.FACTYPE
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

//		RETURN base_t;

		Org_Mast.layouts.Affiliations_Base GetSourceRID(base_t rup) := TRANSFORM
			SELF.source_rid := HASH(hashmd5(
							TRIM(rup.HMS_PIID											) + ','
						+	TRIM(rup.FACTYPE 								)));
			SELF											:= rup;
		END;

		d_rid	:= PROJECT(base_t, GetSourceRID(LEFT));

		d_rid_rup := ROLLUP(d_rid,
										    LEFT.HMS_PIID		= RIGHT.HMS_PIID
										AND LEFT.FACTYPE 		= RIGHT.FACTYPE
										,t_rollup(LEFT,RIGHT)
										,LOCAL);
  return d_rid_rup;

	END;

	EXPORT aha_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).aha_base.built, layouts.aha_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).aha;
		cleanNames := Clean_aha_name(std_input,Org_Mast.Layouts.aha_base):PERSIST('~thor400_data::Persist::base::hms::Org_Mast::CleanNames');;
		cleanAdd_a	:= Clean_addr(cleanNames, Org_Mast.Layouts.aha_base):PERSIST('~thor400_data::Persist::base::hms::Org_Mast::addresses');

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).aha_lBaseTemplate_built)) = 0
											,cleanAdd_a
											,cleanAdd_a+ hist_base);

 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID, AHA_ID,  HOSPITAL_NAME, NAME_CHIEF_ADMINSTRATOR, CLEAN_DT_BEGIN_DATE, CLEAN_DT_END_DATE, CLEAN_FISCAL_YEAR));
//	distribute(base_and_update, hash(lastname, firstname, AddressLine1, AddressLine2, zipcode));
		new_base_s := SORT(new_base_d
				,LNFID
				,AHA_ID
				,HOSPITAL_NAME
				,NAME_CHIEF_ADMINSTRATOR
				,CLEAN_DT_BEGIN_DATE
				,CLEAN_DT_END_DATE
				,CLEAN_FISCAL_YEAR
				,AHA_REGION_CODE
				,AHA_STATE_CODE
				,AHA_HOSPITAL_NUMBER
				,DT_BEGIN_DATE
				,DT_REPORT_BEGIN_MONTH
				,DT_REPORT_BEGIN_DAY
				,DT_REPORT_BEGIN_YEAR
				,DT_END_DATE
				,DT_REPORT_END_MONTH
				,DT_REPORT_END_DAY
				,DT_REPORT_END_YEAR
				,DAYS_OPEN
				,FISCAL_YEAR_PERIOD
				,FISCAL_YEAR
				,FISCAL_MONTH
				,FISCAL_DAY
				,FISCAL_BEGIN_YEAR
				,CONTROL_CODE
				,SERVICE_CODE
				,SERVICE_DESC
				,HOSP_REST_TO_CHILDREN
				,SHORT_LONG_CODE
				,HOSP_TYPE_CODE
				,STREET_ADDRESS
				,CITY
				,STATE_CODE
				,ZIP_CODE
				,STATE_ABBR
				,AREA_CODE
				,PHONE_NUMBER
				,RESP_CODE
				,COMM_HOSPITAL_CODE
				,BED_SIZE_CODE
				,SYSTEM_MEMBER
				,SUBSIDARY_OPER
				,NPI
				,NPI_NUMBER
				,AHA_CLUSTER_CODE
				,SYSTEM_ID
				,SYSTEM_NAME
				,SYSTEM_ADDRESS
				,SYSTEM_CITY
				,SYSTEM_STATE
				,SYSTEM_ZIP_CODE
				,SYSTEM_AREA_CODE
				,SYSTEM_TELEPHONE_NUMBER
				,SYSTEM_PRIMARY_CONTACT
				,SYSTEM_CONTACT_TITLE
				,COMMUNITY_FLAG
				,MEDICARE_PROVIDER_ID
				,LATITUDE
				,LONGITUDE
				,COUNTY_NAME
				,CBSA_NAME
				,CBSA_TYPE
				,CBSA_CODE
				,MODIFIED_FIPS_COUNTY_CODE
				,FIPS_STATE_COUNTY_CODE
				,FIPS_STATE_CODE
				,FIPS_COUNTY_CODE
				,CITY_RANKING
				,ACCREDITATION
				,CANCER_PROGRAM
				,RESIDENCY_TRAINING
				,MEDICAL_SCHOOL_AFFL
				,HOSP_CONTL
				,ACCREDIATION_BY_COMMISION
				,MEMBER_OF_COUNCIL
				,ACCREDIDATION_BY_HEALTHCARE
				,INTERNSHIP_APPROVED
				,RESIDENCY_APPROVED
				,CATHOLIC_CHRUCH_OPER
				,CRITICAL_ACCESS_HOSP
				,RURAL_REFERRAL_CENTER
				,SOLE_COMMUNITY_PROVIDER
				,Teach
				,LOCAL);

		Layouts.aha_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
		 self.date_first_seen            := ut.EarliestDate (l.date_first_seen, r.date_first_seen);
		 self.date_last_seen             := ut.LatestDate (l.date_last_seen, r.date_last_seen);
		 self.date_vendor_first_reported := ut.EarliestDate(l.date_vendor_first_reported, r.date_vendor_first_reported);
		 self.date_vendor_last_reported  := ut.LatestDate(l.date_vendor_last_reported, r.date_vendor_last_reported);
		 self.source_rid := if(l.date_vendor_last_reported > r.date_vendor_last_reported, l.source_rid, r.Source_rid);
		 self := if(l.date_vendor_last_reported > r.date_vendor_last_reported,l,r);
		 //SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
				LEFT.LNFID		= RIGHT.LNFID
				AND LEFT.AHA_ID 		= RIGHT.AHA_ID
				AND LEFT.HOSPITAL_NAME		= RIGHT.HOSPITAL_NAME
				AND LEFT.NAME_CHIEF_ADMINSTRATOR		= RIGHT.NAME_CHIEF_ADMINSTRATOR
				AND LEFT.CLEAN_DT_BEGIN_DATE = RIGHT.CLEAN_DT_BEGIN_DATE
				AND LEFT.CLEAN_DT_END_DATE = RIGHT.CLEAN_DT_END_DATE
				AND LEFT.CLEAN_FISCAL_YEAR = RIGHT.CLEAN_FISCAL_YEAR
				AND LEFT.AHA_REGION_CODE		= RIGHT.AHA_REGION_CODE
				AND LEFT.AHA_STATE_CODE		= RIGHT.AHA_STATE_CODE
				AND LEFT.AHA_HOSPITAL_NUMBER		= RIGHT.AHA_HOSPITAL_NUMBER
				AND LEFT.DT_BEGIN_DATE		= RIGHT.DT_BEGIN_DATE
				AND LEFT.DT_REPORT_BEGIN_MONTH		= RIGHT.DT_REPORT_BEGIN_MONTH
				AND LEFT.DT_REPORT_BEGIN_DAY		= RIGHT.DT_REPORT_BEGIN_DAY
				AND LEFT.DT_REPORT_BEGIN_YEAR		= RIGHT.DT_REPORT_BEGIN_YEAR
				AND LEFT.DT_END_DATE		= RIGHT. DT_END_DATE
				AND LEFT.DT_REPORT_END_MONTH  = RIGHT.DT_REPORT_END_MONTH
				AND LEFT.DT_REPORT_END_DAY   					= RIGHT.DT_REPORT_END_DAY
				AND LEFT.DT_REPORT_END_YEAR  		 		= RIGHT.DT_REPORT_END_YEAR
				AND LEFT.DAYS_OPEN										= RIGHT.DAYS_OPEN
				AND LEFT.FISCAL_YEAR_PERIOD						= RIGHT.FISCAL_YEAR_PERIOD
				AND LEFT.FISCAL_YEAR									= RIGHT.FISCAL_YEAR
				AND LEFT.FISCAL_MONTH		= RIGHT.FISCAL_MONTH
				AND LEFT.FISCAL_DAY 		= RIGHT.FISCAL_DAY
				AND LEFT.FISCAL_BEGIN_YEAR		= RIGHT.FISCAL_BEGIN_YEAR
				AND LEFT.CONTROL_CODE			= RIGHT.CONTROL_CODE
				AND LEFT.SERVICE_CODE		= RIGHT.SERVICE_CODE
				AND LEFT.SERVICE_DESC			= RIGHT.SERVICE_DESC
				AND LEFT.HOSP_REST_TO_CHILDREN			= RIGHT.HOSP_REST_TO_CHILDREN
				AND LEFT.SHORT_LONG_CODE		= RIGHT.SHORT_LONG_CODE
				AND LEFT.HOSP_TYPE_CODE			= RIGHT.HOSP_TYPE_CODE
				AND LEFT.STREET_ADDRESS		= RIGHT.STREET_ADDRESS
				AND LEFT.CITY		= RIGHT.CITY
				AND LEFT.STATE_CODE		= RIGHT.STATE_CODE
				AND LEFT.ZIP_CODE		= RIGHT.ZIP_CODE
				AND LEFT.STATE_ABBR		= RIGHT.STATE_ABBR
				AND LEFT.AREA_CODE		= RIGHT.AREA_CODE
				AND LEFT.PHONE_NUMBER		= RIGHT.PHONE_NUMBER
				AND LEFT.RESP_CODE		= RIGHT.RESP_CODE
				AND LEFT.COMM_HOSPITAL_CODE		= RIGHT.COMM_HOSPITAL_CODE
				AND LEFT.BED_SIZE_CODE		= RIGHT.BED_SIZE_CODE
				AND LEFT.SYSTEM_MEMBER		= RIGHT.SYSTEM_MEMBER
				AND LEFT.SUBSIDARY_OPER			= RIGHT.SUBSIDARY_OPER
				AND LEFT.NPI		= RIGHT.NPI
				AND LEFT.NPI_NUMBER		= RIGHT.NPI_NUMBER
				AND LEFT.AHA_CLUSTER_CODE			= RIGHT.AHA_CLUSTER_CODE
				AND LEFT.SYSTEM_ID		= RIGHT.SYSTEM_ID
				AND LEFT.SYSTEM_NAME		= RIGHT.SYSTEM_NAME
				AND LEFT.SYSTEM_ADDRESS		= RIGHT.SYSTEM_ADDRESS
				AND LEFT.SYSTEM_CITY		= RIGHT.SYSTEM_CITY
				AND LEFT.SYSTEM_STATE		= RIGHT.SYSTEM_STATE
				AND LEFT.SYSTEM_ZIP_CODE		= RIGHT.SYSTEM_ZIP_CODE
				AND LEFT.SYSTEM_AREA_CODE		= RIGHT.SYSTEM_AREA_CODE
				AND LEFT.SYSTEM_TELEPHONE_NUMBER		= RIGHT.SYSTEM_TELEPHONE_NUMBER
				AND LEFT.SYSTEM_PRIMARY_CONTACT		= RIGHT.SYSTEM_PRIMARY_CONTACT
				AND LEFT.SYSTEM_CONTACT_TITLE		= RIGHT.SYSTEM_CONTACT_TITLE
				AND LEFT.COMMUNITY_FLAG		= RIGHT.COMMUNITY_FLAG
				AND LEFT.MEDICARE_PROVIDER_ID		= RIGHT.MEDICARE_PROVIDER_ID
				AND LEFT.LATITUDE		= RIGHT.LATITUDE
				AND LEFT.LONGITUDE		= RIGHT.LONGITUDE
				AND LEFT.COUNTY_NAME		= RIGHT.COUNTY_NAME
				AND LEFT.CBSA_NAME		= RIGHT.CBSA_NAME
				AND LEFT.CBSA_TYPE		= RIGHT.CBSA_TYPE
				AND LEFT.CBSA_CODE		= RIGHT.CBSA_CODE
				AND LEFT.MODIFIED_FIPS_COUNTY_CODE		= RIGHT.MODIFIED_FIPS_COUNTY_CODE
				AND LEFT.FIPS_STATE_COUNTY_CODE		= RIGHT.FIPS_STATE_COUNTY_CODE
				AND LEFT.FIPS_STATE_CODE		= RIGHT.FIPS_STATE_CODE
				AND LEFT.FIPS_COUNTY_CODE		= RIGHT.FIPS_COUNTY_CODE
				AND LEFT.CITY_RANKING		= RIGHT.CITY_RANKING
				AND LEFT.ACCREDITATION		= RIGHT.ACCREDITATION
				AND LEFT.CANCER_PROGRAM		= RIGHT.CANCER_PROGRAM
				AND LEFT.RESIDENCY_TRAINING		= RIGHT.RESIDENCY_TRAINING
				AND LEFT.MEDICAL_SCHOOL_AFFL		= RIGHT.MEDICAL_SCHOOL_AFFL
				AND LEFT.HOSP_CONTL		= RIGHT.HOSP_CONTL
				AND LEFT.ACCREDIATION_BY_COMMISION		= RIGHT.ACCREDIATION_BY_COMMISION
				AND LEFT.MEMBER_OF_COUNCIL		= RIGHT.MEMBER_OF_COUNCIL
				AND LEFT.ACCREDIDATION_BY_HEALTHCARE		= RIGHT.ACCREDIDATION_BY_HEALTHCARE
				AND LEFT.INTERNSHIP_APPROVED		= RIGHT.INTERNSHIP_APPROVED
				AND LEFT.RESIDENCY_APPROVED			= RIGHT.RESIDENCY_APPROVED
				AND LEFT.CATHOLIC_CHRUCH_OPER			= RIGHT.CATHOLIC_CHRUCH_OPER
				AND LEFT.CRITICAL_ACCESS_HOSP			= RIGHT.CRITICAL_ACCESS_HOSP
				AND LEFT.RURAL_REFERRAL_CENTER		= RIGHT.RURAL_REFERRAL_CENTER
				AND LEFT.SOLE_COMMUNITY_PROVIDER		= RIGHT.SOLE_COMMUNITY_PROVIDER
				AND LEFT.Teach		= RIGHT.Teach
				,t_rollup(LEFT,RIGHT)
				,LOCAL);


	Org_Mast.Layouts.aha_base  GetSourceRID(base_t L)	:= TRANSFORM
   			// SELF.source_rid := HASH64(hashmd5(
													 // L.LNFID)+','
   			SELF.source_rid := HASH64(hashmd5(
													 L.LNFID +','
													 +trim(L.AHA_ID)+','
													 +trim(L.HOSPITAL_NAME)+','
													 +trim(L.NAME_CHIEF_ADMINSTRATOR)+','
													 +trim(L.CLEAN_DT_BEGIN_DATE)+','
													 +trim(L.CLEAN_DT_END_DATE)+','
													 +trim(L.CLEAN_FISCAL_YEAR)+','
													 +trim(L.AHA_STATE_CODE)+','
													 +trim(L.AHA_HOSPITAL_NUMBER)+','
													 +trim(L.DT_BEGIN_DATE)+','
													 +trim(L.DT_REPORT_BEGIN_MONTH)+','
													 +trim(L.DT_REPORT_BEGIN_DAY)+','
													 +trim(L.DT_REPORT_BEGIN_YEAR)+','
													 +trim(L.DT_END_DATE)+','
													 +trim(L.DT_REPORT_END_MONTH)+','
													 +trim(L.DT_REPORT_END_DAY)+','
													 +trim(L.DT_REPORT_END_YEAR)+','
													 +trim(L.DAYS_OPEN)+','
													 +trim(L.FISCAL_YEAR_PERIOD)+','
													 +trim(L.FISCAL_YEAR)+','
													 +trim(L.FISCAL_MONTH)+','
													 +trim(L.FISCAL_DAY)+','
													 +trim(L.FISCAL_BEGIN_YEAR)+','
													 +trim(L.CONTROL_CODE)+','
													 +trim(L.SERVICE_DESC)+','
													 +trim(L.HOSP_REST_TO_CHILDREN)+','
													 +trim(L.SHORT_LONG_CODE)+','
													 +trim(L.HOSP_TYPE_CODE)+','
													 +trim(L.HOSPITAL_NAME)+','
													 +trim(L.NAME_CHIEF_ADMINSTRATOR)+','
													 +trim(L.STREET_ADDRESS)+','
													 +trim(L.CITY)+','
													 +trim(L.STATE_CODE)+','
													 +trim(L.ZIP_CODE)+','
													 +trim(L.STATE_ABBR)+','
													 +trim(L.AREA_CODE)+','
													 +trim(L.PHONE_NUMBER)+','
													 +trim(L.RESP_CODE)+','
													 +trim(L.COMM_HOSPITAL_CODE)+','
													 +trim(L.BED_SIZE_CODE)+','
													 +trim(L.SYSTEM_MEMBER)+','
													 +trim(L.SUBSIDARY_OPER)+','
													 +trim(L.NPI)+','
													 +trim(L.NPI_NUMBER)+','
													 +trim(L.AHA_CLUSTER_CODE)+','
													 +trim(L.SYSTEM_ID)+','
													 +trim(L.SYSTEM_NAME)+','
													 +trim(L.SYSTEM_ADDRESS)+','
													 +trim(L.SYSTEM_CITY)+','
													 +trim(L.SYSTEM_STATE)+','
													 +trim(L.SYSTEM_ZIP_CODE)+','
													 +trim(L.SYSTEM_AREA_CODE)+','
													 +trim(L.SYSTEM_TELEPHONE_NUMBER)+','
													 +trim(L.SYSTEM_PRIMARY_CONTACT)+','
													 +trim(L.SYSTEM_CONTACT_TITLE)+','
													 +trim(L.COMMUNITY_FLAG)+','
													 +trim(L.MEDICARE_PROVIDER_ID)+','
													 +trim(L.LATITUDE)+','
													 +trim(L.LONGITUDE)+','
													 +trim(L.CBSA_NAME)+','
													 +trim(L.CBSA_TYPE)+','
													 +trim(L.CBSA_CODE)+','
													 +trim(L.MODIFIED_FIPS_COUNTY_CODE)+','
													 +trim(L.FIPS_STATE_COUNTY_CODE)+','
													 +trim(L.FIPS_STATE_CODE)+','
													 +trim(L.FIPS_COUNTY_CODE)+','
													 +trim(L.CITY_RANKING)+','
													 +trim(L.ACCREDITATION)+','
													 +trim(L.CANCER_PROGRAM)+','
													 +trim(L.RESIDENCY_TRAINING)+','
													 +trim(L.MEDICAL_SCHOOL_AFFL)+','
													 +trim(L.HOSP_CONTL)+','
													 +trim(L.ACCREDIATION_BY_COMMISION)+','
													 +trim(L.MEMBER_OF_COUNCIL)+','
													 +trim(L.ACCREDIDATION_BY_HEALTHCARE)+','
													 +trim(L.INTERNSHIP_APPROVED)+','
													 +trim(L.RESIDENCY_APPROVED)+','
													 +trim(L.CATHOLIC_CHRUCH_OPER)+','
													 +trim(L.CRITICAL_ACCESS_HOSP)+','
													 +trim(L.RURAL_REFERRAL_CENTER)+','
													 +trim(L.RURAL_REFERRAL_CENTER)
													 +trim(L.SOLE_COMMUNITY_PROVIDER)
													 +trim(L.Teach)
													));
   			SELF							:= L;
   		END;

  d_rid:=project(base_t,GetSourceRID(left));

	// matchset := ['A','Z','P'];
	// did_add.MAC_Match_Flex
		// (d_rid, matchset,foo
		 // ,'', HOSPITAL_NAME,foo,foo3,foo4,// mname, lname, name_suffix,
		 // prim_range, prim_name, sec_range, zip_code, state_code, AREA_CODE+phone_number,//clean_phone, //PhonePrimary,
		 // DID, Layouts.aha_base, true, did_score,
		 // 75, d_did);

	// did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,false);

	// did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0,false);

	// d_dob:=project(d_dob0
							// ,transform({d_dob0}
							// ,self.did:= left.did
							// ,self.did_score:=if(self.did=0,0,left.did_score)
							// ,self:=left));

		bdid_matchset := ['A','P','Z'];
		Business_Header_SS.MAC_Add_BDID_Flex
		(
				 d_rid //d_dob0
				,bdid_matchset
				,HOSPITAL_NAME			//firmname					// Company name field
				,prim_range
				,prim_name
				,zip					//orig_zip - 5 char zip
				,sec_range
				,state_abbr 						//license_state	// No separate state for License. Using home state
				,clean_Phone		//phone_number
				,foo
				,bdid
				,Org_Mast.Layouts.aha_base
				,TRUE
				,bdid_score
				,d_bdid
				,
				,
				,
				,BIPV2.xlink_version_set
				,
				,
				,p_city_name
				,
				,
				,
				,
				,//src
				,source_rid
				,
				,
		);	//Business_Header_SS.MAC_Add_BDID_Flex

		Health_Facility_Services.mac_get_best_lnpid_on_thor (
				d_bdid
				,LNPID
				,//clean_Clinic_Name
				,prim_range
				,PRIM_Name
				,SEC_RANGE
				,v_city_name
				,STATE_ABBR
				,ZIP_CODE
				,//sanc_tin
				,//tin1
				,clean_Phone  //phone1
				,//fax
				,//sanc_sancst
				,//sanc_licnbr
				,//Input_DEA_NUMBER
				,				// Group Key. Tried first 10 char of SPI but got error
				,npi_NUMBER //npi_num
				,//clia_num
				,//MedicareNumber//medicare_fac_num
				,//MedicaidNumber//Input_MEDICAID_NUMBER
				,//ncpdp_id
				,//taxonomy
				,//BDID
				,//SRC
				,SOURCE_RID
				,dLnpidOut
				,false
				,30
				);
// Got bdid up to this point 4120 with 0 out of 6293

		// with_lnpid:=dLnpidOut(lnpid>0);
		// no_lnpid:=dLnpidOut(lnpid=0);
// Since there is no fname, lname etc in AHA records, not running the following macro
		 // Health_Provider_Services.mac_get_best_lnpid_on_thor (
			// no_lnpid
			// ,lnpid
			// ,fname
			// ,mname
			// ,lname
			// ,name_suffix
			// ,							//gender
			// ,prim_range
			// ,prim_name
			// ,sec_range
			// ,v_city_name
			// ,st
			// ,zip					//orig_zip
			// ,best_ssn
			// ,best_dob
			// ,phonePrimary
			// ,st						//license_state
			// ,							//License_Number
			// ,							//tin1
			// ,dea					//dea_Number
			// ,						// Group Key
			// ,
			// ,							//UPIN
			// ,DID
			// ,BDID
			// ,SRC
			// ,SOURCE_RID
			// ,result,false,38
		// );

		// dLnpid_LNPID_For_LNFID := Project(dLnpidOut,ReplaceLNFID_With_LNPID_AHA(LEFT));
		// RETURN dLnpid_LNPID_For_LNFID;

		return dLnpidOut;
	END;

	EXPORT dea_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).dea_base.built, layouts.dea_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).dea;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).dea_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);

 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID));

		new_base_s := SORT(new_base_d
										,LNFID
										,DEA
										,DEA_SCHEDULE
										,DEA_EXPIRATION_DATE
										,DEA_BUSINESS_ACT_CODE
										,DEA_BUSINESS_ACT_SUBCODE
										,LOCAL);

		Layouts.dea_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										    LEFT.LNFID									= RIGHT.LNFID
										AND LEFT.DEA	    								= RIGHT.DEA
										AND LEFT.DEA_SCHEDULE							= RIGHT.DEA_SCHEDULE
										AND LEFT.DEA_EXPIRATION_DATE			= RIGHT.DEA_EXPIRATION_DATE
										AND LEFT.DEA_BUSINESS_ACT_CODE		= RIGHT.DEA_BUSINESS_ACT_CODE
										AND LEFT.DEA_BUSINESS_ACT_SUBCODE	= RIGHT.DEA_BUSINESS_ACT_SUBCODE
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

		RETURN base_t;
	END;

	EXPORT npi_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).npi_base.built, layouts.npi_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).npi;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).npi_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);

 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID));

		new_base_s := SORT(new_base_d
										,LNFID
										,NPI
										,NPI_STATUS
										,LOCAL);

		Layouts.npi_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										    LEFT.LNFID				= RIGHT.LNFID
										AND LEFT.NPI						= RIGHT.NPI
										AND LEFT.NPI_STATUS			= RIGHT.NPI_STATUS
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

		RETURN base_t;
	END;

	EXPORT pos_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).pos_base.built, layouts.pos_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).pos;
		cleanNames := Clean_POS_name(std_input,Org_Mast.Layouts.pos_base);
		cleanAdd_a	:= Clean_addr(cleanNames, Org_Mast.Layouts.pos_base); //:PERSIST('~thor400_data::Persist::base::hms::Org_Mast::addresses');

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).pos_lBaseTemplate_built)) = 0
											,cleanAdd_a
											,cleanAdd_a + hist_base);

 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID, Provider_Number,  Facility_Name, ADDRESS,CITY, STATE, ZIP_CODE, PHONE ));
		new_base_s := SORT(new_base_d
				,LNFID
				,Provider_Number
				,Facility_Name
				,ADDRESS
				,CITY
				,STATE
				,ZIP_CODE
				,PHONE
				,LOCAL);

		Layouts.pos_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										LEFT.LNFID		= RIGHT.LNFID
										AND LEFT.Provider_Number 		= RIGHT.Provider_Number
										AND LEFT.Facility_Name 		= RIGHT.Facility_Name
										AND LEFT.ADDRESS 		= RIGHT.ADDRESS
										AND LEFT.CITY 		= RIGHT.CITY
										AND LEFT.STATE 		= RIGHT.STATE
										AND LEFT.ZIP_CODE 		= RIGHT.ZIP_CODE
										AND LEFT.PHONE 		= RIGHT.PHONE

										,t_rollup(LEFT,RIGHT)
										,LOCAL);


	Org_Mast.Layouts.pos_base  GetSourceRID(base_t L)	:= TRANSFORM
		SELF.source_rid := HASH64(hashmd5(
											 L.LNFID +','
											 +trim(L.Provider_Number)+','
											 +trim(L.Facility_Name)+','
											 +trim(L.ADDRESS)+','
											 +trim(L.CITY)+','
											 +trim(L.STATE)+','
											 +trim(L.ZIP_CODE)+','
											 +trim(L.PHONE)
													));
   			SELF							:= L;
   		END;


  d_rid:=project(base_t,GetSourceRID(left));

	// matchset := ['A','Z','P'];
	// did_add.MAC_Match_Flex
		// (d_rid, matchset,foo
		 // ,'', HOSPITAL_NAME,foo,foo3,foo4,// mname, lname, name_suffix,
		 // prim_range, prim_name, sec_range, zip_code, state_code, AREA_CODE+phone_number,//clean_phone, //PhonePrimary,
		 // DID, Layouts.aha_base, true, did_score,
		 // 75, d_did);

	// did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,false);

	// did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0,false);

	// d_dob:=project(d_dob0
							// ,transform({d_dob0}
							// ,self.did:= left.did
							// ,self.did_score:=if(self.did=0,0,left.did_score)
							// ,self:=left));

		bdid_matchset := ['A', 'P'];
		Business_Header_SS.MAC_Add_BDID_Flex
		(
				 d_rid //d_dob0
				,bdid_matchset
				,Facility_Name			//firmname					// Company name field
				,prim_range
				,prim_name
				,zip_code						//orig_zip
				,sec_range
				,state 						//license_state	// No separate state for License. Using home state
				,clean_Phone		//phone_number
				,foo
				,bdid
				,Org_Mast.Layouts.pos_base
				,TRUE
				,bdid_score
				,d_bdid
				,
				,
				,
				,BIPV2.xlink_version_set
				,
				,
				,p_city_name
				,
				,
				,
				,
				,//src
				,source_rid
				,
				,
		);	//Business_Header_SS.MAC_Add_BDID_Flex

		Health_Facility_Services.mac_get_best_lnpid_on_thor (
				d_bdid
				,LNPID
				,Facility_Name //clean_Clinic_Name
				,prim_range
				,PRIM_Name
				,SEC_RANGE
				,v_city_name
				,STATE
				,ZIP_CODE
				,//sanc_tin
				,//tin1
				,clean_Phone  //phone1
				,//fax
				,//sanc_sancst
				,//sanc_licnbr
				,//Input_DEA_NUMBER
				,				// Group Key. Tried first 10 char of SPI but got error
				,//npi_NUMBER //npi_num
				,//clia_num
				,//MedicareNumber//medicare_fac_num
				,//MedicaidNumber//Input_MEDICAID_NUMBER
				,//ncpdp_id
				,//taxonomy
				,//BDID
				,//SRC
				,SOURCE_RID
				,dLnpidOut
				,false
				,30
				);

		with_lnpid:=dLnpidOut(lnpid>0);
		no_lnpid:=dLnpidOut(lnpid=0);

/*
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			no_lnpid
			,lnpid
			,''//fname
			,''//mname
			,''//lname
			,''//name_suffix
			,							//gender
			,prim_range
			,prim_name
			,sec_range
			,v_city_name
			,state
			,zip					//orig_zip
			,best_ssn
			,best_dob
			,phonePrimary
			,st						//license_state
			,							//License_Number
			,							//tin1
			,dea					//dea_Number
			,						// Group Key
			,
			,							//UPIN
			,DID
			,BDID
			,SRC
			,SOURCE_RID
			,result,false,38
		);
*/
		dLnpid_LNPID_For_LNFID := Project(dLnpidOut,ReplaceLNFID_With_LNPID_POS(LEFT));
		RETURN dLnpid_LNPID_For_LNFID;

	END;

	EXPORT crosswalk_base := FUNCTION
		//before adding the updates to the base file, mark the existing base file records as 'H' for historical
		hist_base	:= Mark_history(Files(filedate,pUseProd).crosswalk_base.built, layouts.crosswalk_base);

		//standardize input(update file)
		std_input := Org_Mast.StandardizeInputFile(filedate, pUseProd).crosswalk;

		//Add to previous base
		base_and_update := IF(NOTHOR(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).crosswalk_lBaseTemplate_built)) = 0
											,std_input
											,std_input + hist_base);

 		new_base_d := DISTRIBUTE(base_and_update, HASH(LNFID));

		new_base_s := SORT(new_base_d
										,LNFID
										,SOURCE
										,PRIMARY_ID
										,LOCAL);

		Layouts.crosswalk_base t_rollup(new_base_s  L, new_base_s R) := TRANSFORM
			SELF.date_vendor_first_reported := ut.EarliestDate(L.date_vendor_first_reported, R.date_vendor_first_reported);
			SELF.date_vendor_last_reported  := ut.LatestDate	(L.date_vendor_last_reported, R.date_vendor_last_reported);
			SELF						 							:= IF(L.record_type = 'C', L, R);
		END;

		base_t := ROLLUP(new_base_s,
										    LEFT.LNFID			= RIGHT.LNFID
										AND LEFT.SOURCE 			= RIGHT.SOURCE
										AND LEFT.PRIMARY_ID 	= RIGHT.PRIMARY_ID
										,t_rollup(LEFT,RIGHT)
										,LOCAL);

		RETURN base_t;
	END; // crosswalk_base

END; // Module

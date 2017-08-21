/*Now (gmarcan)
Text In Open Window
*/
import	_control, PRTE2_Common, PRTE_CSV,header,ut,doxie,NID;

EXPORT Proc_Build_Header_keys_v2(string pIndexVersion,
																string pIndexOldVersion, 
																boolean is_test_run, STRING emailTo='') := MODULE
		
		// Setup the Post Processing steps for Dev, Prod-test-run, and Prod
		// Because some of us cannot Sandbox MyInfo in production, give the ability to pass in an email address (default to previous MyInfo)
		EXPORT DOPS_Emails := IF(emailTo<>'', emailTo, _control.MyInfo.EmailAddressNormal);
		EXPORT PROD_PP_STEPS := SEQUENTIAL(
						PRTE.CopyMissingKeys('PersonHeaderKeys',pIndexVersion,pIndexOldVersion)
						,PRTE.CopyMissingKeys('RelativeKeys',pIndexVersion,pIndexOldVersion)
						,PRTE.CopyMissingKeys('FCRA_PersonHeaderKeys',pIndexVersion,pIndexOldVersion,'F')
						,PRTE.UpdateVersion( 'PersonHeaderKeys', pIndexVersion, DOPS_Emails, 'B', 'N', 'N')
						,PRTE.UpdateVersion( 'FCRA_PersonHeaderKeys', pIndexVersion, DOPS_Emails, 'B', 'F', 'N')
						,PRTE.UpdateVersion( 'RelativeKeys', pIndexVersion, DOPS_Emails, 'B', 'N', 'N')
						,PRTE.UpdateVersion( 'RelativeV3Keys', pIndexVersion, DOPS_Emails, 'B', 'N', 'N')
				);
		EXPORT TEST_RUN_PP_STEPS := SEQUENTIAL(
						PRTE.CopyMissingKeys('PersonHeaderKeys',pIndexVersion,pIndexOldVersion)
						,PRTE.CopyMissingKeys('RelativeKeys',pIndexVersion,pIndexOldVersion)
						,PRTE.CopyMissingKeys('FCRA_PersonHeaderKeys',pIndexVersion,pIndexOldVersion,'F')
						,OUTPUT('Production TEST-RUN build so skipping UpdateVersion (PersonHeaderKeys,FCRA_PersonHeaderKeys,RelativeKeys)')
				);
		EXPORT CHOSEN_PROD_PP_STEPS := IF(is_test_run, TEST_RUN_PP_STEPS, PROD_PP_STEPS);								
		EXPORT NOT_PROD_STEP := OUTPUT('Not a production build so skipping copyMissingKeys and UpdateVersion');
		Running_in_production :=  PRTE2_Common.Constants.Running_in_production;
		EXPORT Production_Post_Processing_Actions := IF(Running_in_production, CHOSEN_PROD_PP_STEPS, NOT_PROD_STEP);

		EXPORT Build_Keys	:=
		function
			rKeyHeader__hhid__did_ver := PRTE_CSV.Header.rthor_data400__key__header__hhid__did_ver;
			rKeyHeader__hhid__hhid_ver := PRTE_CSV.Header.rthor_data400__key__header__hhid__hhid_ver;
			rKeyHeader__address := PRTE_CSV.Header.rthor_data400__key__header__address;
			rKeyHeader__apt_bldgs := PRTE_CSV.Header.rthor_data400__key__header__apt_bldgs;
			rKeyHeader__da := PRTE_CSV.Header.rthor_data400__key__header__da;
			rKeyHeader__data := PRTE_CSV.Header.rthor_data400__key__header__data_new;
			rKeyHeader__did_ssn_date := PRTE_CSV.Header.rthor_data400__key__header__did_ssn_date;
			rKeyHeader__dobname := PRTE_CSV.Header.rthor_data400__key__header__dobname;
			rKeyHeader__fname_small := PRTE_CSV.Header.rthor_data400__key__header__fname_small;
			rKeyHeader__fname_small_alt := PRTE_CSV.Header.rthor_data400__key__header__fname_small_alt;
			rKeyHeader__lname_fname := PRTE_CSV.Header.rthor_data400__key__header__lname_fname;
			rKeyHeader__lname_fname_alt := PRTE_CSV.Header.rthor_data400__key__header__lname_fname_alt;
			rKeyHeader__minors := PRTE_CSV.Header.rthor_data400__key__header__minors;
			rKeyHeader__nbr := PRTE_CSV.Header.rthor_data400__key__header__nbr;
			rKeyHeader__nbr_address := PRTE_CSV.Header.rthor_data400__key__header__nbr_address;
			rKeyHeader__nbr_uid := PRTE_CSV.Header.rthor_data400__key__header__nbr_uid;
			rKeyHeader__phone := PRTE_CSV.Header.rthor_data400__key__header__phone;
			rKeyHeader__phonetic_lname := PRTE_CSV.Header.rthor_data400__key__header__phonetic_lname;
			rKeyHeader__pname_prange_st_city_sec_range_lname := PRTE_CSV.Header.rthor_data400__key__header__pname_prange_st_city_sec_range_lname;
			rKeyHeader__pname_zip_name_range := PRTE_CSV.Header.rthor_data400__key__header__pname_zip_name_range;
			rKeyHeader__relatives := PRTE_CSV.Header.rthor_data400__key__header__relatives;
			rKeyHeader__relatives3 := PRTE_CSV.Header.rthor_data400__key__header__relatives_v3;
			rKeyHeader__rid_did2 := PRTE_CSV.Header.rthor_data400__key__header__rid_did2;
			rKeyHeader__ssn_did := PRTE_CSV.Header.rthor_data400__key__header__ssn_did;
			rKeyHeader__ssn4_did := PRTE_CSV.Header.rthor_data400__key__header__ssn4_did;
			rKeyHeader__ssn5_did := PRTE_CSV.Header.rthor_data400__key__header__ssn5_did;
			rKeyHeader__ssn_address := PRTE_CSV.Header.rthor_data400__key__header__ssn_address;
			rKeyHeader__st_city_fname_lname := PRTE_CSV.Header.rthor_data400__key__header__st_city_fname_lname;
			rKeyHeader__st_fname_lname := PRTE_CSV.Header.rthor_data400__key__header__st_fname_lname;
			rKeyHeader__zip_lname_fname := PRTE_CSV.Header.rthor_data400__key__header__zip_lname_fname;
			rKeyHeader__zipprlname := PRTE_CSV.Header.rthor_data400__key__header__zipprlname;

			rKeyheader_dts__fname_small := PRTE_CSV.Header_dts.rthor_data400__key__header__dts__fname_small;
			rKeyheader_dts__pname_prange_st_city_sec_range_lname := PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_prange_st_city_sec_range_lname;
			rKeyheader_dts__pname_zip_name_range := PRTE_CSV.Header_dts.rthor_data400__key__header__dts__pname_zip_name_range;

			rKeyheader_wild__fname_small := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__fname_small;
			rKeyheader_wild__lname_fname := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__lname_fname;
			rKeyheader_wild__phone := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__phone;
			rKeyheader_wild__pname_prange_st_city_sec_range_lname := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_prange_st_city_sec_range_lname;
			rKeyheader_wild__pname_zip_name_range := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__pname_zip_name_range;
			rKeyheader_wild__ssn_did := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__ssn_did;
			rKeyheader_wild__st_city_fname_lname := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_city_fname_lname;
			rKeyheader_wild__st_fname_lname := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__st_fname_lname;
			rKeyheader_wild__zip_lname_fname := PRTE_CSV.Header_Wild.rthor_data400__key__header_wild__zip_lname_fname;
			
			payload := PRTE.Get_Header_Base.payload;

			Prte.header_ds_macro(prKeyHeader__hhid__did_ver,,,,,rKeyHeader__hhid__did_ver,payload,dKeyHeader__hhid__did_ver);
			Prte.header_ds_macro(prKeyHeader__hhid__hhid_ver,,,,,rKeyHeader__hhid__hhid_ver,payload,dKeyHeader__hhid__hhid_ver);
			prte.header_ds_macro(prKeyHeader__address,,,,,rKeyHeader__address,payload,dKeyHeader__address);
			prte.header_ds_macro(prKeyHeader__apt_bldgs,,,,,rKeyHeader__apt_bldgs,payload,dKeyHeader__apt_bldgs);
			prte.header_ds_macro(prKeyHeader__da,,,,,rKeyHeader__da,payload,dKeyHeader__da);
			prte.header_ds_macro(prKeyHeader__data,,,,,rKeyHeader__data,payload,dKeyHeader__data);
			prte.header_ds_macro(prKeyHeader__did_ssn_date,,,,,rKeyHeader__did_ssn_date,payload,dKeyHeader__did_ssn_date);
			prte.header_ds_macro(prKeyHeader__dobname,,,,,rKeyHeader__dobname,payload,dKeyHeader__dobname);
			prte.header_ds_macro(prKeyHeader__fname_small,'self.zip:=(integer)l.zip;',,,,rKeyHeader__fname_small,payload,dKeyHeader__fname_small);
			prte.header_ds_macro(prKeyHeader__lname_fname,'self.s4:=(integer)l.ssn4;',,,,rKeyHeader__lname_fname,payload,dKeyHeader__lname_fname);
			prte.header_ds_macro(prKeyHeader__lname_fname_alt,'self.s4:=(integer)l.ssn4;',,,,rKeyHeader__lname_fname_alt,payload,dKeyHeader__lname_fname_alt);
			prte.header_ds_macro(prKeyHeader__minors,,,,,rKeyHeader__minors,payload,dKeyHeader__minors);
			prte.header_ds_macro(prKeyHeader__nbr,,,,,rKeyHeader__nbr,payload,dKeyHeader__nbr);
			prte.header_ds_macro(prKeyHeader__nbr_address,,,,,rKeyHeader__nbr_address,payload,dKeyHeader__nbr_address);
			prte.header_ds_macro(prKeyHeader__nbr_uid,,,,,rKeyHeader__nbr_uid,payload,dKeyHeader__nbr_uid);
			prte.header_ds_macro(prKeyHeader__phone,,,,,rKeyHeader__phone,payload,dKeyHeader__phone);
			prte.header_ds_macro(prKeyHeader__phonetic_lname,,,,,rKeyHeader__phonetic_lname,payload,dKeyHeader__phonetic_lname);
			prte.header_ds_macro(prKeyHeader__pname_prange_st_city_sec_range_lname,,,,,rKeyHeader__pname_prange_st_city_sec_range_lname,payload,dKeyHeader__pname_prange_st_city_sec_range_lname);
			prte.header_ds_macro(prKeyHeader__pname_zip_name_range,'self.zip:=(integer)l.zip;',,,,rKeyHeader__pname_zip_name_range,payload,dKeyHeader__pname_zip_name_range);

			prte.header_ds_macro(prKeyHeader__relatives,'self.prim_range:=(integer)l.prim_range;',,,,rKeyHeader__relatives,payload,dKeyHeader__relatives);
			prte.header_ds_macro(prKeyHeader__relatives1,'self.prim_range:=(integer)l.prim_range;','self.person1:=l.person2;','self.person2:=l.person1;',,rKeyHeader__relatives,payload,dKeyHeader__relatives1);


			r3_defaults := 'self.did1:=l.person2;       self.did2:=l.person1;           			self.title:=l.rtitle;   '
										+'self.cohabit_cnt:=1;        self.coapt_cnt:=1;             			  self.copobox_cnt:=1;       '
										+'self.cossn_cnt:=1;          self.copolicy_cnt:=1;      			      self.coclaim_cnt:=1;       '
										+'self.coproperty_cnt:=1;     self.bcoproperty_cnt:=1;    			    self.coforeclosure_cnt:=1; '
										+'self.bcoforeclosure_cnt:=1; self.colien_cnt:=1;            				self.bcolien_cnt:=1;       '
										+'self.cobankruptcy_cnt:=1;   self.bcobankruptcy_cnt:=1;     				self.covehicle_cnt:=1;     '
										+'self.coexperian_cnt:=1;     self.cotransunion_cnt:=1;       			self.coenclarity_cnt:=1;   '
										+'self.coecrash_cnt:=1;       self.bcoecrash_cnt:=1;                self.cowatercraft_cnt:=1;  '
										+'self.coaircraft_cnt:=1;     self.comarriagedivorce_cnt:=1;        self.coucc_cnt:=1;         '
										+'self.total_score:=27;       self.rel_dt_last_seen:='+ut.GetDate+';self.isanylnamematch:=true;';


			prte.header_ds_macro(prKeyHeader__relatives3,r3_defaults,,,,rKeyHeader__relatives3,payload,dKeyHeader__relatives3);

			prte.header_ds_macro(prKeyHeader__rid_did2,,,,,rKeyHeader__rid_did2,payload,dKeyHeader__rid_did2);
			prte.header_ds_macro(prKeyHeader__ssn_did,,,,,rKeyHeader__ssn_did,payload,dKeyHeader__ssn_did);
			prte.header_ds_macro(prKeyHeader__ssn4_did,,,,,rKeyHeader__ssn4_did,payload,dKeyHeader__ssn4_did);
			prte.header_ds_macro(prKeyHeader__ssn5_did,,,,,rKeyHeader__ssn5_did,payload,dKeyHeader__ssn5_did);
			prte.header_ds_macro(prKeyHeader__ssn_address,,,,,rKeyHeader__ssn_address,payload,dKeyHeader__ssn_address);
			prte.header_ds_macro(prKeyHeader__st_city_fname_lname,,,,,rKeyHeader__st_city_fname_lname,payload,dKeyHeader__st_city_fname_lname);
			prte.header_ds_macro(prKeyHeader__st_fname_lname,'self.s4:=(integer)l.ssn4;','self.zip:=(integer)l.zip;',,,rKeyHeader__st_fname_lname,payload,dKeyHeader__st_fname_lname);
			prte.header_ds_macro(prKeyHeader__zip_lname_fname,'self.s4:=(integer)l.ssn4;','self.zip:=(integer)l.zip;',,,rKeyHeader__zip_lname_fname,payload,dKeyHeader__zip_lname_fname);
			prte.header_ds_macro(prKeyHeader__zipprlname,'self.zip:=(integer)l.zip;',,,,rKeyHeader__zipprlname,payload,dKeyHeader__zipprlname);

			prte.header_ds_macro(prKeyHeader_dts__fname_small,'self.zip:=(integer)l.zip;',,,,rKeyHeader_dts__fname_small,payload,dKeyHeader__dts__fname_small);
			prte.header_ds_macro(prKeyHeader__dts__pname_prange_st_city_sec_range_lname,,,,,rKeyHeader_dts__pname_prange_st_city_sec_range_lname,payload,dKeyHeader__dts__pname_prange_st_city_sec_range_lname);
			prte.header_ds_macro(prKeyHeader__dts__pname_zip_name_range,'self.zip:=(integer)l.zip;',,,,rKeyHeader_dts__pname_zip_name_range,payload,dKeyHeader__dts__pname_zip_name_range);

			prte.header_ds_macro(prKeyHeader__wild__fname_small,'self.zip:=(integer)l.zip;',,,,rKeyHeader_wild__fname_small,payload,dKeyHeader_wild__fname_small);
			prte.header_ds_macro(prKeyHeader__wild__lname_fname,'self.s4:=(integer)l.ssn4;',,,,rKeyHeader_wild__lname_fname,payload,dKeyHeader_wild__lname_fname);
			prte.header_ds_macro(prKeyHeader__wild__phone,,,,,rKeyHeader_wild__phone,payload,dKeyHeader_wild__phone);
			prte.header_ds_macro(prKeyHeader__wild__pname_prange_st_city_sec_range_lname,,,,,rKeyHeader_wild__pname_prange_st_city_sec_range_lname,payload,dKeyHeader_wild__pname_prange_st_city_sec_range_lname);
			prte.header_ds_macro(prKeyHeader__wild__pname_zip_name_range,'self.zip:=(integer)l.zip;',,,,rKeyHeader_wild__pname_zip_name_range,payload,dKeyHeader_wild__pname_zip_name_range);
			prte.header_ds_macro(prKeyHeader_wild__ssn_did,,,,,rKeyHeader_wild__ssn_did,payload,dKeyHeader_wild__ssn_did);
			prte.header_ds_macro(prKeyHeader_wild__st_city_fname_lname,,,,,rKeyHeader_wild__st_city_fname_lname,payload,dKeyHeader_wild__st_city_fname_lname);
			prte.header_ds_macro(prKeyHeader__wild__st_fname_lname,'self.s4:=(integer)l.ssn4;','self.zip:=(integer)l.zip;',,,rKeyHeader_wild__st_fname_lname,payload,dKeyHeader_wild__st_fname_lname);
			prte.header_ds_macro(prKeyHeader__wild__zip_lname_fname,'self.s4:=(integer)l.ssn4;','self.zip:=(integer)l.zip;',,,rKeyHeader_wild__zip_lname_fname,payload,dKeyHeader_wild__zip_lname_fname);


			fulldKeyHeader__hhid__did_ver := dedup(dKeyHeader__hhid__did_ver,all);
			kKeyHeader__hhid__did_ver := index(fulldKeyHeader__hhid__did_ver, {did,ver}, {fulldKeyHeader__hhid__did_ver}, '~prte::key::header::hhid::' + pIndexVersion + '::did.ver');

			fulldKeyHeader__hhid__hhid_ver := dedup(dKeyHeader__hhid__hhid_ver,all);
			kKeyHeader__hhid__hhid_ver := index(fulldKeyHeader__hhid__hhid_ver, {hhid_relat,ver}, {fulldKeyHeader__hhid__hhid_ver}, '~prte::key::header::hhid::' + pIndexVersion + '::hhid.ver');

			fulldKeyHeader__address := dedup(dKeyHeader__address,all);
			kKeyHeader__address := index(fulldKeyHeader__address, {prim_name,zip,prim_range,sec_range}, {fulldKeyHeader__address}, '~prte::key::header::' + pIndexVersion + '::address');

			fulldKeyHeader__apt_bldgs := dedup(dKeyHeader__apt_bldgs,all);
			kKeyHeader__apt_bldgs := index(fulldKeyHeader__apt_bldgs, {prim_range,prim_name,zip,suffix,predir}, {fulldKeyHeader__apt_bldgs}, '~prte::key::header::' + pIndexVersion + '::apt_bldgs');

			fulldKeyHeader__da := dedup(dKeyHeader__da,all);
			kKeyHeader__da := index(fulldKeyHeader__da, {l4,st,city_code,f3,lname,fname,yob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__da}, '~prte::key::header::' + pIndexVersion + '::da');

			fulldKeyHeader__data := dedup(dKeyHeader__data,all);
			kKeyHeader__data := index(fulldKeyHeader__data, {s_did}, {fulldKeyHeader__data}, '~prte::key::header::' + pIndexVersion + '::data');

			fulldKeyHeader__did_ssn_date := dedup(dKeyHeader__did_ssn_date,all);
			kKeyHeader__did_ssn_date := index(fulldKeyHeader__did_ssn_date, {did,ssn}, {fulldKeyHeader__did_ssn_date}, '~prte::key::header::' + pIndexVersion + '::did.ssn.date');

			fulldKeyHeader__dobname := dedup(dKeyHeader__dobname,all);
			kKeyHeader__dobname := index(fulldKeyHeader__dobname, {yob,dph_lname,lname,pfname,fname,mob,day,st,zip,dob}, {fulldKeyHeader__dobname}, '~prte::key::header::' + pIndexVersion + '::dobname');

			fulldKeyHeader__fname_small := dedup(dKeyHeader__fname_small,all);
			kKeyHeader__fname_small := index(fulldKeyHeader__fname_small, {pfname,st,zip,prim_name,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups,did}, {fulldKeyHeader__fname_small}, '~prte::key::header::' + pIndexVersion + '::fname_small');

			fulldKeyHeader__lname_fname := dedup(dKeyHeader__lname_fname_alt,all);
			kKeyHeader__lname_fname := index(fulldKeyHeader__lname_fname, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__lname_fname}, '~prte::key::header::' + pIndexVersion + '::lname.fname');

			fulldKeyHeader__lname_fname_alt := dedup(dKeyHeader__lname_fname_alt,all);
			kKeyHeader__lname_fname_alt := index(fulldKeyHeader__lname_fname_alt, {dph_lname,pfname,fname,lname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__lname_fname_alt}, '~prte::key::header::' + pIndexVersion + '::lname.fname_alt');

			fulldKeyHeader__minors := dedup(dKeyHeader__minors,all);
			kKeyHeader__minors := index(fulldKeyHeader__minors, {did}, {fulldKeyHeader__minors}, '~prte::key::header::' + pIndexVersion + '::minors');

			fulldKeyHeader__nbr := dedup(dKeyHeader__nbr,all);
			kKeyHeader__nbr := index(fulldKeyHeader__nbr, {zip,prim_name,suffix,predir,postdir,prim_range,sec_range}, {fulldKeyHeader__nbr}, '~prte::key::header::' + pIndexVersion + '::nbr');

			fulldKeyHeader__nbr_address := dedup(dKeyHeader__nbr_address,all);
			kKeyHeader__nbr_address := index(fulldKeyHeader__nbr_address, {prim_name,zip,z2,suffix,prim_range}, {fulldKeyHeader__nbr_address}, '~prte::key::header::' + pIndexVersion + '::nbr_address');

			fulldKeyHeader__nbr_uid := dedup(dKeyHeader__nbr_uid,all);
			kKeyHeader__nbr_uid := index(fulldKeyHeader__nbr_uid, {zip,prim_name,suffix,predir,postdir,uid}, {fulldKeyHeader__nbr_uid}, '~prte::key::header::' + pIndexVersion + '::nbr_uid');

			fulldKeyHeader__phone := dedup(dKeyHeader__phone,all);
			kKeyHeader__phone := index(fulldKeyHeader__phone, {p7,p3,dph_lname,pfname,st}, {fulldKeyHeader__phone}, '~prte::key::header::' + pIndexVersion + '::phone');

			fulldKeyHeader__phonetic_lname := dedup(dKeyHeader__phonetic_lname,all);
			kKeyHeader__phonetic_lname := index(fulldKeyHeader__phonetic_lname, {dph_lname}, {fulldKeyHeader__phonetic_lname}, '~prte::key::header::' + pIndexVersion + '::phonetic_lname');

			fulldKeyHeader__pname_prange_st_city_sec_range_lname := dedup(dKeyHeader__pname_prange_st_city_sec_range_lname,all);
			kKeyHeader__pname_prange_st_city_sec_range_lname := index(fulldKeyHeader__pname_prange_st_city_sec_range_lname, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {fulldKeyHeader__pname_prange_st_city_sec_range_lname}, '~prte::key::header::' + pIndexVersion + '::pname.prange.st.city.sec_range.lname');

			fulldKeyHeader__pname_zip_name_range := dedup(dKeyHeader__pname_zip_name_range,all);
			kKeyHeader__pname_zip_name_range := index(fulldKeyHeader__pname_zip_name_range, {prim_name,zip,dph_lname,pfname,prim_range,lname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__pname_zip_name_range}, '~prte::key::header::' + pIndexVersion + '::pname.zip.name.range');

			fulldKeyHeader__relatives := dedup(dKeyHeader__relatives + dKeyHeader__relatives1,all)(person1>0,person2>0,person1<>person2);
			fulldKeyHeader__relatives3 := dedup(sort(dKeyHeader__relatives3,record),except title, all)(did1>0,did2>0,did1<>did2);
			kKeyHeader__relatives := index(fulldKeyHeader__relatives, {person1,same_lname,number_cohabits,recent_cohabit,person2}, {fulldKeyHeader__relatives}, '~prte::key::header::' + pIndexVersion + '::relatives_v2');
			kKeyHeader__relatives_v3 := index(fulldKeyHeader__relatives3, {did1}, {fulldKeyHeader__relatives3}, '~prte::key::header::' + pIndexVersion + '::relatives_v3');

			fulldKeyHeader__rid_did2 := dedup(dKeyHeader__rid_did2,all);
			kKeyHeader__rid_did2 := index(fulldKeyHeader__rid_did2, {rid}, {fulldKeyHeader__rid_did2}, '~prte::key::header::' + pIndexVersion + '::rid_did2');

			fulldKeyHeader__ssn_did := dedup(dKeyHeader__ssn_did,all);
			kKeyHeader__ssn_did := index(fulldKeyHeader__ssn_did, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname}, {fulldKeyHeader__ssn_did}, '~prte::key::header::' + pIndexVersion + '::ssn.did');

			fulldKeyHeader__ssn4_did := dedup(dKeyHeader__ssn4_did,all);
			kKeyHeader__ssn4_did := index(fulldKeyHeader__ssn4_did, {ssn4,lname,fname}, {fulldKeyHeader__ssn4_did}, '~prte::key::header::' + pIndexVersion + '::ssn4.did');

			fulldKeyHeader__ssn5_did := dedup(dKeyHeader__ssn5_did,all);
			kKeyHeader__ssn5_did := index(fulldKeyHeader__ssn5_did, {ssn5,lname,fname}, {fulldKeyHeader__ssn5_did}, '~prte::key::header::' + pIndexVersion + '::ssn5.did');

			fulldKeyHeader__ssn_address := dedup(dKeyHeader__ssn_address,all);
			kKeyHeader__ssn_address := index(fulldKeyHeader__ssn_address, {ssn,prim_name}, {fulldKeyHeader__ssn_address}, '~prte::key::header::' + pIndexVersion + '::ssn_address');

			fulldKeyHeader__st_city_fname_lname := dedup(dKeyHeader__st_city_fname_lname,all);
			kKeyHeader__st_city_fname_lname := index(fulldKeyHeader__st_city_fname_lname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__st_city_fname_lname}, '~prte::key::header::' + pIndexVersion + '::st.city.fname.lname');

			fulldKeyHeader__st_fname_lname := dedup(dKeyHeader__st_fname_lname,all);
			kKeyHeader__st_fname_lname := index(fulldKeyHeader__st_fname_lname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__st_fname_lname}, '~prte::key::header::' + pIndexVersion + '::st.fname.lname');

			fulldKeyHeader__zip_lname_fname := dedup(dKeyHeader__zip_lname_fname,all);
			kKeyHeader__zip_lname_fname := index(fulldKeyHeader__zip_lname_fname, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {fulldKeyHeader__zip_lname_fname}, '~prte::key::header::' + pIndexVersion + '::zip.lname.fname');

			fulldKeyHeader__zipprlname := dedup(dKeyHeader__zipprlname,all);
			kKeyHeader__zipprlname := index(fulldKeyHeader__zipprlname, {zip,prim_range,lname,lookups}, {fulldKeyHeader__zipprlname}, '~prte::key::header::' + pIndexVersion + '::zipprlname');


			fulldKeyHeader__dts__fname_small := dedup(dKeyHeader__dts__fname_small,all);
			kKeyheader_dts__fname_small:=INDEX(fulldKeyHeader__dts__fname_small,{fulldKeyHeader__dts__fname_small},'~prte::key::header::dts::'+pIndexVersion+'::fname_small');

			fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname := dedup(dKeyHeader__dts__pname_prange_st_city_sec_range_lname,all);
			kKeyheader_dts__pname_prange_st_city_sec_range_lname:=INDEX(fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname,{fulldKeyHeader__dts__pname_prange_st_city_sec_range_lname},'~prte::key::header::dts::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');

			fulldKeyHeader__dts__pname_zip_name_range := dedup(dKeyHeader__dts__pname_zip_name_range,all);
			kKeyheader_dts__pname_zip_name_range:=INDEX(fulldKeyHeader__dts__pname_zip_name_range,{fulldKeyHeader__dts__pname_zip_name_range},'~prte::key::header::dts::'+pIndexVersion+'::pname.zip.name.range');


			fulldKeyheader_wild__fname_small := dedup(dKeyheader_wild__fname_small,all);
			kKeyheader_wild__fname_small:=INDEX(fulldKeyheader_wild__fname_small,{fulldKeyheader_wild__fname_small},'~prte::key::header_wild::'+pIndexVersion+'::fname_small');

			fulldKeyheader_wild__lname_fname := dedup(dKeyheader_wild__lname_fname,all);
			kKeyheader_wild__lname_fname:=INDEX(fulldKeyheader_wild__lname_fname,{fulldKeyheader_wild__lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::lname.fname');

			fulldKeyheader_wild__phone := dedup(dKeyheader_wild__phone,all);
			kKeyheader_wild__phone:=INDEX(fulldKeyheader_wild__phone,{fulldKeyheader_wild__phone},'~prte::key::header_wild::'+pIndexVersion+'::phone');

			fulldKeyheader_wild__pname_prange_st_city_sec_range_lname := dedup(dKeyheader_wild__pname_prange_st_city_sec_range_lname,all);
			kKeyheader_wild__pname_prange_st_city_sec_range_lname:=INDEX(fulldKeyheader_wild__pname_prange_st_city_sec_range_lname,{fulldKeyheader_wild__pname_prange_st_city_sec_range_lname},'~prte::key::header_wild::'+pIndexVersion+'::pname.prange.st.city.sec_range.lname');

			fulldKeyheader_wild__pname_zip_name_range := dedup(dKeyheader_wild__pname_zip_name_range,all);
			kKeyheader_wild__pname_zip_name_range:=INDEX(fulldKeyheader_wild__pname_zip_name_range,{fulldKeyheader_wild__pname_zip_name_range},'~prte::key::header_wild::'+pIndexVersion+'::pname.zip.name.range');

			fulldKeyheader_wild__ssn_did := dedup(dKeyheader_wild__ssn_did,all);
			kKeyheader_wild__ssn_did:=INDEX(fulldKeyheader_wild__ssn_did,{fulldKeyheader_wild__ssn_did},'~prte::key::header_wild::'+pIndexVersion+'::ssn.did');

			fulldKeyheader_wild__st_city_fname_lname := dedup(dKeyheader_wild__st_city_fname_lname,all);
			kKeyheader_wild__st_city_fname_lname:=INDEX(fulldKeyheader_wild__st_city_fname_lname,{fulldKeyheader_wild__st_city_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.city.fname.lname');

			fulldKeyheader_wild__st_fname_lname := dedup(dKeyheader_wild__st_fname_lname,all);
			kKeyheader_wild__st_fname_lname:=INDEX(fulldKeyheader_wild__st_fname_lname,{fulldKeyheader_wild__st_fname_lname},'~prte::key::header_wild::'+pIndexVersion+'::st.fname.lname');

			fulldKeyheader_wild__zip_lname_fname := dedup(dKeyheader_wild__zip_lname_fname,all);
			kKeyheader_wild__zip_lname_fname:=INDEX(fulldKeyheader_wild__zip_lname_fname,{fulldKeyheader_wild__zip_lname_fname},'~prte::key::header_wild::'+pIndexVersion+'::zip.lname.fname');


			return	sequential(
							parallel(
								 build(kKeyHeader__hhid__did_ver			, update)
								,build(kKeyHeader__hhid__hhid_ver			, update)
								,build(kKeyHeader__address			, update)
								,build(kKeyHeader__apt_bldgs			, update)
								,build(kKeyHeader__da			, update)
								,build(kKeyHeader__data			, update)
								,build(kKeyHeader__did_ssn_date			, update)
								,build(kKeyHeader__dobname			, update)
								,build(kKeyHeader__fname_small			, update)
								,build(kKeyHeader__lname_fname			, update)
								,build(kKeyHeader__lname_fname_alt			, update)
								,build(kKeyHeader__minors			, update)
								,build(kKeyHeader__nbr			, update)
								,build(kKeyHeader__nbr_address			, update)
								,build(kKeyHeader__nbr_uid			, update)
								,build(kKeyHeader__phone			, update)
								,build(kKeyHeader__phonetic_lname			, update)
								,build(kKeyHeader__pname_prange_st_city_sec_range_lname			, update)
								,build(kKeyHeader__pname_zip_name_range			, update)
								,build(kKeyHeader__relatives			, update)
								,build(kKeyHeader__relatives_v3			, update)								
								,build(kKeyHeader__rid_did2			, update)
								,build(kKeyHeader__ssn_did			, update)
								,build(kKeyHeader__ssn4_did			, update)
								,build(kKeyHeader__ssn5_did			, update)
								,build(kKeyHeader__ssn_address			, update)
								,build(kKeyHeader__st_city_fname_lname			, update)
								,build(kKeyHeader__st_fname_lname			, update)
								,build(kKeyHeader__zip_lname_fname			, update)
								,build(kKeyHeader__zipprlname			, update)
								,build(kKeyheader_dts__fname_small,UPDATE)
								,build(kKeyheader_dts__pname_prange_st_city_sec_range_lname,UPDATE)
								,build(kKeyheader_dts__pname_zip_name_range,UPDATE)
								,build(kKeyheader_wild__fname_small,UPDATE)
								,build(kKeyheader_wild__lname_fname,UPDATE)
								,build(kKeyheader_wild__phone,UPDATE)
								,build(kKeyheader_wild__pname_prange_st_city_sec_range_lname,UPDATE)
								,build(kKeyheader_wild__pname_zip_name_range,UPDATE)
								,build(kKeyheader_wild__ssn_did,UPDATE)
								,build(kKeyheader_wild__st_city_fname_lname,UPDATE)
								,build(kKeyheader_wild__st_fname_lname,UPDATE)
								,build(kKeyheader_wild__zip_lname_fname,UPDATE)
							 )
		 );


		END;
END;
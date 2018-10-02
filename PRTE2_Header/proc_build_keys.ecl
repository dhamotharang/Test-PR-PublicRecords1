import data_services, header,RoxieKeyBuild,doxie,doxie_build,business_risk,Address,doxie_files,InsuranceHeader_xLink,_Control,std,Relationship;
export proc_build_keys(string filedate) := MODULE

    SHARED kpn:=  PRTE2_Header.constants.KEY_PREFIX;       // '~prte::key::header::'
    SHARED kpf := PRTE2_Header.constants.KEY_PREFIX_FCRA;  // '~prte::key::fcra::header::'
    SHARED phw := '~prte::key::header_wild::';
    SHARED phd := kpn + 'dts::';
    SHARED pih := '~prte::key::insuranceheader_xlink::';
    SHARED phl := '~prte::key::lab::';
    SHARED pll := '~prte::key::lssi::';
    SHARED kpa := '~prte::key::aid::';
    
    /* ***********************************************  BUILD KEYS  *********************************************/

    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_Did_HDid        ,kpn+'did_hhid'                                       ,kpn+'hhid::'+filedate+'::did.ver'                             ,k02);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_AptBuildings              ,kpn+'apt_bldgs'                                      ,kpn+filedate+'::apt_bldgs'                                    ,k03);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_AptBuildings          ,kpf+'apt_bldgs'                                      ,kpf+filedate+'::apt_bldgs'                                    ,k03f);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header                     ,kpn+'data'                                           ,kpn+filedate+'::data'                                         ,k04);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_FCRA_header                ,kpf+'data'                                           ,kpf+filedate+'::data'                                         ,k04f);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_DID_SSN_Date()             ,kpn+'did.ssn.date'                                   ,kpn+filedate+'::did.ssn.date'                                 ,k05);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_DOBName             ,kpn+'dobname'                                        ,kpn+filedate+'::dobname'                                      ,k06);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.Key_Header_FnameSmall          ,kpn+'fname_small'                                    ,kpn+filedate+'::fname_small'                                  ,k07);
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_Address         ,phd+'pname.prange.st.city.sec_range.lname'           ,phd+filedate+'::pname.prange.st.city.sec_range.lname'         ,k08);
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_StreetZipName   ,phd+'pname.zip.name.range'                           ,phd+filedate+'::pname.zip.name.range'                         ,k09);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Name_alt            ,kpn+'lname.fname_alt'                                ,kpn+filedate+'::lname.fname_alt'                              ,k10);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Name                ,kpn+'lname.fname'                                    ,kpn+filedate+'::lname.fname'                                  ,k11);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header_phone               ,kpn+'phone'                                          ,kpn+filedate+'::phone'                                        ,k12);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_address                    ,kpn+'pname.prange.st.city.sec_range.lname'           ,kpn+filedate+'::pname.prange.st.city.sec_range.lname'         ,k13);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_StreetZipName       ,kpn+'pname.zip.name.range'                           ,kpn+filedate+'::pname.zip.name.range'                         ,k14);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_SSN                 ,kpn+'ssn.did'                                        ,kpn+filedate+'::ssn.did'                                      ,k15);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_SSN4                ,kpn+'ssn4.did'                                       ,kpn+filedate+'::ssn4.did'                                     ,k16);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_SSN5                ,kpn+'ssn5.did'                                       ,kpn+filedate+'::ssn5.did'                                     ,k17);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_StCityLFName        ,kpn+'st.city.fname.lname'                            ,kpn+filedate+'::st.city.fname.lname'                          ,k18);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_StFnameLname        ,kpn+'st.fname.lname'                                 ,kpn+filedate+'::st.fname.lname'                               ,k19);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_FnameSmall     ,phw+'fname_small'                                    ,phw+filedate+'::fname_small'                                  ,k20);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Name           ,phw+'lname.fname'                                    ,phw+filedate+'::lname.fname'                                  ,k21);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Phone          ,phw+'phone'                                          ,phw+filedate+'::phone'                                        ,k22);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address        ,phw+'pname.prange.st.city.sec_range.lname'           ,phw+filedate+'::pname.prange.st.city.sec_range.lname'         ,k23);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StreetZipName  ,phw+'pname.zip.name.range'                           ,phw+filedate+'::pname.zip.name.range'                         ,k24);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_header_wild_ssn            ,phw+'ssn.did'                                        ,phw+filedate+'::ssn.did'                                      ,k25);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StCityLFName   ,phw+'st.city.fname.lname'                            ,phw+filedate+'::st.city.fname.lname'                          ,k26);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_StFnameLname   ,phw+'st.fname.lname'                                 ,phw+filedate+'::st.fname.lname'                               ,k27);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Zip            ,phw+'zip.lname.fname'                                ,phw+filedate+'::zip.lname.fname'                              ,k28);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Zip                 ,kpn+'zip.lname.fname'                                ,kpn+filedate+'::zip.lname.fname'                              ,k29);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_ZipPRLName          ,kpn+'zipprlname'                                     ,kpn+filedate+'::zipprlname'                                   ,k30);
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header.key_phonetic_lname            ,kpn+'phonetic_lname'                                 ,kpn+filedate+'::phonetic_lname'                               ,k31);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Address             ,kpn+'header_address'                                 ,kpn+filedate+'::address'                                      ,k32);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_FCRA_Header_Address        ,kpf+'header_address'                                 ,kpf+filedate+'::address'                                      ,k32f);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.key_nbr_headers                ,kpn+'header_nbr'                                     ,kpn+filedate+'::nbr'                                          ,k33);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Doxie.key_nbr_headers_uid            ,kpn+'header_nbr_uid'                                 ,kpn+filedate+'::nbr_uid'                                      ,k34);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(business_risk.Key_SSN_Address        ,kpn+'header_ssn_address'                             ,kpn+filedate+'::ssn_address'                                  ,k35);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_HHID_Did        ,kpn+'hhid_did'                                       ,kpn+'hhid::'+filedate+'::hhid.ver'                            ,k36);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_Nbr_Address               ,kpn+'nbr_address'                                    ,kpn+filedate+'::nbr_address'                                  ,k37);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Did_Rid2                   ,kpn+'rid_did2'                                       ,kpn+filedate+'::rid_did2'                                     ,k38);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Dob_PFname          ,kpn+'dob_pfname'                                     ,kpn+filedate+'::dob_pfname'                                   ,k39);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Address.Key_CityStChance             ,kpn+'hdr_city_name.st.percent_chance'                ,kpn+filedate+'::city_name.st.percent_chance'                  ,k40);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_CountyName          ,kpn+'county'                                         ,kpn+filedate+'::county'                                       ,k41);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Dob_Fname           ,kpn+'dob_fname'                                      ,kpn+filedate+'::dob_fname'                                    ,k42);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_minors_hash          ,kpn+'minors_hash'                                    ,kpn+filedate+'::minors_hash'                                  ,k43);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Piz                 ,kpn+'piz_lname_fname'                                ,kpn+filedate+'::piz_lname_fname'                              ,k44);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Did_Rid                    ,kpn+'rid_did'                                        ,kpn+filedate+'::rid_did'                                      ,k45);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_SSN4_V2             ,kpn+'ssn4_v2.did'                                    ,kpn+filedate+'::ssn4_v2.did'                                  ,k46);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_Zip_Did         ,kpn+'zip_did'                                        ,kpn+filedate+'::zip_did'                                      ,k47);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.key_prep_zip_did_full    ,kpn+'zip_did_full'                                   ,kpn+filedate+'::zip_did_full'                                 ,k48);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address_Loose  ,phw+'lname.fname.st.city.z5.pname.prange.sec_range'  ,phw+filedate+'::lname.fname.st.city.z5.pname.prange.sec_range',k49);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_Address_EN     ,phw+'pname.prange.st.city.sec_range.lname.en'        ,phw+filedate+'::pname.prange.st.city.sec_range.lname.en'      ,k50);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.Key_Header_Wild_SSN_EN         ,phw+'ssn.did.en'                                     ,phw+filedate+'::ssn.did.en'                                   ,k51);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_did_lookups                ,kpn+'header_lookups'                                 ,kpn+filedate+'::lookups'                                      ,k52);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_files.key_minors               ,kpn+'minors'                                         ,kpn+filedate+'::minors'                                       ,k53);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_DA                  ,kpn+'da'                                             ,kpn+filedate+'::da'                                           ,k54);
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(doxie.Key_Header_DTS_FnameSmall      ,phd+'fname_small'                                    ,phd+filedate+'::fname_small'                                  ,k55);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(prte2_header.key_relatives_v3        ,kpn+'relatives_v3'                                   ,kpn+filedate+'::relatives_v3'                                 ,k82);
				RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(prte2_header.key_insuranceheader_xlink_did     ,pih+'did'                                  ,pih+filedate+'::did'                                 									,k85);

    SHARED build_keys := parallel(    k02,k03,k04,k05,k06,k07,k08,k09,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,
                                  k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32,k33,k34,k35,k36,k37,k38,k39,k40,
                                  k41,k42,k43,k44,k45,k46,k47,k48,k49,k50,k51,k52,k53,k54,k55,k82,k85,
                           
                                  k03f,k04f,k32f );
    
    /* ***********************************************  BUILD EMPTY KEYS  *********************************************/    
    ecl1 :=  '#workunit(\'name\',\'PRTE2_Header.proc_build_keys STEP2\');\n'
            +PRTE2_Header.fn_bld_blank_index('','doxie.key_header_address_research  ','thor_data400::key::address_research',           '::address_research',kpn,filedate,       '01')
            +PRTE2_Header.fn_bld_blank_index('','header.key_addr_hist(false)        ','thor_data400::key::header::address_rank',       '::address_rank',kpn,filedate,           '56')
            +PRTE2_Header.fn_bld_blank_index('','header.key_addr_hist(false)        ','thor_data400::key::fcra::header::address_rank', '::address_rank',kpf,filedate,           '56f')
            +PRTE2_Header.fn_bld_blank_index('','AddrFraud.Key_AddrFraud_GeoLink    ','thor_data400::key::addrrisk_geolink',           '::addrrisk_geolink',kpn,filedate,       '57')
            +PRTE2_Header.fn_bld_blank_index('','header.key_ADL_segmentation        ','thor_data400::key::adl_segmentation',           '::adl_segmentation',kpn,filedate,       '58')
            +PRTE2_Header.fn_bld_blank_index('','Header.Key_DMV_restricted()        ','thor_data400::key::header::dmv_restricted',     '::dmv_restricted',kpn,filedate,         '59')
            +PRTE2_Header.fn_bld_blank_index('','doxie.Key_legacy_ssn               ','thor_data400::key::header.legacy_ssn',          '::legacy_ssn',kpn,filedate,             '60')
            +PRTE2_Header.fn_bld_blank_index('','doxie.Key_FCRA_legacy_ssn          ','thor_data400::key::fcra::header.legacy_ssn',    '::legacy_ssn',kpf,filedate,             '60f')
            +PRTE2_Header.fn_bld_blank_index('','doxie.key_max_dt_last_seen         ','thor_data400::key::max_dt_last_seen',           '::max_dt_last_seen',kpn,filedate,       '61')
            +PRTE2_Header.fn_bld_blank_index('','doxie.key_FCRA_max_dt_last_seen    ','thor_data400::key::max_dt_last_seen',           '::max_dt_last_seen',kpf,filedate,       '61f')
            +PRTE2_Header.fn_bld_blank_index('','doxie.key_ParentLnames             ','thor_data400::key::header.parentlnames',        '::parentlnames',kpn,filedate,           '62')
            +PRTE2_Header.fn_bld_blank_index('','doxie.Key_Did_Rid_Split            ','thor_data400::key::rid_did_split',              '::rid_did_split',kpn,filedate,          '63')
            +PRTE2_Header.fn_bld_blank_index('','doxie.Key_Troy_Prep                ','thor_data400::key::troy',                       '::troy',kpn,filedate,                   '64')
            +PRTE2_Header.fn_bld_blank_index('','doxie.Key_TUCH_dob                 ','thor_data400::key::header.tuch_dob',            '::tuch_dob',kpn,filedate,               '65')
            +PRTE2_Header.fn_bld_blank_index('','idl_adl_mapping.keys.key_rid       ','thor_data400::key::lab.did_rid',                '::lab.did_rid',kpn,filedate,            '66')
            +PRTE2_Header.fn_bld_blank_index('','lssi.Key_Prep_Determiner           ','thor_data400::key::lssi.determiner',            '::determiner',kpn,filedate,             '67')
            +PRTE2_Header.fn_bld_blank_index('','AID_Build.Key_AID_Base             ','thor_data400::key::aid::rawaid_to_acecahe',     '::rawaid_to_acecahe',kpa,filedate,      '68')
            +PRTE2_Header.fn_bld_blank_index('','idl_adl_mapping.keys.key_rid       ','thor_data400::key::lab.did_rid',                '::did_rid',phl,filedate,                '69')
            +PRTE2_Header.fn_bld_blank_index('','Lssi.Key_Determiner                ','thor_data400::key::lssi.determiner',            '::determiner',pll,filedate,             '70')
            +PRTE2_Header.fn_bld_blank_index('','Header.Key_Addr_Unique_Expanded(false)','thor_data400::key::header',                  '::addr_unique_expanded',kpn,filedate,   '83'  ,'::qa')
            +PRTE2_Header.fn_bld_blank_index('','Header.Key_Addr_Unique_Expanded(true)','thor_data400::key::fcra::header',             '::addr_unique_expanded',kpf,filedate,   '83f' ,'::qa')
        
    +'sequential(parallel(bld01, bld56, bld56f, bld57, bld58, bld59, bld60, bld60f, bld61, bld61f, bld62, bld63, bld64, bld65,  \n'
    +'                           bld66,         bld67, bld68, bld69, bld70, bld83, bld83f                                      )\n'
    +'          ,PRTE2_Header.proc_build_keys(\''+filedate+'\').step2);';

    SHARED build_empty_keys := //output(ecl1); 
                        _Control.fSubmitNewWorkunit(ecl1,std.system.job.target());
                        
    // *****************************************************************************************************************************************************************

    #stored ('CustomerTestEnv',TRUE);
    SHARED  build_PersonLABKeys := InsuranceHeader_xLink.CustTest_Proc_GoExternal(filedate);
                                                     ;

    // move keys to built 

            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::address_research'                               ,kpn+filedate+'::address_research'                             ,MB01);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::did_hhid'                                       ,kpn+'hhid::'+filedate+'::did.ver'                             ,MB02);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::apt_bldgs'                                      ,kpf+filedate+'::apt_bldgs'                                    ,MB03f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::apt_bldgs'                                      ,kpn+filedate+'::apt_bldgs'                                    ,MB03);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::data'                                           ,kpf+filedate+'::data'                                         ,MB04f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::data'                                           ,kpn+filedate+'::data'                                         ,MB04);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::did.ssn.date'                                   ,kpn+filedate+'::did.ssn.date'                                 ,MB05);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::dobname'                                        ,kpn+filedate+'::dobname'                                      ,MB06);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::fname_small'                                    ,kpn+filedate+'::fname_small'                                  ,MB07);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phd+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,phd+filedate+'::pname.prange.st.city.sec_range.lname'         ,MB08);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phd+'@version@'+'::pname.zip.name.range'                           ,phd+filedate+'::pname.zip.name.range'                         ,MB09);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::lname.fname_alt'                                ,kpn+filedate+'::lname.fname_alt'                              ,MB10);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::lname.fname'                                    ,kpn+filedate+'::lname.fname'                                  ,MB11);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::phone'                                          ,kpn+filedate+'::phone'                                        ,MB12);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,kpn+filedate+'::pname.prange.st.city.sec_range.lname'         ,MB13);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::pname.zip.name.range'                           ,kpn+filedate+'::pname.zip.name.range'                         ,MB14);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::ssn.did'                                        ,kpn+filedate+'::ssn.did'                                      ,MB15);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::ssn4.did'                                       ,kpn+filedate+'::ssn4.did'                                     ,MB16);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::ssn5.did'                                       ,kpn+filedate+'::ssn5.did'                                     ,MB17);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::st.city.fname.lname'                            ,kpn+filedate+'::st.city.fname.lname'                          ,MB18);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::st.fname.lname'                                 ,kpn+filedate+'::st.fname.lname'                               ,MB19);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::fname_small'                                    ,phw+filedate+'::fname_small'                                  ,MB20);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::lname.fname'                                    ,phw+filedate+'::lname.fname'                                  ,MB21);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::phone'                                          ,phw+filedate+'::phone'                                        ,MB22);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,phw+filedate+'::pname.prange.st.city.sec_range.lname'         ,MB23);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::pname.zip.name.range'                           ,phw+filedate+'::pname.zip.name.range'                         ,MB24);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::ssn.did'                                        ,phw+filedate+'::ssn.did'                                      ,MB25);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::st.city.fname.lname'                            ,phw+filedate+'::st.city.fname.lname'                          ,MB26);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::st.fname.lname'                                 ,phw+filedate+'::st.fname.lname'                               ,MB27);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::zip.lname.fname'                                ,phw+filedate+'::zip.lname.fname'                              ,MB28);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::zip.lname.fname'                                ,kpn+filedate+'::zip.lname.fname'                              ,MB29);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::zipprlname'                                     ,kpn+filedate+'::zipprlname'                                   ,MB30);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::phonetic_lname'                                 ,kpn+filedate+'::phonetic_lname'                               ,MB31);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::address'                                        ,kpf+filedate+'::address'                                      ,MB32f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::address'                                        ,kpn+filedate+'::address'                                      ,MB32);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::nbr'                                            ,kpn+filedate+'::nbr'                                          ,MB33);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::nbr_uid'                                        ,kpn+filedate+'::nbr_uid'                                      ,MB34);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::ssn_address'                                    ,kpn+filedate+'::ssn_address'                                  ,MB35);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::hhid'+'hhid.ver'                                ,kpn+'hhid::'+filedate+'::hhid.ver'                            ,MB36);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::nbr_address'                                    ,kpn+filedate+'::nbr_address'                                  ,MB37);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::rid_did2'                                       ,kpn+filedate+'::rid_did2'                                     ,MB38);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::dob_pfname'                                     ,kpn+filedate+'::dob_pfname'                                   ,MB39);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::city_name.st.percent_chance'                    ,kpn+filedate+'::city_name.st.percent_chance'                  ,MB40);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::county'                                         ,kpn+filedate+'::county'                                       ,MB41);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::dob_fname'                                      ,kpn+filedate+'::dob_fname'                                    ,MB42);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::minors_hash'                                    ,kpn+filedate+'::minors_hash'                                  ,MB43);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::piz_lname_fname'                                ,kpn+filedate+'::piz_lname_fname'                              ,MB44);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::rid_did'                                        ,kpn+filedate+'::rid_did'                                      ,MB45);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::ssn4_v2.did'                                    ,kpn+filedate+'::ssn4_v2.did'                                  ,MB46);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::zip_did'                                        ,kpn+filedate+'::zip_did'                                      ,MB47);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::zip_did_full'                                   ,kpn+filedate+'::zip_did_full'                                 ,MB48);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::lname.fname.st.city.z5.pname.prange.sec_range'  ,phw+filedate+'::lname.fname.st.city.z5.pname.prange.sec_range',MB49);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::pname.prange.st.city.sec_range.lname.en'        ,phw+filedate+'::pname.prange.st.city.sec_range.lname.en'      ,MB50);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phw+'@version@'+'::ssn.did.en'                                     ,phw+filedate+'::ssn.did.en'                                   ,MB51);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::lookups'                                        ,kpn+filedate+'::lookups'                                      ,MB52);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::minors'                                         ,kpn+filedate+'::minors'                                       ,MB53);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::da'                                             ,kpn+filedate+'::da'                                           ,MB54);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phd+'@version@'+'::fname_small'                                    ,phd+filedate+'::fname_small'                                  ,MB55);     

            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::address_rank'                                  ,kpn+filedate+'::address_rank'                                  ,MB56);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::address_rank'                                  ,kpf+filedate+'::address_rank'                                  ,MB56f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::addrrisk_geolink'                              ,kpn+filedate+'::addrrisk_geolink'                              ,MB57);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::adl_segmentation'                              ,kpn+filedate+'::adl_segmentation'                              ,MB58);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::dmv_restricted'                                ,kpn+filedate+'::dmv_restricted'                                ,MB59);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::legacy_ssn'                                    ,kpn+filedate+'::legacy_ssn'                                    ,MB60);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::legacy_ssn'                                    ,kpf+filedate+'::legacy_ssn'                                    ,MB60f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::max_dt_last_seen'                              ,kpn+filedate+'::max_dt_last_seen'                              ,MB61);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::max_dt_last_seen'                              ,kpf+filedate+'::max_dt_last_seen'                              ,MB61f);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::parentlnames'                                  ,kpn+filedate+'::parentlnames'                                  ,MB62);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::rid_did_split'                                 ,kpn+filedate+'::rid_did_split'                                 ,MB63);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::troy'                                          ,kpn+filedate+'::troy'                                          ,MB64);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::tuch_dob'                                      ,kpn+filedate+'::tuch_dob'                                      ,MB65);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::lab.did_rid'                                   ,kpn+filedate+'::lab.did_rid'                                   ,MB66);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::lssi.determiner'                               ,kpn+filedate+'::determiner'                                    ,MB67);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpa+'@version@'+'::rawaid_to_acecahe'                             ,kpa+filedate+'::rawaid_to_acecahe'                             ,MB68);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phl+'@version@'+'::did_rid'                                       ,phl+filedate+'::did_rid'                                       ,MB69);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pll+'@version@'+'::determiner'                                    ,pll+filedate+'::determiner'                                    ,MB70);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@'+'::addr_unique_expanded'                          ,kpn+filedate+'::addr_unique_expanded'                          ,MB83);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpf+'@version@'+'::addr_unique_expanded'                          ,kpf+filedate+'::addr_unique_expanded'                          ,MB83f);
												RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@'+'::did'                         																	 ,pih+filedate+'::did'                          																	,MB85);
						
                
    SHARED move_PersonHeaderKeys_built := parallel( MB01,MB02,MB03,MB04,MB05,MB06,MB07,MB08,MB09,MB10,MB11,MB12,MB13,MB14,MB15,MB16,MB17,MB18,MB19,MB20,
                                             MB21,MB22,MB23,MB24,MB25,MB26,MB27,MB28,MB29,MB30,MB31,MB32,MB33,MB34,MB35,MB36,MB37,MB38,MB39,MB40,
                                             MB41,MB42,MB43,MB44,MB45,MB46,MB47,MB48,MB49,MB50,MB51,MB52,MB53,MB54,MB55,
                                             
                                             MB56,MB57,MB58,MB59,MB60,MB61,MB62,MB63,MB64,MB65,MB66,MB67,MB68,MB69,MB70,MB83,
                       
                                             MB03f,MB04f,MB32f,
                                             
                                             MB56f,MB60f,MB61f,MB83f, MB85 );
    
    

            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::address'    ,pih+filedate+'::did::refs::address' ,MB69);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::dln'        ,pih+filedate+'::did::refs::dln'     ,MB70);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::dob'        ,pih+filedate+'::did::refs::dob'     ,MB71);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::lfz'        ,pih+filedate+'::did::refs::lfz'     ,MB72);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::name'       ,pih+filedate+'::did::refs::name'    ,MB73);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::ph'         ,pih+filedate+'::did::refs::ph'      ,MB74);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::relative'   ,pih+filedate+'::did::refs::relative',MB75);
            // RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::rid'        ,pih+filedate+'::did::refs::rid'     ,MB76);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::src_rid'    ,pih+filedate+'::did::refs::src_rid' ,MB77);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::ssn'        ,pih+filedate+'::did::refs::ssn'     ,MB78);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::ssn4'       ,pih+filedate+'::did::refs::ssn4'    ,MB79);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::refs::zip_pr'     ,pih+filedate+'::did::refs::zip_pr'  ,MB80);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::idl'                   ,pih+filedate+'::idl'                ,MB81);     
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(kpn+'@version@::relatives_v3'          ,kpn+filedate+'::relatives_v3'       ,MB82);
            RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pih+'@version@::did::sup::rid'         ,pih+filedate+'::did::sup::rid'      ,MB84);
    
    SHARED move_PersonLABKeys_built := parallel(MB69,MB70,MB71,MB72,MB73,MB74,MB75,MB77,MB78,MB79,MB80,MB81,MB82,MB84);
    
    
    // move keys to QA
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::address_research'                               ,'Q',MQ01,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::did_hhid'                                       ,'Q',MQ02,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::apt_bldgs'                                      ,'Q',MQ03f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::apt_bldgs'                                      ,'Q',MQ03,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::data'                                           ,'Q',MQ04f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::data'                                           ,'Q',MQ04,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::did.ssn.date'                                   ,'Q',MQ05,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::dobname'                                        ,'Q',MQ06,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::fname_small'                                    ,'Q',MQ07,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phd+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,'Q',MQ08,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phd+'@version@'+'::pname.zip.name.range'                           ,'Q',MQ09,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::lname.fname_alt'                                ,'Q',MQ10,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::lname.fname'                                    ,'Q',MQ11,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::phone'                                          ,'Q',MQ12,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,'Q',MQ13,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::pname.zip.name.range'                           ,'Q',MQ14,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::ssn.did'                                        ,'Q',MQ15,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::ssn4.did'                                       ,'Q',MQ16,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::ssn5.did'                                       ,'Q',MQ17,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::st.city.fname.lname'                            ,'Q',MQ18,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::st.fname.lname'                                 ,'Q',MQ19,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::fname_small'                                    ,'Q',MQ20,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::lname.fname'                                    ,'Q',MQ21,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::phone'                                          ,'Q',MQ22,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::pname.prange.st.city.sec_range.lname'           ,'Q',MQ23,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::pname.zip.name.range'                           ,'Q',MQ24,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::ssn.did'                                        ,'Q',MQ25,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::st.city.fname.lname'                            ,'Q',MQ26,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::st.fname.lname'                                 ,'Q',MQ27,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::zip.lname.fname'                                ,'Q',MQ28,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::zip.lname.fname'                                ,'Q',MQ29,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::zipprlname'                                     ,'Q',MQ30,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::phonetic_lname'                                 ,'Q',MQ31,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::address'                                        ,'Q',MQ32f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::address'                                        ,'Q',MQ32,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::nbr'                                            ,'Q',MQ33,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::nbr_uid'                                        ,'Q',MQ34,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::ssn_address'                                    ,'Q',MQ35,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::hhid'+'hhid.ver'                                ,'Q',MQ36,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::nbr_address'                                    ,'Q',MQ37,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::rid_did2'                                       ,'Q',MQ38,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::dob_pfname'                                     ,'Q',MQ39,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::city_name.st.percent_chance'                    ,'Q',MQ40,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::county'                                         ,'Q',MQ41,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::dob_fname'                                      ,'Q',MQ42,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::minors_hash'                                    ,'Q',MQ43,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::piz_lname_fname'                                ,'Q',MQ44,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::rid_did'                                        ,'Q',MQ45,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::ssn4_v2.did'                                    ,'Q',MQ46,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::zip_did'                                        ,'Q',MQ47,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::zip_did_full'                                   ,'Q',MQ48,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::lname.fname.st.city.z5.pname.prange.sec_range'  ,'Q',MQ49,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::pname.prange.st.city.sec_range.lname.en'        ,'Q',MQ50,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phw+'@version@'+'::ssn.did.en'                                     ,'Q',MQ51,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::lookups'                                        ,'Q',MQ52,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::minors'                                         ,'Q',MQ53,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::da'                                             ,'Q',MQ54,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phd+'@version@'+'::fname_small'                                    ,'Q',MQ55,2); 
       
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::address_rank'                                   ,'Q',MQ56,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::address_rank'                                   ,'Q',MQ56f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::addrrisk_geolink'                               ,'Q',MQ57,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::adl_segmentation'                               ,'Q',MQ58,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::dmv_restricted'                                 ,'Q',MQ59,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::legacy_ssn'                                     ,'Q',MQ60,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::legacy_ssn'                                     ,'Q',MQ60f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::max_dt_last_seen'                               ,'Q',MQ61,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::max_dt_last_seen'                               ,'Q',MQ61f,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::parentlnames'                                   ,'Q',MQ62,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::rid_did_split'                                  ,'Q',MQ63,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::troy'                                           ,'Q',MQ64,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::tuch_dob'                                       ,'Q',MQ65,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::lab.did_rid'                                    ,'Q',MQ66,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::lssi.determiner'                                ,'Q',MQ67,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpa+'@version@'+'::rawaid_to_acecahe'                              ,'Q',MQ68,2);
        RoxieKeyBuild.Mac_SK_Move_V2(phl+'@version@'+'::did_rid'                                        ,'Q',MQ69,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pll+'@version@'+'::determiner'                                     ,'Q',MQ70,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@'+'::addr_unique_expanded'                           ,'Q',MQ83,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpf+'@version@'+'::addr_unique_expanded'                           ,'Q',MQ83f,2);
								RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@'+'::did'                           																	,'Q',MQ85,2);
        
        
        ;

    SHARED move_PersonHeaderKeys_qa := parallel( MQ01,MQ02,MQ03,MQ04,MQ05,MQ06,MQ07,MQ08,MQ09,MQ10,MQ11,MQ12,MQ13,MQ14,MQ15,MQ16,MQ17,MQ18,MQ19,MQ20,
                                                 MQ21,MQ22,MQ23,MQ24,MQ25,MQ26,MQ27,MQ28,MQ29,MQ30,MQ31,MQ32,MQ33,MQ34,MQ35,MQ36,MQ37,MQ38,MQ39,MQ40,
                                                 MQ41,MQ42,MQ43,MQ44,MQ45,MQ46,MQ47,MQ48,MQ49,MQ50,MQ51,MQ52,MQ53,MQ54,MQ55,
                                                 
                                                 MQ56,MQ57,MQ58,MQ59,MQ60,MQ61,MQ62,MQ63,MQ64,MQ65,MQ66,MQ67,MQ68,MQ69,MQ70,MQ83,
                                                 
                                                 MQ03f,MQ04f,MQ32f,
                                             
                                                 MQ56f,MQ60f,MQ61f,MQ83f,MQ85);
    
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::address'    ,'Q',MQ69,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::dln'        ,'Q',MQ70,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::dob'        ,'Q',MQ71,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::lfz'        ,'Q',MQ72,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::name'       ,'Q',MQ73,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::ph'         ,'Q',MQ74,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::relative'   ,'Q',MQ75,2);
        // RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::rid'        ,'Q',MQ76,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::src_rid'    ,'Q',MQ77,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::ssn'        ,'Q',MQ78,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::ssn4'       ,'Q',MQ79,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::refs::zip_pr'     ,'Q',MQ80,2);
        RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::idl'                   ,'Q',MQ81,2);
        RoxieKeyBuild.Mac_SK_Move_V2(kpn+'@version@::relatives_v3'          ,'Q',MQ82,2);
								RoxieKeyBuild.Mac_SK_Move_V2(pih+'@version@::did::sup::rid'         ,'Q',MQ84,2);
            
            
    
    SHARED move_PersonLABKeys_qa := parallel(MQ69,MQ70,MQ71,MQ72,MQ73,MQ74,MQ75,MQ77,MQ78,MQ79,MQ80,MQ81,MQ82,MQ84);
     
    EXPORT step1 := sequential(
                                    build_keys
                                    ,build_PersonLABKeys
                                    ,build_empty_keys // This will trigger move keys in the next wuid
                                    
                                   ):success(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Header.proc_build_keys step1 completed',workunit)),
                                     failure(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Header.proc_build_keys step1 FAILED!!!',workunit));

    EXPORT step2 := SEQUENTIAL( 
                                  parallel (move_PersonHeaderKeys_built,    move_PersonLABKeys_built) ,
                                  parallel (move_PersonHeaderKeys_qa,       move_PersonLABKeys_qa   ) 
                                  
                                ):success(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Header.proc_build_keys step2 completed',workunit)),
                                  failure(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Header.proc_build_keys step2 FAILED!!!',workunit));
END;
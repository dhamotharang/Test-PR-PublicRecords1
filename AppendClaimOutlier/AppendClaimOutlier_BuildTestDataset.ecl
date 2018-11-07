Claim_Record :=
  record
    string50 transaction_id;
    string50 rendering_provider_key;
    string50 patient_key;
    string50 med_rec_num;
    string38 patient_acct_num;
    string50 pcp_provider_key;
    string50 billing_provider_key;
    string50 referring_provider_key;
    string50 primary_insured_key;
    string10 facility_npi;
    string9 company_id;
    string2 medical_security_code;
    string55 claim_num;
    string10 claim_line_num;
    string1 patient_status;
    string2 claim_status;
    string4 claim_type;
    string1 transaction_type;
    string5 adjustment_cd;
    string2 adjustment_num;
    string5 rej_reason_1;
    string5 rej_reason_2;
    string5 rej_reason_3;
    string5 rej_reason_4;
    string5 rej_reason_5;
    string5 rej_reason_6;
    string9 auth_code;
    string20 agreement_id;
    string12 line_of_business;
    string20 type_of_plan;
    string20 benefit_plan;
    string4 type_of_bill;
    string50 check_num;
    string8 check_dt;
    string8 processed_dt;
    string22 dt_tm_stamp;
    string8 service_from_dt;
    string8 service_to_dt;
    string8 service_dt;
    string8 admit_dt;
    string8 disch_dt;
    string8 received_dt;
    string8 accident_dt;
    string10 accident_type;
    string2 place_of_service;
    string10 type_of_service;
    string15 unit_of_serv_type;
    string5 units_of_service;
    string5 units_of_service_allowed;
    string12 cpt_hcpcs_proc_cd;
    string2 cpt_hcpcs_proc_cd_modifier_1;
    string2 cpt_hcpcs_proc_cd_modifier_2;
    string2 cpt_hcpcs_proc_cd_modifier_3;
    string2 cpt_hcpcs_proc_cd_modifier_4;
    string10 payment_type;
    string4 drg_source;
    string4 drg_version;
    string10 diag_rel_group;
    string10 diag_rel_group_2;
    string18 drg_pricing;
    string2 outlier_cd;
    string2 icd_version;
    string10 prn_diag_cd;
    string10 adm_diag_cd;
    string10 visit_reasn_diag_cd;
    string10 diag_cd_1;
    string10 diag_cd_2;
    string10 diag_cd_3;
    string10 diag_cd_4;
    string10 diag_cd_5;
    string10 diag_cd_6;
    string10 diag_cd_7;
    string10 diag_cd_8;
    string10 diag_cd_9;
    string10 diag_cd_10;
    string10 diag_cd_11;
    string10 diag_cd_12;
    string12 prn_icd_cd;
    string12 icd_proc_cd_1;
    string12 icd_proc_cd_2;
    string12 icd_proc_cd_3;
    string12 icd_proc_cd_4;
    string12 icd_proc_cd_5;
    string11 ndc_cd_1;
    string6 ndc_cd_1_qty;
    string2 ndc_cd_1_uom;
    string11 ndc_cd_2;
    string6 ndc_cd_2_qty;
    string2 ndc_cd_2_uom;
    string11 ndc_cd_3;
    string6 ndc_cd_3_qty;
    string2 ndc_cd_3_uom;
    string11 ndc_cd_4;
    string6 ndc_cd_4_qty;
    string2 ndc_cd_4_uom;
    string11 ndc_cd_5;
    string6 ndc_cd_5_qty;
    string2 ndc_cd_5_uom;
    string11 ndc_cd_6;
    string6 ndc_cd_6_qty;
    string2 ndc_cd_6_uom;
    string11 ndc_cd_7;
    string6 ndc_cd_7_qty;
    string2 ndc_cd_7_uom;
    string11 ndc_cd_8;
    string6 ndc_cd_8_qty;
    string2 ndc_cd_8_uom;
    string11 ndc_cd_9;
    string6 ndc_cd_9_qty;
    string2 ndc_cd_9_uom;
    string11 ndc_cd_10;
    string6 ndc_cd_10_qty;
    string2 ndc_cd_10_uom;
    string10 revenue_cd;
    string50 payee_code;
    string1 network_ind;
    string1 prov_medicare_par_ind;
    string1 max_pocket_out_met_indv;
    string1 max_pocket_out_met_family;
    string1 deductible_met_indv;
    string1 deductible_met_family;
    string1 price_ind;
    string18 charge_amt;
    string18 rc_amt;
    string18 deduct_amt;
    string18 paid_amt;
    string18 copay_amt;
    string18 cob_amt;
    string18 co_ins_amt;
    string50 med_user_def_01;
    string50 med_user_def_02;
    string50 med_user_def_03;
    string50 med_user_def_04;
    string50 med_user_def_05;
    string50 med_user_def_06;
    string50 med_user_def_07;
    string50 med_user_def_08;
    string50 med_user_def_09;
    string50 med_user_def_10;
    string50 cleanclaimproviderkey;
    string50 cleanclaimpatientkey;
    string55 cleanclaimclaimnumber;
    string10 cleanclaimclaimlinenumber;
    string8 cleanclaimbeginningdateofservice;
    string8 cleanclaimendingdateofservice;
    string8 cleanclaimservicedate;
    string18 cleanclaimchargeamount;
    string18 cleanclaimpaidamount;
  end;
dsClaim :=
  dataset([
    {'320482258                                         ', 'PDI410810                                         ', 'HPP13573401                                       ', '                                                  ', 'TVWX7152006369969                     ', '1313        0013                                  ', 'PDI410810                                         ', 'AA133446    0004                                  ', 'HPP13573400                                       ', '1568633741', 'HPHC     ', '  ', '130701M2968700                                         ', '0010      ', ' ', 'Y ', 'M   ', 'O', '2958 ', '00', '2958 ', '     ', '     ', '     ', '     ', '     ', '         ', '                    ', 'COM         ', 'COM                 ', '                    ', '    ', '                                                  ', '        ', '20130709', '                      ', '20130701', '20130701', '        ', '        ', '        ', '20130701', '        ', '          ', '12', '10        ', 'Count          ', '1    ', '     ', 'E1390       ', 'RR', '  ', '  ', '  ', '          ', '    ', '    ', '          ', '          ', '                  ', '  ', '9 ', '496       ', '          ', '          ', '496       ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '            ', '            ', '            ', '            ', '            ', '            ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '          ', '                                                  ', ' ', ' ', ' ', ' ', ' ', '0', ' ', '0000519.51        ', '0000098.24        ', '0000000.00        ', '0000098.24        ', '0000000.00        ', '0000000.00        ', '                  ', 'P1                                                ', 'PPO                                               ', '1MONTHD2                                          ', 'AA133446                                          ', '1313                                              ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'PDI410810                                         ', 'HPP13573401                                       ', '130701M2968700                                         ', '0010      ', '20130701', '20130701', '        ', '0000519.51        ', '0000098.24        '}, 
    {'320643768                                         ', 'PDI410810                                         ', 'HPP14208400                                       ', '                                                  ', 'TVWX71420065                          ', '1313        0026                                  ', 'PDI410810                                         ', 'AA100424    0005                                  ', 'HPP14208400                                       ', '1295770659', 'HPHC     ', '  ', '130701M29696                                           ', '01        ', ' ', 'Y ', 'M   ', 'O', '11   ', '00', '11   ', '     ', '     ', '     ', '     ', '     ', 'PHI01905 ', '                    ', 'COM         ', 'COM                 ', '                    ', '    ', '                                                  ', '        ', '20130709', '                      ', '20130701', '20130701', '        ', '        ', '        ', '20130701', '        ', '          ', '12', '10        ', 'Count          ', '1    ', '     ', 'E0470       ', 'RR', '  ', '  ', '  ', '          ', '    ', '    ', '          ', '          ', '                  ', '  ', '9 ', '327.23    ', '          ', '          ', '327.23    ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '          ', '            ', '            ', '            ', '            ', '            ', '            ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '           ', '      ', '  ', '          ', '                                                  ', ' ', ' ', ' ', ' ', ' ', '0', ' ', '0000671.95        ', '0000133.03        ', '0000000.00        ', '0000133.03        ', '0000000.00        ', '0000000.00        ', '                  ', 'FS                                                ', 'PPO                                               ', '15MONTD2                                          ', 'AA100424                                          ', '1313                                              ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'PDI410810                                         ', 'HPP14208400                                       ', '130701M29696                                           ', '01        ', '20130701', '20130701', '        ', '0000671.95        ', '0000133.03        '}], Claim_Record);
		
OUTPUT(dsClaim,,'~qa::appenclaimoutlier::appendclaimoutlier::input3',OVERWRITE,compressed);

Patient_Record :=
  record
    unsigned8 lexid;
    string50 patient_key;
    string12 patient_num;
    string2 patient_seq_nbr;
    string2 patient_security_code;
    string2 patient_relation;
    string9 patient_ssn;
    string30 patient_first_name;
    string1 patient_mid_init;
    string36 patient_last_name;
    string36 patient_address_1;
    string36 patient_address_2;
    string24 patient_city_name;
    string2 patient_state_name;
    string9 patient_zip_cd;
    string30 patient_county;
    string2 patient_country;
    string8 patient_birth_dt;
    string1 patient_gender;
    string8 patient_dod;
    string8 insured_elig_eff_dt;
    string8 insured_elig_exp_dt;
    string6 insured_elig_cov_type;
    string4 insured_elig_status;
    string50 primary_member_key;
    string9 primary_ins_ssn;
    string12 primary_ins_num;
    string12 primary_ins_policy_number;
    string15 primary_ins_group_num;
    string11 primary_ins_division_num;
    string8 patient_latest_update_date;
    string50 pat_user_def_01;
    string50 pat_user_def_02;
    string50 pat_user_def_03;
    string50 pat_user_def_04;
    string50 pat_user_def_05;
    string50 pat_user_def_06;
    string50 pat_user_def_07;
    string50 pat_user_def_08;
    string50 pat_user_def_09;
    string50 pat_user_def_10;
    string20 idvfirstname;
    string20 idvmiddlename;
    string20 idvlastname;
    string5 idvnamesuffix;
    string10 idvprimaryrange;
    string2 idvpredirectional;
    string28 idvprimaryname;
    string4 idvaddresssuffix;
    string2 idvpostdirectional;
    string10 idvunitdesignation;
    string8 idvsecondaryrange;
    string25 idvpostalcity;
    string25 idvvanitycity;
    string2 idvstate;
    string5 idvzip5;
    string4 idvzip4;
    string2 idvdbpc;
    string1 idvcheckdigit;
    string2 idvrecordtype;
    string2 idvfipsstate;
    string3 idvcounty;
    string10 idvlatitude;
    string11 idvlongitude;
    string4 idvmsa;
    string7 idvgeoblock;
    string1 idvgeomatchcode;
    string4 idverrorstatus;
    string1 consumerpatienthasbankruptcy;
    string1 consumerpatienthasconvictions;
    string1 consumerpatienthasdeceased;
    string8 consumerpatientdateofdeaceased;
    string1 consumerpatienthasrelativebankruptcy;
    string1 consumerpatienthasrelativeconvictions;
    string8 consumerpatientbankruptcydate;
    string8 consumerpatientconvictiondate;
    string3 consumerpatientrelativecount;
    string3 consumerpatientrelativesbankruptcycount;
    string3 consumerpatientrelativesfelonycount;
  end;

  dsPatient :=
  dataset([
    {86716, 'HP241570500                                       ', 'HP241570500 ', '00', '  ', '1 ', '142807976', 'GRETA                         ', ' ', 'MERHY                               ', '16 HEREFORD ST                      ', 'APT 1                               ', 'BOSTON                  ', 'MA', '02115    ', 'SUFFOLK                       ', 'US', '19760212', 'F', '        ', '20120923', '20120930', 'I     ', 'TERM', 'HP241570500                                       ', '142807976', 'HP2415705   ', 'HP241570500 ', '058590         ', '0585900000 ', '        ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'GRETA               ', '                    ', 'MERHY               ', '     ', '16        ', '  ', 'HEREFORD                    ', 'ST  ', '  ', 'APT       ', '1       ', 'BOSTON                   ', 'BOSTON                   ', 'MA', '02115', '1611', '01', '1', 'H ', '25', '025', '42.351050 ', '-71.086540 ', '0000', '0108021', '0', 'S800', 'N', 'N', 'N', '        ', 'Y', 'Y', '        ', '        ', '12 ', '1  ', '1  '}, 
    {86716, 'HP520450900                                       ', 'HP520450900 ', '00', '  ', '1 ', '142807976', 'GRETA                         ', 'A', 'MERHY                               ', '16 HEREFORD ST APT #1               ', '                                    ', 'BOSTON                  ', 'MA', '02115    ', 'SUFFOLK                       ', 'US', '19760212', 'F', '        ', '20160720', '20160930', 'ES    ', 'ACTV', 'HP520450900                                       ', '142807976', 'HP5204509   ', 'HP520450900 ', '040609         ', '0406090000 ', '        ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'GRETA               ', 'A                   ', 'MERHY               ', '     ', '16        ', '  ', 'HEREFORD                    ', 'ST  ', '  ', 'APT       ', '1       ', 'BOSTON                   ', 'BOSTON                   ', 'MA', '02115', '1611', '01', '1', 'H ', '25', '025', '42.351050 ', '-71.086540 ', '0000', '0108021', '0', 'S800', 'N', 'N', 'N', '        ', 'Y', 'Y', '        ', '        ', '12 ', '1  ', '1  '}], Patient_Record);

 OUTPUT(dsPatient,,'~qa::appenclaimoutlier::appendclaimoutlier::input2',OVERWRITE,compressed);
  
Provider_Record :=
  record
    string50 provider_key;
    string10 provider_npi;
    string12 provider_dea;
    string10 provider_taxonomy;
    string10 provider_tax_id;
    string5 provider_tax_id_suffix;
    string12 provider_num;
    string5 provider_num_suffix;
    string2 provider_num_qualifier;
    string2 provider_security_code;
    string3 network_code;
    string50 provider_facility_name;
    string12 provider_facility_num;
    string30 provider_first_name;
    string36 provider_last_name;
    string36 provider_address_1;
    string36 provider_address_2;
    string24 provider_city;
    string2 provider_state;
    string9 provider_zip_cd;
    string30 provider_county;
    string2 provider_country;
    string4 provider_region;
    string9 prov_specialty_cd_1;
    string9 prov_specialty_cd_2;
    string2 provider_type;
    string1 watch_cd;
    string8 provider_latest_update_date;
    string50 prov_user_def_01;
    string50 prov_user_def_02;
    string50 prov_user_def_03;
    string50 prov_user_def_04;
    string50 prov_user_def_05;
    string50 prov_user_def_06;
    string50 prov_user_def_07;
    string50 prov_user_def_08;
    string50 prov_user_def_09;
    string50 prov_user_def_10;
    string50 provproviderkey;
    string20 provfirstname;
    string20 provmiddlename;
    string20 provlastname;
    string5 provnamesuffix;
    string10 provprimaryrange;
    string2 provpredirectional;
    string28 provprimaryname;
    string4 provaddresssuffix;
    string2 provpostdirectional;
    string10 provunitdesignation;
    string8 provsecondaryrange;
    string25 provpostalcity;
    string25 provvanitycity;
    string2 provstate;
    string5 provzip5;
    string4 provzip4;
    string2 provdbpc;
    string1 provcheckdigit;
    string2 provrecordtype;
    string2 provfipsstate;
    string3 provcounty;
    string10 provlatitude;
    string11 provlongitude;
    string4 provmsa;
    string7 provgeoblock;
    string1 provgeomatchcode;
    string4 proverrorstatus;
    string1 advoadvohitflag;
    string1 advovacancyindicator;
    string1 advothrowbackindicator;
    string1 advoseasonaldeliveryindicator;
    string5 advoseasonalsuppressionstartdate;
    string5 advoseasonalsuppressionenddate;
    string1 advodonotdeliverindicator;
    string1 advocollegeindicator;
    string10 advocollegesuppressionstartdate;
    string10 advocollegesuppressionenddate;
    string1 advoaddressstyle;
    string5 advosimplifyaddresscount;
    string1 advodropindicator;
    string1 advoresidentialorbusinessindicator;
    string1 advoonlywaytogetmailindicator;
    string1 advorecordtypecode;
    string1 advoadvoaddresstype;
    string1 advoaddressusagetype;
    string8 advofirstseendate;
    string8 advolastseendate;
    string8 advovendorfirstreporteddate;
    string8 advovendorlastreporteddate;
    string8 advovacationbegindate;
    string8 advovacationenddate;
    string8 advonumberofcurrentvacationmonths;
    string8 advomaxvacationmonths;
    string8 advovacationperiodscount;
    string1 advoacahitflag;
    string200 advoinstitution;
    string2 advoinstitutiontype;
    string10 advoinstitutiontypeexp;
    string1 advoacaaddresstype;
    unsigned8 providerlnpid;
    unsigned2 providerpidweight;
    unsigned2 providerpiddistance;
    unsigned8 providerattrlexid;
    string1 providerattrentitytype;
    string20 providerattrfname;
    string20 providerattrmname;
    string28 providerattrlname;
    string5 providerattrsname;
    string9 providerattrssn;
    string9 providerattrconsumerssn;
    unsigned4 providerattrdateofbirth;
    unsigned4 providerattrconsumerdateofbirth;
    string25 providerattrlicensenumber;
    string25 providerattrcleanedlicensenumber;
    string2 providerattrlicensestate;
    string60 providerattrlicensetype;
    string60 providerattrlicensestatus;
    unsigned4 providerattrdatelicenseexpired;
    unsigned4 providerattrlicensecount;
    unsigned4 providerattrlicensestatecount;
    unsigned4 providerattractivelicensecount;
    unsigned4 providerattrinactivelicensecount;
    unsigned4 providerattrrevokedlicensecount;
    string2 providerattrinactivelicensestate;
    string1 providerattrinactivelicenseflag;
    string1 providerattrrevokedlicenseflag;
    string1 providerattrexpiredlicenseflag;
    string1 providerattrdeathindicator;
    unsigned4 providerattrdateofdeath;
    unsigned4 providerattrbillingtaxid;
    string10 providerattrphone;
    string10 providerattrfax;
    string6 providerattrupin;
    string10 providerattrnpinumber;
    string8 providerattrnpienumerationdate;
    string8 providerattrnpideactivationdate;
    string8 providerattrnpireactivationdate;
    string1 providerattrnpiflag;
    unsigned4 providerattrdeactivednpicount;
    string1 providerattrdeabusinessactivityindicator;
    string10 providerattrdeanumber;
    unsigned4 providerattrdatedeaexpired;
    unsigned4 providerattrdeacount;
    unsigned4 providerattractivedeacount;
    unsigned4 providerattrexpireddeacount;
    string1 providerattrdeaexpiredflag;
    string1 providerattrisstatesanction;
    string1 providerattrisoigsanction;
    string1 providerattrisopmsanction;
    string10 providerattrtaxonomy;
    string50 providerattrtaxonomydescription;
    string3 providerattrspecialitycode;
    string1 providerattrproviderstatus;
    string40 providerattrgroupkey;
    string1 providerattrhasactivelicenserevocation;
    string2 providerattractivelicenserevocationstate;
    string8 providerattractivelicenserevocationdate;
    string1 providerattrhasactivestateexclusion;
    string2 providerattractivelicenseexclusionstate;
    string8 providerattractivestateexclusiondate;
    string1 providerattrhasactiveoigexclusion;
    string8 providerattractiveoigexclusiondate;
    string1 providerattrhasactiveopmexclusion;
    string8 providerattractiveopmexclusiondate;
    string8 providerattractivestatesanctionexclusiondate;
    string8 providerattractiveoigsanctionexclusiondate;
    string8 providerattractiveopmsanctionexclusiondate;
    string1 providerattrhaslicenserevocationreinstated;
    string2 providerattrlicenserevocationreinstatedstate;
    string1 providerattrhasstateexclusioinreinstated;
    string2 providerattrstateexclusionreinstatedstate;
    string8 providerattrstateexclusionreinstateddate;
    string1 providerattrhasoigexclusioinreinstated;
    string8 providerattroigexclusionreinstateddate;
    string1 providerattrhasopmexclusioinreinstated;
    string8 providerattropmexclusionreinstateddate;
    string10 providerattrresidentialprimaryrange;
    string2 providerattrresidentialpredirectional;
    string28 providerattrresidentialprimaryname;
    string4 providerattrresidentialaddresssuffix;
    string2 providerattrresidentialpostdirectional;
    string8 providerattrresidentialsecondaryrange;
    string25 providerattrresidentialcityname;
    string2 providerattrresidentialstate;
    string5 providerattrresidentialzip5;
    unsigned3 providerattrresidentialaddresslastseen;
    string1 providerattrproviderwithsingleaddress;
    unsigned3 providerattrsingleaddressprovidercount;
    string10 providerattrpractiseprimaryrange;
    string2 providerattrpractisepredirectional;
    string28 providerattrpractiseprimaryname;
    string4 providerattrpractiseaddresssuffix;
    string2 providerattrpractisepostdirectional;
    string8 providerattrpractisesecondaryrange;
    string25 providerattrpractisecityname;
    string2 providerattrpractisestate;
    string5 providerattrpractisezip5;
    string1 providerattrhasbankruptcy;
    string8 providerattrbankruptcylastseen;
    string1 providerattrhascriminalhistory;
    string8 providerattrlastarresteddate;
    string1 providerattrhasrelativeconvictions;
    string1 providerattrhasrelativebankruptcy;
    string3 providerattrrelativecount;
    string3 providerattrrelativebankruptcycount;
    string3 providerattrrelativefelonycount;
    string1 providerattrhasassocactivestateexclusion;
    string1 providerattrhasassocactivelicenserevocation;
    string1 providerattrhasassocstateexclusionreinstated;
    string1 providerattrhasassoclicenserevocationreinstated;
    string1 providerattrhasassocbankruptcy;
    string1 providerattrhasassoccriminalhistory;
    string1 providerattrhasdeceased;
    string8 providerattrdeceaseddate;
    string1 consumerproviderhasbankruptcy;
    string1 consumerproviderhasconvictions;
    string1 consumerproviderhasdeceased;
    string8 consumerproviderdateofdeaceased;
    string1 consumerproviderhasrelativebankruptcy;
    string1 consumerproviderhasrelativeconvictions;
    string8 consumerproviderbankruptcydate;
    string8 consumerproviderconvictiondate;
    string3 consumerproviderrelativecount;
    string3 consumerproviderrelativesbankruptcycount;
    string3 consumerproviderrelativesfelonycount;
  end;
dsProvider :=
  dataset([
    {'PDI41586                                          ', '          ', '            ', '          ', '382391907 ', '     ', 'Z900637     ', '0062 ', '  ', '  ', 'N  ', 'HARPER HOSPITAL                                   ', '            ', 'HARPER                        ', 'HOSPITAL                            ', 'DEPT 641164                         ', 'PO BOX 67000                        ', 'DETROIT                 ', 'MI', '48267002 ', '                              ', '  ', '    ', '119      ', '         ', '14', ' ', '        ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'PDI41586                                          ', 'HARPER              ', '                    ', 'HOSPITAL            ', '     ', '          ', '  ', '                            ', '    ', '  ', '          ', '        ', 'DETROIT                  ', 'DETROIT                  ', 'MI', '     ', '    ', '  ', ' ', '  ', '26', '   ', '          ', '           ', '    ', '       ', '5', 'E302', 'N', ' ', ' ', ' ', '     ', '     ', ' ', ' ', '          ', '          ', ' ', '     ', ' ', ' ', ' ', ' ', ' ', ' ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', 'N', '                                                                                                                                                                                                        ', '  ', '          ', ' ', 0, 12, 0, 0, ' ', '                    ', '                    ', '                            ', '     ', '         ', '         ', 0, 0, '                         ', '                         ', '  ', '                                                            ', '                                                            ', 0, 0, 0, 0, 0, 0, '  ', ' ', ' ', ' ', ' ', 0, 0, '          ', '          ', '      ', '          ', '        ', '        ', '        ', ' ', 0, ' ', '          ', 0, 0, 0, 0, ' ', ' ', ' ', ' ', '          ', '                                                  ', '   ', ' ', '                                        ', ' ', '  ', '        ', ' ', '  ', '        ', ' ', '        ', ' ', '        ', '        ', '        ', '        ', ' ', '  ', ' ', '  ', '        ', ' ', '        ', ' ', '        ', '          ', '  ', '                            ', '    ', '  ', '        ', '                         ', '  ', '     ', 0, ' ', 0, '          ', '  ', '                            ', '    ', '  ', '        ', '                         ', '  ', '     ', ' ', '        ', ' ', '        ', ' ', ' ', '   ', '   ', '   ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '        ', 'N', 'N', 'N', '        ', 'N', 'N', '        ', '        ', '   ', '   ', '   '}, 
    {'PDI199901                                         ', '          ', '            ', '          ', '383179325 ', '     ', 'ZAA32034    ', '0031 ', '  ', '  ', 'N  ', 'MERCY MEDICAL GROUP                               ', '            ', 'STACEY W                      ', 'GORMAN                              ', 'DEPT 55001                          ', 'PO BOX 67000                        ', 'DETROIT                 ', 'MI', '48267002 ', '                              ', '  ', '    ', '6        ', '         ', '1 ', ' ', '        ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', '                                                  ', 'PDI199901                                         ', 'STACEY              ', 'W                   ', 'GORMAN              ', '     ', '          ', '  ', '                            ', '    ', '  ', '          ', '        ', 'DETROIT                  ', 'DETROIT                  ', 'MI', '     ', '    ', '  ', ' ', '  ', '26', '   ', '          ', '           ', '    ', '       ', '5', 'E302', 'N', ' ', ' ', ' ', '     ', '     ', ' ', ' ', '          ', '          ', ' ', '     ', ' ', ' ', ' ', ' ', ' ', ' ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', '        ', 'N', '                                                                                                                                                                                                        ', '  ', '          ', ' ', 0, 32, 0, 0, ' ', '                    ', '                    ', '                            ', '     ', '         ', '         ', 0, 0, '                         ', '                         ', '  ', '                                                            ', '                                                            ', 0, 0, 0, 0, 0, 0, '  ', ' ', ' ', ' ', ' ', 0, 0, '          ', '          ', '      ', '          ', '        ', '        ', '        ', ' ', 0, ' ', '          ', 0, 0, 0, 0, ' ', ' ', ' ', ' ', '          ', '                                                  ', '   ', ' ', '                                        ', ' ', '  ', '        ', ' ', '  ', '        ', ' ', '        ', ' ', '        ', '        ', '        ', '        ', ' ', '  ', ' ', '  ', '        ', ' ', '        ', ' ', '        ', '          ', '  ', '                            ', '    ', '  ', '        ', '                         ', '  ', '     ', 0, ' ', 0, '          ', '  ', '                            ', '    ', '  ', '        ', '                         ', '  ', '     ', ' ', '        ', ' ', '        ', ' ', ' ', '   ', '   ', '   ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '        ', 'N', 'N', 'N', '        ', 'N', 'N', '        ', '        ', '   ', '   ', '   '}], Provider_Record);

  OUTPUT(dsProvider,,'~qa::appenclaimoutlier::appendclaimoutlier::input1',OVERWRITE,compressed);
  
  Exclusion_Record :=
  record
    string120 cnp_name;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string8 sec_range;
    string25 v_city_name;
    string2 st;
    string5 zip;
  end;
dsExclusion :=
  dataset([
    {'WELLSPRING THERAPY ASSOC                                                                                                ', '10        ', 'S ', 'BROOKS                      ', 'ST  ', '  ', '2       ', 'CLEVELAND                ', 'GA', '30528'}, 
    {'LEWIS CALVO DR                                                                                                          ', '10        ', 'W ', 'SAGEBRUSH                   ', 'LN  ', '  ', '        ', 'SAVANNAH                 ', 'GA', '31419'}], Exclusion_Record);

OUTPUT(dsExclusion,,'~qa::appenclaimoutlier::appendclaimoutlier::input4',OVERWRITE,compressed);
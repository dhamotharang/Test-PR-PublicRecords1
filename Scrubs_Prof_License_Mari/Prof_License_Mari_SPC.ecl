MODULE:Scrubs_Prof_License_Mari
FILENAME:Prof_License_Mari
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking

SOURCEFIELD:std_source_upd

FIELDTYPE:nums:ALLOW(0123456789)
FIELDTYPE:lowercase:ALLOW(abcdefghijklmnopqrstuvwxyz)
FIELDTYPE:uppercase:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:alphas:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:lowercaseandnums:ALLOW(abcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:uppercaseandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:alphasandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:allupper:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©)
FIELDTYPE:allupperandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©0123456789)
FIELDTYPE:allalphaandnums:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘Ã•ÃšÃœÃÃ¡Ã£Ã±Ã³Ã¶Ã©abcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:blank:LENGTHS(0)

FIELDTYPE:invalid_blank:LIKE(blank)
FIELDTYPE:invalid_date:LIKE(nums):SPACES( ):LENGTHS(0,8)
FIELDTYPE:invalid_primary_key:LIKE(nums)
FIELDTYPE:invalid_create_dte:LIKE(nums):LENGTHS(8,19)
FIELDTYPE:invalid_last_upd_dte:LIKE(nums):LENGTHS(8,19)
FIELDTYPE:invalid_stamp_dte:LIKE(nums):LENGTHS(8,19)
FIELDTYPE:invalid_gen_nbr:ALLOW(C0123456789):LENGTHS(0,9..10)
FIELDTYPE:invalid_std_prof_cd:WITHIN(Prof_License_Mari.files_References.cmvtranslation,DM_VALUE1)
FIELDTYPE:invalid_std_prof_desc:ENUM(MORTGAGE LENDERS|APPRAISERS|)
FIELDTYPE:invalid_std_source_upd:ALLOW(ST0123456789):LENGTHS(5)
FIELDTYPE:invalid_std_source_desc:LIKE(uppercase):SPACES( &):LENGTHS(0,39,47)
FIELDTYPE:invalid_type_cd:LENGTHS(2):ENUM(MD|GR|)
FIELDTYPE:invalid_name_org_prefx:ALLOW(THE):SPACES(()):LENGTHS(0,3,5)
FIELDTYPE:invalid_name_org:LIKE(allupperandnums):SPACES( -"&$'./()#{},+@!)
FIELDTYPE:invalid_name_org_sufx:LIKE(uppercase):LENGTHS(0..15)
FIELDTYPE:invalid_store_nbr:LIKE(nums):LENGTHS(0..8)
FIELDTYPE:invalid_name_dba_prefx:ALLOW(THE):SPACES(()):LENGTHS(0,3,5)
FIELDTYPE:invalid_name_dba:LIKE(uppercaseandnums):SPACES( -"&'./()#{},+)
FIELDTYPE:invalid_name_dba_sufx:LIKE(uppercase):LENGTHS(0..5)
FIELDTYPE:invalid_store_nbr_dba:LIKE(nums):LENGTHS(0..10)
FIELDTYPE:invalid_dba_flag:ALLOW(01)
FIELDTYPE:invalid_name_office:LIKE(uppercaseandnums):SPACES( -&'./\()#{},@+$!Â®):LENGTHS(0..80)
FIELDTYPE:invalid_office_parse:LENGTHS(0,2):ENUM(MD|GR|)
FIELDTYPE:invalid_name:LIKE(allupperandnums):SPACES( -.()')
FIELDTYPE:invalid_gender:LENGTHS(0..1):ENUM(M|F|U|)
FIELDTYPE:invalid_prov_stat:LENGTHS(0..1):ENUM(D|R|)
FIELDTYPE:invalid_credential:LIKE(uppercase):LENGTHS(0..14)
FIELDTYPE:invalid_license_nbr:LIKE(uppercaseandnums):SPACES( -./#)
FIELDTYPE:invalid_prev_license_nbr:LENGTHS(0)
FIELDTYPE:invalid_prev_license_type:LENGTHS(0)
FIELDTYPE:invalid_license_state:LIKE(uppercase):LENGTHS(0,2)
FIELDTYPE:invalid_raw_license_type:LIKE(uppercaseandnums):SPACES( -.()/#&)
FIELDTYPE:invalid_std_license_type:WITHIN(Prof_License_Mari.files_References.MARIcmvLicType,LICENSE_TYPE)
FIELDTYPE:invalid_std_license_desc:WITHIN(Prof_License_Mari.files_References.MARIcmvLicType,LICENSE_DESC)
FIELDTYPE:invalid_raw_license_status:LIKE(uppercaseandnums):SPACES( -.()/#&)
FIELDTYPE:invalid_std_license_status:WITHIN(Prof_License_Mari.files_References.cmvtranslation,DM_VALUE1)
FIELDTYPE:invalid_std_status_desc:LIKE(uppercaseandnums):SPACES( -.()/#&):WITHIN(Scrubs_Prof_License_Mari.files_References.MARIcmvLicStatus,STATUS_DESC)
FIELDTYPE:invalid_renewal_dte:ALLOW(NONE0123456789)
FIELDTYPE:invalid_active_flag:ALLOW(01):LENGTHS(0..1)
FIELDTYPE:invalid_ssn_taxid_1:LIKE(nums):LENGTHS(0,9)
FIELDTYPE:invalid_tax_type_1:ALLOW(E):LENGTHS(0..1)
FIELDTYPE:invalid_ssn_taxid_2:LENGTHS(0)
FIELDTYPE:invalid_tax_type_2:LENGTHS(0)
FIELDTYPE:invalid_fed_rssd:LIKE(nums):LENGTHS(0..7)
FIELDTYPE:invalid_addr_bus_ind:ALLOW(BWNR):SPACES( ):LENGTHS(0..1)
FIELDTYPE:invalid_name_format:ALLOW(FL):LENGTHS(0..1)
FIELDTYPE:invalid_name_org_orig:LIKE(allalphaandnums):SPACES( /\@Â¸:+$?_;,=![]-'`"()&.*#)
FIELDTYPE:invalid_name_dba_orig:LIKE(allalphaandnums):SPACES( /\@Â¸:+$?_;,=![]-'`"()&.*#)
FIELDTYPE:invalid_name_mari_org:LIKE(allalphaandnums):SPACES( /\@Â¸:+$?_;,=![]-'`"()&.*#)
FIELDTYPE:invalid_name_mari_dba:LIKE(allalphaandnums):SPACES( /\@Â¸:+$?_;,=![]-'`"()&.*#)
FIELDTYPE:invalid_phone_number:LIKE(nums):SPACES(()-+):LENGTHS(0,9..15)
FIELDTYPE:invalid_address:LIKE(uppercaseandnums):SPACES( ,-.()':;"&#/)
FIELDTYPE:invalid_city:LIKE(uppercase):SPACES( .')
FIELDTYPE:invalid_state:LIKE(uppercase):LENGTHS(0,2)
FIELDTYPE:invalid_zip5:LIKE(nums):LENGTHS(0,5)
FIELDTYPE:invalid_zip4:LIKE(nums):LENGTHS(0,4)
FIELDTYPE:invalid_county:LIKE(uppercase):SPACES( .)
FIELDTYPE:invalid_country:LIKE(uppercase):SPACES( ,.)
FIELDTYPE:invalid_sud_key:LIKE(uppercaseandnums):SPACES( )
FIELDTYPE:invalid_ooc_ind:ALLOW(01):LENGTHS(1)
FIELDTYPE:invalid_addr_mail_ind:ALLOW(MH):LENGTHS(0..1)
FIELDTYPE:invalid_license_nbr_contact:LIKE(nums):SPACES( )
FIELDTYPE:invalid_email:LIKE(alphasandnums):SPACES(.@-_)
FIELDTYPE:invalid_url:LIKE(alphasandnums):SPACES(/:.)
FIELDTYPE:invalid_bk_class:ALLOW(ABIMNOS):SPACES( ):LENGTHS(0..2)
FIELDTYPE:invalid_bk_class_desc:LIKE(alphasandnums):SPACES( ()-,.)
FIELDTYPE:invalid_charter:LIKE(nums)
FIELDTYPE:invalid_origin_cd:ALLOW(DELOR):LENGTHS(0..1)
FIELDTYPE:invalid_origin_cd_desc:LIKE(uppercase):SPACES(/)
FIELDTYPE:invalid_disp_type_cd:ALLOW(DPQRV):LENGTHS(0..1)
FIELDTYPE:invalid_disp_type_desc:LIKE(uppercase):WITHIN(Scrubs_Prof_License_Mari.files_References.MARIcmvDispType,DISP_DESC)
FIELDTYPE:invalid_reg_agent:ENUM(FDIC|OCC|OTS|FED|)
FIELDTYPE:invalid_regulator:LIKE(uppercase):SPACES( ,.-)
FIELDTYPE:invalid_hqtr_name:LIKE(alphasandnums):SPACES( ()-,.)
FIELDTYPE:invalid_domestic_off_nbr:LIKE(nums)
FIELDTYPE:invalid_foreign_off_nbr:LIKE(nums)
FIELDTYPE:invalid_hcr_rssd:LIKE(nums)
FIELDTYPE:invalid_affil_type_cd:LENGTHS(0,2):ENUM(BO|BR|CO|IN|)
FIELDTYPE:invalid_genlink:ALLOW(C0123456789):LENGTHS(0,10)
FIELDTYPE:invalid_research_ind:ALLOW(0):LENGTHS(1)
FIELDTYPE:invalid_docket_id:LIKE(nums)
FIELDTYPE:invalid_mltreckey:LIKE(nums)
FIELDTYPE:invalid_cmc_slpk:LIKE(nums)
FIELDTYPE:invalid_pcmc_slpk:LIKE(nums)
FIELDTYPE:invalid_affil_key:LIKE(nums)
FIELDTYPE:invalid_provnote:LIKE(alphasandnums):SPACES( /\|@Â¸:+$?_;,=![]-'`"()&.*#{})
FIELDTYPE:invalid_viol_desc:LIKE(uppercaseandnums):SPACES( ,.)
FIELDTYPE:invalid_displinary_action:LIKE(uppercaseandnums):SPACES( ,.)
FIELDTYPE:invalid_misc_other_id:LIKE(nums):SPACES(/)
FIELDTYPE:invalid_misc_other_type:ENUM(MAS_FIL_NR|NEWCERT|POS. DOB/S|)
FIELDTYPE:invalid_cont_education_ernd:LIKE(uppercaseandnums):SPACES( :/)
FIELDTYPE:invalid_cont_education_req:LIKE(uppercaseandnums):SPACES( :/)
FIELDTYPE:invalid_cont_education_term:LIKE(uppercaseandnums):SPACES( :/)
FIELDTYPE:invalid_addl_license_spec:LIKE(uppercase):SPACES( ()-'|)
FIELDTYPE:invalid_race_cd:ALLOW(ABHOPUW):LENGTHS(0..2)
FIELDTYPE:invalid_std_race_cd:ENUM(API|BLK|HISP|OTH|UNK|WHT|)
FIELDTYPE:invalid_agency_status:ENUM(ACTIVE|INACTIVE|)
FIELDTYPE:invalid_prev_primary_key:LIKE(nums)
FIELDTYPE:invalid_prev_mltreckey:LIKE(nums)
FIELDTYPE:invalid_prev_cmc_slpk:LIKE(nums)
FIELDTYPE:invalid_prev_pcmc_slpk:LIKE(nums)
FIELDTYPE:invalid_license_id:LIKE(nums)
FIELDTYPE:invalid_nmls_id:LIKE(nums)
FIELDTYPE:invalid_foreign_nmls_id:LIKE(nums)
FIELDTYPE:invalid_location_type:ENUM(BRANCH|MAIN|WORK|)
FIELDTYPE:invalid_off_license_nbr_type:LIKE(uppercase):SPACES( )
FIELDTYPE:invalid_brkr_license_nbr:LIKE(uppercaseandnums):SPACES( -.)
FIELDTYPE:invalid_brkr_license_nbr_type:LIKE(uppercase):SPACES( 6)
FIELDTYPE:invalid_agency_id:LIKE(uppercaseandnums):SPACES( )
FIELDTYPE:invalid_business_type:LIKE(uppercase):SPACES( )
FIELDTYPE:invalid_name_type:SPACES( )
FIELDTYPE:invalid_is_authorized:ENUM(YES|NO|Yes|No|)
FIELDTYPE:invalid_federal_regulator:LIKE(uppercase):SPACES( -)

FIELD:primary_key:LIKE(invalid_primary_key):TYPE(UNSIGNED8):0,0
FIELD:create_dte:LIKE(invalid_create_dte):TYPE(STRING19):0,0
FIELD:last_upd_dte:LIKE(invalid_last_upd_dte):TYPE(STRING19):0,0
FIELD:stamp_dte:LIKE(invalid_stamp_dte):TYPE(STRING19):0,0
FIELD:date_first_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_last_seen:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_first_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:date_vendor_last_reported:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:process_date:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:gen_nbr:LIKE(invalid_gen_nbr):TYPE(STRING10):0,0
FIELD:std_prof_cd:LIKE(invalid_std_prof_cd):TYPE(STRING3):0,0
FIELD:std_prof_desc:LIKE(invalid_std_prof_desc):TYPE(STRING40):0,0
FIELD:std_source_upd:LIKE(invalid_std_source_upd):TYPE(STRING5):0,0
FIELD:std_source_desc:LIKE(invalid_std_source_desc):TYPE(STRING85):0,0
FIELD:type_cd:LIKE(invalid_type_cd):TYPE(STRING2):0,0
FIELD:name_org_prefx:LIKE(invalid_name_org_prefx):TYPE(STRING10):0,0
FIELD:name_org:LIKE(invalid_name_org):TYPE(STRING80):0,0
FIELD:name_org_sufx:LIKE(invalid_name_org_sufx):TYPE(STRING15):0,0
FIELD:store_nbr:LIKE(invalid_store_nbr):TYPE(STRING10):0,0
FIELD:name_dba_prefx:LIKE(invalid_name_dba_prefx):TYPE(STRING10):0,0
FIELD:name_dba:LIKE(invalid_name_dba):TYPE(STRING80):0,0
FIELD:name_dba_sufx:LIKE(invalid_name_dba_sufx):TYPE(STRING15):0,0
FIELD:store_nbr_dba:LIKE(invalid_store_nbr_dba):TYPE(STRING10):0,0
FIELD:dba_flag:LIKE(invalid_dba_flag):TYPE(INTEGER1):0,0
FIELD:name_office:LIKE(invalid_name_office):TYPE(STRING80):0,0
FIELD:office_parse:LIKE(invalid_office_parse):TYPE(STRING2):0,0
FIELD:name_prefx:LIKE(invalid_name):TYPE(STRING8):0,0
FIELD:name_first:LIKE(invalid_name):TYPE(STRING30):0,0
FIELD:name_mid:LIKE(invalid_name):TYPE(STRING30):0,0
FIELD:name_last:LIKE(invalid_name):TYPE(STRING50):0,0
FIELD:name_sufx:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:name_nick:LIKE(invalid_name):TYPE(STRING15):0,0
FIELD:birth_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:gender:LIKE(invalid_gender):TYPE(STRING1):0,0
FIELD:prov_stat:LIKE(invalid_prov_stat):TYPE(STRING1):0,0
FIELD:credential:LIKE(invalid_credential):TYPE(STRING14):0,0
FIELD:license_nbr:LIKE(invalid_license_nbr):TYPE(STRING30):0,0
FIELD:off_license_nbr:LIKE(invalid_license_nbr):TYPE(STRING18):0,0
FIELD:prev_license_nbr:LIKE(invalid_prev_license_nbr):TYPE(STRING20):0,0
FIELD:prev_license_type:LIKE(invalid_prev_license_type):TYPE(STRING20):0,0
FIELD:license_state:LIKE(invalid_license_state):TYPE(STRING2):0,0
FIELD:raw_license_type:LIKE(invalid_raw_license_type):TYPE(STRING100):0,0
FIELD:std_license_type:LIKE(invalid_std_license_type):TYPE(STRING10):0,0
FIELD:std_license_desc:LIKE(invalid_std_license_desc):TYPE(STRING120):0,0
FIELD:raw_license_status:LIKE(invalid_raw_license_status):TYPE(STRING75):0,0
FIELD:std_license_status:LIKE(invalid_std_license_status):TYPE(STRING3):0,0
FIELD:std_status_desc:LIKE(invalid_std_status_desc):TYPE(STRING120):0,0
FIELD:curr_issue_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:orig_issue_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:expire_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:renewal_dte:LIKE(invalid_renewal_dte):TYPE(STRING8):0,0
FIELD:active_flag:LIKE(invalid_active_flag):TYPE(STRING6):0,0
FIELD:ssn_taxid_1:LIKE(invalid_ssn_taxid_1):TYPE(STRING9):0,0
FIELD:tax_type_1:LIKE(invalid_tax_type_1):TYPE(STRING1):0,0
FIELD:ssn_taxid_2:LIKE(invalid_ssn_taxid_2):TYPE(STRING9):0,0
FIELD:tax_type_2:LIKE(invalid_tax_type_2):TYPE(STRING1):0,0
FIELD:fed_rssd:LIKE(invalid_fed_rssd):TYPE(STRING8):0,0
FIELD:addr_bus_ind:LIKE(invalid_addr_bus_ind):TYPE(STRING1):0,0
FIELD:name_format:LIKE(invalid_name_format):TYPE(STRING1):0,0
FIELD:name_org_orig:LIKE(invalid_name_org_orig):TYPE(STRING254):0,0
FIELD:name_dba_orig:LIKE(invalid_name_dba_orig):TYPE(STRING254):0,0
FIELD:name_mari_org:LIKE(invalid_name_mari_org):TYPE(STRING80):0,0
FIELD:name_mari_dba:LIKE(invalid_name_mari_dba):TYPE(STRING80):0,0
FIELD:phn_mari_1:LIKE(invalid_phone_number):TYPE(STRING15):0,0
FIELD:phn_mari_fax_1:LIKE(invalid_phone_number):TYPE(STRING15):0,0
FIELD:phn_mari_2:LIKE(invalid_phone_number):TYPE(STRING15):0,0
FIELD:phn_mari_fax_2:LIKE(invalid_phone_number):TYPE(STRING15):0,0
FIELD:addr_addr1_1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr2_1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr3_1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr4_1:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_city_1:LIKE(invalid_city):TYPE(STRING25):0,0
FIELD:addr_state_1:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:addr_zip5_1:LIKE(invalid_zip5):TYPE(STRING5):0,0
FIELD:addr_zip4_1:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:phn_phone_1:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:phn_fax_1:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:addr_cnty_1:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:addr_cntry_1:LIKE(invalid_country):TYPE(STRING25):0,0
FIELD:sud_key_1:LIKE(invalid_sud_key):TYPE(STRING5):0,0
FIELD:ooc_ind_1:LIKE(invalid_ooc_ind):TYPE(INTEGER1):0,0
FIELD:addr_mail_ind:LIKE(invalid_addr_mail_ind):TYPE(STRING1):0,0
FIELD:addr_addr1_2:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr2_2:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr3_2:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_addr4_2:LIKE(invalid_address):TYPE(STRING50):0,0
FIELD:addr_city_2:LIKE(invalid_city):TYPE(STRING25):0,0
FIELD:addr_state_2:LIKE(invalid_state):TYPE(STRING2):0,0
FIELD:addr_zip5_2:LIKE(invalid_zip5):TYPE(STRING5):0,0
FIELD:addr_zip4_2:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:addr_cnty_2:LIKE(invalid_county):TYPE(STRING35):0,0
FIELD:addr_cntry_2:LIKE(invalid_country):TYPE(STRING25):0,0
FIELD:phn_phone_2:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:phn_fax_2:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:sud_key_2:LIKE(invalid_sud_key):TYPE(STRING5):0,0
FIELD:ooc_ind_2:LIKE(invalid_ooc_ind):TYPE(INTEGER1):0,0
FIELD:license_nbr_contact:LIKE(invalid_license_nbr_contact):TYPE(STRING15):0,0
FIELD:name_contact_prefx:LIKE(invalid_name):TYPE(STRING8):0,0
FIELD:name_contact_first:LIKE(invalid_name):TYPE(STRING15):0,0
FIELD:name_contact_mid:LIKE(invalid_name):TYPE(STRING15):0,0
FIELD:name_contact_last:LIKE(invalid_name):TYPE(STRING30):0,0
FIELD:name_contact_sufx:LIKE(invalid_name):TYPE(STRING3):0,0
FIELD:name_contact_nick:LIKE(invalid_name):TYPE(STRING15):0,0
FIELD:name_contact_ttl:LIKE(invalid_name):TYPE(STRING40):0,0
FIELD:phn_contact:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:phn_contact_ext:LIKE(invalid_phone_number):TYPE(STRING6):0,0
FIELD:phn_contact_fax:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:email:LIKE(invalid_email):TYPE(STRING80):0,0
FIELD:url:LIKE(invalid_url):TYPE(STRING80):0,0
FIELD:bk_class:LIKE(invalid_bk_class):TYPE(STRING7):0,0
FIELD:bk_class_desc:LIKE(invalid_bk_class_desc):TYPE(STRING75):0,0
FIELD:charter:LIKE(invalid_charter):TYPE(STRING7):0,0
FIELD:inst_beg_dte:LIKE(invalid_date):TYPE(STRING10):0,0
FIELD:origin_cd:LIKE(invalid_origin_cd):TYPE(STRING1):0,0
FIELD:origin_cd_desc:LIKE(invalid_origin_cd_desc):TYPE(STRING35):0,0
FIELD:disp_type_cd:LIKE(invalid_disp_type_cd):TYPE(STRING5):0,0
FIELD:disp_type_desc:LIKE(invalid_disp_type_desc):TYPE(STRING250):0,0
FIELD:reg_agent:LIKE(invalid_reg_agent):TYPE(STRING7):0,0
FIELD:regulator:LIKE(invalid_regulator):TYPE(STRING150):0,0
FIELD:hqtr_city:LIKE(invalid_city):TYPE(STRING22):0,0
FIELD:hqtr_name:LIKE(invalid_hqtr_name):TYPE(STRING95):0,0
FIELD:domestic_off_nbr:LIKE(invalid_domestic_off_nbr):TYPE(STRING6):0,0
FIELD:foreign_off_nbr:LIKE(invalid_foreign_off_nbr):TYPE(STRING5):0,0
FIELD:hcr_rssd:LIKE(invalid_hcr_rssd):TYPE(STRING7):0,0
FIELD:hcr_location:LIKE(invalid_state):TYPE(STRING8):0,0
FIELD:affil_type_cd:LIKE(invalid_affil_type_cd):TYPE(STRING2):0,0
FIELD:genlink:LIKE(invalid_genlink):TYPE(STRING10):0,0
FIELD:research_ind:LIKE(invalid_research_ind):TYPE(INTEGER1):0,0
FIELD:docket_id:LIKE(invalid_docket_id):TYPE(STRING6):0,0
FIELD:mltreckey:LIKE(invalid_mltreckey):TYPE(UNSIGNED8):0,0
FIELD:cmc_slpk:LIKE(invalid_cmc_slpk):TYPE(UNSIGNED8):0,0
FIELD:pcmc_slpk:LIKE(invalid_pcmc_slpk):TYPE(UNSIGNED8):0,0
FIELD:affil_key:LIKE(invalid_affil_key):TYPE(UNSIGNED8):0,0
//FIELD:provnote_1:LIKE(invalid_provnote):TYPE(STRING):0,0
//FIELD:provnote_2:LIKE(invalid_provnote):TYPE(STRING):0,0
//FIELD:provnote_3:LIKE(invalid_provnote):TYPE(STRING):0,0
FIELD:action_taken_ind:LIKE(invalid_blank):TYPE(STRING1):0,0
FIELD:viol_type:LIKE(invalid_blank):TYPE(STRING8):0,0
FIELD:viol_cd:LIKE(invalid_blank):TYPE(STRING50):0,0
FIELD:viol_desc:LIKE(invalid_viol_desc):TYPE(STRING200):0,0
FIELD:viol_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:viol_case_nbr:LIKE(invalid_blank):TYPE(STRING50):0,0
FIELD:viol_eff_dte:LIKE(invalid_blank):TYPE(STRING8):0,0
FIELD:action_final_nbr:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:action_status:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:action_status_dte:LIKE(invalid_blank):TYPE(STRING8):0,0
FIELD:displinary_action:LIKE(invalid_displinary_action):TYPE(STRING500):0,0
FIELD:action_file_name:LIKE(invalid_blank):TYPE(STRING100):0,0
FIELD:occupation:LIKE(invalid_blank):TYPE(STRING50):0,0
FIELD:practice_hrs:LIKE(invalid_blank):TYPE(STRING20):0,0
FIELD:practice_type:LIKE(invalid_blank):TYPE(STRING50):0,0
FIELD:misc_other_id:LIKE(invalid_misc_other_id):TYPE(STRING50):0,0
FIELD:misc_other_type:LIKE(invalid_misc_other_type):TYPE(STRING10):0,0
FIELD:cont_education_ernd:LIKE(invalid_cont_education_ernd):TYPE(STRING50):0,0
FIELD:cont_education_req:LIKE(invalid_cont_education_req):TYPE(STRING60):0,0
FIELD:cont_education_term:LIKE(invalid_cont_education_term):TYPE(STRING10):0,0
FIELD:schl_attend_1:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:schl_attend_dte_1:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:schl_curriculum_1:LIKE(invalid_blank):TYPE(STRING25):0,0
FIELD:schl_degree_1:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:schl_attend_2:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:schl_attend_dte_2:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:schl_curriculum_2:LIKE(invalid_blank):TYPE(STRING25):0,0
FIELD:schl_degree_2:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:schl_attend_3:LIKE(invalid_blank):TYPE(STRING30):0,0
FIELD:schl_attend_dte_3:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:schl_curriculum_3:LIKE(invalid_blank):TYPE(STRING25):0,0
FIELD:schl_degree_3:LIKE(invalid_blank):TYPE(STRING15):0,0
FIELD:addl_license_spec:LIKE(invalid_addl_license_spec):TYPE(STRING75):0,0
FIELD:place_birth_cd:LIKE(invalid_blank):TYPE(STRING5):0,0
FIELD:place_birth_desc:LIKE(invalid_blank):TYPE(STRING25):0,0
FIELD:race_cd:LIKE(invalid_race_cd):TYPE(STRING5):0,0
FIELD:std_race_cd:LIKE(invalid_std_race_cd):TYPE(STRING5):0,0
FIELD:race_desc:LIKE(invalid_blank):TYPE(STRING25):0,0
FIELD:status_effect_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:status_renew_desc:LIKE(invalid_blank):TYPE(STRING8):0,0
FIELD:agency_status:LIKE(invalid_agency_status):TYPE(STRING20):0,0
FIELD:prev_primary_key:LIKE(invalid_prev_primary_key):TYPE(UNSIGNED8):0,0
FIELD:prev_mltreckey:LIKE(invalid_prev_mltreckey):TYPE(UNSIGNED8):0,0
FIELD:prev_cmc_slpk:LIKE(invalid_prev_cmc_slpk):TYPE(UNSIGNED8):0,0
FIELD:prev_pcmc_slpk:LIKE(invalid_prev_pcmc_slpk):TYPE(UNSIGNED8):0,0
FIELD:license_id:LIKE(invalid_license_id):TYPE(UNSIGNED8):0,0
FIELD:nmls_id:LIKE(invalid_nmls_id):TYPE(UNSIGNED8):0,0
FIELD:foreign_nmls_id:LIKE(invalid_foreign_nmls_id):TYPE(UNSIGNED8):0,0
FIELD:location_type:LIKE(invalid_location_type):TYPE(STRING6):0,0
FIELD:off_license_nbr_type:LIKE(invalid_off_license_nbr_type):TYPE(STRING50):0,0
FIELD:brkr_license_nbr:LIKE(invalid_brkr_license_nbr):TYPE(STRING30):0,0
FIELD:brkr_license_nbr_type:LIKE(invalid_brkr_license_nbr_type):TYPE(STRING50):0,0
FIELD:agency_id:LIKE(invalid_agency_id):TYPE(STRING30):0,0
FIELD:site_location:LIKE(invalid_address):TYPE(STRING60):0,0
FIELD:business_type:LIKE(invalid_business_type):TYPE(STRING50):0,0
FIELD:name_type:LIKE(invalid_name_type):TYPE(STRING10):0,0
FIELD:start_dte:LIKE(invalid_date):TYPE(STRING8):0,0
FIELD:is_authorized_license:LIKE(invalid_is_authorized):TYPE(STRING3):0,0
FIELD:is_authorized_conduct:LIKE(invalid_is_authorized):TYPE(STRING3):0,0
FIELD:federal_regulator:LIKE(invalid_federal_regulator):TYPE(STRING150):0,0


//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking

RECORDTYPE:invalid_seen_dates:CONDITION(date_first_seen,<,date_last_seen):VALID(date_first_seen,date_last_seen)
RECORDTYPE:invalid_vendor_dates:CONDITION(date_vendor_first_reported,<,date_vendor_last_reported):VALID(date_vendor_first_reported,date_vendor_last_reported)

Generated by SALT V3.1.3
File being processed :-
MODULE:Scrubs_HMS
FILENAME:Individuals
NAMESCOPE:Individuals
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
RIDFIELD:source_rid
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
THRESHOLD:10
BLOCKTHRESHOLD:10
FIELDTYPE:hms_piid:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:first:SPACES( ):ALLOW(-'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:middle:SPACES( ):ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:last:SPACES( ):ALLOW( -_ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:suffix:SPACES( ):ALLOW(DIMJRSV):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cred:SPACES( ):ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:practitioner_type:SPACES( ):ALLOW( -ABCDEHMNOPRSTVacdeghilmnoprstuvy):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:active:SPACES( ):ALLOW(NY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:vendible:SPACES( ):ALLOW(NY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi_num:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi_enumeration_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi_deactivation_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi_reactivation_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:npi_taxonomy_code:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:upin:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:medicare_participation_flag:SPACES( ):ALLOW(NY):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_born:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_died:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:pid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:src:SPACES( ):ALLOW(S8):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_vendor_first_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_vendor_last_reported:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_first_seen:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date_last_seen:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:record_type:SPACES( ):ALLOW(CH):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:source_rid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lnpid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fname:SPACES( ):ALLOW(-'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:mname:SPACES( ):ALLOW(-'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lname:SPACES( ):ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:name_suffix:SPACES( ):ALLOW(IJRSVX):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:nametype:SPACES( ):ALLOW(BIPU):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:nid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_npi_enumeration_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_npi_deactivation_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_npi_reactivation_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_date_born:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_date_died:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_company_name:SPACES( ):ALLOW( &!"#$+<>?@[]_`{}~0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prim_range:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:predir:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prim_name:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:addr_suffix:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:postdir:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:unit_desig:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sec_range:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:p_city_name:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:v_city_name:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:st:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:zip:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:zip4:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cart:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cr_sort_sz:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lot:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lot_order:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dbpc:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:chk_digit:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:rec_type:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fips_st:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fips_county:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:geo_lat:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:geo_long:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:msa:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:geo_blk:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:geo_match:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:err_stat:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:rawaid:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:aceaid:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:firm_name:SPACES( ):ALLOW( -./`&,!"#$%'()+:;<=>?@[\]_`-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:agid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:address_std_code:SPACES( ):ALLOW(ENS):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:latitude:SPACES( ):ALLOW(.-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:longitude:SPACES( ):ALLOW(-.0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prepped_addr1:SPACES( ):ALLOW( #-":;@[]_'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:prepped_addr2:SPACES( ):ALLOW( ,-/:;@[]_'`{}0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:addr_type:SPACES( ):ALLOW(ABEHIKLMNOSU):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_number:SPACES( ):ALLOW(-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_type:SPACES( ):ALLOW(-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_active:SPACES( ):ALLOW(AIPUi):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_expire:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_qualifier:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZn):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_sub_qualifier:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:state_license_issued:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_state_license_expire:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_state_license_issued:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_num:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_bac:SPACES( ):ALLOW(BCGM):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_sub_bac:SPACES( ):ALLOW(0123456789ABCD):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_schedule:SPACES( ):ALLOW( 2345N):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_expire:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dea_active:SPACES( ):ALLOW(01):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_dea_expire:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_number:SPACES( ):ALLOW(-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_expire_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_issue_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_2:SPACES( ):ALLOW(2Y):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_2n:SPACES( ):ALLOW(2N):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_3:SPACES( ):ALLOW(3Y):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_3n:SPACES( ):ALLOW(3N):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_4:SPACES( ):ALLOW(4Y):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dsa_lvl_5:SPACES( ):ALLOW(5Y):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_raw1:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_raw2:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_raw3:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:csr_raw4:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_csr_expire_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_csr_issue_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_id:SPACES( ):ALLOW(0123456789abcdef):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_action_code:SPACES( ):ALLOW(0123456789ABCDETU):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_action_description:SPACES( ):ALLOW( ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_board_code:SPACES( ):ALLOW(0123456789BCDNS):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_board_description:SPACES( ):ALLOW( &,()/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:action_date:SPACES( ):ALLOW(/0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_period_start_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:sanction_period_end_date:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:month_duration:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fine_amount:SPACES( ):ALLOW(.0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:offense_code:SPACES( ):ALLOW(012345689ABCEDFGHJKLOU):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:offense_description:SPACES( ):ALLOW( ,/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:offense_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_offense_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_action_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_sanction_period_start_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_sanction_period_end_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_sanction_id:SPACES( ):ALLOW(-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_first:SPACES( ):ALLOW( '-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_middle:SPACES( ):ALLOW( .-'ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_last:SPACES( ):ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_suffix:SPACES( ):ALLOW(.4DHIJMNRSTV):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_city:SPACES( ):ALLOW( ,-/'.01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:gsa_zip:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:date:SPACES( ):ALLOW(/0123456789DEFINT):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:agency:SPACES( ):ALLOW(-/ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:confidence:SPACES( ):ALLOW(45):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_first:SPACES( ):ALLOW( '-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_middle:SPACES( ):ALLOW( .'-ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_last:SPACES( ):ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_suffix:SPACES( ):ALLOW(.4DHIJMNRSTV):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_city:SPACES( ):ALLOW( ,-./ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_state:SPACES( ):ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_zip:SPACES( ):ALLOW(-0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_action_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_gsa_date:SPACES( ):ALLOW(/0123456789DEFINT):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:fax:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:phone:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:certification_code:SPACES( ):ALLOW(0123456789CN):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:certification_description:SPACES( ):ALLOW( &-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:board_code:SPACES( ):ALLOW(0123456789ABCDEFGHIJKMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:board_description:SPACES( ):ALLOW( &ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:expiration_year:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:issue_year:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:renewal_year:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lifetime_flag:SPACES( ):ALLOW(01):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:covered_recipient_id:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_state_code:SPACES( ):ALLOW(AM):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_full_name:SPACES( ):ALLOW( -.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_attribute1:SPACES( ):ALLOW( ()-/ACDGHIOLMNPRSTabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_attribute2:SPACES( ):ALLOW(0123456789ACDGHILNPRT):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_attribute3:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:cov_rcp_raw_attribute4:SPACES( ):ALLOW():LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:hms_scid:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:school_name:SPACES( ):ALLOW( ./"&'()-`ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:grad_year:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:lang_code:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:language:SPACES( ):ALLOW( ,ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:specialty_description:SPACES( ):ALLOW( &,-/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_phone:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:bdid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:bdid_score:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:did:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:did_score:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:clean_dob:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:best_dob:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:best_ssn:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:rec_deactivated_date:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:superceeding_piid:SPACES( ):ALLOW(0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dotid:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dotscore:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:dotweight:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:empid:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:empscore:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:empweight:SPACES( ):ALLOW(0):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:powid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:powscore:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:powweight:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:proxid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:proxscore:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:proxweight:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:seleid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:selescore:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:seleweight:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:orgid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:orgscore:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:orgweight:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:ultid:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:ultscore:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELDTYPE:ultweight:SPACES( ):ALLOW(0123456789):LEFTTRIM:ONFAIL(CLEAN)
FIELD:hms_piid:5,1
FIELD:first:5,1
FIELD:middle:5,1
FIELD:last:5,1
FIELD:suffix:5,1
FIELD:cred:5,1
FIELD:practitioner_type:5,1
FIELD:active:5,1
FIELD:vendible:5,1
FIELD:npi_num:5,1
FIELD:npi_enumeration_date:5,1
FIELD:npi_deactivation_date:5,1
FIELD:npi_reactivation_date:5,1
FIELD:npi_taxonomy_code:5,1
FIELD:upin:5,1
FIELD:medicare_participation_flag:5,1
FIELD:date_born:5,1
FIELD:date_died:5,1
FIELD:pid:5,1
FIELD:src:5,1
FIELD:date_vendor_first_reported:5,1
FIELD:date_vendor_last_reported:5,1
FIELD:date_first_seen:5,1
FIELD:date_last_seen:5,1
FIELD:record_type:5,1
FIELD:source_rid:5,1
FIELD:lnpid:5,1
FIELD:fname:5,1
FIELD:mname:5,1
FIELD:lname:5,1
FIELD:name_suffix:5,1
FIELD:nametype:5,1
FIELD:nid:5,1
FIELD:clean_npi_enumeration_date:5,1
FIELD:clean_npi_deactivation_date:5,1
FIELD:clean_npi_reactivation_date:5,1
FIELD:clean_date_born:5,1
FIELD:clean_date_died:5,1
FIELD:clean_company_name:5,1
FIELD:prim_range:5,1
FIELD:predir:5,1
FIELD:prim_name:5,1
FIELD:addr_suffix:5,1
FIELD:postdir:5,1
FIELD:unit_desig:5,1
FIELD:sec_range:5,1
FIELD:p_city_name:5,1
FIELD:v_city_name:5,1
FIELD:st:5,1
FIELD:zip:5,1
FIELD:zip4:5,1
FIELD:cart:5,1
FIELD:cr_sort_sz:5,1
FIELD:lot:5,1
FIELD:lot_order:5,1
FIELD:dbpc:5,1
FIELD:chk_digit:5,1
FIELD:rec_type:5,1
FIELD:fips_st:5,1
FIELD:fips_county:5,1
FIELD:geo_lat:5,1
FIELD:geo_long:5,1
FIELD:msa:5,1
FIELD:geo_blk:5,1
FIELD:geo_match:5,1
FIELD:err_stat:5,1
FIELD:rawaid:5,1
FIELD:aceaid:5,1
FIELD:firm_name:5,1
FIELD:lid:5,1
FIELD:agid:5,1
FIELD:address_std_code:5,1
FIELD:latitude:5,1
FIELD:longitude:5,1
FIELD:prepped_addr1:5,1
FIELD:prepped_addr2:5,1
FIELD:addr_type:5,1
FIELD:state_license_state:5,1
FIELD:state_license_number:5,1
FIELD:state_license_type:5,1
FIELD:state_license_active:5,1
FIELD:state_license_expire:5,1
FIELD:state_license_qualifier:5,1
FIELD:state_license_sub_qualifier:5,1
FIELD:state_license_issued:5,1
FIELD:clean_state_license_expire:5,1
FIELD:clean_state_license_issued:5,1
FIELD:dea_num:5,1
FIELD:dea_bac:5,1
FIELD:dea_sub_bac:5,1
FIELD:dea_schedule:5,1
FIELD:dea_expire:5,1
FIELD:dea_active:5,1
FIELD:clean_dea_expire:5,1
FIELD:csr_number:5,1
FIELD:csr_state:5,1
FIELD:csr_expire_date:5,1
FIELD:csr_issue_date:5,1
FIELD:dsa_lvl_2:5,1
FIELD:dsa_lvl_2n:5,1
FIELD:dsa_lvl_3:5,1
FIELD:dsa_lvl_3n:5,1
FIELD:dsa_lvl_4:5,1
FIELD:dsa_lvl_5:5,1
FIELD:csr_raw1:5,1
FIELD:csr_raw2:5,1
FIELD:csr_raw3:5,1
FIELD:csr_raw4:5,1
FIELD:clean_csr_expire_date:5,1
FIELD:clean_csr_issue_date:5,1
FIELD:sanction_id:5,1
FIELD:sanction_action_code:5,1
FIELD:sanction_action_description:5,1
FIELD:sanction_board_code:5,1
FIELD:sanction_board_description:5,1
FIELD:action_date:5,1
FIELD:sanction_period_start_date:5,1
FIELD:sanction_period_end_date:5,1
FIELD:month_duration:5,1
FIELD:fine_amount:5,1
FIELD:offense_code:5,1
FIELD:offense_description:5,1
FIELD:offense_date:5,1
FIELD:clean_offense_date:5,1
FIELD:clean_action_date:5,1
FIELD:clean_sanction_period_start_date:5,1
FIELD:clean_sanction_period_end_date:5,1
FIELD:gsa_sanction_id:5,1
FIELD:gsa_first:5,1
FIELD:gsa_middle:5,1
FIELD:gsa_last:5,1
FIELD:gsa_suffix:5,1
FIELD:gsa_city:5,1
FIELD:gsa_state:5,1
FIELD:gsa_zip:5,1
FIELD:date:5,1
FIELD:agency:5,1
FIELD:confidence:5,1
FIELD:clean_gsa_first:5,1
FIELD:clean_gsa_middle:5,1
FIELD:clean_gsa_last:5,1
FIELD:clean_gsa_suffix:5,1
FIELD:clean_gsa_city:5,1
FIELD:clean_gsa_state:5,1
FIELD:clean_gsa_zip:5,1
FIELD:clean_gsa_action_date:5,1
FIELD:clean_gsa_date:5,1
FIELD:fax:5,1
FIELD:phone:5,1
FIELD:certification_code:5,1
FIELD:certification_description:5,1
FIELD:board_code:5,1
FIELD:board_description:5,1
FIELD:expiration_year:5,1
FIELD:issue_year:5,1
FIELD:renewal_year:5,1
FIELD:lifetime_flag:5,1
FIELD:covered_recipient_id:5,1
FIELD:cov_rcp_raw_state_code:5,1
FIELD:cov_rcp_raw_full_name:5,1
FIELD:cov_rcp_raw_attribute1:5,1
FIELD:cov_rcp_raw_attribute2:5,1
FIELD:cov_rcp_raw_attribute3:5,1
FIELD:cov_rcp_raw_attribute4:5,1
FIELD:hms_scid:5,1
FIELD:school_name:5,1
FIELD:grad_year:5,1
FIELD:lang_code:5,1
FIELD:language:5,1
FIELD:specialty_description:5,1
FIELD:clean_phone:5,1
FIELD:bdid:5,1
FIELD:bdid_score:5,1
FIELD:did:5,1
FIELD:did_score:5,1
FIELD:clean_dob:5,1
FIELD:best_dob:5,1
FIELD:best_ssn:5,1
FIELD:rec_deactivated_date:5,1
FIELD:superceeding_piid:5,1
FIELD:dotid:5,1
FIELD:dotscore:5,1
FIELD:dotweight:5,1
FIELD:empid:5,1
FIELD:empscore:5,1
FIELD:empweight:5,1
FIELD:powid:5,1
FIELD:powscore:5,1
FIELD:powweight:5,1
FIELD:proxid:5,1
FIELD:proxscore:5,1
FIELD:proxweight:5,1
FIELD:seleid:5,1
FIELD:selescore:5,1
FIELD:seleweight:5,1
FIELD:orgid:5,1
FIELD:orgscore:5,1
FIELD:orgweight:5,1
FIELD:ultid:5,1
FIELD:ultscore:5,1
FIELD:ultweight:5,1
Total available specificity:1005
User specified threshold 10
Search Threshold set at 6
Use of PERSISTs in code set at:3
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.

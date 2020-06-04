IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Database_USA.Layouts.Base) 						Delta = DATASET([],Database_USA.Layouts.Base)
, DATASET(Database_USA.Layouts.Base) 						dsBase
, DATASET(RECORDOF(Database_USA.Layouts.Base)) 	infile
) := MODULE
  SHARED NullFile := DATASET([],Database_USA.Layouts.Base); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  In_Src_Cnt_Rec := RECORD
    FilesToIngest.source;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT InputSourceCounts := TABLE(FilesToIngest,In_Src_Cnt_Rec,source,FEW);
  SHARED S0 := OUTPUT(InputSourceCounts,ALL,NAMED('InputSourceCounts'));
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Database_USA.Layouts.Base;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_first_seen = 0 => ri.dt_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_first_seen = 0 => le.dt_first_seen,
                     (UNSIGNED)le.dt_first_seen < (UNSIGNED)ri.dt_first_seen => le.dt_first_seen, // Want the lowest non-zero value
                     ri.dt_first_seen);
    SELF.dt_last_seen := MAP ( le.__Tpe = 0 => ri.dt_last_seen,
                     ri.__Tpe = 0 => le.dt_last_seen,
                     (UNSIGNED)le.dt_last_seen < (UNSIGNED)ri.dt_last_seen => ri.dt_last_seen, // Want the highest value
                     le.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (UNSIGNED)le.dt_vendor_first_reported < (UNSIGNED)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (UNSIGNED)le.dt_vendor_last_reported < (UNSIGNED)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    SELF.process_date := ri.process_date; // Derived(NEW)
    SELF.dotid := ri.dotid; // Derived(NEW)
    SELF.dotscore := ri.dotscore; // Derived(NEW)
    SELF.dotweight := ri.dotweight; // Derived(NEW)
    SELF.empid := ri.empid; // Derived(NEW)
    SELF.empscore := ri.empscore; // Derived(NEW)
    SELF.empweight := ri.empweight; // Derived(NEW)
    SELF.powid := ri.powid; // Derived(NEW)
    SELF.powscore := ri.powscore; // Derived(NEW)
    SELF.powweight := ri.powweight; // Derived(NEW)
    SELF.proxid := ri.proxid; // Derived(NEW)
    SELF.proxscore := ri.proxscore; // Derived(NEW)
    SELF.proxweight := ri.proxweight; // Derived(NEW)
    SELF.selescore := ri.selescore; // Derived(NEW)
    SELF.seleweight := ri.seleweight; // Derived(NEW)
    SELF.orgid := ri.orgid; // Derived(NEW)
    SELF.orgscore := ri.orgscore; // Derived(NEW)
    SELF.orgweight := ri.orgweight; // Derived(NEW)
    SELF.ultid := ri.ultid; // Derived(NEW)
    SELF.ultscore := ri.ultscore; // Derived(NEW)
    SELF.ultweight := ri.ultweight; // Derived(NEW)
    SELF.record_type := ri.record_type; // Derived(NEW)
    SELF.global_sid := ri.global_sid; // Derived(NEW)
    SELF.businesstypedesc := ri.businesstypedesc; // Derived(NEW)
    SELF.genderdesc := ri.genderdesc; // Derived(NEW)
    SELF.executivetypedesc := ri.executivetypedesc; // Derived(NEW)
    SELF.dbconsgenderdesc := ri.dbconsgenderdesc; // Derived(NEW)
    SELF.dbconsethnicdesc := ri.dbconsethnicdesc; // Derived(NEW)
    SELF.dbconsreligiousdesc := ri.dbconsreligiousdesc; // Derived(NEW)
    SELF.dbconslangprefdesc := ri.dbconslangprefdesc; // Derived(NEW)
    SELF.dbconsownerrenter := ri.dbconsownerrenter; // Derived(NEW)
    SELF.dbconsdwellingtypedesc := ri.dbconsdwellingtypedesc; // Derived(NEW)
    SELF.dbconsmaritaldesc := ri.dbconsmaritaldesc; // Derived(NEW)
    SELF.dbconsnewparentdesc := ri.dbconsnewparentdesc; // Derived(NEW)
    SELF.dbconsteendriverdesc := ri.dbconsteendriverdesc; // Derived(NEW)
    SELF.dbconspolipartydesc := ri.dbconspolipartydesc; // Derived(NEW)
    SELF.dbconsoccupationdesc := ri.dbconsoccupationdesc; // Derived(NEW)
    SELF.dbconspropertytypedesc := ri.dbconspropertytypedesc; // Derived(NEW)
    SELF.dbconsheadhouseeducdesc := ri.dbconsheadhouseeducdesc; // Derived(NEW)
    SELF.dbconseducationdesc := ri.dbconseducationdesc; // Derived(NEW)
    SELF.title := ri.title; // Derived(NEW)
    SELF.fname := ri.fname; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.name_score := ri.name_score; // Derived(NEW)
    SELF.phy_prim_range := ri.phy_prim_range; // Derived(NEW)
    SELF.phy_predir := ri.phy_predir; // Derived(NEW)
    SELF.phy_prim_name := ri.phy_prim_name; // Derived(NEW)
    SELF.phy_addr_suffix := ri.phy_addr_suffix; // Derived(NEW)
    SELF.phy_postdir := ri.phy_postdir; // Derived(NEW)
    SELF.phy_unit_desig := ri.phy_unit_desig; // Derived(NEW)
    SELF.phy_sec_range := ri.phy_sec_range; // Derived(NEW)
    SELF.phy_p_city_name := ri.phy_p_city_name; // Derived(NEW)
    SELF.phy_v_city_name := ri.phy_v_city_name; // Derived(NEW)
    SELF.phy_st := ri.phy_st; // Derived(NEW)
    SELF.phy_cart := ri.phy_cart; // Derived(NEW)
    SELF.phy_cr_sort_sz := ri.phy_cr_sort_sz; // Derived(NEW)
    SELF.phy_lot := ri.phy_lot; // Derived(NEW)
    SELF.phy_lot_order := ri.phy_lot_order; // Derived(NEW)
    SELF.phy_dbpc := ri.phy_dbpc; // Derived(NEW)
    SELF.phy_chk_digit := ri.phy_chk_digit; // Derived(NEW)
    SELF.phy_rec_type := ri.phy_rec_type; // Derived(NEW)
    SELF.phy_fips_state := ri.phy_fips_state; // Derived(NEW)
    SELF.phy_fips_county := ri.phy_fips_county; // Derived(NEW)
    SELF.phy_geo_lat := ri.phy_geo_lat; // Derived(NEW)
    SELF.phy_geo_long := ri.phy_geo_long; // Derived(NEW)
    SELF.phy_msa := ri.phy_msa; // Derived(NEW)
    SELF.phy_geo_blk := ri.phy_geo_blk; // Derived(NEW)
    SELF.phy_geo_match := ri.phy_geo_match; // Derived(NEW)
    SELF.phy_err_stat := ri.phy_err_stat; // Derived(NEW)
    SELF.phy_raw_aid := ri.phy_raw_aid; // Derived(NEW)
    SELF.phy_ace_aid := ri.phy_ace_aid; // Derived(NEW)
    SELF.phy_prep_address_line1 := ri.phy_prep_address_line1; // Derived(NEW)
    SELF.phy_prep_address_line_last := ri.phy_prep_address_line_last; // Derived(NEW)
    SELF.DB_cons_prim_range := ri.DB_cons_prim_range; // Derived(NEW)
    SELF.DB_cons_predir := ri.DB_cons_predir; // Derived(NEW)
    SELF.DB_cons_prim_name := ri.DB_cons_prim_name; // Derived(NEW)
    SELF.DB_cons_addr_suffix := ri.DB_cons_addr_suffix; // Derived(NEW)
    SELF.DB_cons_postdir := ri.DB_cons_postdir; // Derived(NEW)
    SELF.DB_cons_unit_desig := ri.DB_cons_unit_desig; // Derived(NEW)
    SELF.DB_cons_sec_range := ri.DB_cons_sec_range; // Derived(NEW)
    SELF.DB_cons_p_city_name := ri.DB_cons_p_city_name; // Derived(NEW)
    SELF.DB_cons_v_city_name := ri.DB_cons_v_city_name; // Derived(NEW)
    SELF.DB_cons_st := ri.DB_cons_st; // Derived(NEW)
    SELF.DB_cons_cart := ri.DB_cons_cart; // Derived(NEW)
    SELF.DB_cons_cr_sort_sz := ri.DB_cons_cr_sort_sz; // Derived(NEW)
    SELF.DB_cons_lot := ri.DB_cons_lot; // Derived(NEW)
    SELF.DB_cons_lot_order := ri.DB_cons_lot_order; // Derived(NEW)
    SELF.DB_cons_dbpc := ri.DB_cons_dbpc; // Derived(NEW)
    SELF.DB_cons_chk_digit := ri.DB_cons_chk_digit; // Derived(NEW)
    SELF.DB_cons_rec_type := ri.DB_cons_rec_type; // Derived(NEW)
    SELF.DB_cons_fips_state := ri.DB_cons_fips_state; // Derived(NEW)
    SELF.DB_cons_fips_county := ri.DB_cons_fips_county; // Derived(NEW)
    SELF.DB_cons_geo_lat := ri.DB_cons_geo_lat; // Derived(NEW)
    SELF.DB_cons_geo_long := ri.DB_cons_geo_long; // Derived(NEW)
    SELF.DB_cons_msa := ri.DB_cons_msa; // Derived(NEW)
    SELF.DB_cons_geo_blk := ri.DB_cons_geo_blk; // Derived(NEW)
    SELF.DB_cons_geo_match := ri.DB_cons_geo_match; // Derived(NEW)
    SELF.DB_cons_err_stat := ri.DB_cons_err_stat; // Derived(NEW)
    SELF.DB_cons_raw_aid := ri.DB_cons_raw_aid; // Derived(NEW)
    SELF.DB_cons_ace_aid := ri.DB_cons_ace_aid; // Derived(NEW)
    SELF.DB_cons_prep_address_line1 := ri.DB_cons_prep_address_line1; // Derived(NEW)
    SELF.DB_cons_prep_address_line_last := ri.DB_cons_prep_address_line_last; // Derived(NEW)		
    SELF.mail_prim_range := ri.mail_prim_range; // Derived(NEW)
    SELF.mail_predir := ri.mail_predir; // Derived(NEW)
    SELF.mail_prim_name := ri.mail_prim_name; // Derived(NEW)
    SELF.mail_addr_suffix := ri.mail_addr_suffix; // Derived(NEW)
    SELF.mail_postdir := ri.mail_postdir; // Derived(NEW)
    SELF.mail_unit_desig := ri.mail_unit_desig; // Derived(NEW)
    SELF.mail_sec_range := ri.mail_sec_range; // Derived(NEW)
    SELF.mail_p_city_name := ri.mail_p_city_name; // Derived(NEW)
    SELF.mail_v_city_name := ri.mail_v_city_name; // Derived(NEW)
    SELF.mail_st := ri.mail_st; // Derived(NEW)
    SELF.mail_cart := ri.mail_cart; // Derived(NEW)
    SELF.mail_cr_sort_sz := ri.mail_cr_sort_sz; // Derived(NEW)
    SELF.mail_lot := ri.mail_lot; // Derived(NEW)
    SELF.mail_lot_order := ri.mail_lot_order; // Derived(NEW)
    SELF.mail_dbpc := ri.mail_dbpc; // Derived(NEW)
    SELF.mail_chk_digit := ri.mail_chk_digit; // Derived(NEW)
    SELF.mail_rec_type := ri.mail_rec_type; // Derived(NEW)
    SELF.mail_fips_state := ri.mail_fips_state; // Derived(NEW)
    SELF.mail_fips_county := ri.mail_fips_county; // Derived(NEW)
    SELF.mail_geo_lat := ri.mail_geo_lat; // Derived(NEW)
    SELF.mail_geo_long := ri.mail_geo_long; // Derived(NEW)
    SELF.mail_msa := ri.mail_msa; // Derived(NEW)
    SELF.mail_geo_blk := ri.mail_geo_blk; // Derived(NEW)
    SELF.mail_geo_match := ri.mail_geo_match; // Derived(NEW)
    SELF.mail_err_stat := ri.mail_err_stat; // Derived(NEW)
    SELF.mail_raw_aid := ri.mail_raw_aid; // Derived(NEW)
    SELF.mail_ace_aid := ri.mail_ace_aid; // Derived(NEW)
    SELF.mail_prep_address_line1 := ri.mail_prep_address_line1; // Derived(NEW)
    SELF.mail_prep_address_line_last := ri.mail_prep_address_line_last; // Derived(NEW)			
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner));
  SortIngest0 := SORT(DistIngest0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner, __Tpe, record_sid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner));
  SortBase0 := SORT(DistBase0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner, __Tpe, record_sid, LOCAL);
  GroupBase0 := GROUP(SortBase0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner, __Tpe,record_sid,LOCAL);
  Group0 := GROUP(Sort0,dbusa_business_id,dbusa_executive_id
             ,subhq_parent_id,hq_id,ind_frm_indicator,company_name,full_name,prefix,first_name,middle_initial,last_name,suffix
             ,gender,standardized_title,sourcetitle,executive_title_rank,primary_exec_flag,exec_type,executive_department,executive_level,phy_addr_standardized,phy_addr_city
             ,phy_addr_state,phy_addr_zip,phy_addr_zip4,phy_addr_carrierroute,phy_addr_deliverypt,phy_addr_deliveryptchkdig,mail_addr_standardized,mail_addr_city,mail_addr_state,mail_addr_zip
             ,mail_addr_zip4,mail_addr_carrierroute,mail_addr_deliverypt,mail_addr_deliveryptchkdig,mail_score,mail_score_desc,phone,area_code,fax,email
             ,email_available_indicator,url,url_facebook,url_googleplus,url_instagram,url_linkedin,url_twitter,url_youtube,business_status_code,business_status_desc
             ,franchise_flag,franchise_type,franchise_desc,ticker_symbol,stock_exchange,fortune_1000_flag,fortune_1000_rank,fortune_1000_branches,num_linked_locations,county_code
             ,county_desc,cbsa_code,cbsa_desc,geo_match_level,latitude,longitude,scf,timezone,censustract,censusblock
             ,city_population_code,city_population_descr,primary_sic,primary_sic_desc,sic02,sic02_desc,sic03,sic03_desc,sic04,sic04_desc
             ,sic05,sic05_desc,sic06,sic06_desc,primarysic2,primary_2_digit_sic_desc,primarysic4,primary_4_digit_sic_desc,naics01,naics01_desc
             ,naics02,naics02_desc,naics03,naics03_desc,naics04,naics04_desc,naics05,naics05_desc,naics06,naics06_desc
             ,location_employees_total,location_employee_code,location_employee_desc,location_sales_total,location_sales_code,location_sales_desc,corporate_employee_total,corporate_employee_code,corporate_employee_desc,year_established
             ,years_in_business_range,female_owned,minority_owned_flag,minority_type,home_based_indicator,small_business_indicator,import_export,manufacturing_location,public_indicator,ein
             ,non_profit_org,square_footage,square_footage_code,square_footage_desc,creditscore,creditcode,credit_desc,credit_capacity,credit_capacity_code,credit_capacity_desc
             ,advertising_expenses_code,expense_advertising_desc,technology_expenses_code,expense_technology_desc,office_equip_expenses_code,expense_office_equip_desc,rent_expenses_code,expense_rent_desc,telecom_expenses_code,expense_telecom_desc
             ,accounting_expenses_code,expense_accounting_desc,bus_insurance_expense_code,expense_bus_insurance_desc,legal_expenses_code,expense_legal_desc,utilities_expenses_code,expense_utilities_desc,number_of_pcs_code,number_of_pcs_desc
             ,nb_flag,hq_company_name,hq_city,hq_state,subhq_parent_name,subhq_parent_city,subhq_parent_state,domestic_foreign_owner_flag,foreign_parent_company_name,foreign_parent_city
             ,foreign_parent_country,db_cons_matchkey,databaseusa_individual_id,db_cons_full_name,db_cons_full_name_prefix,db_cons_first_name,db_cons_middle_initial,db_cons_last_name,db_cons_email,db_cons_gender
             ,db_cons_date_of_birth_year,db_cons_date_of_birth_month,db_cons_age,db_cons_age_code_desc,db_cons_age_in_two_year_hh,db_cons_ethnic_code,db_cons_religious_affil,db_cons_language_pref,db_cons_phy_addr_std,db_cons_phy_addr_city
             ,db_cons_phy_addr_state,db_cons_phy_addr_zip,db_cons_phy_addr_zip4,db_cons_phy_addr_carrierroute,db_cons_phy_addr_deliverypt,db_cons_line_of_travel,db_cons_geocode_results,db_cons_latitude,db_cons_longitude,db_cons_time_zone_code
             ,db_cons_time_zone_desc,db_cons_census_tract,db_cons_census_block,db_cons_countyfips,db_countyname,db_cons_cbsa_code,db_cons_cbsa_desc,db_cons_walk_sequence,db_cons_phone,db_cons_dnc
             ,db_cons_scrubbed_phoneable,db_cons_children_present,db_cons_home_value_code,db_cons_home_value_desc,db_cons_donor_capacity,db_cons_donor_capacity_code,db_cons_donor_capacity_desc,db_cons_home_owner_renter,db_cons_length_of_res,db_cons_length_of_res_code
             ,db_cons_length_of_res_desc,db_cons_dwelling_type,db_cons_recent_home_buyer,db_cons_income_code,db_cons_income_desc,db_cons_unsecuredcredcap,db_cons_unsecuredcredcapcode,db_cons_unsecuredcredcapdesc,db_cons_networthhomeval,db_cons_networthhomevalcode
             ,db_cons_net_worth_desc,db_cons_discretincome,db_cons_discretincomecode,db_cons_discretincomedesc,db_cons_marital_status,db_cons_new_parent,db_cons_child_near_hs_grad,db_cons_college_graduate,db_cons_intend_purchase_veh,db_cons_recent_divorce
             ,db_cons_newlywed,db_cons_new_teen_driver,db_cons_home_year_built,db_cons_home_sqft_ranges,db_cons_poli_party_ind,db_cons_home_sqft_actual,db_cons_occupation_ind,db_cons_credit_card_user,db_cons_home_property_type,db_cons_education_hh
             ,db_cons_education_ind,db_cons_other_pet_owner,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,record_sid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.record_sid := IF ( le.record_sid=0, PrevBase+1+thorlib.node(), le.record_sid+thorlib.nodes() );
    SELF.seleid := SELF.record_sid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(record_sid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(record_sid<>0) : PERSIST('~temp::seleid::Database_USA::Ingest_Cache',EXPIRE(Database_USA.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  SHARED UpdateStatsSrcFull := SORT(TABLE(AllRecs, {source,__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
  SHARED UpdateStatsSrcInc := SORT(UpdateStatsSrcFull(__Tpe = RecordType.New), source,__Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStatsSrc := IF(incremental, UpdateStatsSrcInc, UpdateStatsSrcFull);
  SHARED S2 := OUTPUT(UpdateStatsSrc, {{UpdateStatsSrc} AND NOT __Tpe}, ALL, NAMED('UpdateStatsSrc'));
 
  SHARED l_roll := RECORD
    UpdateStatsSrc.source;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
    unsigned pct_tot_Old;
    unsigned pct_tot_Unchanged;
    unsigned pct_tot_Updated;
    unsigned pct_tot_New;
    unsigned pct_ingest_Unchanged;
    unsigned pct_ingest_Updated;
    unsigned pct_ingest_New;
  END;
  SHARED l_roll toRoll(UpdateStatsSrc L) := TRANSFORM
    SELF.cnt_Old := IF(L.__Tpe=RecordType.Old, L.Cnt, 0);
    SELF.cnt_Unchanged := IF(L.__Tpe=RecordType.Unchanged, L.Cnt, 0);
    SELF.cnt_Updated := IF(L.__Tpe=RecordType.Updated, L.Cnt, 0);
    SELF.cnt_New := IF(L.__Tpe=RecordType.New, L.Cnt, 0);
    SELF := L;
    SELF := [];
  END;
  SHARED l_roll doRoll(l_roll L, l_roll R) := TRANSFORM
    SELF.cnt_Old := IF(L.cnt_Old<>0, L.cnt_Old, R.cnt_Old);
    SELF.cnt_Unchanged := IF(L.cnt_Unchanged<>0, L.cnt_Unchanged, R.cnt_Unchanged);
    SELF.cnt_Updated := IF(L.cnt_Updated<>0, L.cnt_Updated, R.cnt_Updated);
    SELF.cnt_New := IF(L.cnt_New<>0, L.cnt_New, R.cnt_New);
    SELF := L;
  END;
  SHARED l_roll toPct(l_roll L) := TRANSFORM
    cnt_tot := L.cnt_old + L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    cnt_ingest := L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    SELF.pct_tot_Old := 100.0 * L.cnt_Old / cnt_tot;
    SELF.pct_tot_Unchanged := 100.0 * L.cnt_Unchanged / cnt_tot;
    SELF.pct_tot_Updated := 100.0 * L.cnt_Updated / cnt_tot;
    SELF.pct_tot_New := 100.0 * L.cnt_New / cnt_tot;
    SELF.pct_ingest_Unchanged := 100.0 * L.cnt_Unchanged / cnt_ingest;
    SELF.pct_ingest_Updated := 100.0 * L.cnt_Updated / cnt_ingest;
    SELF.pct_ingest_New := 100.0 * L.cnt_New / cnt_ingest;
    SELF := L;
  END;
  SHARED UpdateStatsXtab := PROJECT(ROLLUP(PROJECT(SORT(UpdateStatsSrc,source),toRoll(LEFT)),doRoll(LEFT,RIGHT),source),toPct(LEFT));
  SHARED S3 := IF(~incremental, OUTPUT(UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab')));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Database_USA.Layouts.Base);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Database_USA.Layouts.Base);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Database_USA.Layouts.Base);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Database_USA.Layouts.Base); // Records in 'pure' format
 
  // Compute field level differences
  IOR := JOIN(OldRecords,InputSourceCounts,left.source=right.source,TRANSFORM(LEFT),LOOKUP); // Only send in old records from sources in this ingest
  Fields.MAC_CountDifferencesByPivot(NewRecords,IOR,((SALT311.StrType)source+'|'+(SALT311.StrType)dbusa_business_id+dbusa_executive_id),BadPivs,DC)
  EXPORT FieldChangeStats := DC;
  SHARED S4 := OUTPUT(FieldChangeStats,ALL,NAMED('FieldChangeStats'));
 
f := TABLE(dsBase,{record_sid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,record_sid);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3,S4);
 
  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE, BOOLEAN doInfilePerSrcCnt = TRUE, BOOLEAN doStatusPerSrcCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    sourceCountsStandard := IF(doInfilePerSrcCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileSourceCounts(InputSourceCounts, source, myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    ingestStatusPerSrc := IF(doStatusPerSrcCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStatsSrc, source, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall & sourceCountsStandard & ingestStatusPerSrc;
    RETURN standardStats;
  END;
END;

IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_InfutorWP.BaseOut) Delta = DATASET([],Layout_InfutorWP.BaseOut)
, DATASET(Layout_InfutorWP.BaseOut) dsBase = InfutorWP_In_CanadianPhones // Change IN_CanadianPhones to change input to ingest process
, DATASET(RECORDOF(CanadianPhones.InfutorWP_ingest_prep))  infile = CanadianPhones.InfutorWP_ingest_prep
) := MODULE
  SHARED NullFile := DATASET([],Layout_InfutorWP.BaseOut); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_InfutorWP.BaseOut;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.date_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_first_reported = 0 => ri.date_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_first_reported = 0 => le.date_first_reported,
                     (UNSIGNED)le.date_first_reported < (UNSIGNED)ri.date_first_reported => le.date_first_reported, // Want the lowest non-zero value
                     ri.date_first_reported);
    SELF.date_last_reported := MAP ( le.__Tpe = 0 => ri.date_last_reported,
                     ri.__Tpe = 0 => le.date_last_reported,
                     (UNSIGNED)le.date_last_reported < (UNSIGNED)ri.date_last_reported => ri.date_last_reported, // Want the highest value
                     le.date_last_reported);
    SELF.vendor := ri.vendor; // Derived(NEW)
    SELF.source_file := ri.source_file; // Derived(NEW)
    SELF.prim_range := ri.prim_range; // Derived(NEW)
    SELF.predir := ri.predir; // Derived(NEW)
    SELF.prim_name := ri.prim_name; // Derived(NEW)
    SELF.addr_suffix := ri.addr_suffix; // Derived(NEW)
    SELF.unit_desig := ri.unit_desig; // Derived(NEW)
    SELF.sec_range := ri.sec_range; // Derived(NEW)
    SELF.p_city_name := ri.p_city_name; // Derived(NEW)
    SELF.state := ri.state; // Derived(NEW)
    SELF.zip := ri.zip; // Derived(NEW)
    SELF.rec_type := ri.rec_type; // Derived(NEW)
    SELF.language := ri.language; // Derived(NEW)
    SELF.errstat := ri.errstat; // Derived(NEW)
    SELF.name_title := ri.name_title; // Derived(NEW)
    SELF.fname := ri.fname; // Derived(NEW)
    SELF.mname := ri.mname; // Derived(NEW)
    SELF.lname := ri.lname; // Derived(NEW)
    SELF.name_suffix := ri.name_suffix; // Derived(NEW)
    SELF.name_score := ri.name_score; // Derived(NEW)
    SELF.global_sid := ri.global_sid; // Derived(NEW)
    SELF.record_sid := ri.record_sid; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.date_first_reported <> le.date_first_reported OR SELF.date_last_reported <> le.date_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type));
  SortIngest0 := SORT(DistIngest0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, __Tpe, record_id, LOCAL);
  GroupIngest0 := GROUP(SortIngest0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type));
  SortBase0 := SORT(DistBase0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, __Tpe, record_id, LOCAL);
  GroupBase0 := GROUP(SortBase0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, __Tpe, record_id, LOCAL);
  Group0 := GROUP(Sort0, 
    lastname, firstname, middlename, name, nickname, 
    generational, title, professionalsuffix, housenumber, directional, 
    streetname, streetsuffix, suitenumber, suburbancity, postalcity, 
    province, postalcode, provincecode, county_code, phonenumber, 
    phonetypeflag, nosolicitation, cmacode, company_name, record_use_indicator, 
    city, pub_date, latitude, longitude, lat_long_level_applied, 
    book_number, secondary_name, room_number, room_code, record_type, 
    yphc_1, yphc_2, yphc_3, yphc_4, yphc_5, 
    yphc_6, sic_1, sic_2, sic_3, sic_4, 
    bus_govt_indicator, status_indicator, selected_sic, franchise_codes, ad_size, 
    french_flag, population_code, individual_firm_code, year_of_1st_appearance_ccyy, date_added_to_db_ccyymm, 
    title_code, contact_gender_code, employee_size_code, sales_volume_code, industry_specific_code, 
    business_status_code, key_code, fax_phone, office_size_code, production_date_mmddccyy, 
    abi_number, subsidiary_parent_number, ultimate_parent_number, primary_sic, secondary_sic_code_1, 
    secondary_sic_code_2, secondary_sic_code_3, secondary_sic_code_4, total_employee_size_code, total_output_sales_code, 
    number_of_employees_actual, total_no_employees_actual, postal_mode, postal_bag_bundle, transaction_code, 
    listing_type, LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,record_id);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.record_id := IF ( le.record_id=0, PrevBase+1+thorlib.node(), le.record_id+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(record_id=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(record_id<>0) : PERSIST('~temp::CanadianPhones::Ingest_Cache',EXPIRE(CanadianPhones.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_InfutorWP.BaseOut);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_InfutorWP.BaseOut);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_InfutorWP.BaseOut);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_InfutorWP.BaseOut); // Records in 'pure' format
 
f := TABLE(dsBase,{record_id}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,record_id);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := S0;
 
  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall;
    RETURN standardStats;
  END;
END;

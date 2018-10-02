IMPORT STD,SALT38,bank_routing;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_Accuity_Bank_Routing) Delta = DATASET([],Layout_Accuity_Bank_Routing)
, DATASET(Layout_Accuity_Bank_Routing) dsBase = bank_routing.Files.base // Change IN_bank_routing to change input to ingest process
, DATASET(RECORDOF(bank_routing.Files.base))  infile = bank_routing.In_Accuity_Bank_Routing
) := MODULE
  SHARED NullFile := DATASET([],Layout_Accuity_Bank_Routing); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_Accuity_Bank_Routing;
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
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier));
  SortIngest0 := SORT(DistIngest0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier, __Tpe, rcid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier));
  SortBase0 := SORT(DistBase0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier, __Tpe, rcid, LOCAL);
  GroupBase0 := GROUP(SortBase0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier, __Tpe,rcid,LOCAL);
  Group0 := GROUP(Sort0,file_key,date_updated,type_instituon_code,head_office_branch_codes,routing_number_micr
             ,routing_number_fractional,institution_name_full,institution_name_abbreviated,street_address,city_town,state,zip_code,zip_4,mail_address,mail_city_town
             ,mail_state,mail_zip_code,mail_zip_4,branch_office_name,head_office_routing_number,phone_number_area_code,phone_number,phone_number_extension,fax_area_code,fax_number
             ,fax_extension,head_office_asset_size,federal_reserve_district_code,year_2000_date_last_updated,head_office_file_key,routing_number_type,routing_number_status,employer_tax_id,institution_identifier,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT38.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0);// : PERSIST('~temp::bank_routing::Ingest_Cache',EXPIRE(bank_routing.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT38.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_Accuity_Bank_Routing);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_Accuity_Bank_Routing);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_Accuity_Bank_Routing);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_Accuity_Bank_Routing); // Records in 'pure' format
 
  EXPORT DoStats := S0;
 
END;

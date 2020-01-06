IMPORT SALT35,BIPV2_Ingest; 
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_BASE) Delta = DATASET([],Layout_BASE)
, DATASET(Layout_BASE) dsBase = In_BASE // Change IN_BASE to change input to ingest process
, DATASET(RECORDOF(BIPV2_Ingest.In_INGEST))  infile = BIPV2_Ingest.In_INGEST
,string pPersistname = '~temp::DOTid::BIPV2_Ingest::Ingest_Cache'/*HACK01*/
) := MODULE
  SHARED NullFile := DATASET([],Layout_BASE); // Use to replace files you wish to remove
 
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
  WithRT := RECORD(Layout_BASE)
    __Tpe := RecordType.Unknown;
  END; 
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=IF(incremental,RecordType.Old,RecordType.New),SELF:=LEFT));
  Base0WithBlank := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
Base0 := _Custom.FilterBlanks(Base0WithBlank);/*HACK05*/
 
  WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_first_seen := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_first_seen = 0 => ri.dt_first_seen,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_first_seen = 0 => le.dt_first_seen,
                     (unsigned)le.dt_first_seen < (unsigned)ri.dt_first_seen => le.dt_first_seen, // Want the lowest non-zero value
                     ri.dt_first_seen);
    SELF.dt_last_seen := MAP ( le.__Tpe = 0 => ri.dt_last_seen,
                     ri.__Tpe = 0 => le.dt_last_seen,
                     (unsigned)le.dt_last_seen < (unsigned)ri.dt_last_seen => ri.dt_last_seen, // Want the highest value
                     le.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (unsigned)le.dt_vendor_first_reported < (unsigned)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (unsigned)le.dt_vendor_last_reported < (unsigned)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    SELF.dt_first_seen_company_name := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_first_seen_company_name = 0 => ri.dt_first_seen_company_name,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_first_seen_company_name = 0 => le.dt_first_seen_company_name,
                     (unsigned)le.dt_first_seen_company_name < (unsigned)ri.dt_first_seen_company_name => le.dt_first_seen_company_name, // Want the lowest non-zero value
                     ri.dt_first_seen_company_name);
    SELF.dt_last_seen_company_name := MAP ( le.__Tpe = 0 => ri.dt_last_seen_company_name,
                     ri.__Tpe = 0 => le.dt_last_seen_company_name,
                     (unsigned)le.dt_last_seen_company_name < (unsigned)ri.dt_last_seen_company_name => ri.dt_last_seen_company_name, // Want the highest value
                     le.dt_last_seen_company_name);
    SELF.dt_first_seen_company_address := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_first_seen_company_address = 0 => ri.dt_first_seen_company_address,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_first_seen_company_address = 0 => le.dt_first_seen_company_address,
                     (unsigned)le.dt_first_seen_company_address < (unsigned)ri.dt_first_seen_company_address => le.dt_first_seen_company_address, // Want the lowest non-zero value
                     ri.dt_first_seen_company_address);
    SELF.dt_last_seen_company_address := MAP ( le.__Tpe = 0 => ri.dt_last_seen_company_address,
                     ri.__Tpe = 0 => le.dt_last_seen_company_address,
                     (unsigned)le.dt_last_seen_company_address < (unsigned)ri.dt_last_seen_company_address => ri.dt_last_seen_company_address, // Want the highest value
                     le.dt_last_seen_company_address);
    SELF.dt_first_seen_contact := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_first_seen_contact = 0 => ri.dt_first_seen_contact,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_first_seen_contact = 0 => le.dt_first_seen_contact,
                     (unsigned)le.dt_first_seen_contact < (unsigned)ri.dt_first_seen_contact => le.dt_first_seen_contact, // Want the lowest non-zero value
                     ri.dt_first_seen_contact);
    SELF.dt_last_seen_contact := MAP ( le.__Tpe = 0 => ri.dt_last_seen_contact,
                     ri.__Tpe = 0 => le.dt_last_seen_contact,
                     (unsigned)le.dt_last_seen_contact < (unsigned)ri.dt_last_seen_contact => ri.dt_last_seen_contact, // Want the highest value
                     le.dt_last_seen_contact);
    SELF.isContact := ri.isContact; // Derived - so take newest 
    SELF.iscorp := ri.iscorp; // Derived - so take newest 
    SELF.cnp_hasnumber := ri.cnp_hasnumber; // Derived - so take newest 
    SELF.cnp_name := ri.cnp_name; // Derived - so take newest 
    SELF.cnp_number := ri.cnp_number; // Derived - so take newest 
    SELF.cnp_btype := ri.cnp_btype; // Derived - so take newest 
    SELF.cnp_lowv := ri.cnp_lowv; // Derived - so take newest 
    SELF.cnp_translated := ri.cnp_translated; // Derived - so take newest 
    SELF.cnp_classid := ri.cnp_classid; // Derived - so take newest 
    SELF.company_aceaid := ri.company_aceaid; // Derived - so take newest 
    SELF.corp_legal_name := ri.corp_legal_name; // Derived - so take newest 
    SELF.dba_name := ri.dba_name; // Derived - so take newest 
    SELF.active_duns_number := ri.active_duns_number; // Derived - so take newest 
    SELF.hist_duns_number := ri.hist_duns_number; // Derived - so take newest 
    SELF.active_enterprise_number := ri.active_enterprise_number; // Derived - so take newest 
    SELF.hist_enterprise_number := ri.hist_enterprise_number; // Derived - so take newest 
    SELF.ebr_file_number := ri.ebr_file_number; // Derived - so take newest 
    SELF.active_domestic_corp_key := ri.active_domestic_corp_key; // Derived - so take newest 
    SELF.hist_domestic_corp_key := ri.hist_domestic_corp_key; // Derived - so take newest 
    SELF.foreign_corp_key := ri.foreign_corp_key; // Derived - so take newest 
    SELF.unk_corp_key := ri.unk_corp_key; // Derived - so take newest 
    SELF.global_sid := ri.global_sid; // Derived - so take newest 
    SELF.record_sid := ri.record_sid; // Derived - so take newest 
		SELF.employee_count_org_raw := ri.employee_count_org_raw; // Derived - so take newest 
    SELF.employee_count_org_derived := ri.employee_count_org_derived; // Derived - so take newest 
    SELF.revenue_org_raw := ri.revenue_org_raw; // Derived - so take newest 
    SELF.revenue_org_derived := ri.revenue_org_derived; // Derived - so take newest 
    SELF.employee_count_local_raw := ri.employee_count_local_raw; // Derived - so take newest 
    SELF.employee_count_local_derived := ri.employee_count_local_derived; // Derived - so take newest 
    SELF.revenue_local_raw := ri.revenue_local_raw; // Derived - so take newest 
    SELF.revenue_local_derived := ri.revenue_local_derived; // Derived - so take newest 
    SELF.locid := ri.locid; // Derived - so take newest 
    SELF.source_docid := ri.source_docid; // Derived - so take newest 
    SELF.name_score := ri.name_score; // Derived - so take newest 
    SELF.company_name_type_derived := ri.company_name_type_derived; // Derived - so take newest 
    SELF.company_rawaid := ri.company_rawaid; // Derived - so take newest 
    SELF.addr_suffix := ri.addr_suffix; // Derived - so take newest 
    SELF.unit_desig := ri.unit_desig; // Derived - so take newest 
    SELF.p_city_name := ri.p_city_name; // Derived - so take newest 
    SELF.cart := ri.cart; // Derived - so take newest 
    SELF.cr_sort_sz := ri.cr_sort_sz; // Derived - so take newest 
    SELF.lot := ri.lot; // Derived - so take newest 
    SELF.lot_order := ri.lot_order; // Derived - so take newest 
    SELF.dbpc := ri.dbpc; // Derived - so take newest 
    SELF.chk_digit := ri.chk_digit; // Derived - so take newest 
    SELF.rec_type := ri.rec_type; // Derived - so take newest 
    SELF.fips_state := ri.fips_state; // Derived - so take newest 
    SELF.fips_county := ri.fips_county; // Derived - so take newest 
    SELF.geo_lat := ri.geo_lat; // Derived - so take newest 
    SELF.geo_long := ri.geo_long; // Derived - so take newest 
    SELF.msa := ri.msa; // Derived - so take newest 
    SELF.geo_blk := ri.geo_blk; // Derived - so take newest 
    SELF.geo_match := ri.geo_match; // Derived - so take newest 
    SELF.err_stat := ri.err_stat; // Derived - so take newest 
    SELF.company_bdid := ri.company_bdid; // Derived - so take newest 
    SELF.company_incorporation_date := ri.company_incorporation_date; // Derived - so take newest 
    SELF.company_foreign_domestic := ri.company_foreign_domestic; // Derived - so take newest 
    SELF.company_filing_date := ri.company_filing_date; // Derived - so take newest 
    SELF.company_status_date := ri.company_status_date; // Derived - so take newest 
    SELF.company_foreign_date := ri.company_foreign_date; // Derived - so take newest 
    SELF.event_filing_date := ri.event_filing_date; // Derived - so take newest 
    SELF.current := ri.current; // Derived - so take newest 
    SELF.contact_did := ri.contact_did; // Derived - so take newest 
    SELF.contact_email_username := ri.contact_email_username; // Derived - so take newest 
    SELF.contact_email_domain := ri.contact_email_domain; // Derived - so take newest 
    SELF.company_address_type_derived := ri.company_address_type_derived; // Derived - so take newest 
    SELF.company_org_structure_derived := ri.company_org_structure_derived; // Derived - so take newest 
    SELF.company_name_status_derived := ri.company_name_status_derived; // Derived - so take newest 
    SELF.company_status_derived := ri.company_status_derived; // Derived - so take newest 
    SELF.contact_type_derived := ri.contact_type_derived; // Derived - so take newest 
    SELF.contact_job_title_derived := ri.contact_job_title_derived; // Derived - so take newest 
    SELF.contact_status_derived := ri.contact_status_derived; // Derived - so take newest 
    SELF.__Tpe := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported OR SELF.dt_first_seen_company_name <> le.dt_first_seen_company_name OR SELF.dt_last_seen_company_name <> le.dt_last_seen_company_name OR SELF.dt_first_seen_company_address <> le.dt_first_seen_company_address OR SELF.dt_last_seen_company_address <> le.dt_last_seen_company_address OR SELF.dt_first_seen_contact <> le.dt_first_seen_contact OR SELF.dt_last_seen_contact <> le.dt_last_seen_contact => RecordType.Updated,
      RecordType.Unchanged);
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Full Ingest: combine delta with ingest files
  /*HACK04*/
GroupIngest0_dist := DISTRIBUTE( Delta0+FilesToIngest0, hash32(source,source_record_id,title,fname,mname,lname,name_suffix,company_name,company_name_type_raw,prim_range,predir,prim_name,postdir,sec_range,v_city_name,st,zip,zip4,company_address_type_raw,company_fein,best_fein_indicator,company_phone,phone_type,phone_score,company_org_structure_raw,company_sic_code1,company_sic_code2,company_sic_code3,company_sic_code4,company_sic_code5,company_naics_code1,company_naics_code2,company_naics_code3,company_naics_code4
             ,company_naics_code5,company_ticker,company_ticker_exchange,company_url,company_inc_state,company_charter_number,company_name_status_raw,company_status_raw,vl_id,contact_type_raw,contact_job_title_raw,contact_ssn,contact_dob
             ,contact_status_raw,contact_email,contact_phone,from_hdr,company_department));
GroupIngest0 := GROUP(GroupIngest0_dist,source,source_record_id,title,fname,mname,lname,name_suffix,company_name,company_name_type_raw,prim_range,predir,prim_name,postdir,sec_range,v_city_name,st,zip,zip4,company_address_type_raw,company_fein,best_fein_indicator,company_phone,phone_type,phone_score,company_org_structure_raw,company_sic_code1,company_sic_code2,company_sic_code3,company_sic_code4,company_sic_code5,company_naics_code1,company_naics_code2,company_naics_code3,company_naics_code4
             ,company_naics_code5,company_ticker,company_ticker_exchange,company_url,company_inc_state,company_charter_number,company_name_status_raw,company_status_raw,vl_id,contact_type_raw,contact_job_title_raw,contact_ssn,contact_dob
             ,contact_status_raw,contact_email,contact_phone,from_hdr,company_department,ALL,LOCAL);
  AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
  // Incremental Ingest: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0,source,source_record_id,title,fname,mname,lname,name_suffix,company_name,company_name_type_raw,prim_range,predir,prim_name,postdir,sec_range,v_city_name,st,zip,zip4,company_address_type_raw,company_fein,best_fein_indicator,company_phone,phone_type,phone_score,company_org_structure_raw,company_sic_code1,company_sic_code2,company_sic_code3,company_sic_code4,company_sic_code5,company_naics_code1,company_naics_code2,company_naics_code3,company_naics_code4
             ,company_naics_code5,company_ticker,company_ticker_exchange,company_url,company_inc_state,company_charter_number,company_name_status_raw,company_status_raw,vl_id,contact_type_raw,contact_job_title_raw,contact_ssn,contact_dob
             ,contact_status_raw,contact_email,contact_phone,from_hdr,company_department,ALL);
  AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
 
  Base1 := IF(incremental,AllBaseRecs0,Base0);
  FilesToIngest1 := IF(incremental,FilesToIngest0,AllIngestRecs0);
  /*HACK03*/
Group0_dist := DISTRIBUTE( Base1+FilesToIngest1, hash32(source,source_record_id,title,fname,mname,lname,name_suffix,company_name,company_name_type_raw,prim_range,predir,prim_name,postdir,sec_range,v_city_name,st,zip,zip4,company_address_type_raw,company_fein,best_fein_indicator,company_phone,phone_type,phone_score,company_org_structure_raw,company_sic_code1,company_sic_code2,company_sic_code3,company_sic_code4,company_sic_code5,company_naics_code1,company_naics_code2,company_naics_code3,company_naics_code4
             ,company_naics_code5,company_ticker,company_ticker_exchange,company_url,company_inc_state,company_charter_number,company_name_status_raw,company_status_raw,vl_id,contact_type_raw,contact_job_title_raw,contact_ssn,contact_dob
             ,contact_status_raw,contact_email,contact_phone,from_hdr,company_department));
Group0 := GROUP(Group0_dist,source,source_record_id,title,fname,mname,lname,name_suffix,company_name,company_name_type_raw,prim_range,predir,prim_name,postdir,sec_range,v_city_name,st,zip,zip4,company_address_type_raw,company_fein,best_fein_indicator,company_phone,phone_type,phone_score,company_org_structure_raw,company_sic_code1,company_sic_code2,company_sic_code3,company_sic_code4,company_sic_code5,company_naics_code1,company_naics_code2,company_naics_code3,company_naics_code4
             ,company_naics_code5,company_ticker,company_ticker_exchange,company_url,company_inc_state,company_charter_number,company_name_status_raw,company_status_raw,vl_id,contact_type_raw,contact_job_title_raw,contact_ssn,contact_dob
             ,contact_status_raw,contact_email,contact_phone,from_hdr,company_department,ALL,LOCAL);
  AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New) + _Custom.GetBlanks(Base0WithBlank);/*HACK06*/
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF.DOTid := SELF.rcid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST(pPersistname/*HACK02*/,EXPIRE(Config.PersistExpire));
  EXPORT UpdateStats := SORT(TABLE(AllRecs, {__Tpe,SALT35.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  EXPORT UpdateStatsSrc := SORT(TABLE(AllRecs, {source,__Tpe,SALT35.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
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
SHARED S3 := OUTPUT(UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab'));
 
  EXPORT NewRecords := AllRecs(__Tpe=RecordType.New);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_BASE);
  EXPORT OldRecords := AllRecs(__Tpe=RecordType.Old);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_BASE);
  EXPORT UpdatedRecords := AllRecs(__Tpe=RecordType.Updated);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_BASE);
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_BASE); // Records in 'pure' format
 
  // Compute field level differences
  IOR := JOIN(OldRecords,InputSourceCounts,left.source=right.source,TRANSFORM(LEFT),LOOKUP); // Only send in old records from sources in this ingest
  Fields.MAC_CountDifferencesByPivot(NewRecords,IOR,((SALT35.StrType)source+'|'+(SALT35.StrType)source_record_id),BadPivs,DC)
  EXPORT FieldChangeStats := DC;
  SHARED S4 := OUTPUT(FieldChangeStats,ALL,NAMED('FieldChangeStats'));
 
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3,S4);
 
END;

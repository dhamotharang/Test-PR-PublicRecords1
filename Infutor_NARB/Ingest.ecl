IMPORT SALT34,infutor_narb;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Infutor_NARB.Layouts.Base) Delta = DATASET([],Infutor_NARB.Layouts.Base) //default empty file
, DATASET(Infutor_NARB.Layouts.Base) dsBase 
, DATASET(Infutor_NARB.Layouts.Base) infile 
) := MODULE
  SHARED NullFile := DATASET([],Infutor_NARB.Layouts.Base); // Use to replace files you wish to remove
 
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
  WithRT := RECORD(Infutor_NARB.Layouts.Base)
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=IF(incremental,RecordType.Old,RecordType.New),SELF:=LEFT));
  Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.process_date := ri.process_date; // Derived - so take newest 
    SELF.dotid := ri.dotid; // Derived - so take newest 
    SELF.dotscore := ri.dotscore; // Derived - so take newest 
    SELF.dotweight := ri.dotweight; // Derived - so take newest 
    SELF.empid := ri.empid; // Derived - so take newest 
    SELF.empscore := ri.empscore; // Derived - so take newest 
    SELF.empweight := ri.empweight; // Derived - so take newest 
    SELF.powid := ri.powid; // Derived - so take newest 
    SELF.powscore := ri.powscore; // Derived - so take newest 
    SELF.powweight := ri.powweight; // Derived - so take newest 
    SELF.proxid := ri.proxid; // Derived - so take newest 
    SELF.proxscore := ri.proxscore; // Derived - so take newest 
    SELF.proxweight := ri.proxweight; // Derived - so take newest 
    SELF.seleid := ri.seleid; // Derived - so take newest 
    SELF.selescore := ri.selescore; // Derived - so take newest 
    SELF.seleweight := ri.seleweight; // Derived - so take newest 
    SELF.orgid := ri.orgid; // Derived - so take newest 
    SELF.orgscore := ri.orgscore; // Derived - so take newest 
    SELF.orgweight := ri.orgweight; // Derived - so take newest 
    SELF.ultid := ri.ultid; // Derived - so take newest 
    SELF.ultscore := ri.ultscore; // Derived - so take newest 
    SELF.ultweight := ri.ultweight; // Derived - so take newest 
    SELF.did := ri.did; // Derived - so take newest 
    SELF.did_score := ri.did_score; // Derived - so take newest 
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
    SELF.record_type := ri.record_type; // Derived - so take newest 
    SELF.clean_company_name := ri.clean_company_name; // Derived - so take newest 
    SELF.title := ri.title; // Derived - so take newest 
    SELF.fname := ri.fname; // Derived - so take newest 
    SELF.mname := ri.mname; // Derived - so take newest 
    SELF.lname := ri.lname; // Derived - so take newest 
    SELF.name_suffix := ri.name_suffix; // Derived - so take newest 
    SELF.name_score := ri.name_score; // Derived - so take newest 
    SELF.prim_range := ri.prim_range; // Derived - so take newest 
    SELF.predir := ri.predir; // Derived - so take newest 
    SELF.prim_name := ri.prim_name; // Derived - so take newest 
    SELF.addr_suffix := ri.addr_suffix; // Derived - so take newest 
    SELF.postdir := ri.postdir; // Derived - so take newest 
    SELF.unit_desig := ri.unit_desig; // Derived - so take newest 
    SELF.sec_range := ri.sec_range; // Derived - so take newest 
    SELF.p_city_name := ri.p_city_name; // Derived - so take newest 
    SELF.v_city_name := ri.v_city_name; // Derived - so take newest 
    SELF.st := ri.st; // Derived - so take newest 
    SELF.zip := ri.zip; // Derived - so take newest 
    SELF.zip4 := ri.zip4; // Derived - so take newest 
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
    SELF.clean_phone := ri.clean_phone; // Derived - so take newest 
    SELF.raw_aid := ri.raw_aid; // Derived - so take newest 
    SELF.ace_aid := ri.ace_aid; // Derived - so take newest 
    SELF.prep_address_line1 := ri.prep_address_line1; // Derived - so take newest 
    SELF.prep_address_line_last := ri.prep_address_line_last; // Derived - so take newest 
    SELF.__Tpe := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Full Ingest: combine delta with ingest files
  GroupIngest0 := GROUP( Delta0+FilesToIngest0
             ,pid,record_id,ein,busname,tradename,house,predirection,street,strtype,postdirection
             ,apttype,aptnbr,city,state,zip5,ziplast4,dpc,carrier_route,address_type_code,dpv_code
             ,mailable,county_code,censustract,censusblockgroup,censusblock,congress_code,msacode,timezonecode,latitude,longitude
             ,url,telephone,toll_free_number,fax,sic1,sic2,sic3,sic4,sic5,stdclass
             ,heading1,heading2,heading3,heading4,heading5,business_specialty,sales_code,employee_code,location_type,parent_company
             ,parent_address,parent_city,parent_state,parent_zip,parent_phone,stock_symbol,stock_exchange,public,number_of_pcs,square_footage
             ,business_type,incorporation_state,minority,woman,government,small,home_office,soho,franchise,phoneable
             ,prefix,first_name,middle_name,surname,suffix,birth_year,ethnicity,gender,email,contact_title
             ,year_started,date_added,validationdate,internal1,dacd,normcompany_type,normcompany_name,normcompany_street,normcompany_city,normcompany_state
             ,normcompany_zip,normcompany_phone,ALL);
  AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
  // Incremental Ingest: combine delta with base file
  GroupBase0 := GROUP( Base0+Delta0
             ,pid,record_id,ein,busname,tradename,house,predirection,street,strtype,postdirection
             ,apttype,aptnbr,city,state,zip5,ziplast4,dpc,carrier_route,address_type_code,dpv_code
             ,mailable,county_code,censustract,censusblockgroup,censusblock,congress_code,msacode,timezonecode,latitude,longitude
             ,url,telephone,toll_free_number,fax,sic1,sic2,sic3,sic4,sic5,stdclass
             ,heading1,heading2,heading3,heading4,heading5,business_specialty,sales_code,employee_code,location_type,parent_company
             ,parent_address,parent_city,parent_state,parent_zip,parent_phone,stock_symbol,stock_exchange,public,number_of_pcs,square_footage
             ,business_type,incorporation_state,minority,woman,government,small,home_office,soho,franchise,phoneable
             ,prefix,first_name,middle_name,surname,suffix,birth_year,ethnicity,gender,email,contact_title
             ,year_started,date_added,validationdate,internal1,dacd,normcompany_type,normcompany_name,normcompany_street,normcompany_city,normcompany_state
             ,normcompany_zip,normcompany_phone,ALL);
  AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
 
  Base1 := IF(incremental,AllBaseRecs0,Base0);
  FilesToIngest1 := IF(incremental,FilesToIngest0,AllIngestRecs0);
  Group0 := GROUP( Base1+FilesToIngest1
             ,pid,record_id,ein,busname,tradename,house,predirection,street,strtype,postdirection
             ,apttype,aptnbr,city,state,zip5,ziplast4,dpc,carrier_route,address_type_code,dpv_code
             ,mailable,county_code,censustract,censusblockgroup,censusblock,congress_code,msacode,timezonecode,latitude,longitude
             ,url,telephone,toll_free_number,fax,sic1,sic2,sic3,sic4,sic5,stdclass
             ,heading1,heading2,heading3,heading4,heading5,business_specialty,sales_code,employee_code,location_type,parent_company
             ,parent_address,parent_city,parent_state,parent_zip,parent_phone,stock_symbol,stock_exchange,public,number_of_pcs,square_footage
             ,business_type,incorporation_state,minority,woman,government,small,home_office,soho,franchise,phoneable
             ,prefix,first_name,middle_name,surname,suffix,birth_year,ethnicity,gender,email,contact_title
             ,year_started,date_added,validationdate,internal1,dacd,normcompany_type,normcompany_name,normcompany_street,normcompany_city,normcompany_state
             ,normcompany_zip,normcompany_phone,ALL);
  AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
//Now need to update 'rid' numbers on new records
//Base upon ut.Mac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF.seleid := SELF.rcid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST('~temp::seleid::infutor_narb::Ingest_Cache',EXPIRE(Config.PersistExpire));
  EXPORT UpdateStats := SORT(TABLE(AllRecs, {__Tpe,SALT34.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  EXPORT UpdateStatsSrc := SORT(TABLE(AllRecs, {source,__Tpe,SALT34.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
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
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Infutor_NARB.Layouts.Base);
  EXPORT OldRecords := AllRecs(__Tpe=RecordType.Old);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Infutor_NARB.Layouts.Base);
  EXPORT UpdatedRecords := AllRecs(__Tpe=RecordType.Updated);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Infutor_NARB.Layouts.Base);
  EXPORT AllRecords := AllRecs;
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Infutor_NARB.Layouts.Base); // Records in 'pure' format
 
  // Compute field level differences
  IOR := JOIN(OldRecords,InputSourceCounts,left.source=right.source,TRANSFORM(LEFT),LOOKUP); // Only send in old records from sources in this ingest
  Fields.MAC_CountDifferencesByPivot(NewRecords,IOR,((SALT34.StrType)source+'|'+(SALT34.StrType)pid),BadPivs,DC)
  EXPORT FieldChangeStats := DC;
  SHARED S4 := OUTPUT(FieldChangeStats,ALL,NAMED('FieldChangeStats'));
 
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3,S4);
 
END;

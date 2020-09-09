IMPORT STD,SALT311;
EXPORT Release_Ingest(BOOLEAN incremental=FALSE
, DATASET(Release_Layout_BKMortgage) Delta = DATASET([],Release_Layout_BKMortgage)
, DATASET(Release_Layout_BKMortgage) dsBase = Release_In_BKMortgage // Change IN_BKMortgage to change input to ingest process
, DATASET(RECORDOF(BKMortgage.Release_prep_ingest_file))  infile = BKMortgage.Release_prep_ingest_file
) := MODULE
  SHARED NullFile := DATASET([],Release_Layout_BKMortgage); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Release_Layout_BKMortgage;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_first_seen = 0 => le.date_first_seen,
                     (UNSIGNED)le.date_first_seen < (UNSIGNED)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (UNSIGNED)le.date_last_seen < (UNSIGNED)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (UNSIGNED)le.date_vendor_first_reported < (UNSIGNED)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (UNSIGNED)le.date_vendor_last_reported < (UNSIGNED)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.process_date := MAP ( le.__Tpe = 0 => ri.process_date,
                     ri.__Tpe = 0 => le.process_date,
                     (UNSIGNED)le.process_date < (UNSIGNED)ri.process_date => ri.process_date, // Want the highest value
                     le.process_date);
    SELF.source := ri.source; // Derived(NEW)
    SELF.ln_filedate := MAP ( le.__Tpe = 0 => ri.ln_filedate,
                     ri.__Tpe = 0 => le.ln_filedate,
                     (UNSIGNED)le.ln_filedate < (UNSIGNED)ri.ln_filedate => ri.ln_filedate, // Want the highest value
                     le.ln_filedate);
    SELF.bk_infile_type := ri.bk_infile_type; // Derived(NEW)
    SELF.multiplepageimage := ri.multiplepageimage; // Derived(NEW)
    SELF.bkfsimageid := ri.bkfsimageid; // Derived(NEW)
    SELF.mspsvrloan := ri.mspsvrloan; // Derived(NEW)
    SELF.dataentrydate := ri.dataentrydate; // Derived(NEW)
    SELF.dataentryopercode := ri.dataentryopercode; // Derived(NEW)
    SELF.pid := ri.pid; // Derived(NEW)
    SELF.matchedororphan := ri.matchedororphan; // Derived(NEW)
    SELF.deed_pid := ri.deed_pid; // Derived(NEW)
    SELF.sam_pid := ri.sam_pid; // Derived(NEW)
    SELF.assessorparcelnumber_matched := ri.assessorparcelnumber_matched; // Derived(NEW)
    SELF.assessorpropertyfulladd := ri.assessorpropertyfulladd; // Derived(NEW)
    SELF.assessorpropertyunittype := ri.assessorpropertyunittype; // Derived(NEW)
    SELF.assessorpropertyunit := ri.assessorpropertyunit; // Derived(NEW)
    SELF.assessorpropertycity := ri.assessorpropertycity; // Derived(NEW)
    SELF.assessorpropertystate := ri.assessorpropertystate; // Derived(NEW)
    SELF.assessorpropertyzip := ri.assessorpropertyzip; // Derived(NEW)
    SELF.assessorpropertyzip4 := ri.assessorpropertyzip4; // Derived(NEW)
    SELF.assessorpropertyaddrsource := ri.assessorpropertyaddrsource; // Derived(NEW)
    SELF.clnlenderben := ri.clnlenderben; // Derived(NEW)
    SELF.clncurrentlenderben := ri.clncurrentlenderben; // Derived(NEW)
    SELF.DBALenderBen := ri.DBALenderBen; // Derived(NEW)
    SELF.DBACurrentLenderBen := ri.DBACurrentLenderBen; // Derived(NEW)
    SELF.raw_file_name := ri.raw_file_name; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported OR SELF.process_date <> le.process_date OR SELF.ln_filedate <> le.ln_filedate => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle));
  SortIngest0 := SORT(DistIngest0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle, __Tpe, record_id, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle));
  SortBase0 := SORT(DistBase0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle, __Tpe, record_id, LOCAL);
  GroupBase0 := GROUP(SortBase0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle, __Tpe,record_id,LOCAL);
  Group0 := GROUP(Sort0,rectype
             ,documenttype,fipscode,mainaddendum,releaserecdate,releaseeffecdate,mortgagepayoffdate,releasedoc,releasebk,releasepg,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,loannumber,currentlenderben
             ,mers,mersvalidation,currentlenderpool,borrowername,borrmailfulladdress,borrmailunit,borrmailcity,borrmailstate,borrmailzip
             ,borrmailzip4,apn,multiapncode,taxacctid,propertyfulladd,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,vendorsourcecode,hids_recordingflag,hids_docnumber,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,LOCAL, ORDERED, STABLE);
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
  SHARED AllRecs := ORe+NR1+NR(record_id<>0) : PERSIST('~temp::BKMortgage::Release::Ingest_Cache',EXPIRE(BKMortgage.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('ReleaseUpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Release_Layout_BKMortgage);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Release_Layout_BKMortgage);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Release_Layout_BKMortgage);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Release_Layout_BKMortgage); // Records in 'pure' format
 
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

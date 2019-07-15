﻿IMPORT STD,SALT311;
EXPORT AssignUpdate_Ingest(BOOLEAN incremental=FALSE
, DATASET(AssignUpdate_Layout_BKMortgage) Delta = DATASET([],AssignUpdate_Layout_BKMortgage)
, DATASET(AssignUpdate_Layout_BKMortgage) dsBase = AssignUpdate_In_BKMortgage // Change IN_BKMortgage to change input to ingest process
, DATASET(RECORDOF(BKMortgage_Assignment.AssignUpdate_prep_ingest_file))  infile = BKMortgage_Assignment.AssignUpdate_prep_ingest_file
) := MODULE
  SHARED NullFile := DATASET([],AssignUpdate_Layout_BKMortgage); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    AssignUpdate_Layout_BKMortgage;
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
    SELF.clnoriglenderben := ri.clnoriglenderben; // Derived(NEW)
    SELF.clnassignorname := ri.clnassignorname; // Derived(NEW)
    SELF.clnassignee := ri.clnassignee; // Derived(NEW)
    SELF.clnborrowername := ri.clnborrowername; // Derived(NEW)
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
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource));
  SortIngest0 := SORT(DistIngest0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource, __Tpe, record_id, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource));
  SortBase0 := SORT(DistBase0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource, __Tpe, record_id, LOCAL);
  GroupBase0 := GROUP(SortBase0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource, __Tpe,record_id,LOCAL);
  Group0 := GROUP(Sort0,rectype
             ,documenttype,fipscode,mersindicator,mainaddendum,assigrecdate,assigeffecdate,assigdoc,assigbk,assigpg,multiplepageimage
             ,bkfsimageid,origdotrecdate,origdotcontractdate,origdotdoc,origdotbk,origdotpg,origlenderben,origloanamnt,assignorname,loannumber
             ,assignee,mers,mersvalidation,assigneepool,mspsvcrloan,borrowername,apn,multiapncode,taxacctid,propertyfulladd
             ,propertyunit,propertycity,propertystate,propertyzip,propertyzip4,dataentrydate,dataentryopercode,vendorsourcecode,hids_recordingflag,hids_docnumber
             ,transfercertificateoftitle,hi_condo_cpr_hpr,hi_situs_unit_number,hids_previous_docnumber,prevtransfercertificateoftitle,pid,matchedororphan,deed_pid,sam_pid,assessorparcelnumber_matched
             ,assessorpropertyfulladd,assessorpropertyunittype,assessorpropertyunit,assessorpropertycity,assessorpropertystate,assessorpropertyzip,assessorpropertyzip4,assessorpropertyaddrsource,LOCAL, ORDERED, STABLE);
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
  SHARED AllRecs := ORe+NR1+NR(record_id<>0) : PERSIST('~temp::BKMortgage_Assignment::Update_Ingest_Cache',EXPIRE(BKMortgage_Assignment.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,AssignUpdate_Layout_BKMortgage);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,AssignUpdate_Layout_BKMortgage);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,AssignUpdate_Layout_BKMortgage);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,AssignUpdate_Layout_BKMortgage); // Records in 'pure' format
 
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

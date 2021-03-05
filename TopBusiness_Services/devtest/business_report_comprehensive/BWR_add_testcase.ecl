// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, iesp, ebr, TopBusiness_Services, STD;

my_query := 'TopBusiness_Services.BusinessReportComprehensive';
svc_layout := TopBusiness_Services.devtest.business_report_comprehensive.layout;

k := ebr.Key_0010_Header_linkids.key;
INDUSTRY_CLASS := 'OTHER';
DRM := '0000000000000100000000001000000000000000';
DPM := '110001000000000000000000000100';

BUCKET_SZ := 10;
brecs_raw_a := DEDUP(SORT(CHOOSEN(PULL(k(ultid>10000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_b := DEDUP(SORT(CHOOSEN(PULL(k(ultid>200000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_c := DEDUP(SORT(CHOOSEN(PULL(k(ultid>300000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);

RECORDOF(brecs_raw_a) newRec(INTEGER ultid, INTEGER orgid, INTEGER seleid) := TRANSFORM
  SELF.ultid := ultid;
  SELF.orgid := orgid;
  SELF.seleid := seleid;
  SELF.date_last_seen := (STRING)STD.Date.Today();
  SELF := [];
END;
brecs_raw_handpicked := 
   DATASET([newRec(4672418, 4672418, 4672418)])
  +DATASET([newRec(7678100, 7678100, 33222566)])
  +DATASET([newRec(54041187, 54041187, 54041187)]) // file_number: 747522778 - More than 10000 match candidates in keyed join 506 for row (in Project 264)
  +DATASET([newRec(7678100, 7678100, 33222566)])
  +DATASET([newRec(6355495, 6355495, 11417840)])
  +DATASET([newRec(33237222, 33237222, 33237222)]) // file_number: 414455318 - More than 10000 match candidates in keyed join 474 for row  (in Project 264)
  +DATASET([newRec(72869954, 72869954, 72869954 )])
  +DATASET([newRec(114157757, 114157757, 114157757)])
  +DATASET([newRec(5941568, 5941568, 5941568 )]) // file _number: 702843791 - (some) file numbers: 2013045526, 2013042828, 2013040174 - More than 10000 match candidates in keyed join 474 for row  (in Project 264)
  +DATASET([newRec(33237222, 33237222, 33237222)])
  ;

brecs_a := CHOOSEN(SORT(brecs_raw_a, -date_last_seen), BUCKET_SZ);
brecs_b := CHOOSEN(SORT(brecs_raw_b, -date_last_seen), BUCKET_SZ);
brecs_c := CHOOSEN(SORT(brecs_raw_c, -date_last_seen), BUCKET_SZ);
// brecs := brecs_a + brecs_b + brecs_c + brecs_raw_handpicked;
brecs := brecs_raw_handpicked;

iesp.TopBusinessReport.t_TopBusinessReportBy xtReportBy(RECORDOF(brecs) L) := TRANSFORM
  SELF.BusinessIDs.UltID := L.ultid;
  SELF.BusinessIDs.OrgID := L.orgid;
  SELF.BusinessIDs.SeleID := L.seleid;
  SELF := [];
END;

esdl_recs_ebr := PROJECT(brecs, xtReportBy(LEFT)); // ER = EBR source
esdl_recs_all_sources := PROJECT(brecs, xtReportBy(LEFT));
esdl_recs_all := esdl_recs_all_sources;
// esdl_recs_all := esdl_recs_ebr + esdl_recs_all_sources;

esdl_recs := PROJECT(esdl_recs_all, TRANSFORM(iesp.TopBusinessReport.t_TopBusinessReportRequest,
  SELF.ReportBy := LEFT;
  SELF.User.GLBPurpose := (STRING) (COUNTER*RANDOM() % 7);
  SELF.User.DLPurpose := (STRING) (COUNTER*RANDOM() % 7);
  SELF.User.DataRestrictionMask := '0000000000000000000000000000000000000000';
  SELF.User.DataPermissionMask :=  '1111111111111111111111111111111111111111';
  SELF.Options.IncludeExperianBusinessReports := 1;
  SELF := [];
  ));
esdl_recs;

svc_layout.request wrapESDL(iesp.TopBusinessReport.t_TopBusinessReportRequest L) := TRANSFORM
  SELF.TopBusinessReportRequest := DATASET(L);
END;

dev_regression.layouts.testcase xt(iesp.TopBusinessReport.t_TopBusinessReportRequest L, INTEGER c) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'test EBR join limits #'+c;
  SELF.request_xml := dev_regression.utils.wrapTOXML(ROW(wrapESDL(L)));
END;

testcases := PROJECT(esdl_recs, xt(LEFT, COUNTER));
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases, 'EBR regression');


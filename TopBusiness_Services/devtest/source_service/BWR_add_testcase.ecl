// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, iesp, ebr, TopBusiness_Services;

my_query := 'TopBusiness_Services.SourceService';
svc_layout := TopBusiness_Services.devtest.source_service.layout;

k := ebr.Key_0010_Header_linkids.key;
INDUSTRY_CLASS := 'OTHER';
DRM := '0000000000000100000000001000000000000000';
DPM := '110001000000000000000000000100';

BUCKET_SZ := 10;
brecs_raw_a := DEDUP(SORT(CHOOSEN(PULL(k(ultid>10000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_b := DEDUP(SORT(CHOOSEN(PULL(k(ultid>200000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_c := DEDUP(SORT(CHOOSEN(PULL(k(ultid>300000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);

brecs_a := CHOOSEN(SORT(brecs_raw_a, -date_last_seen), BUCKET_SZ);
brecs_b := CHOOSEN(SORT(brecs_raw_b, -date_last_seen), BUCKET_SZ);
brecs_c := CHOOSEN(SORT(brecs_raw_c, -date_last_seen), BUCKET_SZ);
brecs := brecs_a + brecs_b + brecs_c;
brecs;

iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocBy xtSearchBy(RECORDOF(brecs) L, STRING src = '') := TRANSFORM
  SELF.BusinessIDs.UltID := L.ultid;
  SELF.BusinessIDs.OrgID := L.orgid;
  SELF.BusinessIDs.SeleID := L.seleid;
  SELF.Source := IF(src <> '', src, ''); //'ER'; // <-- EBR
  SELF.Section := IF(src = '', 'Source', ''); // all sources
  SELF := [];
END;

esdl_recs_ebr := PROJECT(brecs, xtSearchBy(LEFT, 'ER')); // ER = EBR source
esdl_recs_all_sources := PROJECT(brecs, xtSearchBy(LEFT));
esdl_recs_all := esdl_recs_all_sources;
// esdl_recs_all := esdl_recs_ebr + esdl_recs_all_sources;

esdl_recs := PROJECT(esdl_recs_all, TRANSFORM(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest,
  SELF.SearchBy := LEFT;
  SELF.User.GLBPurpose := (STRING) (COUNTER*RANDOM() % 7);
  SELF.User.DLPurpose := (STRING) (COUNTER*RANDOM() % 7);
  SELF.User.DataRestrictionMask := '0000000000000100000000001000000000000000';
  SELF.User.DataPermissionMask := '110001000000000000000000000100';
  SELF.Options.SourceDocFetchLevel := 'S';
  SELF := [];
  ));
esdl_recs;

svc_layout.request wrapESDL(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest L) := TRANSFORM
  SELF.TopBusinessSourceDocRequest := DATASET(L);
END;

dev_regression.layouts.testcase xt(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest L, INTEGER c) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'Random all sources #'+c;
  SELF.request_xml := dev_regression.utils.wrapTOXML(ROW(wrapESDL(L)));
END;

testcases := PROJECT(esdl_recs, xt(LEFT, COUNTER));
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases, 'random, all sources');


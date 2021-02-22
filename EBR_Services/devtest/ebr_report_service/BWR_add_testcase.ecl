// Use it as an example, modify as you wish
IMPORT dev_regression, EBR, EBR_Services, Gateway;

my_query := 'EBR_Services.EbrReportService';
svc_layout := EBR_Services.devtest.ebr_report_service.layout;
in_rec := svc_layout.request;

BUCKET_SZ := 10;
brecs_raw_a := DEDUP(SORT(CHOOSEN(PULL(EBR.Key_0010_Header_BDID(bdid>10000)), 1000), bdid), bdid);
brecs_raw_b := DEDUP(SORT(CHOOSEN(PULL(EBR.Key_0010_Header_BDID(bdid>20000)), 1000), bdid), bdid);
brecs_raw_c := DEDUP(SORT(CHOOSEN(PULL(EBR.Key_0010_Header_BDID(bdid>30000)), 1000), bdid), bdid);

brecs_a := CHOOSEN(SORT(brecs_raw_a, -process_date_last_seen), BUCKET_SZ);
brecs_b := CHOOSEN(SORT(brecs_raw_b, -process_date_last_seen), BUCKET_SZ);
brecs_c := CHOOSEN(SORT(brecs_raw_c, -process_date_last_seen), BUCKET_SZ);

in_rec patch(RECORDOF(brecs_a) l, string glb, string dppa, boolean take_bdid, boolean take_filenumber) := TRANSFORM
  SELF.dppapurpose := dppa;
  SELF.glbpurpose := glb;
  SELF.bdid := IF(take_bdid, (STRING)l.bdid, '');
  SELF.filenumber := if(take_filenumber, l.file_number, '');
END;

patch_a := PROJECT(brecs_a, patch(LEFT, '3', '1', TRUE, FALSE));
patch_b := PROJECT(brecs_b, patch(LEFT, '2', '3', TRUE, TRUE));
patch_c := PROJECT(brecs_c, patch(LEFT, '1', '1', FALSE, TRUE));
patch_recs := SORT(patch_a + patch_b + patch_c, filenumber);

// xml samples
xml_in := DATASET(FROMXML(in_rec, '<ebr_services.ebrreportserviceRequest><bdid>33161885</bdid><dppapurpose>3</dppapurpose><glbpurpose>5</glbpurpose><filenumber></filenumber></ebr_services.ebrreportserviceRequest>'));

dev_regression.layouts.testcase toTestcase(in_rec L, INTEGER c) := TRANSFORM
  // SELF.tid := c;
  SELF.query := my_query;
  SELF.short_description := 'random #'+c;
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases := project(patch_recs, toTestcase(LEFT, COUNTER));

dev_regression.bucket().add(testcases);

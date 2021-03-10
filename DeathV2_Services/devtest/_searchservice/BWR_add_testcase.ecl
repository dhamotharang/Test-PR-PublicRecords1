IMPORT deathv2_services, dev_regression;

my_query := 'deathv2_services.searchservice';
svc_layout := deathv2_services.devtest._searchservice.layout;

xml_in :=
DATASET(FROMXML(svc_layout.request, '<deathv2_services.searchservice></deathv2_services.searchservice>')) +
DATASET(FROMXML(svc_layout.request, '<deathv2_services.searchservice></deathv2_services.searchservice>'));

svc_layout.request xt(svc_layout.request L) := TRANSFORM
  SELF := L;
END;

xml_recs := PROJECT(DEDUP(xml_in, RECORD, ALL), xt(LEFT));

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'verify deep dive hits';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));
testcases;
dev_regression.bucket().add(testcases, 'deep dive regression');

#WORKUNIT('name', 'bwr add testcases');

IMPORT dev_regression, ContactCard;

my_query := 'ContactCard.ReportService';
svc_layout := ContactCard.devtest._ReportService.layout;

svc_layout.request xt(string _did) := TRANSFORM
  SELF.did := _did;
	SELF.datapermissionmask := '1111111111111111111111111111111111111111111';
	SELF.datarestrictionmask := '000000000000000000000000000000000000000000';
	SELF.dppapurpose := '1';
	SELF.glbpurpose := '2';
	SELF.includerelatives := '1';
	SELF.includeassociates := '1';
	SELF.includeneighbors := '1';
	SELF.includephonesfeedback := '1';
	SELF.includephonesplus := '1';
	SELF.includephonesplusforrna := '1';
  SELF := [];
END;
xml_recs_bydid := dataset([xt('100')]);

xml_in :=
   DATASET(FROMXML(svc_layout.request, '<contactcard.reportservice></contactcard.reportservice>'))
   + DATASET(FROMXML(svc_layout.request, '<contactcard.reportservice></contactcard.reportservice>'))
   ;

svc_layout.request xt_in(svc_layout.request L) := TRANSFORM
  SELF := L;
END;

xml_recs_in := PROJECT(DEDUP(xml_in, RECORD, ALL), xt_in(LEFT));

xml_recs := xml_recs_in + xml_recs_bydid;

dev_regression.layouts.testcase xtTc(svc_layout.request xml_req) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'verify Finder&Addresses section';
  SELF.request_xml := dev_regression.utils.wrapTOXML(xml_req);
END;

testcases := PROJECT(xml_recs, xtTc(LEFT));

dev_regression.bucket().add(testcases, 'Finder/Addresses sections regression');

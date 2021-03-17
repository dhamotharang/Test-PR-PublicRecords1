// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, doxie_cbrs, ebr;

my_query := 'doxie_cbrs.Business_Report_Service';
svc_layout := doxie_cbrs.devtest.business_report_service.layout;

k := ebr.Key_0010_Header_linkids.key;
INDUSTRY_CLASS := 'OTHER';
DRM := '0000000000000100000000001000000000000000';
DPM := '110001000000000000000000000100';

BUCKET_SZ := 15;
brecs_raw_a := DEDUP(SORT(CHOOSEN(PULL(k(ultid>10000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_b := DEDUP(SORT(CHOOSEN(PULL(k(ultid>200000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);
brecs_raw_c := DEDUP(SORT(CHOOSEN(PULL(k(ultid>300000)), 1000), ultid, orgid, seleid), ultid, orgid, seleid);

brecs_a := CHOOSEN(SORT(brecs_raw_a, -date_last_seen), BUCKET_SZ);
brecs_b := CHOOSEN(SORT(brecs_raw_b, -date_last_seen), BUCKET_SZ);
brecs_c := CHOOSEN(SORT(brecs_raw_c, -date_last_seen), BUCKET_SZ);
brecs := brecs_a + brecs_b + brecs_c;
brecs;

svc_layout.request xt1(RECORDOF(brecs) L, INTEGER c) := TRANSFORM
  SELF.glbpurpose := (STRING) (c*RANDOM() % 7);
  SELF.dppapurpose := (STRING) (c*RANDOM() % 7);
  SELF.industryclass := MAP(
    c*RANDOM() % 6 = 1 => 'CNSMR',
    c*RANDOM() % 6 = 2 => 'UTILI', 
    ''); 
  SELF.applicationtype :=  MAP(
    c*RANDOM() % 6 = 1 => 'LE', 
    c*RANDOM() % 6 = 2 => 'CON', 
    ''); // Suppress.Constants.ApplicationTypes
  SELF.datapermissionmask := '110001000000000000000000000100';
  SELF.datarestrictionmask := '0000000000000000000000000000000000000000';
  SELF.bdid := (STRING) L.bdid;
  SELF.selectindividually := TRUE;
  SELF.alwayscompute := FALSE;
  // all random selections below...
  SELF.include_bus_dppa := c*RANDOM()%10 <= 2;
  SELF.includeaddressvariations := c*RANDOM()%10 <= 2;
  SELF.includeaircrafts := c*RANDOM()%10 <= 1;
  SELF.includeassociatedpeople := c*RANDOM()%10 <= 4;
  bkVersion := (INTEGER)(c*RANDOM()%5);
  SELF.bankruptcyversion := '2';
  SELF.includebankruptcies := FALSE;
  SELF.includebankruptciesv2 := c*RANDOM()%10 <= 3;
  SELF.includebusinessassociates := c*RANDOM()%10 <= 5;
  SELF.includebusinessregistrations := c*RANDOM()%10 <= 4;
  SELF.includecompanyidnumbers :=  c*RANDOM()%10 <= 3;
  SELF.includecompanyprofile :=  FALSE;
  SELF.includecompanyprofilev2 :=  c*RANDOM()%10 <= 4;
  SELF.includecompanyverification := c*RANDOM()%10 <= 2;
  SELF.includedca := c*RANDOM()%10 <= 1;
  SELF.includedunbradstreetrecords := c*RANDOM()%10 <= 2;
  SELF.includeexecutives := c*RANDOM()%10 <= 5;
  SELF.includeexperianbusinessreports := c*RANDOM()%10 <= 3;
  SELF.includeforeclosures := c*RANDOM()%10 <= 2;
  SELF.includeindustryinformation := c*RANDOM()%10 <= 2;
  SELF.includeinternetdomains := c*RANDOM()%10 <= 2;
  SELF.includeirs5500 := c*RANDOM()%10 <= 3;
  SELF.includeliensjudgments := FALSE;
  SELF.includeliensjudgmentsv2 := c*RANDOM()%10 <= 6;
  SELF.includemotorvehicles := FALSE;
  SELF.includemotorvehiclesv2 := c*RANDOM()%10 <= 3;
  SELF.includenamevariations := c*RANDOM()%10 <= 4;
  SELF.includenoticeofdefaults := c*RANDOM()%10 <= 5;
  SELF.includephonesummary := c*RANDOM()%10 <= 6;
  SELF.includephonevariations := c*RANDOM()%10 <= 6;
  SELF.includeprofessionallicenses := c*RANDOM()%10 <= 3;
  SELF.includeproperties := FALSE;
  SELF.includepropertiesv2 := c*RANDOM()%10 <= 3;
  SELF.includeregisteredagents := c*RANDOM()%10 <= 2;
  SELF.includesales := c*RANDOM()%10 <= 4;
  SELF.includesanctions := c*RANDOM()%10 <= 6;
  SELF.includesourcecounts := c*RANDOM()%10 <= 4;
  SELF.includesourceflags := c*RANDOM()%10 <= 4;
  SELF.includeuccfilings := FALSE;
  SELF.includeuccfilingsv2 := c*RANDOM()%10 <= 4;
  SELF.includewatercrafts := c*RANDOM()%10 <= 1;

  SELF := [];
END;
recs := PROJECT(brecs, xt1(LEFT, COUNTER));
recs;

dev_regression.layouts.testcase xt2(svc_layout.request L, INTEGER c) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'Random by bdid #'+c;
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(recs, xt2(LEFT, COUNTER));
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases, 'Random searches by bdid');


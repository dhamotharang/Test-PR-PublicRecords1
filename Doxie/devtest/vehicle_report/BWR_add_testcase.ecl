// Use it as an example, modify as you wish
IMPORT dev_regression, doxie;

my_query := 'doxie.vehicle_report';
svc_layout := doxie.devtest.vehicle_report.layout;

ds_in := DATASET([
  {002137646927},
  {000148526035},
  {000280396063},
  {000544098141},
  {000366781935},
  {002120248362},
  {1579923151},
  {000280396063},
  {31488595704},
  {1357376010}
], {unsigned6 did});

svc_layout.request SetValues(ds_in L, string glb, string dppa, string dpm, string drm, string ssn_mask, string dl_mask) := TRANSFORM
  SELF.did := (string)L.did;
	SELF.glbpurpose := glb;
	SELF.dppapurpose := dppa;
	SELF.datapermissionmask := dpm;
	SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF := [];
END;

ds_1 := PROJECT(ds_in, SetValues(LEFT, '1', '1', '1111111111111111111111111111111', '0000000000000000000000000000000', '', ''));
ds_2 := PROJECT(ds_in, SetValues(LEFT, '2', '7', '1111111111111111111111111111111', '0000000000000000000000000000000', '', ''));
ds_3 := PROJECT(ds_in, SetValues(LEFT, '0', '0', '1111111111111111111111111111111', '0000000000000000000000000000000', '', ''));
ds_4 := PROJECT(ds_in, SetValues(LEFT, '1', '1', '0000000000000000000000000000000', '1111111111111111111111111111111', 'first5', ''));
ds_5 := PROJECT(ds_in, SetValues(LEFT, '1', '1', '0000000000000000000000000000000', '1111111111111111111111111111111', 'last4', 'true'));
ds_6 := PROJECT(ds_in, SetValues(LEFT, '0', '0', '0000000000000000000000000000000', '1111111111111111111111111111111', '', ''));

xml_recs := ds_1 + ds_2 + ds_3 + ds_4 + ds_5 + ds_6;

dev_regression.layouts.testcase toTestCase(svc_layout.request L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := '';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));

// OUTPUT(xml_recs, NAMED('xml_recs'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');

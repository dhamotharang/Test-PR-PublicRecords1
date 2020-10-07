// Use it as an example, modify as you wish
IMPORT dev_regression, doxie, iesp;

my_query := 'vehicleV2_services.VehicleRegSearchService';
xml_in_rec := $.layout.request;

// random LexIds
ds_in := DATASET([
  {881401},  {2007278},  {3126189},  {8090500},  {9092136},  {10187374},  {11548310},  {17442203},  {17800638},  {18703595},
  {29151918},  {29458494},  {37432196},  {38622622},  {40005125},  {41440681},  {45295672},  {46260201},  {48637162},  {52768950}
], {unsigned6 did});

xml_in_rec SetValues(ds_in L, string glb, string dppa, string dpm, string drm, string ssn_mask, string dl_mask, string ic) := TRANSFORM
  SELF.did := (string) L.did;
	SELF.glbpurpose := glb;
	SELF.dppapurpose := dppa;
	SELF.datapermissionmask := dpm;
	SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF.industryclass := ic;
  SELF.motorvehicleregistrationsearchrequest.user.glbpurpose := glb;
  SELF.motorvehicleregistrationsearchrequest.user.dlpurpose := dppa;
  SELF.motorvehicleregistrationsearchrequest.user.datapermissionmask := dpm;
  SELF.motorvehicleregistrationsearchrequest.user.datarestrictionmask := drm;
  SELF.motorvehicleregistrationsearchrequest.user.dlmask := dl_mask = 'true';
  SELF.motorvehicleregistrationsearchrequest.user.ssnmask := ssn_mask;
  SELF.motorvehicleregistrationsearchrequest.user.ssnmaskingon := TRUE;
  SELF := [];
END;

ds_1 := PROJECT(ds_in, SetValues(LEFT, '1', '1', '11111111111111111111111111111111111111111111', '00000000000000000000000000000000000000000000', 'first5', '', ''));
ds_2 := PROJECT(ds_in, SetValues(LEFT, '2', '7', '00000000000000000000000000000000000000000000', '11111111111111111111111111111111111111111111', '', '', 'CNSMR'));
ds_3 := PROJECT(ds_in, SetValues(LEFT, '0', '0', '11111111111111111111111111111111111111111111', '00000000000000000000000000000000000000000000', '', 'true', 'UTILI'));

xml_recs := ds_1 + ds_2 + ds_3;

dev_regression.layouts.testcase toTestCase(xml_in_rec L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := '';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases := PROJECT(xml_recs, toTestCase(LEFT));

dev_regression.bucket().add(testcases, 'compliance regression');

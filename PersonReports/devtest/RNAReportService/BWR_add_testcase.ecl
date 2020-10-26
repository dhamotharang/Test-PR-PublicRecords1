// Use it as an example, modify as you wish
IMPORT dev_regression, doxie, dx_BestRecords, iesp, PersonReports;

my_query := 'PersonReports.RNAReportService';
svc_layout := PersonReports.devtest.RNAReportService.layout;

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

// Get best data: need an address
mod_access := MODULE(doxie.IDataAccess)
  EXPORT unsigned1 glb := 1;
  EXPORT unsigned1 dppa := 1;
  EXPORT string DataPermissionMask := '111111111111111111111111111111111111111111111111111111111111';
  EXPORT string DataRestrictionMask := '000000000000000000000000000000000000000000000000000000000000';
  EXPORT string5 industry_class := '';
  EXPORT boolean suppress_dmv := FALSE;
END;
perms := dx_BestRecords.Functions.get_perm_type_idata(mod_access, checkRNA := TRUE);
ds_best := dx_BestRecords.get(ds_in, did, perms);

//convert to ESDL
iesp.rnareport.t_RNAReportRequest SetValues(
                                    dx_BestRecords.layout_best L,
                                    string glb, string dppa, string dpm, string drm) := TRANSFORM

  SELF.User.GLBPurpose := glb;
  SELF.User.DLPurpose := dppa;
  SELF.User.DataRestrictionMask := drm;
  SELF.User.DataPermissionMask := dpm;

  SELF.Options.IncludeAssociates := TRUE;
  SELF.Options.IncludeRelatives := TRUE;
  SELF.Options.IncludeNeighbors := TRUE;

  SELF.ReportBy.UniqueId := (string)L.did;
  SELF.ReportBy.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                           L.suffix, L.unit_desig, L.sec_range, L.city_name,
                           L.st, L.zip, '',  '', '');
  // SELF.did := (string)L.did;
	// SELF.glbpurpose := glb;
	// SELF.dppapurpose := dppa;
	// SELF.datapermissionmask := dpm;
	// SELF.datarestrictionmask := drm;
  SELF := [];
END;

//Set different permissions; I'm interested only in variations of glb/dppa to check RNA
ds_1 := PROJECT(ds_best, SetValues(LEFT, '1', '1', '1111111111111111111111111111111', '0000000000000000000000000000000'));
ds_2 := PROJECT(ds_best, SetValues(LEFT, '2', '7', '1111111111111111111111111111111', '0000000000000000000000000000000'));
ds_3 := PROJECT(ds_best, SetValues(LEFT, '0', '0', '1111111111111111111111111111111', '0000000000000000000000000000000'));
ds_4 := PROJECT(ds_best, SetValues(LEFT, '3', '3', '1111111111111111111111111111111', '0000000000000000000000000000000'));

esdl_recs := ds_1 + ds_2 + ds_3 + ds_4;

svc_layout.request wrapESDL(iesp.rnareport.t_RNAReportRequest L) := TRANSFORM
  SELF.rnareportrequest := DATASET(L);
END;

dev_regression.layouts.testcase toTestCase(iesp.rnareport.t_RNAReportRequest L) := TRANSFORM
  _row := ROW(wrapESDL(L));
  SELF.query := my_query;
  SELF.short_description := 'test "checkRNA" glb for fetching neighbor\'s';
  SELF.request_xml := dev_regression.utils.wrapTOXML(_row);
END;

testcases := PROJECT(esdl_recs, toTestCase(LEFT));

// OUTPUT(esdl_recs, NAMED('xml_recs'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');

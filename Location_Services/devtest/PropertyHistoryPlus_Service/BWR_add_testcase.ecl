// Use it as an example, modify as you wish
IMPORT dev_regression, doxie, dx_BestRecords, iesp, STD;

my_query := 'Location_Services.PropertyHistoryPlus_Service';
svc_layout := $.layout.request;

//Generate random test cases
ds_in := DATASET([
  {3}, {469}, {3420}, {16555}, {32954},
  {45018}, {70076}, {148526035}, {280396063}, {366781935},
  {544098141}, {1357376010}, {1579923151},  {2071082680}, {2120248362},
  {2137646927}, {2349570049}, {2682608577}, {31488595704}, {112486800817}
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
perms := dx_BestRecords.Functions.get_perm_type_idata(mod_access, checkRNA := FALSE);
ds_best := dx_BestRecords.get(ds_in, did, perms);
// OUTPUT(ds_best, NAMED('ds_best'));

//convert to ESDL
$.layout.esdl_request SetQueryInput(dx_BestRecords.layout_best L) := TRANSFORM
  SELF.User := [];
  SELF.Options := [];
  SELF.ReportBy.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                           L.suffix, L.unit_desig, L.sec_range, L.city_name,
                           L.st, L.zip, '',  '', '');
  SELF := [];
END;
ds_sample := PROJECT(ds_best, SetQueryInput(LEFT));

//Create variations of compliance values
$.layout.request SetValues($.layout.esdl_request L,
      string glb, string dppa, string dpm, string drm,
      string ssn_mask, string dlmask, string dobmask, string ic,
      string excludedmvpii = '', string ignoreFares = '', string ignoreFidelity = '',
      string lnbranded = '', string probation = '') := TRANSFORM

  iesp.share.t_User xUser () := TRANSFORM
      SELF.GLBPurpose := glb;
      SELF.DLPurpose :=dppa;
      SELF.IndustryClass := ic;
      SELF.SSNMask := ssn_mask;
      SELF.DOBMask := dobmask;
      SELF.ExcludeDMVPII := ((integer)excludedmvpii) > 0;
      SELF.DLMask := STD.Str.ToLowerCase(dlmask) = 'true';
      SELF.DataRestrictionMask := drm;
      SELF.DataPermissionMask := dpm;
      SELF.LnBranded := STD.Str.ToLowerCase(lnbranded) = 'true';
      SELF := [];
  END;

  $.layout.esdl_request xInput() := TRANSFORM
    SELF.User := Row(xUser());
    SELF.Options := L.Options;
    SELF.ReportBy := L.ReportBy;
    SELF.remotelocations := [];
    SELF.servicelocations := [];
  END;

  SELF.PropertyHistoryPlusReportRequest := DATASET([xInput()]);

	SELF.glbpurpose := glb;
	SELF.dppapurpose :=dppa;
	SELF.datapermissionmask := dpm;
	SELF.datarestrictionmask := drm;

  SELF.ssnmask := ssn_mask;
  SELF.dlmask := dlmask;
  SELF.dobmask := dobmask;
  SELF.industryclass := ic;

  SELF.excludedmvpii := excludedmvpii;
  SELF.ignorefares := ignoreFares;
  SELF.ignorefidelity := ignoreFidelity;

  SELF.lnbranded := lnbranded;
  SELF.probationoverride := probation;
  // string  applicationtype;
  // string  intendeduse;
  // string  includeminors;
  SELF := [];

END;

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, 'first5', '',  'day',   ''));
ds_2 := PROJECT(ds_sample, SetValues(LEFT, '2', '7', mask_ones, mask_zero, 'first5', '1', 'year',  '', '1'));
ds_3 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '1', 'month', 'UTILI'));
ds_4 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '',  '',      'CNSMR', '1'));
ds_5 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',     '1', 'true'));
ds_6 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',     '1', 'true', 'true'));
ds_7 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',        ,       ,       , 'true'));
ds_8 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  '',       '',        ,       ,       , 'true', 'true'));

xml_recs := ds_1 + ds_2 + ds_3 + ds_4 + ds_5 + ds_6 + ds_7 + ds_8;

dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_variations := PROJECT(xml_recs, toTestCase(LEFT));

// Set default values
$.layout.request_defaults SetDefaultValues($.layout.esdl_request L) := TRANSFORM
  $.layout.esdl_request xInput() := TRANSFORM
    SELF.User := [];
    SELF.Options := L.Options;
    SELF.ReportBy := L.ReportBy;
    SELF.remotelocations := [];
    SELF.servicelocations := [];
  END;
  SELF.PropertyHistoryPlusReportRequest := DATASET([xInput()]);
END;
ds_default := PROJECT(ds_sample, SetDefaultValues(LEFT));

dev_regression.layouts.testcase toTestCaseDefaults($.layout.request_defaults L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance: defaults';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases_def := PROJECT(ds_default, toTestCaseDefaults(LEFT));

testcases := testcases_variations + testcases_def;

// OUTPUT(xml_recs, NAMED('xml_recs'), ALL);
// OUTPUT(ds_default, NAMED('ds_default'));
dev_regression.bucket().add(testcases, 'compliance regression');

// Use it as an example, modify as you wish
IMPORT dev_regression;

my_query := 'DueDiligence.DueDiligence_PersonRptService';

in_rec := $.layout.request;

xml_in :=
//example: input as it appears in roxie logs
DATASET(FROMXML(in_rec, '<DueDiligence.DueDiligence_PersonRptService><DOBMask_Overload>NONE</DOBMask_Overload><_QueryId/><GLBPurpose>11</GLBPurpose><disallowtarguseid3220>0</disallowtarguseid3220><dlmask>0</dlmask><ssnmask>NONE</ssnmask><_GCID>111111</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><duediligencepersonreportrequest><row><User><OutcomeTrackingOptOut>0</OutcomeTrackingOptOut><SSNMaskingOn>0</SSNMaskingOn><DLMaskingOn>0</DLMaskingOn><GLBPurpose>11</GLBPurpose><LogAsFunction>cp_DDPerReport</LogAsFunction><DLMask>0</DLMask><CompanyId>111111</CompanyId><ExcludeDMVPII>1</ExcludeDMVPII><DLPurpose>3</DLPurpose><DataRestrictionMask>0000000040000100000000000000000000000000</DataRestrictionMask><ApplicationType>RSKM</ApplicationType><AllowRoamingBypass>0</AllowRoamingBypass><IndustryClass>OTHER</IndustryClass><GCID>0</GCID><LnBranded>0</LnBranded><TestDataEnabled>0</TestDataEnabled><DeathMasterPurpose>00</DeathMasterPurpose><DebitUnits>0</DebitUnits><ReferenceCode>287305650607</ReferenceCode><ArchiveOptIn>0</ArchiveOptIn><MaxWaitSeconds>217</MaxWaitSeconds><DataPermissionMask>110001000000000000001000000000</DataPermissionMask><SourceCode>243</SourceCode><NonSubjectSuppression2>0</NonSubjectSuppression2></User><Options><FBOPIncludeLexIDPrimaryDOBYear>0</FBOPIncludeLexIDPrimaryDOBYear><DisplayText>0</DisplayText><Encrypt>0</Encrypt><HistoryDate><Year>2021</Year><Day>16</Day><Month>04</Month></HistoryDate><Blind>0</Blind><FBOPDateToleranceYearsPrior>0</FBOPDateToleranceYearsPrior><IncludeSpecialAttributes>Online</IncludeSpecialAttributes><FBOPIncludeNicknames>0</FBOPIncludeNicknames><FBOPDOBNumberOfYearsRadius>0</FBOPDOBNumberOfYearsRadius><FBOPIncludeExactInputLastName>0</FBOPIncludeExactInputLastName><FBOPNameOrderSearched>0</FBOPNameOrderSearched><FBOPDateTolerance>0</FBOPDateTolerance><FBOPIncludeDOBYearRadius>0</FBOPIncludeDOBYearRadius></Options><ReportBy><Person><LexID>1</LexID></Person></ReportBy></row></duediligencepersonreportrequest><DataRestrictionMask>0000000040000100000000000000000000000000</DataRestrictionMask><_ReferenceCode>287305650607</_ReferenceCode><ApplicationType>RSKM</ApplicationType><usage>0111000300050000</usage><IndustryClass>OTHER</IndustryClass><DPPAPurpose>3</DPPAPurpose><testdataenabled>0</testdataenabled><dobmask>NONE</dobmask><DeathMasterPurpose>00</DeathMasterPurpose><DataPermissionMask>110001000000000000001000000000</DataPermissionMask><SSNMask_Overload>NONE</SSNMask_Overload><DLMask_Overload>0</DLMask_Overload></DueDiligence.DueDiligence_PersonRptService>')) +
DATASET(FROMXML(in_rec, '<DueDiligence.DueDiligence_PersonRptService><DOBMask_Overload>NONE</DOBMask_Overload><_QueryId/><disallowtarguseid3220>1</disallowtarguseid3220><dlmask>0</dlmask><ssnmask>None</ssnmask><_GCID>111111</_GCID><ExcludeDMVPII>1</ExcludeDMVPII><duediligencepersonreportrequest><row><User><OutcomeTrackingOptOut>0</OutcomeTrackingOptOut><DLMaskingOn>0</DLMaskingOn><SSNMaskingOn>0</SSNMaskingOn><GCID>0</GCID><LnBranded>0</LnBranded><DLMask>0</DLMask><ExcludeDMVPII>1</ExcludeDMVPII><TestDataEnabled>0</TestDataEnabled><DebitUnits>0</DebitUnits><ArchiveOptIn>0</ArchiveOptIn><MaxWaitSeconds>0</MaxWaitSeconds><AllowRoamingBypass>0</AllowRoamingBypass><NonSubjectSuppression2>0</NonSubjectSuppression2></User><Options><FBOPDOBNumberOfYearsRadius>0</FBOPDOBNumberOfYearsRadius><DisplayText>0</DisplayText><FBOPIncludeDOBYearRadius>0</FBOPIncludeDOBYearRadius><Encrypt>0</Encrypt><FBOPDateTolerance>0</FBOPDateTolerance><Blind>0</Blind><IncludeSpecialAttributes>None</IncludeSpecialAttributes><FBOPDateToleranceYearsPrior>0</FBOPDateToleranceYearsPrior><FBOPIncludeExactInputLastName>0</FBOPIncludeExactInputLastName><FBOPNameOrderSearched>0</FBOPNameOrderSearched><FBOPIncludeNicknames>0</FBOPIncludeNicknames><FBOPIncludeLexIDPrimaryDOBYear>0</FBOPIncludeLexIDPrimaryDOBYear></Options></row></duediligencepersonreportrequest><testdatatablename/><_ReferenceCode/><usage>0111020312050607</usage><industryclass>OTHER</industryclass><testdataenabled>0</testdataenabled><dobmask>NONE</dobmask><SSNMask_Overload>None</SSNMask_Overload><DLMask_Overload>0</DLMask_Overload></DueDiligence.DueDiligence_PersonRptService>'));


// fix the input (remove unnecessary duplicates, ensure not passing blanks in some fields, etc.)
in_rec FixInput(in_rec L) := TRANSFORM
  // SELF.skiprecords := '';
  // SELF.maxresults := IF(L.maxresults != '', L.maxresults, (string)MaxResults_val);
  // SELF.maxresultsthistime := IF(L.maxresultsthistime != '', L.maxresultsthistime, (string)MaxResultsThisTime_val);
  SELF := L;
END;
ds_in := PROJECT(DEDUP(xml_in, RECORD, ALL), FixInput(LEFT));
//OUTPUT(ds_in);

// to produce variations of the input
in_rec SetValues(in_rec L, string glb, string dppa, string dpm, string drm,
                 string ssn_mask, string dl_mask, string dob_mask,
                 string ic, string exc_dmv = '') := TRANSFORM
  SELF.glbpurpose := glb;
  SELF.dppapurpose := dppa;
  SELF.datapermissionmask := dpm;
  SELF.datarestrictionmask := drm;
  SELF.dlmask := dl_mask;
  SELF.ssnmask := ssn_mask;
  SELF.dobmask := dob_mask;
  SELF.industryclass := ic;

  ds_embedded := PROJECT(L.duediligencepersonreportrequest,
                     TRANSFORM($.layout.esdl_request,
                       SELF.User.glbpurpose := glb,
                       SELF.User.DLPurpose := dppa,
                       SELF.User.datapermissionmask := dpm,
                       SELF.User.datarestrictionmask := drm,
                       SELF.User.excludedmvpii := exc_dmv = '1',
                       SELF.User.DOBMask := dob_mask,
                       // SELF.User.LnBranded
                       SELF := LEFT));

  SELF.duediligencepersonreportrequest := ds_embedded;

  SELF := L;
END;

//choose a small sample for compliance variations:
ds_sample := CHOOSEN(ds_in, 20);

mask_zero := '00000000000000000000000000000000000000000000';
mask_ones := '11111111111111111111111111111111111111111111';
ds_1 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_zero, '',       '',  'day',   ''));
ds_2 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_ones, mask_zero, 'last4',  '1', 'year',  '', '1'));
ds_3 := PROJECT(ds_sample, SetValues(LEFT, '1', '1', mask_ones, mask_ones, 'first5', '1', 'year',  '', '1'));
ds_4 := PROJECT(ds_sample, SetValues(LEFT, '0', '0', mask_zero, mask_ones, '',       '1', 'month', 'UTILI'));
ds_5 := PROJECT(ds_sample, SetValues(LEFT, '2', '7', mask_zero, mask_zero, '',       '',  '',      'CNSMR', '1'));
xml_recs := ds_in + ds_1 + ds_2 + ds_3 + ds_4 + ds_5;


dev_regression.layouts.testcase toTestCase(xml_recs L) := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := 'compliance';
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;

testcases := PROJECT(xml_recs, toTestCase(LEFT));

// OUTPUT(ds_in, NAMED('ds_in'));
// OUTPUT(xml_recs, NAMED('xml_recs'));
// OUTPUT(testcases, NAMED('testcases'));
dev_regression.bucket().add(testcases, 'compliance regression');

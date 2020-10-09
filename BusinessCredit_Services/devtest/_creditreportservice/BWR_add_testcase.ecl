// ----------------------------------------------------------------------------------------------
//   The code below is for reference only; you must change it to reflect the new testcase(s) being 
// added to the bucket.
// ----------------------------------------------------------------------------------------------
#WORKUNIT('name', '-- dev regression: add testcase --');

IMPORT dev_regression, iesp, BusinessCredit_Services;

my_query := 'BusinessCredit_Services.CreditReportService';
svc_layout := BusinessCredit_Services.devtest._creditreportservice.layout;

iesp.businesscreditreport.t_BusinessCreditReportRequest xtESDL() := TRANSFORM
  SELF.User.GLBPurpose := '7';
  SELF.User.DLPurpose := '3';
  SELF.User.DataRestrictionMask := '000000000000';
  SELF.User.DataPermissionMask := '111111111111111111111';
  SELF.Options.IncludeBusinessCredit := true;
  SELF.Options.BusinessCreditReportType := '1';
  SELF.ReportBy.Company.BusinessIds.SeleID := 44206511;
  SELF.ReportBy.Company.BusinessIds.OrgID := 44206511;
  SELF.ReportBy.Company.BusinessIds.UltID := 44206511;
  SELF.ReportBy.Company.CompanyName := '';
  SELF.ReportBy.Company.Address.StreetAddress1 := '';
  SELF.ReportBy.Company.Address.City := '';
  SELF.ReportBy.Company.Address.State := '';
  SELF.ReportBy.Company.Address.Zip5 := '';
  SELF := [];  
END;
esdl_recs := DATASET([xtESDL()]);

svc_layout.request wrapESDL() := TRANSFORM
  SELF.BusinessCreditReportRequest := esdl_recs;
END;

dev_regression.layouts.testcase xt() := TRANSFORM
  SELF.query := my_query;
  SELF.short_description := '';
  SELF.request_xml := dev_regression.utils.wrapTOXML(ROW(wrapESDL()));
END;

testcases := DATASET([xt()]);
output(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases);

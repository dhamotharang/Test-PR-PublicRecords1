// Use it as an example, modify as you wish
IMPORT dev_regression, EBR, EBR_Services, Gateway;

my_query := 'EBR_Services.EbrSearchService';
svc_layout := EBR_Services.devtest.ebr_search_service.layout;
in_rec := svc_layout.request;

in_rec xt(STRING bdid, STRING cname, STRING addr, STRING city, STRING st, STRING zip, STRING phone, STRING glb = '', STRING dppa = '', STRING drm='', STRING dpm = '') := TRANSFORM
  SELF.bdid := bdid;
  SELF.CompanyName  := cname;
  SELF.Addr  :=  addr;
  SELF.City  := city;
  SELF.State  := st;
  SELF.Zip  := zip;
  SELF.Phone := phone;
  SELF.DPPAPurpose := IF(dppa<>'', dppa, '');
  SELF.GLBPurpose := IF(glb<>'', glb, '');
  SELF.DataRestrictionMask := IF(drm<>'', drm, '0000000000000000000000000000');
  SELF.DataPermissionMask := IF(dpm<>'', dpm, '1111111111111111111111111110');
  SELF.MaxResults := '1000';
  SELF.MaxResultsThisTime := '25';
  SELF := [];
END;  

// xml samples -- add yours below...
xml_in  := 
  DATASET([xt('20416', '', '', '', '', '', '', '7', '1')])
  ;
OUTPUT(xml_in, NAMED('xml_in'));

dev_regression.layouts.testcase toTestcase(in_rec L, INTEGER c) := TRANSFORM
  SELF.tid := c;
  SELF.query := my_query;
  SELF.short_description := 'random #'+c;
  SELF.request_xml := dev_regression.utils.wrapTOXML(L);
END;
testcases := project(xml_in, toTestcase(LEFT, COUNTER));
OUTPUT(testcases, NAMED('testcases'));

dev_regression.bucket().add(testcases);

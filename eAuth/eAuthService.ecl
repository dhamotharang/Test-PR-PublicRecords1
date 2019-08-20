/*--SOAP--
<message name="EAuthService" wuTimeout="300000">
<!--
  <part name="UseCurrentlyOwnedProperty" type="xsd:boolean" description=" ...IncludeCurrentProperty"/>
  <separator />
-->
  <part name="EAuthRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns set of multiple choice questions to eAuthenticate a person*/
/*--USES-- ut.input_xslt */

IMPORT iesp, doxie, AutoHeaderI, AutoStandardI, eAuth;

EXPORT EAuthService () := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#onwarning(4207, ignore);
#option ('globalAutoHoist', false);
// for use in outdated code

#constant('IsCRS',true);
#constant('useOnlyBestDID',true);
#constant('LegacyVerified',true);
#constant('UseCurrentlyOwnedVehicles', true);
#constant('IncludePriorProperties', true); // NOT NECESSARILY SUBJECT PROPERTY!
#constant('DataRestrictionMask', 00000000000); // allows to fetch maximum property records

  rec_in := iesp.eAuth.t_EAuthRequest;
  ds_in := DATASET ([], rec_in) : STORED ('EAuthRequest', FEW);
  first_raw := ds_in[1] : INDEPENDENT;

  // read input, transform it into suitable bps-type
  search_by := global (first_raw.SearchBy);
  report_by := ROW (search_by, transform (iesp.bpsreport.t_BpsReportBy, Self := Left; Self := []));

  iesp.ECL2ESP.SetInputBaseRequest (first_raw);
  iesp.ECL2ESP.SetInputReportBy (report_by);

  options := global (first_raw.Options);
  // #stored ('UseCurrentlyOwnedProperty', options.IncludeCurrentProperty);
  #constant ('UseCurrentlyOwnedProperty', false);

  // define all relevant input parameters
  gm := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);
  tempmod := module (project (gm, eAuth.IParam.records, opt))
    export dataset (iesp.eAuth.t_QuestionReq) questions := search_by.Questions;
    export boolean IsDeceased             := options.IsDeceased;
    export boolean GetMultipleCorrect     := options.GetMultipleCorrect;
    export boolean GetDOD                 := options.GetDOD;
    export boolean GetDOB                 := options.GetDOB;
    export boolean VerifySSN              := options.VerifySSN;
    export boolean IncludeCurrentProperty := false : stored ('UseCurrentlyOwnedProperty');
    export boolean IncludeCurrentVehicles := true;
  end;
  dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (tempmod);

  // main records
  results := eAuth.eauth_records (dids, tempmod, mod_access, FALSE);

  did_num := count (dids);
  MAP (did_num = 0 => fail (205, 'Individual not found'), //205 in old spec 
       did_num > 1 => fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
       output (results, named ('Results')));

ENDMACRO;
// EAuthService ();

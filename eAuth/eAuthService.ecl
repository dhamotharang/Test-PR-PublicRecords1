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
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
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
  tempmod := module (project (AutoStandardI.GlobalModule(), eAuth.IParam.records, opt))
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
  results := eAuth.eauth_records (dids, tempmod, FALSE);

  did_num := count (dids);
  MAP (did_num = 0 => fail (205, 'Individual not found'), //205 in old spec 
       did_num > 1 => fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
       output (results, named ('Results')));

ENDMACRO;
// EAuthService ();
/*
<EAuthRequest>
<row>
<User>
  <ReferenceCode>ref_code_str</ReferenceCode>
  <BillingCode>billing_code</BillingCode>
  <QueryId>query_id</QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <EndUser/>
</User>
<Options>
  <IsDeceased></IsDeceased>
  <GetMultipleCorrect></GetMultipleCorrect>
  <GetDOD></GetDOD>
  <GetDOB></GetDOB>
  <VerifySSN></VerifySSN>
  <IncludeCurrentProperty></IncludeCurrentProperty>
</Options>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetSuffix></StreetSuffix>
    <UnitNumber></UnitNumber>
    <State></State>
    <City></City>
    <Zip5></Zip5>
  </Address>
  <SSN></SSN>
  <SSNLast4></SSNLast4>
  <UniqueId></UniqueId>
  <Questions>
    <Question><Id>county1</Id><NumAnswers>4</NumAnswers><NumValid>1</NumValid></Question>
    <Question><Id>ssn1</Id></Question>
    <Question><Id>zip1</Id></Question>
    <Question><Id>city1</Id></Question>
    <Question><Id>city2</Id></Question>
    <Question><Id>city3</Id></Question>
    <Question><Id>city4</Id></Question>
    <Question><Id>city5</Id></Question>
    <Question><Id>city6</Id></Question>
    <Question><Id>people1</Id></Question>
    <Question><Id>property1</Id></Question>
    <Question><Id>property2</Id></Question>
    <Question><Id>property3</Id></Question>
    <Question><Id>property4</Id></Question>
    <Question><Id>property5</Id></Question>
    <Question><Id>property6</Id></Question>
    <Question><Id>property7</Id></Question>
    <Question><Id>vehicle1</Id></Question>
    <Question><Id>vehicle2</Id></Question>
    <Question><Id>vehicle3</Id></Question>
    <Question><Id>vehicle4</Id></Question>
    <Question><Id>vehicle5</Id></Question>
    <Question><Id>address1</Id></Question>
  </Questions>

</SearchBy>
</row>
</EAuthRequest>
*/

/*
<query>
  <random>no</random>
  <function>authenticate</function>
  <userid></userid>
  <password></password>
  <name-first>david</name-first>
  <name-last>iglesias</name-last>
  <address-1>2930 sw 106th ave</address-1>
  <city>Miami</city>
  <state>FL</state>
  <zip>33165</zip>
  <ssn-last4>3180</ssn-last4>
  <question><id>county1</id></question>
  <question><id>city1</id></question>
  <question><id>zip1</id></question>
  <question><id>city2</id></question>
  <question><id>city3</id></question>
  <question><id>city4</id></question>
  <question><id>city5</id></question>
  <question><id>people1</id></question>
  <question><id>property1</id></question>
  <question><id>property2</id></question>
  <question><id>property3</id></question>
  <question><id>property4</id></question>
  <question><id>property5</id></question>
  <question><id>property6</id></question>
  <question><id>property7</id></question>
  <question><id>ssn1</id></question>
</query>
*/


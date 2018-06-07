/*--SOAP--
<message name="ReportService">

    <!-- User Section -->
    <part name="ReferenceCode"    type="xsd:string"/>
    <part name="BillingCode"      type="xsd:string"/>
    <part name="QueryId"          type="xsd:string"/>

    <!-- COMPLIANCE SETTINGS -->
    <part name="GLBPurpose"       type="xsd:byte"/>
    <part name="DPPAPurpose"      type="xsd:byte"/>
    <part name="MaxWaitSeconds"   type="xsd:integer"/>

    <!-- SEARCH FIELDS -->
    <part name="VIN"              		type="xsd:string"/>
		<part name='SSN'									type='xsd:string'/>
		<part name='DriverLicenseNumber'	type='xsd:string'/>
		<part name='DriverLicenseState'		type='xsd:string'/>
		<part name='UniqueId'							type='xsd:string'/>
		<part name='AccidentDate'					type='xsd:unsignedInt'/>

    <!-- OPTIONS -->
    <part name="ReportType"       type="xsd:string"/>
		<part name="EnableExtraAccidents" type="xsd:boolean"/>
		
		<!-- AUTOKEY SEARCH FIELDS -->
		<part name="UnParsedFullName" type="xsd:string"/>
		<part name="FirstName"   			type="xsd:string"/>
		<part name="MiddleName"  			type="xsd:string"/>
		<part name="LastName"    			type="xsd:string"/>
		<part name="Addr"	       			type="xsd:string"/>
		<part name="City"        			type="xsd:string"/>
		<part name="State"       			type="xsd:string"/>
		<part name="Zip"         			type="xsd:string"/>
		<part name="County"           type="xsd:string"/>		
		<part name="DOB" 							type="xsd:unsignedInt"/>
		
		<part name="PenaltThreshold"	type="xsd:unsignedInt"/>

    <part name="NationalAccidentReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- 
    Return National Accident information in a report format by VIN<br/>
    ReportType: defaults to MobileTrac response else 'Claims'
*/

import iesp,AutoStandardI,Accident_Services;

export ReportService := macro
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
		#constant('StrictMatch', true);

    //get XML input 
    rec_in := iesp.national_accident.t_NationalAccidentReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('NationalAccidentReportRequest', FEW);
    first_row := ds_in[1] : independent;

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    report_opt := global (first_row.Options);
    #stored('ReportType', report_opt.ReportType);
		#stored('EnableExtraAccidents',report_opt.EnableExtraAccidents);

    //set search criteria
    report_by := global (first_row.ReportBy);
    #stored ('VIN', report_by.VIN);
		#stored ('SSN', report_by.SSN);
		#stored ('DriverLicenseNumber', report_by.DriverLicenseNumber);
		#stored ('DriverLicenseState', report_by.DriverLicenseState);
		#stored ('UniqueId', report_by.UniqueID);
		#stored ('AccidentDate', (unsigned4)iesp.ECL2ESP.t_DateToString8(report_by.AccidentDate));
		
		iesp.ECL2ESP.SetInputName (report_by.Name);
    iesp.ECL2ESP.SetInputAddress (report_by.Address);
		iesp.ECL2ESP.SetInputDate (report_by.DOB, 'DOB');
		
		AIGmod:=AutoStandardI.GlobalModule();
    tempmod := module(project(AIGmod, 
            Accident_Services.IParam.searchrecords,opt));
        export string30 VIN := '' : stored('VIN');
        export string10 ReportType := '' : stored('ReportType');
				export string11 SSN := '' : stored('SSN');
				export string24 DriverLicenseNumber := '' : stored('DriverLicenseNumber');
				export string2 DriverLicenseState := '' : stored('DriverLicenseState');
				export string22 UniqueId :=  '' : stored('UniqueId');
				export unsigned4 AccidentDate :=  0 : stored('AccidentDate');
				export string32 applicationType := if (AIGmod.ApplicationType = '', Accident_Services.Constants.claimsApplicationType, AIGmod.ApplicationType);
				export boolean  EnableExtraAccidents := false : stored('EnableExtraAccidents');
    end;
		
		recs := Accident_Services.Report_Records.vertical(tempmod);
		nada:=dataset([],iesp.national_accident.t_NationalAccidentReportAccident);
    temp:= if(tempmod.vin <> '' and length (trim(tempmod.VIN)) < 7,nada,recs);

    iesp.national_accident.t_NationalAccidentReportResponse marshall() := transform
        self._Header := iesp.ECL2ESP.GetHeaderRow(),
        self.QueriedVIN := tempmod.VIN,
        self.HitIndicator := count(temp)>0,
        self.Accidents := choosen(temp,iesp.constants.NATIONAL_ACCIDENTS_MAX_COUNT_ACCIDENT),
    end;

    results := dataset([marshall()]);
    output(results,named('Results'));

endmacro;

// NationalAccident_Services.ReportService();
/*
<NationalAccidentReportRequest>
  <row>
    <User>
      <ReferenceCode></ReferenceCode>
      <BillingCode></BillingCode>
      <QueryId></QueryId>
      <GLBPurpose></GLBPurpose>
      <DLPurpose></DLPurpose>
      <EndUser>
        <CompanyName></CompanyName>
        <StreetAddress1></StreetAddress1>
        <City></City>
        <State></State>
        <Zip5></Zip5>
      </EndUser>
      <MaxWaitSeconds></MaxWaitSeconds>
    </User>
    <Options>
      <ReportType></ReportType>
      <EnableExtraAccidents></EnableExtraAccidents>
    </Options>
    <ReportBy>
      <VIN></VIN>
      <SSN></SSN>
      <DriverLicenseNumber></DriverLicenseNumber>
      <DriverLicenseState></DriverLicenseState>
      <UniqueId></UniqueId>
      <DOB>
        <Year></Year>
        <Month></Month>
        <Day></Day>
      </DOB>
      <Name>
        <Full></Full>
        <First></First>
        <Middle></Middle>
        <Last></Last>
        <Suffix></Suffix>
        <Prefix></Prefix>
      </Name>
      <Address>
        <StreetName></StreetName>
        <StreetNumber></StreetNumber>
        <StreetPreDirection></StreetPreDirection>
        <StreetPostDirection></StreetPostDirection>
        <StreetSuffix></StreetSuffix>
        <UnitDesignation></UnitDesignation>
        <UnitNumber></UnitNumber>
        <StreetAddress1></StreetAddress1>
        <StreetAddress2></StreetAddress2>
        <State></State>
        <City></City>
        <Zip5></Zip5>
        <Zip4></Zip4>
        <County></County>
        <PostalCode></PostalCode>
        <StateCityZip></StateCityZip>
      </Address>
      <AccidentDate>
        <Year></Year>
        <Month></Month>
        <Day></Day>
      </AccidentDate>
    </ReportBy>
  </row>
</NationalAccidentReportRequest>
*/

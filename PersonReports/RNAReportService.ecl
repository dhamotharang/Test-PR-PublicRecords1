/*--SOAP--
<message name="RNA ReportService">
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="allowNicknames" type="xsd:boolean"/>
  <part name="UnparsedFullName" type="xsd:string"/>  
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <separator />
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <separator />
  <part name="DID" type="xsd:string" required="1" />
  <part name="SSN" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/> 
  <!--<part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>-->
  <part name="DataPermissionMask" type="xsd:string" default="00000000000"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
  <separator />
  <!--<part name="SelectIndividually" type="xsd:boolean" default="false"/>-->
  <part name="IncludeRelatives"  type="xsd:boolean"/>
  <part name="IncludeNeighbors" type="xsd:boolean"/>
  <part name="IncludeAssociates" type="xsd:boolean"/>
  <part name="IncludeRelativeAddresses"  type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>
  <separator />
  <part name="UnverifiedAddresses" type="xsd:boolean" default="false" description=" return unverified addresses as well"/>
  <part name="AddressesWithoutPhones" type="xsd:boolean" default="false" description=" includes addresses without phones as well"/>
  <part name="NeighborsProximityRadius" type="xsd:byte" default="20" description=" defines neighbors in terms of &quot;units proximity&quot;"/>
  <separator />
  <part name="RNAReportRequest" type="tns:XmlDataSet" cols="80" rows="10" />
</message>
*/
/*--INFO-- <b>Relatives, neighbors, associates.</b><br>
  Only neighbors at the neighborhood specified by input address will be returned.<br>
  Real service accepts DID [+ address], all other input fields are for convenience only*/
/*--USES-- ut.input_xslt */

IMPORT iesp, doxie, AutoStandardI, AutoHeaderI, Relationship;


EXPORT RNAReportService() := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	//The following macro defines the field sequence on WsECL page of query. 
	WSInput.MAC_PersonReports_RNAReportService();
	#constant('IsCRS',true);
	#constant('useOnlyBestDID',true);
	#constant('LegacyVerified',true);
	#constant('SelectIndividually', true); // we will setup all components explicitly
	#constant('IncludeCensusData', false); // this can be true only for most complete BpsAddress structures

	#constant('RelativeDepth', 1);
	#constant('MaxRelatives', 20);
	#constant('MaxRelativeAddresses', 10);

	#stored ('MaxNeighborhoods', 10);
	#stored ('NeighborsPerAddress', 6);
	#stored ('AddressesPerNeighbor', 1);
	//#constant('NeighborsProximityRadius', 20);

  // reads "volatile" [includes] from XML, if any, and stores them for subsequent reading
  SetInputSearchOptions (iesp.rnareport.t_RNAReportOption tag) := FUNCTION
    #stored ('IncludeRelatives', global(tag).IncludeRelatives);
    #stored ('IncludeRelativeAddresses', global(tag).IncludeRelativesAddresses);
    #stored ('IncludeAssociates', global(tag).IncludeAssociates);
    #stored ('IncludeNeighbors', global(tag).IncludeNeighbors);
    #stored ('IncludeCriminalIndicators', global(tag).IncludeCriminalIndicators);
    return output (dataset ([],{integer x}), named('__internal__'), extend);
  end;

  ds_in := DATASET ([], iesp.rnareport.t_RNAReportRequest) : STORED ('RNAReportRequest', FEW);
  first_row := ds_in[1] : independent;

  report_by := global (first_row.ReportBy);
  
  report_by_bps:=project(report_by,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[]));  
  iesp.ECL2ESP.SetInputReportBy (report_by_bps);
	
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
  SetInputSearchOptions (first_row.Options);

  include_stored := PersonReports.GlobalIncludes ();

  // define parameters (so far all standard ones)
  in_standard := project (AutoStandardI.GlobalModule(), PersonReports.input._didsearch, opt);

  report_mod := module (in_standard)
    export string6 ssn_mask := 'NONE' : stored('SSNMask'); // ideally, must be "translated"

    export unsigned1 GLBPurpose := AutoStandardI.InterfaceTranslator.glb_purpose.val (in_standard);
    export unsigned1 DPPAPurpose := AutoStandardI.InterfaceTranslator.dppa_purpose.val (in_standard);
		export string5 IndustryClass := AutoStandardI.InterfaceTranslator.industry_class_value.val (in_standard);

    export boolean include_relatives       := include_stored.include_relatives;
    export boolean include_neighbors       := include_stored.include_neighbors;
    export boolean include_associates      := include_stored.include_associates;
    export boolean include_censusdata      := false;
    export boolean include_criminalindicators   := include_stored.include_criminalindicators;
  end;

  // only needed for search
  search_mod := module (project (report_mod, PersonReports.input._didsearch, opt))
  end;
 
 dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (search_mod);
	
  neighbors_only := include_stored.include_neighbors and 
                 not include_stored.include_relatives and 
                 not include_stored.include_associates;
  valid_addr:=(report_mod.prim_name<>'' or report_mod.prim_range<>'' or report_mod.addr<>'') and report_mod.zip<>'';
  return_blank:= not valid_addr and neighbors_only;
  ds_blank:=dataset([],iesp.rnareport.t_RNAReport);
 
  // main records
	Relationship.IParams.storeParams(first_row.Options.RelationshipOption,in_standard.ApplicationType);
  rna_mod := Relationship.IParams.getParams(report_mod,PersonReports.input._rnareport);
  recs_data := PersonReports.RNAReport (dids, rna_mod, FALSE);
 
 recs:=if(return_blank,ds_blank,recs_data);
  // wrap it into output structure
 
 iesp.rnareport.t_RNAReportResponse SetResponse (recordof (recs) L) := transform
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();
    Self.Individual := L;
  end;
  results := PROJECT (recs, SetResponse (Left));

  IF (not return_blank and count (dids) > 1,
      fail (203, doxie.ErrorCodes (203)), // or ('ambiguous criteria')
      output (results, named ('Results')));

ENDMACRO;

//RNAReportService ();

/*
<RNAReportRequest>
<row>
  <Options>
    <ReturnCount>10</ReturnCount>
    <StartingRecord>1</StartingRecord>
    <IncludeRelatives>1</IncludeRelatives>
    <IncludeNeighbors>1</IncludeNeighbors>
    <IncludeAssociates>1</IncludeAssociates>
    <IncludeRelativesAddresses>1</IncludeRelativesAddresses>
  </Options>
  <ReportBy>
    <UniqueID></UniqueID>
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
  </ReportBy>
</row>
</RNAReportRequest>
*/

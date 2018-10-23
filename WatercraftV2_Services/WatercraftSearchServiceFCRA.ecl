/*--SOAP--
<message name="WatercraftSearchFCRA" wuTimeout="300000">
	<part name = 'BDID'			type = 'xsd:string'/>
	<part name = 'DID'			type = 'xsd:string'/>
	<part name = 'SSN'			type = 'xsd:string'/>
  <part name="UnParsedFullName" 	type="xsd:string"/>	
	<part name="FirstName" type='xsd:string' />
	<part name="MiddleName" type='xsd:string' />
	<part name="LastName" type = 'xsd:string' />
	<part name="AllowNicknames" type='xsd:boolean' />
	<part name="PhoneticMatch" type='xsd:boolean' />
	<part name="CompanyName" type='xsd:string' />
	<part name="FEIN" type='xsd:string' />
	<part name="Addr" type='xsd:string' />
	<part name="City" type="xsd:string" />
	<part name="State" type='xsd:string' />
	<part name="Zip" 	type = 'xsd:string' />
  <part name="County" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
	<part name="Phone" 	type = 'xsd:string' />
  <part name="RecordByDate" type="xsd:string"/>
	<part name = 'GLBPurpose'	type = 'xsd:byte'/>
	<part name = 'DPPAPurpose'	type = 'xsd:byte'/>
	<part name = 'FCRAPurpose'	type = 'xsd:string'/>
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="PenaltThreshold" 		type="xsd:unsignedInt"/>
	<part name="MaxResults"  type = 'xsd:unsignedInt' />
	<part name="MaxResultsThisTime" type = 'xsd:unsignedInt' />
	<part name="SkipRecords" type = 'xsd:unsignedInt' />
  <part name="SSNMask" type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
	<part name='NonSubjectSuppression' type = 'xsd:unsignedInt' default="2"/> <!-- [1,2,3] -->
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="FFDOptionsMask" 	      type="xsd:string"/>
</message>
*/
/*--INFO-- This service searches all Watercraft datafiles with FCRA restrictions.<p/>
					 When using NonSubjectSuppression:<br/>
					 -1: no co-owners suppression<br/>
					 -2: co-owners are blanked and lname is overriden with value "FCRA Restricted"<br/>
					 -3: co-owners are suppressed<p/>
					 The default behavior for NonSubjectSuppression is 2.*/

import Text_Search, doxie, FCRA, iesp, AutoStandardI, Gateway, suppress,STD;

export WatercraftSearchServiceFCRA := macro
	#constant('NoDeepDive', true);

	#constant('SearchGoodSSNOnly',true);
	#constant('SearchIgnoresAddressOnly',true);
	#constant('getBdidsbyExecutive',FALSE);
	#constant('DidOnly', true); // for picklist

	doxie.MAC_Header_Field_Declare (true);
	gm := AutoStandardI.GlobalModule(true);

	//soap call for remote DIDs
	//------------------------------------------------------------------------------------
	// gateways := dataset([], Gateway.layouts.config) : stored ('gateways', few);
	gateways := Gateway.Configuration.Get();
	picklist_res := FCRA.PickListSoapcall.non_esdl(gateways);
	//------------------------------------------------------------------------------------

	rdid := picklist_res[1].Records[1].UniqueId;
	
	//non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);

	params := module(project(gm, WatercraftV2_Services.Interfaces.search_params, opt))
		export string14 DID := rdid;
		export unsigned2 pt := 10 			: stored('PenaltThreshold');
		export string6 ssn_mask := ssn_mask_val;
		export integer1 non_subject_suppression := nss;
		export integer8 FFDOptionsMask := FFD.FFDMask.Get();
		export integer  FCRAPurpose := FCRA.FCRAPurpose.Get();
	END;
	
	rsrt_stmts := WatercraftV2_services.WatercraftSearch(params, true);
	rsrt1 := rsrt_stmts.Records;
	Text_Search.MAC_Append_ExternalKey(rsrt1, rsrt2, l.watercraft_key + l.sequence_key + l.state_origin);

  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, false);

	doxie.MAC_Marshall_Results(rsrt2,rmar);

	output(rmar, named('Results'));
	output(rsrt_stmts.Statements, named('ConsumerStatements'));
	output(rsrt_stmts.ConsumerAlerts, named('ConsumerAlerts'));
	output(input_consumer, named('Consumer'));

endmacro;

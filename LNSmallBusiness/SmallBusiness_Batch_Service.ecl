/*--SOAP--
<message name="SmallBusiness_Batch_Service">
	<!-- XML INPUT -->
	<part name="SmallBusinessRiskRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name='GLBPurpose' type='xsd:byte'/>
	<part name='DPPAPurpose' type='xsd:byte'/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	</message>
*/
/*--INFO-- LexisNexis Small Business Risk Score batch service */
/*--HELP--
<pre>
SmallBusinessRiskRequest XML:
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;bus_name&gt;&lt;/bus_name&gt;
      &lt;bus_altname&gt;&lt;/bus_altname&gt;
      &lt;bus_streetname&gt;&lt;/bus_streetname&gt;
      &lt;bus_streetnumber&gt;&lt;/bus_streetnumber&gt;
      &lt;bus_streetpredirection&gt;&lt;/bus_streetpredirection&gt;
      &lt;bus_streetpostdirection&gt;&lt;/bus_streetpostdirection&gt;
      &lt;bus_streetsuffix&gt;&lt;/bus_streetsuffix&gt;
      &lt;bus_unitdesignation&gt;&lt;/bus_unitdesignation&gt;
      &lt;bus_unitnumber&gt;&lt;/bus_unitnumber&gt;
      &lt;bus_streetaddress1&gt;&lt;/bus_streetaddress1&gt;
      &lt;bus_streetaddress2&gt;&lt;/bus_streetaddress2&gt;
      &lt;bus_state&gt;&lt;/bus_state&gt;
      &lt;bus_city&gt;&lt;/bus_city&gt;
      &lt;bus_zip5&gt;&lt;/bus_zip5&gt;
      &lt;bus_zip4&gt;&lt;/bus_zip4&gt;
      &lt;bus_county&gt;&lt;/bus_county&gt;
      &lt;bus_postalcode&gt;&lt;/bus_postalcode&gt;
      &lt;bus_statecityzip&gt;&lt;/bus_statecityzip&gt;
      &lt;bus_fein&gt;&lt;/bus_fein&gt;
      &lt;bus_phone10&gt;&lt;/bus_phone10&gt;
      &lt;rep_fullname&gt;&lt;/rep_fullname&gt;
      &lt;rep_first&gt;&lt;/rep_first&gt;
      &lt;rep_middle&gt;&lt;/rep_middle&gt;
      &lt;rep_last&gt;&lt;/rep_last&gt;
      &lt;rep_suffix&gt;&lt;/rep_suffix&gt;
      &lt;rep_prefix&gt;&lt;/rep_prefix&gt;
      &lt;rep_streetname&gt;&lt;/rep_streetname&gt;
      &lt;rep_streetnumber&gt;&lt;/rep_streetnumber&gt;
      &lt;rep_streetpredirection&gt;&lt;/rep_streetpredirection&gt;
      &lt;rep_streetpostdirection&gt;&lt;/rep_streetpostdirection&gt;
      &lt;rep_streetsuffix&gt;&lt;/rep_streetsuffix&gt;
      &lt;rep_unitdesignation&gt;&lt;/rep_unitdesignation&gt;
      &lt;rep_unitnumber&gt;&lt;/rep_unitnumber&gt;
      &lt;rep_streetaddress1&gt;&lt;/rep_streetaddress1&gt;
      &lt;rep_streetaddress2&gt;&lt;/rep_streetaddress2&gt;
      &lt;rep_state&gt;&lt;/rep_state&gt;
      &lt;rep_city&gt;&lt;/rep_city&gt;
      &lt;rep_zip5&gt;&lt;/rep_zip5&gt;
      &lt;rep_zip4&gt;&lt;/rep_zip4&gt;
      &lt;rep_county&gt;&lt;/rep_county&gt;
      &lt;rep_postalcode&gt;&lt;/rep_postalcode&gt;
      &lt;rep_statecityzip&gt;&lt;/rep_statecityzip&gt;
      &lt;rep_ssn&gt;&lt;/rep_ssn&gt;
      &lt;rep_dob_year&gt;&lt;/rep_dob_year&gt;
      &lt;rep_dob_month&gt;&lt;/rep_dob_month&gt;
      &lt;rep_dob_day&gt;&lt;/rep_dob_day&gt;
      &lt;rep_phone10&gt;&lt;/rep_phone10&gt;
      &lt;rep_driverlicensenumber&gt;&lt;/rep_driverlicensenumber&gt;
      &lt;rep_driverlicensestate&gt;&lt;/rep_driverlicensestate&gt;
			&lt;HistorydateYYYYMM&gt;&lt;/HistorydateYYYYMM&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import Risk_Indicators;

export SmallBusiness_Batch_Service := MACRO
 #onwarning(4207, ignore);
	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

	// Get XML input 
	batch_in     := dataset([], LNSmallBusiness.Layouts.Batch_In )  : STORED ('SmallBusinessRiskRequest', few);
	gateways     := Gateway.Configuration.Get();
	dppa         := LNSmallBusiness.Helpers.DPPA_Purpose : stored('DPPAPurpose');
	glb          := LNSmallBusiness.Helpers.GLB_Purpose  : stored('GLBPurpose');
	history_date := LNSmallBusiness.Helpers.History_Date : stored('HistoryDateYYYYMM');
	string modelname := '' : stored('ModelName');
	string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	
    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
    string TransactionID := '' : STORED('_TransactionId');
    string BatchUID := '' : STORED('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

	// add sequence here
	batch_seq := project( batch_in, transform( LNSmallBusiness.Layouts.Batch_In, self.seq:=counter, 
																		self.HistoryDateYYYYMM := IF(LEFT.HistoryDateYYYYMM=0, HISTORY_DATE, LEFT.HISTORYDATEYYYYMM);  
																		self:=left ) );
	indata := LNSmallBusiness.Helpers.BatchIn2Hierarchical( batch_seq, modelname, glb, dppa );
	lnsb   := PROJECT(LNSmallBusiness.SmallBusiness_Function( indata, gateways, false, '', DataRestriction, DataPermission, 
                                                                                                                  LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                                  TransactionID := TransactionID, 
                                                                                                                  BatchUID := BatchUID, 
                                                                                                                  GlobalCompanyID := GlobalCompanyID), 
                  TRANSFORM(LNSmallBusiness.Layouts.ResponseEx, SELF := LEFT));
                  
	batch_out := LNSmallBusiness.Helpers.HierarchicalOut2Testseed( lnsb );


	// remove sequence number, set acctno
	layout_final := LNSmallBusiness.Layouts.Batch_Out - seq;

	layout_final finalize( batch_seq le, batch_out ri ) := TRANSFORM
		self.AcctNo := le.AcctNo;
		self := ri;
	end;
	final := join( batch_seq, batch_out, left.seq=right.seq, finalize(left,right), left outer, keep(1) );

	output(final, named('Results'));
endmacro;
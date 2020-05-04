/*--SOAP--
<message name="BatchService">
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="DataRestrictionMask" type="xsd:string" default="0000000000000000"/>
  <separator />
  <part name="Product" type="xsd:string" description=" [I]nspection) or [P]roperty)"/> 
  <part name="IndResultOption" type="xsd:string" description="DO Deafult" /> 
  <part name="ReportType" type="xsd:string" description=" P Only" /> 
  <part name="IncludeConfidenceFactors" type="xsd:boolean" description=" confidence scores for in-house properties"/> 
  // <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
  <separator />
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/> 
</message>
*/

/*--INFO-- This service searches property bluebook data, LN property data, and optionaly makes ERC
           (Estimated Replacement Cost) gatewya soap call.

<pre>
&lt;batch_in&gt;
&lt;row&gt;
  &lt;acctno&gt;1&lt;/acctno&gt;
  &lt;StreetAddress&gt;516 Linley Trace&lt;/StreetAddress&gt;
  &lt;City&gt;&lt;/City&gt;
  &lt;State&gt;GA&lt;/State&gt;
  &lt;Zip5&gt;30043&lt;/Zip5&gt;
  &lt;First&gt;f1&lt;/First&gt;
  &lt;Middle/&gt;
  &lt;Last&gt;l1&lt;/Last&gt;
  &lt;LivingAreaSF&gt;2222&lt;/LivingAreaSF&gt;
  &lt;Stories/&gt;
  &lt;Bedrooms/&gt;
  &lt;Baths/&gt;
  &lt;Fireplaces/&gt;
  &lt;Pool/&gt;
  &lt;AC/&gt;
  &lt;YearBuilt/&gt;
  &lt;SlopeCode/&gt;
  &lt;Slope/&gt;
  &lt;QualityOfStructCode/&gt;
  &lt;QualityOfStruct/&gt;
  &lt;ReplacementCostReportId/&gt;
  &lt;PolicyCoverageValue/&gt;
  &lt;Category_1&gt;010&lt;/Category_1&gt;
  &lt;Material_1&gt;WCD&lt;/Material_1&gt;
  &lt;Value_1&gt;50.000000&lt;/Value_1&gt;
  &lt;Quality_1/&gt;
  &lt;Condition_1/&gt;
  &lt;Age_1/&gt;
  &lt;Category_8&gt;013&lt;/Category_8&gt;
  &lt;Material_8&gt;FIN&lt;/Material_8&gt;
  &lt;Value_8&gt;1550.000000&lt;/Value_8&gt;
&lt;/row&gt;  
&lt;row&gt;
  &lt;acctno&gt;2&lt;/acctno&gt;
  &lt;StreetAddress&gt;1521 HAGUE AVE&lt;/StreetAddress&gt;
  &lt;City&gt;SAINT PAUL&lt;/City&gt;
  &lt;State&gt;MN&lt;/State&gt;
  &lt;Zip5&gt;30043&lt;/Zip5&gt;
  &lt;First&gt;f2&lt;/First&gt;
  &lt;Middle/&gt;
  &lt;Last&gt;l2&lt;/Last&gt;
  &lt;LivingAreaSF&gt;&lt;/LivingAreaSF&gt;
  &lt;Stories/&gt;
  &lt;Bedrooms/&gt;
  &lt;Baths/&gt;
  &lt;Fireplaces/&gt;
  &lt;Pool/&gt;
  &lt;AC/&gt;
  &lt;YearBuilt/&gt;
  &lt;SlopeCode/&gt;
  &lt;Slope/&gt;
  &lt;QualityOfStructCode/&gt;
  &lt;QualityOfStruct/&gt;
  &lt;ReplacementCostReportId/&gt;
  &lt;PolicyCoverageValue/&gt;
&lt;/row&gt;  
&lt;/batch_in&gt;
</pre>
*/
/*--USES-- ut.input_xslt */

import PropertyCharacteristics_Services, Gateway;


export BatchService := MACRO

  in_rec := PropertyCharacteristics_Services.layouts.batch_in;

  // input property
  ds_batch_in :=  dataset([], in_rec) : stored('batch_in');
  // ds_batch_in := dataset([
    // {'1', '16105 Poppyseed Cir. #1808', 'Delray Beach', 'FL',          '', '', 'fname_1', '', 'lname_1'},
    // {'2', '6161 2nd Ave. apt. 122',     'BOCA RATON',   'FL', '33474', '', '', 'fname_2', '', 'lname_2'},
    // {'3', '516 Linley Trace',           'SAN ANTONIO',  'GA', '30043', '', '', 'fname_3', '', 'lname_3'},
    // {'4', '1521 HAGUE AVE',             'SAINT PAUL',   'MN', '',      '', '', 'fname_4', '', 'lname_4'} //zip=55104 
   // ], in_rec);

  // project flat customer request to the ESDL form
  ds_batch_in_esdl := project (ds_batch_in, transform (PropertyCharacteristics_Services.layouts.batch_in_esdl,
                                                       Self.acctno := Left.acctno,
                                                       Self.request := row (PropertyCharacteristics_Services.SetBatchCustomerRequest (Left))));
  
  // get gateway config
	gateway_cfg  := Gateway.Configuration.Get()(Gateway.Configuration.IsERC(servicename));

  // check validity of a product
  string1 product_in := '' : stored ('Product');
  _product := PropertyCharacteristics_Services.Functions.GetProductType (product_in);
  ptypes := PropertyCharacteristics_Services.Constants.PRODUCT;

  // report type (for Product=PROPERTY only) 
  string1 reporttype_in  := '' : stored ('ReportType');

  // request properties common for all input records
  inMod := module (PropertyCharacteristics_Services.IParam.Report)
    export unsigned1 Product := _product;
    // ERC data can be produced only for report type in [K,L];
    // Product=Inspection isn't aware of a report type, so I need to fake it
    export string1 ReportType	:= if (_product = ptypes.INSPECTION, 'K', reporttype_in);
		export	string3		ResultOption	:=	'DO': stored('ResultOption');
    export boolean IncludeConfidenceFactors	:= false : stored ('IncludeConfidenceFactors');
		// export dataset(Gateway.Layouts.Config) GatewayConfig := gateway_cfg;

    // in_ERC := false : stored ('IncludeERC');
    // export boolean RunGateway_ERC := (_product = ptypes.INSPECTION and in_ERC) or 
                                     // (_product = ptypes.PROPERTY and ReportType in ['K', 'L']);
  end;

  // Check minimum required input
  // if (inMod.RunGateway_ERC and (inMod.GatewayConfig[1].Url=''), FAIL ('gateway is absent'));
  if (inMod.Product not in [ptypes.INSPECTION, ptypes.PROPERTY], FAIL ('invalid product: [' + product_in + ']'));

	ds_output:=PropertyCharacteristics_Services.records_batch (ds_batch_in_esdl, inMod);
  ut.mac_TrimFields(ds_output, 'ds_output', results);
  OUTPUT(Results,NAMED('Results'));

ENDMACRO;

// BatchService();

/*
<batch_in>
<row>
  <acctno>1</acctno>
  <StreetAddress>516 Linley Trace</StreetAddress>
  <City></City>
  <State>GA</State>
  <Zip5>30043</Zip5>
  <First>f1</First>
  <Middle/>
  <Last>l1</Last>
  <LivingAreaSF>2222</LivingAreaSF>
  <Stories/>
  <Bedrooms/>
  <Baths/>
  <Fireplaces/>
  <Pool/>
  <AC/>
  <YearBuilt/>
  <SlopeCode/>
  <Slope/>
  <QualityOfStructCode/>
  <QualityOfStruct/>
  <ReplacementCostReportId/>
  <PolicyCoverageValue/>
  <Category_1>010</Category_1>
  <Material_1>WCD</Material_1>
  <Value_1>50.000000</Value_1>
  <Quality_1/>
  <Condition_1/>
  <Age_1/>
  <Category_8>013</Category_8>
  <Material_8>FIN</Material_8>
  <Value_8>1550.000000</Value_8>
</row>  
<row>
  <acctno>2</acctno>
  <StreetAddress>1521 HAGUE AVE</StreetAddress>
  <City>SAINT PAUL</City>
  <State>MN</State>
  <Zip5>30043</Zip5>
  <First>f2</First>
  <Middle/>
  <Last>l2</Last>
  <LivingAreaSF></LivingAreaSF>
  <Stories/>
  <Bedrooms/>
  <Baths/>
  <Fireplaces/>
  <Pool/>
  <AC/>
  <YearBuilt/>
  <SlopeCode/>
  <Slope/>
  <QualityOfStructCode/>
  <QualityOfStruct/>
  <ReplacementCostReportId/>
  <PolicyCoverageValue/>
</row>  
</batch_in>

*/

/*--SOAP--
<message name="MortgageCollusion Batch Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
/*--HELP--
<pre>
&lt;DATASET&gt;
&lt;ROW&gt;
	&lt;ACCTNO&gt;&lt;/ACCTNO&gt;
	&lt;STREETADDRESS&gt;&lt;/STREETADDRESS&gt;
	&lt;CITY&gt;&lt;/CITY&gt;
	&lt;ST&gt;&lt;/ST&gt;
	&lt;ZIP&gt;&lt;/ZIP&gt
	&lt;BUYER1_FIRST_NAME&gt;&lt;/BUYER1_FIRST_NAME&gt;
	&lt;BUYER1_MIDDLE_NAME&gt;&lt;/BUYER1_MIDDLE_NAME&gt;
	&lt;BUYER1_LAST_NAME&gt;&lt;/BUYER1_LAST_NAME&gt;
	&lt;BUYER1_SSN&gt;&lt;/BUYER1_SSN&gt;
	&lt;BUYER1_DATEOFBIRTH&gt;&lt;/BUYER1_DATEOFBIRTH&gt;
	&lt;BUYER1_STREETADDRESS&gt;&lt;/BUYER1_STREETADDRESS&gt;
	&lt;BUYER1_CITY&gt;&lt;/BUYER1_CITY&gt;
	&lt;BUYER1_ST&gt;&lt;/BUYER1_ST&gt;
	&lt;BUYER1_ZIP&gt;&lt;/BUYER1_ZIP&gt;

	&lt;BUYER2_FIRST_NAME&gt;&lt;/BUYER2_FIRST_NAME&gt;
	&lt;BUYER2_MIDDLE_NAME&gt;&lt;/BUYER2_MIDDLE_NAME&gt;
	&lt;BUYER2_LAST_NAME&gt;&lt;/BUYER2_LAST_NAME&gt;
	&lt;BUYER2_SSN&gt;&lt;/BUYER2_SSN&gt;
	&lt;BUYER2_DATEOFBIRTH&gt;&lt;/BUYER2_DATEOFBIRTH&gt;
	&lt;BUYER2_STREETADDRESS&gt;&lt;/BUYER2_STREETADDRESS&gt;
	&lt;BUYER2_CITY&gt;&lt;/BUYER2_CITY&gt;
	&lt;BUYER2_ST&gt;&lt;/BUYER2_ST&gt;
	&lt;BUYER2_ZIP&gt;&lt;/BUYER2_ZIP&gt;

	&lt;BUYER3_FIRST_NAME&gt;&lt;/BUYER3_FIRST_NAME&gt;
	&lt;BUYER3_MIDDLE_NAME&gt;&lt;/BUYER3_MIDDLE_NAME&gt;
	&lt;BUYER3_LAST_NAME&gt;&lt;/BUYER3_LAST_NAME&gt;
	&lt;BUYER3_SSN&gt;&lt;/BUYER3_SSN&gt;
	&lt;BUYER3_DATEOFBIRTH&gt;&lt;/BUYER3_DATEOFBIRTH&gt;
	&lt;BUYER3_STREETADDRESS&gt;&lt;/BUYER3_STREETADDRESS&gt;
	&lt;BUYER3_CITY&gt;&lt;/BUYER3_CITY&gt;
	&lt;BUYER3_ST&gt;&lt;/BUYER3_ST&gt;
	&lt;BUYER3_ZIP&gt;&lt;/BUYER3_ZIP&gt;

	&lt;SELLER1_FIRST_NAME&gt;&lt;/SELLER1_FIRST_NAME&gt;
	&lt;SELLER1_MIDDLE_NAME&gt;&lt;/SELLER1_MIDDLE_NAME&gt;
	&lt;SELLER1_LAST_NAME&gt;&lt;/SELLER1_LAST_NAME&gt;
	&lt;SELLER1_SSN&gt;&lt;/SELLER1_SSN&gt;
	&lt;SELLER1_DATEOFBIRTH&gt;&lt;/SELLER1_DATEOFBIRTH&gt;
	&lt;SELLER1_STREETADDRESS&gt;&lt;/SELLER1_STREETADDRESS&gt;
	&lt;SELLER1_CITY&gt;&lt;/SELLER1_CITY&gt;
	&lt;SELLER1_ST&gt;&lt;/SELLER1_ST&gt;
	&lt;SELLER1_ZIP&gt;&lt;/SELLER1_ZIP&gt;

	&lt;SELLER2_FIRST_NAME&gt;&lt;/SELLER2_FIRST_NAME&gt;
	&lt;SELLER2_MIDDLE_NAME&gt;&lt;/SELLER2_MIDDLE_NAME&gt;
	&lt;SELLER2_LAST_NAME&gt;&lt;/SELLER2_LAST_NAME&gt;
	&lt;SELLER2_SSN&gt;&lt;/SELLER2_SSN&gt;
	&lt;SELLER2_DATEOFBIRTH&gt;&lt;/SELLER2_DATEOFBIRTH&gt;
	&lt;SELLER2_STREETADDRESS&gt;&lt;/SELLER2_STREETADDRESS&gt;
	&lt;SELLER2_CITY&gt;&lt;/SELLER2_CITY&gt;
	&lt;SELLER2_ST&gt;&lt;/SELLER2_ST&gt;
	&lt;SELLER2_ZIP&gt;&lt;/SELLER2_ZIP&gt;
	&lt;SELLER3_FIRST_NAME&gt;&lt;/SELLER3_FIRST_NAME&gt;
	&lt;SELLER3_MIDDLE_NAME&gt;&lt;/SELLER3_MIDDLE_NAME&gt;
	&lt;SELLER3_LAST_NAME&gt;&lt;/SELLER3_LAST_NAME&gt;
	&lt;SELLER3_SSN&gt;&lt;/SELLER3_SSN&gt;
	&lt;SELLER3_DATEOFBIRTH&gt;&lt;/SELLER3_DATEOFBIRTH&gt;
	&lt;SELLER3_STREETADDRESS&gt;&lt;/SELLER3_STREETADDRESS&gt;
	&lt;SELLER3_CITY&gt;&lt;/SELLER3_CITY&gt;
	&lt;SELLER3_ST&gt;&lt;/SELLER3_ST&gt;
	&lt;SELLER3_ZIP&gt;&lt;/SELLER3_ZIP&gt;
	&lt;PROFESSIONAL1_FIRST_NAME&gt;&lt;/PROFESSIONAL1_FIRST_NAME&gt;
	&lt;PROFESSIONAL1_MIDDLE_NAME&gt;&lt;/PROFESSIONAL1_MIDDLE_NAME&gt;
	&lt;PROFESSIONAL1_LAST_NAME&gt;&lt;/PROFESSIONAL1_LAST_NAME&gt;
	&lt;PROFESSIONAL1_SSN&gt;&lt;/PROFESSIONAL1_SSN&gt;
	&lt;PROFESSIONAL1_DATEOFBIRTH&gt;&lt;/PROFESSIONAL1_DATEOFBIRTH&gt;
	&lt;PROFESSIONAL1_STREETADDRESS&gt;&lt;/PROFESSIONAL1_STREETADDRESS&gt;
	&lt;PROFESSIONAL1_CITY&gt;&lt;/PROFESSIONAL1_CITY&gt;
	&lt;PROFESSIONAL1_ST&gt;&lt;/PROFESSIONAL1_ST&gt;
	&lt;PROFESSIONAL1_ZIP&gt;&lt;/PROFESSIONAL1_ZIP&gt;
	&lt;PROFESSIONAL1_LICENSE_NUMBER&gt;&lt;/PROFESSIONAL1_LICENSE_NUMBER&gt;
	&lt;PROFESSIONAL1_LICENSE_TYPE&gt;&lt;/PROFESSIONAL1_LICENSE_TYPE&gt;
	&lt;PROFESSIONAL2_FIRST_NAME&gt;&lt;/PROFESSIONAL2_FIRST_NAME&gt;
	&lt;PROFESSIONAL2_MIDDLE_NAME&gt;&lt;/PROFESSIONAL2_MIDDLE_NAME&gt;
	&lt;PROFESSIONAL2_LAST_NAME&gt;&lt;/PROFESSIONAL2_LAST_NAME&gt;
	&lt;PROFESSIONAL2_SSN&gt;&lt;/PROFESSIONAL2_SSN&gt;
	&lt;PROFESSIONAL2_DATEOFBIRTH&gt;&lt;/PROFESSIONAL2_DATEOFBIRTH&gt;
	&lt;PROFESSIONAL2_STREETADDRESS&gt;&lt;/PROFESSIONAL2_STREETADDRESS&gt;
	&lt;PROFESSIONAL2_CITY&gt;&lt;/PROFESSIONAL2_CITY&gt;
	&lt;PROFESSIONAL2_ST&gt;&lt;/PROFESSIONAL2_ST&gt;
	&lt;PROFESSIONAL2_ZIP&gt;&lt;/PROFESSIONAL2_ZIP&gt;
	&lt;PROFESSIONAL2_LICENSE_NUMBER&gt;&lt;/PROFESSIONAL2_LICENSE_NUMBER&gt;
	&lt;PROFESSIONAL2_LICENSE_TYPE&gt;&lt;/PROFESSIONAL2_LICENSE_TYPE&gt;
	&lt;PROFESSIONAL3_FIRST_NAME&gt;&lt;/PROFESSIONAL3_FIRST_NAME&gt;
	&lt;PROFESSIONAL3_MIDDLE_NAME&gt;&lt;/PROFESSIONAL3_MIDDLE_NAME&gt;
	&lt;PROFESSIONAL3_LAST_NAME&gt;&lt;/PROFESSIONAL3_LAST_NAME&gt;
	&lt;PROFESSIONAL3_SSN&gt;&lt;/PROFESSIONAL3_SSN&gt;
	&lt;PROFESSIONAL3_DATEOFBIRTH&gt;&lt;/PROFESSIONAL3_DATEOFBIRTH&gt;
	&lt;PROFESSIONAL3_STREETADDRESS&gt;&lt;/PROFESSIONAL3_STREETADDRESS&gt;
	&lt;PROFESSIONAL3_CITY&gt;&lt;/PROFESSIONAL3_CITY&gt;
	&lt;PROFESSIONAL3_ST&gt;&lt;/PROFESSIONAL3_ST&gt;
	&lt;PROFESSIONAL3_ZIP&gt;&lt;/PROFESSIONAL3_ZIP&gt;
	&lt;PROFESSIONAL3_LICENSE_NUMBER&gt;&lt;/PROFESSIONAL3_LICENSE_NUMBER&gt;
	&lt;PROFESSIONAL3_LICENSE_TYPE&gt;&lt;/PROFESSIONAL3_LICENSE_TYPE&gt;

	&lt;HISTORYDATEYYYYMM&gt;&lt;/HISTORYDATEYYYYMM&gt;
 &lt;/ROW&gt;
&lt;/DATASET&gt;

</pre>
*/



EXPORT MortgageCollusion_Batch_Service := MACRO
	import Risk_Indicators;

	batch_in  := dataset( [], sna.layouts.mortgage_collusion_input ) : stored('batch_in');
	unsigned1 glb       								:= 8  : stored('GLBPurpose');
	unsigned1 dppa      								:= 0  : stored('DPPAPurpose');
	string50 DataRestrictionMask       	:= risk_indicators.iid_constants.default_DataRestriction  : stored('DataRestrictionMask');
	gateways 														:= Gateway.Constants.void_gateway;	
	integer	bsVersion           := 4;
	boolean	isFCRA              := false;
	unsigned1 AppendBest 				:= 0;   //lead integrity-value=2 get ssn on file for did, replease input ssn , IID =1, search best file for ssn, hold on to but don't replace input ssn


final := SNA.MortgageCollusion_Function(batch_in, DataRestrictionMask,  gateways, dppa,  glb, AppendBest,	isFCRA, bsVersion);


	
output(final, named('Results'));





ENDMACRO;
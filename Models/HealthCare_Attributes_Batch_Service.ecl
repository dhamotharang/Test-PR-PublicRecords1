/*--SOAP--
<message name="HealthCare_Attributes_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="Version" type="xsd:integer"/>
</message>
*/
/*--INFO-- Health Care Attributes Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;
      &lt;HistorydateYYYYMM&gt;&lt;/HistorydateYYYYMM&gt;
      &lt;UniqueID&gt;&lt;/UniqueID&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import models, gateway, AutoStandardI, RiskWise, STD;

export HealthCare_Attributes_Batch_Service := MACRO
// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);

batchin := dataset([],Models.layouts.Layout_HealthCare_Attributes_Batch_In) 			: stored('batch_in',few);
gateways := Gateway.Constants.void_gateway;

unsigned1 DPPAPurpose 					:= 0				: stored('DPPAPurpose'); // ** kwh - Should we be looking at DPPA or not?
unsigned1 GLBPurpose := RiskWise.permittedUse.fraudGLBA: stored('GLBPurpose');
string50  DataRestriction 			:= AutoStandardI.GlobalModule().DataRestrictionMask;
string10	DataPermission 				:= AutoStandardI.GlobalModule().DataPermissionMask;

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_HealthCare_Attributes_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));

// add sequence to matchup later to add acctno to output
Models.layouts.Layout_HealthCare_Attributes_In into_HCA_in(batchinseq le) := TRANSFORM
	self.seq := (string)le.seq;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.FirstName := STD.Str.touppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.LastName := STD.Str.touppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.MiddleName := STD.Str.touppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.SuffixName := STD.Str.touppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	
	self.streetAddr := STD.Str.ToUpperCase(le.street_addr);
	self.City := STD.Str.ToUpperCase(le.p_City_name);
	self.State := STD.Str.ToUpperCase(le.st);
	self.Zip := le.z5;
	self.HomePhone := le.Home_Phone;
	self.DateOfBirth := le.DOB;
	self.SSN := le.SSN;
	self.HistoryDate := if(le.HistorydateYYYYMM = 0, 999999, le.HistorydateYYYYMM);
	self.DID := le.UniqueID;
	self := [];
END;
HCA_in := project(batchinseq, into_HCA_in(left));

/* ***************************************
	 *     Gather Attributes:      				 *
   *************************************** */
	 
FunctionResults := Models.HealthCare_Attributes_Search_Function(HCA_in, GLBPurpose, DPPAPurpose, DataRestriction, DataPermission,
                                                                                                                      LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                                      TransactionID := TransactionID, 
                                                                                                                      BatchUID := BatchUID, 
                                                                                                                      GlobalCompanyID := GlobalCompanyID);
	 
Results := join(batchinseq, FunctionResults, left.seq=right.seq, transform(models.layouts.layout_HealthCare_Attributes_batch,
			self.acctno := left.acctno;
			self.HistoryDate := left.HistorydateYYYYMM;
			self.DID := (integer)right.DID;
			self := right));
	
output(Results, named('Results'));


ENDMACRO;

// models.HealthCare_Attributes_Batch_Service();
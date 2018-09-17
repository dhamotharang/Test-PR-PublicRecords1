/*--SOAP--
<message name="FraudAdvisor Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="IncludeVersion1" type="xsd:boolean"/>
	<part name="IncludeVersion2" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="OFACSearching" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/> 
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO-- Contains Attributes Version 1, Version2 and room for 2 scores*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;p_City_name&gt;&lt;/p_City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;DL_Number&gt;&lt;/DL_Number&gt;
      &lt;DL_State&gt;&lt;/DL_State&gt;
      &lt;Home_Phone&gt;&lt;/Home_Phone&gt;
      &lt;Work_Phone&gt;&lt;/Work_Phone&gt;
      &lt;Prim_Range&gt;&lt;/Prim_Range&gt;
      &lt;Predir&gt;&lt;/Predir&gt;
      &lt;Prim_Name&gt;&lt;/Prim_Name&gt;
      &lt;Suffix&gt;&lt;/Suffix&gt;
      &lt;Postdir&gt;&lt;/Postdir&gt;
      &lt;Unit_Desig&gt;&lt;/Unit_Desig&gt;
      &lt;Sec_Range&gt;&lt;/Sec_Range&gt;
      &lt;Age&gt;&lt;/Age&gt;
      &lt;ip_addr&gt;&lt;/ip_addr&gt;
      &lt;email&gt;&lt;/email&gt;
      &lt;HistoryDateYYYYMM&gt;&lt;/HistoryDateYYYYMM&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import address, risk_indicators, models, riskwise, ut, gateway, AutoStandardI;


export FraudAdvisor_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

fp_batch_in := Models.FraudAdvisor_Batch_Service_Layouts.BatchInput;

batchin := dataset([],fp_batch_in) 			: stored('batch_in',few);

Boolean VALIDATION := False; //True for validation mode, false for production mode

// module here inherits the interface & overrides it
 InputArgs := MODULE (Models.FraudAdvisor_Batch_Service_Interfaces.Input)
					export string ModelName_in := '' : stored('ModelName');
					export boolean   doVersion1 := false				: stored('IncludeVersion1');
					export boolean   doVersion2 := false				: stored('IncludeVersion2');
					export unsigned1 dppa 			:= 0 						: stored('DPPAPurpose');
					export unsigned1 glb 				:= AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
					export string5   industry_class_val := '' 	: stored('IndustryClass');
					export boolean   ofac_Only         := true 	: stored('OfacOnly');
					export boolean   ofacSearching     := true 	: stored('OFACSearching');
					export boolean   excludewatchlists := false : stored('ExcludeWatchLists');
					export unsigned1 OFACVersion       := 1     : stored('OFACVersion');
					export boolean   IncludeOfac       := false : stored('IncludeOfac');
					export real      gwThreshold       := 0.84  : stored('GlobalWatchlistThreshold');
					export boolean   addtl_watchlists  := false : stored('IncludeAdditionalWatchLists');
					export boolean   usedobFilter      := false : stored('UseDOBFilter');
					export integer2  dobradius         := 2     : stored('DOBRadius');
					export unsigned1 RedFlag_version   := 0 		: stored('RedFlag_version');
					export string    DataRestriction   := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
					export string    DataPermission    := risk_indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
          //This would correspond to requestedattributegroups = 'fraudpointattrvparo' in XML
          export boolean   doParo_attrs      := false : stored('IncludeParoAttrs'); 
		END;

gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(le.servicename = 'bridgerwlc' and InputArgs.OFACVersion = 4 and StringLib.StringToLowerCase(InputArgs.ModelName_in) not in Risk_Indicators.iid_constants.FABatch_WatchlistModels, '', le.servicename);
	
  self.url := if(le.servicename = 'bridgerwlc' and InputArgs.OFACVersion = 4 and StringLib.StringToLowerCase(InputArgs.ModelName_in) not in Risk_Indicators.iid_constants.FABatch_WatchlistModels, '', le.url); 		
  
  self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if(InputArgs.OFACVersion = 4 and StringLib.StringToLowerCase(InputArgs.ModelName_in) in Risk_Indicators.iid_constants.FABatch_WatchlistModels and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

wModel := Models.FraudAdvisor_Batch_Service_Records(InputArgs,batchin,gateways);

#IF(VALIDATION)
  output(wModel, NAMED('Results'));
#ELSE
 
  results := PROJECT(wModel, models.Layout_FD_Batch_Out);
  output(results, NAMED('Results'));

  BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
  dIPIn := PROJECT(batchin,TRANSFORM(Royalty.RoyaltyNetAcuity.IPData,SELF.AcctNo := LEFT.AcctNo; SELF.IPAddr:=LEFT.ip_addr;));
  dRoyaltiesByAcctno 	:= Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(gateways, dIPIn, wModel, TRUE);
  dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);
  output(dRoyalties,NAMED('RoyaltySet'));
#END

ENDMACRO;
// Models.FraudAdvisor_Batch_Service()
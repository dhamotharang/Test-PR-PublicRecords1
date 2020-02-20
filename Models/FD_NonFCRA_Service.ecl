/*--SOAP--
<message name="FD5607_1_Service">
	<part name="batch_in" type="tns:XmlDataSet"/>
	<part name="tribCode" type="xsd:string"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
 </message>
*/
/*--INFO-- Contains non-declinable Fraud Advisor used in fcra products */

import Riskwise, risk_indicators;

export FD_NonFCRA_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
unsigned1 ofac_version      := 1        : stored('OFACVersion');

unsigned1 dppa := 0;
unsigned1 glb := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
unsigned3 history_date := 999999  	: stored('HistoryDateYYYYMM');
string4   tribCode_value := ''	: stored('tribCode');
string   DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');
    
tribCode := STD.Str.ToLowerCase(tribCode_Value);

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version = 4 and tribcode in ['','ex17','ex80'] and le.servicename = 'bridgerwlc', le.servicename, '');
	self.url := if(ofac_version = 4 and tribcode in ['','ex17','ex80'] and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if(ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

include_ofac := if(ofac_version = 1, false, true);
global_watchlist_threshold := if(ofac_version in [1, 2, 3], 0.84, 0.85);


prep	:= dataset([],Risk_Indicators.Layout_CIID_BtSt_In) : stored('batch_in',few);

iid_results := Risk_Indicators.InstantId_BtSt_Function(prep, gateways, dppa, glb, false, false, true, true, true, ofac_version := ofac_version, include_ofac := include_ofac, 
                                                       global_watchlist_threshold := global_watchlist_threshold, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                       LexIdSourceOptout := LexIdSourceOptout, 
                                                      TransactionID := TransactionID, 
                                                      BatchUID := BatchUID, 
                                                      GlobalCompanyID := GlobalCompanyID);

clamfull := Risk_Indicators.BocaShell_BtSt_Function(iid_results, gateways, dppa, glb, false, false, true, false, false, true, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);
									
Risk_Indicators.layout_boca_shell into_modelinput(clamfull le, integer i) := TRANSFORM
	self := if(i=1, le.bill_to_out, le.ship_to_out);
END;
clam := project(clamfull, into_modelinput(left,1));
clam2 := project(clamfull, into_modelinput(left,2));



/* build easi_census data for 2x products */
	risk_indicators.layout_output mkOutput( risk_indicators.layout_ciid_btst_Output le, UNSIGNED bt ) := TRANSFORM
		self := if( bt = 1, le.Bill_To_Output, le.Ship_To_Output );
	END;

	easi_census_bt := join( project( iid_results, mkOutput(left, 1) ), Easi.Key_Easi_Census,
			keyed(right.geolink=left.st+left.county+left.geo_blk),
			transform(easi.layout_census, 
						self.state:= left.st,
						self.county:=left.county,
						self.tract:=left.geo_blk[1..6],
						self.blkgrp:=left.geo_blk[7],
						self.geo_blk:=left.geo_blk,
						self := right));

	easi_census_st := join( project( iid_results, mkOutput(left, 2) ), Easi.Key_Easi_Census,
			keyed(right.geolink=left.st+left.county+left.geo_blk),
			transform(easi.layout_census, 
						self.state:= left.st,
						self.county:=left.county,
						self.tract:=left.geo_blk[1..6],
						self.blkgrp:=left.geo_blk[7],
						self.geo_blk:=left.geo_blk,
						self := right));
//

fd5603_ofac := ( tribcode = 'ex80' );

ret := map(
	tribcode in ['ex73','ex80'] => Models.FD5603_1_0(clam, fd5603_ofac ), // use ofac when running ex80
	tribcode in ['2x13','2x14','2x15','2x17','2x18','2x19'] => Models.FD9606_0_0(clam, ungroup(easi_census_bt), false),
	tribcode = '2x20' => Models.FD9606_0_0(clam, ungroup(easi_census_bt), false),
	tribcode = 'ex17' => Models.FD5709_1_0(clam, true),
	Models.FD5607_1_0(clam, true)
);

ret2 := map(
	tribcode in ['ex73','ex80'] => Models.FD5603_1_0(clam2, fd5603_ofac ), // use ofac when running ex80
	tribcode in ['2x13','2x14','2x15','2x17','2x18','2x19'] => Models.FD9606_0_0(clam2, ungroup(easi_census_st), false),
	tribcode = '2x20' => Models.FD9606_0_0(clam2, ungroup(easi_census_st), false),
	tribcode = 'ex17' => Models.FD5709_1_0(clam2, true),
	Models.FD5607_1_0(clam2, true)
);


final := ret + ret2;

OUTPUT(final, named('Results'));

ENDMACRO;
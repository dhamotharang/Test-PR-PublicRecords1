import models, risk_indicators, easi, riskwise, business_risk, riskview,  iesp;

// model environment options:  1 = both nonfcra and fcra, 2 = FCRA only, 3= nonFCRA only
EXPORT Runway_function(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, 
boolean exclude_reasons = False, 
integer model_environment = 1) := function

ofac := false;
inCalif := false;
isStudent := false;
isCalifornia := false;
usebillTo := false;
IBICID := false;
ISbusiness := false;
criminal := false;
xmlPrescreenOptOut := false;
num_reasons := 4;
WantstoSeeBillToShipToDifferenceFlag := false;
string inputfluxgrade:= 'A0';
unsigned3 history_date := clam[1].historydate;
Unsigned in_employment_years := 0;
Unsigned in_employment_months := 0;
Unsigned total_income := 0;
String 	 returncode := '';
String   pay_frequency := '';
String retailzip := '0';
String loadamount := '0';
String Segment := '';
boolean lexIDOnlyOnInput := false; //for RV 50 models

// set to true if model environment wanted is FCRA only
isFCRA := if(model_environment=2, true, false); 

riskview.layouts.Layout_Custom_Inputs intoCustomInput(clam le) := TRANSFORM
		customInputs := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(iesp.riskview_share.t_ModelOptionRV,
					self.OptionName:= 'tuln_channel';
					self.OptionValue := '';
					SELF := []))[1];

		Self.seq := (INTEGER)le.seq;
		self.Custom_Inputs := customInputs;
		END;
		
channel_inputs := project(ungroup(clam), intoCustomInput(LEFT));

census := ungroup(join(clam, easi.Key_Easi_Census,
right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
transform(easi.Layout_Census, self := right, self := []), keep(1)));

paro_clam := project(clam, transform(risk_indicators.Layout_Boca_Shell,
		// clean the address with the TOMTOM cleaner instead like we do in IT1O_function
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr_paro(left.shell_input.in_streetaddress, left.shell_input.in_city, left.shell_input.in_State, left.shell_input.in_Zipcode);	
	
	self.shell_input.prim_range := clean_addr[1..10];
	self.shell_input.predir := clean_addr[11..12];
	self.shell_input.prim_name := clean_addr[13..40];
	self.shell_input.addr_suffix := clean_addr[41..44];
	self.shell_input.postdir := clean_addr[45..46];
	self.shell_input.unit_desig := clean_addr[47..56];
	self.shell_input.sec_range := clean_addr[57..64];
	self.shell_input.p_city_name := clean_addr[90..114];
	
	self.shell_input.z5 := clean_addr[117..121];
	self.shell_input.zip4 := clean_addr[122..125];
	self.shell_input.lat := clean_addr[146..155];
	self.shell_input.long := clean_addr[156..166];
	self.shell_input.addr_type := clean_addr[139];
	self.shell_input.addr_status := clean_addr[179..182];
	
	// pay special attention to these 3 fields that we use to search the old y2000 census file with for the MSN605
	self.shell_input.st := clean_addr[115..116];
	self.shell_input.county := clean_addr[143..145];
	self.shell_input.geo_blk := clean_addr[171..177];

	self := left));
	
census2000 := ungroup(join(paro_clam, Easi.Key_Easi_Census_2000,
right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
transform(easi.Layout_Census, self := right, self := []), keep(1)));

// Business := dataset([], Business_Risk.Layout_Output);
Business := project(ungroup(clam), transform(Business_Risk.Layout_Output, self := left, self :=[]));
// Reasons := dataset([], riskwise.Layout_BusReasons_Input);
Reasons := project(ungroup(clam), transform(riskwise.Layout_BusReasons_Input, self := left, self := []));
// clambtst := dataset([], Risk_Indicators.Layout_BocaShell_BtSt_Out);
clambtst := project(ungroup(clam), transform(Risk_Indicators.Layout_BocaShell_BtSt_Out, self.Bill_To_Out := left, self.ship_to_out := left, self := []));
// biid := dataset([], Business_Risk.Layout_BIID_BtSt_Output);
biid := project(ungroup(clam), transform(Business_Risk.Layout_BIID_BtSt_Output, self.Bill_to_Output := left, self.ship_to_output := left, self := []));
// indata := dataset([], RiskWise.Layout_CD2I);
indata := project(ungroup(clam), transform(RiskWise.Layout_CD2I, self := left));
// dataset(riskwise.layouts.cdn706_variables)
modelvariables := project(ungroup(clam), transform(RiskWise.Layouts.cdn706_variables, self := left, self := []));
// grouped dataset(Risk_Indicators.Layout_CIID_BtSt_Output) iid_results
iid_results := project(ungroup(clam), transform(Risk_Indicators.Layout_CIID_BtSt_Output, self := left, self := []));
// dataset(Risk_Indicators.collection_shell_mod.collection_shell_layout_full) cclam ) 
cclam := project(ungroup(clam), transform(Risk_Indicators.collection_shell_mod.collection_shell_layout_full, self := left, self := []));
// dataset(Business_Risk.Layout_Business_Shell) bshell
bshell := project(ungroup(clam), transform(Business_Risk.Layout_Business_Shell, self.biid := left, self := left, self := []));

custom_clam := project(clam, transform(Risk_Indicators.Layout_Bocashell_with_Custom, self := left, self := []));

recoverScoreBatchIn := project(ungroup(clam), transform(Models.Layout_RecoverScore_Batch_Input, self := left.shell_input, self := left, 
self := []
));
// dataset(riskwise.Layout_IT1O_model_in) rsn_prep
rsn_prep := project(ungroup(clam), transform(riskwise.Layout_IT1O_model_in, self := left, self := [])); 
// dataset(riskwise.Layout_SkipTrace) skiptrace) 
skiptrace:= project(ungroup(clam), transform(riskwise.Layout_SkipTrace, self := left, self := [])); 
// dataset(riskwise.Layout_BusReasons_Input) orig_input
input:= project(ungroup(clam), transform(riskwise.Layout_BusReasons_Input, self := left, self := [])); 	
// dataset(Business_Risk.Layout_Output) biid,
biidRisk:= project(ungroup(clam), transform(Business_Risk.Layout_Output, self := left, self := []));

bs_with_ip :=  record
risk_indicators.Layout_Boca_Shell bs;
riskwise.Layout_IP2O ip;
end;

clam_ip := project(clam,transform(bs_with_ip, self.bs := left, self.IP:=[])); 

BocaShell_With_IP := RECORD
Risk_Indicators.Layout_Boca_Shell bs;
RiskWise.Layout_IP2O ip;
END;

customCDInputs := ungroup(project(clam, transform(Models.Layout_CD_CustomModelInputs, self := left, self := [])));
hcpCLAM := ungroup(project(clam, transform(Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare,
self.BocaShell := left, self.input_seq := left.seq, self := [])));

np31_cvi_layout := RECORD
	riskwise.Layout_NP2O;
	dataset(Risk_Indicators.Layout_Desc) ri;
	dataset(Risk_Indicators.Layout_Desc) fua;
	unsigned4 seq;
	string verlast := '';
	string veraddr := '';
	riskwise.Layout_for_Royalties;
END;

// np31_iid_results := project(ungroup(clam), transform(np31_cvi_layout, self.seq := left.seq, self.score := risk_indicators.cviScoreV1(); self := []));
np31_iid_results := project(ungroup(clam), transform(np31_cvi_layout, self.seq := left.seq, self.score := '00', self := []));
// np31_iid_results := dataset([], np31_cvi_layout);



ain509_0_0_score := Models.AIN509_0_0	(clam, ofac, incalif);
// output(ain509_0_0_score, named('ain509_0_0_score'));

with_ain509_0_0 := join(clam, ain509_0_0_score,
left.seq = right.seq,
transform(Models.layout_Runway,
self.seq := left.seq,
self.did := left.did;
self.nap := (string)left.iid.nap_summary;
self.nas := (string)left.iid.nas_summary;
self.cvi_score := (string)left.iid.cvi;
self.cvi_reason1 := if(exclude_reasons, '',  left.iid.reason1);
self.cvi_reason2 := if(exclude_reasons, '',  left.iid.reason2);
self.cvi_reason3 := if(exclude_reasons, '',  left.iid.reason3);
self.cvi_reason4 := if(exclude_reasons, '',  left.iid.reason4);

self.ain509_0_0_score := right.score;
self.ain509_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain509_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain509_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain509_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

));
// output(with_ain509_0_0, named('with_ain509_0_0'));



ain602_1_0_score := Models.AIN602_1_0	(clam, ofac);
// output(ain602_1_0_score, named('ain602_1_0_score'));

with_ain602_1_0	:= join(with_ain509_0_0, ain602_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.ain602_1_0_score := right.score;
self.ain602_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain602_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain602_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain602_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_ain602_1_0, named('with_ain602_1_0'));



ain605_1_0_score := Models.AIN605_1_0	(clam, ofac);
// output(ain605_1_0_score, named('ain605_1_0_score'));

with_ain605_1_0	:= join(with_ain602_1_0, ain605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.ain605_1_0_score := right.score;
self.ain605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_ain605_1_0, named('with_ain605_1_0'));

ain605_2_0_score := Models.AIN605_2_0	(clam, ofac, '');
// output(ain605_2_0_score, named('ain605_2_0_score'));

with_ain605_2_0	:= join(with_ain605_1_0, ain605_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.ain605_2_0_score := right.score;
self.ain605_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain605_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain605_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain605_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_ain605_2_0, named('with_ain605_2_0'));


ain605_3_0_score := Models.AIN605_3_0	(clam, ofac);
// output(ain605_3_0_score, named('ain605_3_0_score'));

with_ain605_3_0	:= join(with_ain605_2_0, ain605_3_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.ain605_3_0_score := right.score;
self.ain605_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain605_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain605_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain605_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_ain605_3_0, named('with_ain605_3_0'));



ain801_1_0_score := Models.AIN801_1_0	(clam, ofac,'');
// output(ain801_1_0_score, named('ain801_1_0_score'));

with_ain801_1_0	:= join(with_ain605_3_0, ain801_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.ain801_1_0_score := right.score;
self.ain801_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.ain801_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.ain801_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.ain801_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_ain801_1_0, named('with_ain801_1_0'));	


anmk909_0_1_score := Models.ANMK909_0_1	(clam);
// output(anmk909_0_1_score, named('anmk909_0_1_score'));

with_anmk909_0_1	:= join(with_ain801_1_0, anmk909_0_1_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.anmk909_0_1_score := right.score;
self := left), keep(1), left outer);
// output(with_anmk909_0_1, named('with_anmk909_0_1'));


awn510_0_0_score := Models.AWN510_0_0	(clam);
// output(awn510_0_0_score, named('awn510_0_0_score'));

with_awn510_0_0	:= join(with_anmk909_0_1, awn510_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.awn510_0_0_score := right.score;
self.awn510_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.awn510_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.awn510_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.awn510_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_awn510_0_0, named('with_awn510_0_0'));




awn603_1_0_score := Models.AWN603_1_0	(clam);
// output(awn603_1_0_score, named('awn603_1_0_score'));

with_awn603_1_0	:= join(with_awn510_0_0, awn603_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.awn603_1_0_score := right.score;
self.awn603_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.awn603_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.awn603_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.awn603_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_awn603_1_0, named('with_awn603_1_0'));



bd3605_0_0_score := Models.BD3605_0_0	(clam, business, reasons, OFAC);
// output(BD3605_0_0_score, named('BD3605_0_0_score'));

with_BD3605_0_0	:= join(with_AWN603_1_0, BD3605_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd3605_0_0_score := right.score;
self.bd3605_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd3605_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd3605_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd3605_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD3605_0_0, named('with_BD3605_0_0'));


bd5605_0_0_score := Models.BD5605_0_0	(clam, business, reasons, OFAC);
// output(BD5605_0_0_score, named('BD5605_0_0_score'));

with_BD5605_0_0	:= join(with_BD3605_0_0, BD5605_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd5605_0_0_score := right.score;
self.bd5605_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd5605_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd5605_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd5605_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD5605_0_0, named('with_BD5605_0_0'));


bd5605_1_0_score := Models.BD5605_1_0	(clam, business, reasons, OFAC);
// output(BD5605_1_0_score, named('BD5605_1_0_score'));

with_BD5605_1_0	:= join(with_BD5605_0_0, BD5605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd5605_1_0_score := right.score;
self.bd5605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd5605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd5605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd5605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD5605_1_0, named('with_BD5605_1_0'));

bd5605_2_0_score := Models.BD5605_2_0	(clam, business, reasons, OFAC);
// output(BD5605_2_0_score, named('BD5605_2_0_score'));

with_BD5605_2_0	:= join(with_BD5605_1_0, BD5605_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd5605_2_0_score := right.score;
self.bd5605_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd5605_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd5605_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd5605_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD5605_2_0, named('with_BD5605_2_0'));


bd5605_3_0_score := Models.BD5605_3_0	(clam, business, reasons, OFAC);
// output(BD5605_3_0_score, named('BD5605_3_0_score'));

with_BD5605_3_0	:= join(with_BD5605_2_0, BD5605_3_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd5605_3_0_score := right.score;
self.bd5605_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd5605_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd5605_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd5605_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD5605_3_0, named('with_BD5605_3_0'));




bd9605_0_0_score := Models.BD9605_0_0 (clam, business, reasons, OFAC);
// output(BD9605_0_0_score, named('BD9605_0_0_score'));

with_BD9605_0_0	:= join(with_BD5605_3_0, BD9605_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd9605_0_0_score := right.score;
self.bd9605_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd9605_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd9605_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd9605_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD9605_0_0, named('with_BD9605_0_0'));



bd9605_1_0_score := Models.BD9605_1_0	(clam, business, reasons, OFAC);
// output(BD9605_1_0_score, named('BD9605_1_0_score'));

with_BD9605_1_0	:= join(with_BD9605_0_0, BD9605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.bd9605_1_0_score := right.score;
self.bd9605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.bd9605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.bd9605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.bd9605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_BD9605_1_0, named('with_BD9605_1_0'));

CDN1109_1_0_score := Models.CDN1109_1_0 (group(clambtst,bill_to_out.seq), customCDInputs, false, WantstoSeeBillToShipToDifferenceFlag );
with_CDN1109_1_0	:= join(with_bd9605_1_0, CDN1109_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1109_1_0_score := right.score;
self.CDN1109_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1109_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1109_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1109_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1109_1_0, named('with_CDN1109_1_0'));		 

    
CDN1205_1_0_score := Models.CDN1205_1_0 (group(clambtst,bill_to_out.seq), indata, false, biid);
with_CDN1205_1_0	:= join(with_CDN1109_1_0, CDN1205_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1205_1_0_score := right.score;
self.CDN1205_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1205_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1205_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1205_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1205_1_0, named('with_CDN1205_1_0'));		 

CDN1305_1_0_score := Models.CDN1305_1_0 (group(clambtst,bill_to_out.seq), customCDInputs, false, WantstoSeeBillToShipToDifferenceFlag ); 
with_CDN1305_1_0	:= join(with_CDN1205_1_0, CDN1305_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1305_1_0_score := right.score;
self.CDN1305_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1305_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1305_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1305_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1305_1_0, named('with_CDN1305_1_0'));		 

CDN1404_1_0_score := Models.CDN1404_1_0 (group(clambtst,bill_to_out.seq), customCDInputs, false, WantstoSeeBillToShipToDifferenceFlag ); 
with_CDN1404_1_0	:= join(with_CDN1305_1_0, CDN1404_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1404_1_0_score := right.score;
self.CDN1404_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1404_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1404_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1404_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1404_1_0, named('with_CDN1404_1_0'));	

CDN1410_1_0_score := Models.CDN1410_1_0 (group(clambtst,bill_to_out.seq), customCDInputs, false, WantstoSeeBillToShipToDifferenceFlag, True ); 
with_CDN1410_1_0	:= join(with_CDN1404_1_0, CDN1410_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1410_1_0_score := right.score;
self.CDN1410_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1410_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1410_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1410_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1410_1_0, named('with_CDN1410_1_0'));	

CDN1506_1_0_score := Models.CDN1506_1_0 (group(clambtst,bill_to_out.seq), customCDInputs, false, WantstoSeeBillToShipToDifferenceFlag, True ); 
with_CDN1506_1_0	:= join(with_CDN1410_1_0, CDN1506_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1506_1_0_score := right.score;
self.CDN1506_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1506_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1506_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1506_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN1410_1_0, named('with_CDN1410_1_0'));	

CDN1508_1_0_score := Models.CDN1508_1_0 (group(clambtst,bill_to_out.seq),indata, false, biid ); 
with_CDN1508_1_0	:= join(with_CDN1506_1_0, CDN1508_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.CDN1508_1_0_score := right.score;
self.CDN1508_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.CDN1508_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.CDN1508_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.CDN1508_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.CDN1508_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.CDN1508_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_CDN1508_1_0, named('with_CDN1508_1_0'));	

/*  Flag ship model for Order Score  */  
OSN1504_0_0_score := Models.OSN1504_0_0 (group(clambtst,bill_to_out.seq), indata, IBICID, WantstoSeeBillToShipToDifferenceFlag, false, false); 
with_OSN1504_0_0	:= join(with_CDN1508_1_0, OSN1504_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.OSN1504_0_0_score := right.score;
self.OSN1504_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.OSN1504_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.OSN1504_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.OSN1504_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.OSN1504_0_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.OSN1504_0_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_OSN1504_0_0, named('with_OSN1504_0_0'));	

/*  Custom model for Vivid Seats within Order Score  */  
OSN1608_1_0_score :=  models.OSN1608_1_0(group(clambtst,bill_to_out.seq), IBICID, WantstoSeeBillToShipToDifferenceFlag, false, false);   
with_OSN1608_1_0	:= join(with_OSN1504_0_0, OSN1608_1_0_score,                                     //Join this set of reason codes with the previous set 
left.seq=right.seq,
transform(Models.layout_Runway,
self.OSN1608_1_0_score := right.score;
self.OSN1608_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.OSN1608_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.OSN1608_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.OSN1608_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.OSN1608_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.OSN1608_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_OSN1608_1_0, named('with_OSN1608_1_0'));	


/*  Custom model for Wallmart within Order Score  */  
OSN1803_1_0_score :=  models.OSN1803_1_0(group(clambtst,bill_to_out.seq), IBICID, WantstoSeeBillToShipToDifferenceFlag, false, false);   
with_OSN1803_1_0	:= join(with_OSN1608_1_0, OSN1803_1_0_score,                                     //Join this set of reason codes with the previous set 
left.seq=right.seq,
transform(Models.layout_Runway,
self.OSN1803_1_0_score := right.score;
self.OSN1803_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.OSN1803_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.OSN1803_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.OSN1803_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.OSN1803_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.OSN1803_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_OSN1803_1_0, named('with_OSN1803_1_0'));	



CDN604_0_0_score := Models.CDN604_0_0 (group(clambtst,bill_to_out.seq), ofac);
// output(CDN604_0_0_score, named('CDN604_0_0_score'));

with_CDN604_0_0	:= join(with_OSN1803_1_0, CDN604_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn604_0_0_score := right.score;
self.cdn604_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn604_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn604_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn604_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN604_0_0, named('with_CDN604_0_0'));



CDN604_1_0_score := Models.CDN604_1_0	(group(clambtst,bill_to_out.seq),biid );
// output(CDN604_1_0_score, named('CDN604_1_0_score'));

with_CDN604_1_0	:= join(with_CDN604_0_0, CDN604_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn604_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_CDN604_1_0, named('with_CDN604_1_0'));



CDN604_2_0_score := Models.CDN604_2_0	(group(clambtst,bill_to_out.seq),ofac );
// output(CDN604_2_0_score, named('CDN604_2_0_score'));

with_CDN604_2_0	:= join(with_cdn604_1_0, CDN604_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn604_2_0_score := right.score;
self.cdn604_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn604_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn604_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn604_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN604_2_0, named('with_CDN604_2_0'));



CDN604_3_0_score := Models.CDN604_3_0	(group(clambtst,bill_to_out.seq),ofac );
// output(CDN604_3_0_score, named('CDN604_3_0_score'));

with_CDN604_3_0	:= join(with_cdn604_2_0, CDN604_3_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn604_3_0_score := right.score;
self.cdn604_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn604_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn604_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn604_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN604_3_0, named('with_CDN604_3_0')); 




CDN604_4_0_score := Models.CDN604_4_0	(group(clambtst,bill_to_out.seq),ofac );
// output(CDN604_4_0_score, named('CDN604_4_0_score'));

with_CDN604_4_0	:= join(with_CDN604_3_0, CDN604_4_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn604_4_0_score := right.score;
self.cdn604_4_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn604_4_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn604_4_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn604_4_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN604_4_0, named('with_CDN604_4_0'));



CDN605_1_0_score := Models.CDN605_1_0	(group(clambtst,bill_to_out.seq),ofac, usebillTo );
// output(CDN605_1_0_score, named('CDN605_1_0_score'));

with_CDN605_1_0	:= join(with_CDN604_4_0, CDN605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn605_1_0_score := right.score;
self.cdn605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN605_1_0, named('with_CDN605_1_0'));

CDN606_2_0_score := Models.CDN606_2_0 (group(clambtst,bill_to_out.seq), indata, IBICID, ISbusiness, biid);
// output(CDN606_2_0_score, named('CDN606_2_0_score'));

with_CDN606_2_0	:= join(with_cdn605_1_0, CDN606_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn606_2_0_score := right.score;
self.cdn606_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn606_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn606_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn606_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN606_2_0, named('with_CDN606_2_0'));

CDN706_1_0_score := Models.CDN706_1_0	(modelvariables);
// output(CDN706_1_0_score, named('CDN706_1_0_score'));

with_CDN706_1_0	:= join(with_cdn606_2_0, CDN706_1_0_score,
left.seq=right.indata.seq,
transform(Models.layout_Runway,
self.cdn706_1_0_score := (string)right.score;
self.cdn706_1_0_bt_reason1 := if(exclude_reasons, '', right.bt_reasons[1].hri);
self.cdn706_1_0_bt_reason2 := if(exclude_reasons, '', right.bt_reasons[2].hri);
self.cdn706_1_0_bt_reason3 := if(exclude_reasons, '', right.bt_reasons[3].hri);
self.cdn706_1_0_bt_reason4 := if(exclude_reasons, '', right.bt_reasons[4].hri);

self.cdn706_1_0_st_reason1 := if(exclude_reasons, '', right.st_reasons[1].hri);
self.cdn706_1_0_st_reason2 := if(exclude_reasons, '', right.st_reasons[2].hri);
self.cdn706_1_0_st_reason3 := if(exclude_reasons, '', right.st_reasons[3].hri);
self.cdn706_1_0_st_reason4 := if(exclude_reasons, '', right.st_reasons[4].hri);
self := left), keep(1), left outer);
// output(with_CDN706_1_0, named('with_CDN6706_1_0'));

CDN707_1_0_score := Models.CDN707_1_0 (group(clambtst,bill_to_out.seq), indata, IBICID, WantstoSeeBillToShipToDifferenceFlag);
// output(CDN707_1_0_score, named('CDN707_1_0_score'));

with_CDN707_1_0	:= join(with_cdn706_1_0, CDN707_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn707_1_0_score := right.score;
self.cdn707_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn707_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn707_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn707_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN707_1_0, named('with_CDN707_1_0'));

CDN712_0_0_score := Models.CDN712_0_0 (group(clambtst,bill_to_out.seq), IBICID, WantstoSeeBillToShipToDifferenceFlag);
// output(CDN712_0_0_score, named('CDN712_0_0_score'));

with_CDN712_0_0	:= join(with_cdn707_1_0, CDN712_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn712_0_0_score := right.score;
self.cdn712_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn712_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn712_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn712_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN712_0_0, named('with_CDN712_0_0'));

CDN806_1_0_score := Models.CDN806_1_0 (group(clambtst,bill_to_out.seq), indata, IBICID, WantstoSeeBillToShipToDifferenceFlag);
// output(CDN806_1_0_score, named('CDN806_1_0_score'));

with_CDN806_1_0	:= join(with_cdn712_0_0, CDN806_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn806_1_0_score := right.score;
self.cdn806_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn806_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn806_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn806_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN806_1_0, named('with_CDN806_1_0'));


CDN908_1_0_score := Models.CDN908_1_0 (group(clambtst,bill_to_out.seq), indata, IBICID, WantstoSeeBillToShipToDifferenceFlag);
// output(CDN908_1_0_score, named('CDN908_1_0_score'));

with_CDN908_1_0	:= join(with_cdn806_1_0, CDN908_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cdn908_1_0_score := right.score;
self.cdn908_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.cdn908_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.cdn908_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.cdn908_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_CDN908_1_0, named('with_CDN908_1_0'));




CEN509_0_0_score := Models.Cen509_0_0(clam);
// output(CEN509_0_0_score, named('CEN509_0_0_score'));

with_CEN509_0_0	:= join(with_cdn908_1_0, CEN509_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.cen509_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_CEN509_0_0, named('with_CDEN509_0_0'));



CSN1007_0_0_score := Models.CSN1007_0_0(UNGROUP(cclam));
// output(CSN1007_0_0_score, named('CSN1007_0_0_score'));

with_Csn1007_0_0	:= join(with_cen509_0_0, CSN1007_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.Csn1007_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_CSN1007_0_0, named('with_CSN1007_0_0'));


FD3510_0_0_score := Models.FD3510_0_0(clam);
// output(fd3510_0_0_score, named('FD3510_0_0_score'));

with_FD3510_0_0	:= join(with_Csn1007_0_0, FD3510_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fd3510_0_0_score := right.score;
self.fd3510_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fd3510_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fd3510_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fd3510_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_fd3510_0_0, named('with_fd3510_0_0'));


FD3606_0_0_score := Models.FD3606_0_0(clam,  census, ofac);
// output(FD3606_0_0_score, named('FD3606_0_0_score'));

with_FD3606_0_0 := join(with_FD3510_0_0, FD3606_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fd3606_0_0_score := right.score;
self.fd3606_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fd3606_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fd3606_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fd3606_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_fd3606_0_0, named('with_fd3606_0_0'));

FD5510_0_0_score := Models.FD5510_0_0(clam);
// output(FD5510_0_0_score, named('FD5510_0_0_score'));

with_FD5510_0_0	:= join(with_fd3606_0_0, FD5510_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fd5510_0_0_score := right.score;
self.fd5510_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fd5510_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fd5510_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fd5510_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_fd5510_0_0, named('with_fd5510_0_0'));   


FD5603_1_0_score := Models.FD5603_1_0(clam);
// output(FD5603_1_0_score, named('FD5603_1_0_score'));

with_FD5603_1_0	:= join(with_FD5510_0_0, FD5603_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5603_1_0_score := right.score;
self.FD5603_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5603_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5603_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5603_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5603_1_0, named('with_FD5603_1_0'));



FD5603_2_0_score := Models.FD5603_2_0(clam);
// output(FD5603_2_0_score, named('FD5603_2_0_score'));

with_FD5603_2_0	:= join(with_FD5603_1_0, FD5603_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5603_2_0_score := right.score;
self.FD5603_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5603_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5603_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5603_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5603_2_0, named('with_FD5603_2_0'));

FD5603_3_0_score := Models.FD5603_3_0(clam);
// output(FD5603_3_0_score, named('FD5603_3_0_score'));

with_FD5603_3_0	:= join(with_FD5603_2_0, FD5603_3_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5603_3_0_score := right.score;
self.FD5603_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5603_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5603_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5603_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5603_3_0, named('with_FD5603_3_0'));

FD5607_1_0_score := Models.FD5607_1_0(clam, ofac);
// output(FD5607_1_0_score, named('FD5607_1_0_score'));

with_FD5607_1_0	:= join(with_FD5603_3_0, FD5607_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5607_1_0_score := right.score;
self.FD5607_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5607_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5607_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5607_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5607_1_0, named('with_FD5607_1_0'));

FD5609_1_0_score := Models.FD5609_1_0(clam, ofac, incalif);
// output(FD5609_1_0_score, named('FD5609_1_0_score'));

with_FD5609_1_0	:= join(with_FD5607_1_0, FD5609_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5609_1_0_score := right.score;
self.FD5609_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5609_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5609_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5609_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5609_1_0, named('with_FD5609_1_0'));


FD5609_2_0_score := Models.FD5609_2_0(clam, ofac, incalif);
// output(FD5609_2_0_score, named('FD5609_2_0_score'));

with_FD5609_2_0	:= join(with_FD5609_1_0, FD5609_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5609_2_0_score := right.score;
self.FD5609_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5609_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5609_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5609_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5609_2_0, named('with_FD5609_2_0'));

FD5709_1_0_score := Models.FD5709_1_0(clam);
// output(FD5709_1_0_score, named('FD5709_1_0_score'));

with_FD5709_1_0	:= join(with_FD5609_2_0, FD5709_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD5709_1_0_score := right.score;
self.FD5709_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD5709_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD5709_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD5709_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD5709_1_0, named('with_FD5709_1_0'));


FD9510_0_0_score := Models.FD9510_0_0(clam);
// output(FD9510_0_0_score, named('FD9510_0_0_score'));

with_FD9510_0_0	:= join(with_FD5709_1_0, FD9510_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9510_0_0_score := right.score;
self.FD9510_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9510_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9510_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9510_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9510_0_0, named('with_FD9510_0_0'));




FD9603_1_0_score := Models.FD9603_1_0(clam);
// output(FD9603_1_0_score, named('FD9603_1_0_score'));

with_FD9603_1_0	:= join(with_FD9510_0_0, FD9603_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9603_1_0_score := right.score;
self.FD9603_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9603_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9603_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9603_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9603_1_0, named('with_FD9603_1_0'));



FD9603_2_0_score := Models.FD9603_2_0(clam);
// output(FD9603_2_0_score, named('FD9603_2_0_score'));

with_FD9603_2_0	:= join(with_FD9603_1_0, FD9603_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9603_2_0_score := right.score;
self.FD9603_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9603_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9603_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9603_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9603_2_0, named('with_FD9603_2_0'));

FD9603_3_0_score := Models.FD9603_3_0(clam);
// output(FD9603_3_0_score, named('FD9603_3_0_score'));

with_FD9603_3_0	:= join(with_FD9603_2_0, FD9603_3_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9603_3_0_score := right.score;
self.FD9603_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9603_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9603_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9603_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9603_3_0, named('with_FD9603_3_0'));


FD9603_4_0_score := Models.FD9603_4_0(clam);
// output(FD9603_4_0_score, named('FD9603_4_0_score'));

with_FD9603_4_0	:= join(with_FD9603_3_0, FD9603_4_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9603_4_0_score := right.score;
self.FD9603_4_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9603_4_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9603_4_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9603_4_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9603_4_0, named('with_FD9603_4_0'));


FD9604_1_0_score := Models.FD9604_1_0(clam);
// output(FD9604_1_0_score, named('FD9604_1_0_score'));

with_FD9604_1_0	:= join(with_FD9603_4_0, FD9603_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9604_1_0_score := right.score;
self.FD9604_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9604_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9604_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9604_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9604_1_0, named('with_FD9604_1_0'));



FD9606_0_0_score := Models.FD9606_0_0(clam, census) ;
// output(FD9606_0_0_score, named('FD9606_0_0_score'));

with_FD9606_0_0	:= join(with_FD9604_1_0, FD9606_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FD9606_0_0_score := right.score;
self.FD9606_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FD9606_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FD9606_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FD9606_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9606_0_0, named('with_FD9606_1_0'));


FD9607_1_0_score := Models.FD9607_1_0(clam, ofac, isStudent);
// output(FD9607_1_0_score, named('FD9607_1_0_score'));

with_FD9607_1_0	:= join(with_FD9606_0_0, FD9607_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fd9607_1_0_score := right.score;
self.fd9607_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fd9607_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fd9607_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fd9607_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FD9607_1_0, named('with_FD9607_1_0'));



FP1109_0_0_score := Models.FP1109_0_0(Ungroup(clam_ip), num_reasons, criminal);
// output(FP1109_0_0_score, named('FP1109_0_0_score'));

with_FP1109_0_0	:= join(with_FD9607_1_0, FP1109_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1109_0_0_score := right.score;
self.fp1109_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1109_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1109_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1109_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP1109_0_0, named('with_FP1109_0_0'));

FP1210_1_0_score := Models.FP1210_1_0(clam);
with_FP1210_1_0	:= join(with_FP1109_0_0, FP1210_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1210_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_FP1210_1_0, named('with_FP1210_1_0'));

FP1303_1_0_score := Models.FP1303_1_0( ungroup(clam), 6, false);
// output(FP1303_1_0_score, named('FP1303_1_0_score'));

with_FP1303_1_0	:= join(with_FP1210_1_0, FP1303_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1303_1_0_score := right.score;
self.fp1303_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1303_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1303_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1303_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP1303_1_0, named('with_FP1303_1_0'));

FP1310_1_0_score := Models.FP1310_1_0( ungroup(clam), 6);
// output(FP1310_1_0_score, named('FP1310_1_0_score'));

with_FP1310_1_0	:= join(with_FP1303_1_0, FP1310_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1310_1_0_score := right.score;
self.fp1310_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1310_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1310_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1310_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1310_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1310_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1310_1_0, named('with_FP1310_1_0'));

FP1401_1_0_score := Models.FP1401_1_0( ungroup(clam), 6);
// output(FP1401_1_0_score, named('FP1401_1_0_score'));

with_FP1401_1_0	:= join(with_FP1310_1_0, FP1401_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1401_1_0_score := right.score;
self.fp1401_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1401_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1401_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1401_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1401_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1401_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1401_1_0, named('with_FP1401_1_0'));

FP1404_1_0_score := Models.FP1404_1_0( ungroup(clam), 6);
// output(FP1404_1_0_score, named('FP1404_1_0_score'));

with_FP1404_1_0	:= join(with_FP1401_1_0, FP1404_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1404_1_0_score := right.score;
self.fp1404_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1404_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1404_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1404_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1404_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1404_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1404_1_0, named('with_FP1404_1_0'));

FP1407_1_0_score := Models.FP1407_1_0( ungroup(clam), 6, Segment);
// output(FP1407_1_0_score, named('FP1407_1_0_score'));

with_FP1407_1_0	:= join(with_FP1404_1_0, FP1407_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1407_1_0_score := right.score;
self.fp1407_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1407_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1407_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1407_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1407_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1407_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1407_1_0, named('with_FP1407_1_0'));

FP1407_2_0_score := Models.FP1407_2_0( ungroup(clam), 6, Segment);
// output(FP1407_2_0_score, named('FP1407_2_0_score'));

with_FP1407_2_0	:= join(with_FP1407_1_0, FP1407_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1407_2_0_score := right.score;
self.fp1407_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1407_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1407_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1407_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1407_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1407_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1407_2_0, named('with_FP1407_2_0'));

FP1606_1_0_score := Models.FP1606_1_0( ungroup(clam), 6);
// output(FP1606_1_0_score, named('FP1606_1_0_score'));

with_FP1606_1_0	:= join(with_FP1407_2_0, FP1606_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1606_1_0_score := right.score;
self.FP1606_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1606_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1606_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1606_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1606_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1606_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1606_1_0, named('with_FP1606_1_0'));

FP1611_1_0_score := Models.FP1611_1_0( ungroup(clam), 6);
// output(FP1611_1_0_score, named('FP1611_1_0_score'));

with_FP1611_1_0	:= join(with_FP1606_1_0, FP1611_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1611_1_0_score := right.score;
self.FP1611_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1611_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1611_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1611_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1611_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1611_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1611_1_0, named('with_FP1611_1_0'));

FP1610_1_0_score := Models.FP1610_1_0( ungroup(clam), 6);
// output(FP1610_1_0_score, named('FP1610_1_0_score'));

with_FP1610_1_0	:= join(with_FP1611_1_0, FP1610_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1610_1_0_score := right.score;
self.fp1610_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1610_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1610_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1610_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1610_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1610_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1610_1_0, named('with_FP1610_1_0'));


FP1802_1_0_score := Models.FP1802_1_0( ungroup(clam), 6);
// output(FP1802_1_0_score, named('FP1802_1_0_score'));

with_FP1802_1_0	:= join(with_FP1610_1_0, FP1802_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1802_1_0_score := right.score;
self.fp1802_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1802_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1802_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1802_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1802_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1802_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1802_1_0, named('with_FP1802_1_0'));


FP1801_1_0_score := Models.FP1801_1_0( ungroup(clam), 6);
// output(FP1801_1_0_score, named('FP1801_1_0_score'));

with_FP1801_1_0	:= join(with_FP1802_1_0, FP1801_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1801_1_0_score := right.score;
self.fp1801_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1801_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1801_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1801_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1801_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1801_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1801_1_0, named('with_FP1801_1_0'));




FP1610_2_0_score := Models.FP1610_2_0( ungroup(clam), 6);
// output(FP1610_2_0_score, named('FP1610_2_0_score'));

with_FP1610_2_0	:= join(with_FP1801_1_0, FP1610_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1610_2_0_score := right.score;
self.fp1610_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1610_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1610_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1610_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1610_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1610_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1610_2_0, named('with_FP1610_2_0'));


FP1609_1_0_score := Models.FP1609_1_0( ungroup(clam), 6);
// output(FP1609_1_0_score, named('FP1609_1_0_score'));

with_FP1609_1_0	:= join(with_FP1610_2_0, FP1609_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1609_1_0_score := right.score;
self.fp1609_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1609_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1609_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1609_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1609_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1609_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1609_1_0, named('with_FP1609_1_0'));

FP1508_1_0_score := Models.FP1508_1_0( ungroup(clam), 6);
// output(FP1508_1_0_score, named('FP1508_1_0_score'));

with_FP1508_1_0	:= join(with_FP1609_1_0, FP1508_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1508_1_0_score := right.score;
self.fp1508_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1508_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1508_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1508_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1508_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1508_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_fp1508_1_0, named('with_fp1508_1_0'));


FP1702_2_0_score := Models.FP1702_2_0	( ungroup(clam), 6);
// output(FP1606_1_0_score, named('FP1606_1_0_score'));

with_FP1702_2_0	:= join(with_FP1508_1_0, FP1702_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1702_2_0_score := right.score;
self.FP1702_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1702_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1702_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1702_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1702_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1702_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1702_2_0, named('with_FP1702_2_0'));

FP1702_1_0_score := Models.FP1702_1_0	( ungroup(clam), 6);
// output(FP1702_1_0_score, named('FP1702_1_0_score'));

with_FP1702_1_0	:= join(with_FP1702_2_0, FP1702_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1702_1_0_score := right.score;
self.FP1702_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1702_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1702_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1702_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1702_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1702_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1702_1_0, named('with_FP1702_1_0'));

FP1706_1_0_score := Models.FP1706_1_0	( ungroup(clam), 6);
// output(FP1706_1_0_score, named('FP1706_1_0_score'));

with_FP1706_1_0	:= join(with_FP1702_1_0, FP1706_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1706_1_0_score := right.score;
self.FP1706_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1706_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1706_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1706_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1706_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1706_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1706_1_0, named('with_FP1706_1_0'));

FP1705_1_0_score := Models.FP1705_1_0	( ungroup(clam), 6);
// output(FP1705_1_0_score, named('FP1705_1_0_score'));

with_FP1705_1_0	:= join(with_FP1706_1_0, FP1705_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1705_1_0_score := right.score;
self.FP1705_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1705_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1705_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1705_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1705_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1705_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1705_1_0, named('with_FP1705_1_0'));

FP1710_1_0_score := Models.FP1710_1_0	( ungroup(clam), 6);
// output(FP1710_1_0_score, named('FP1710_1_0_score'));

with_FP1710_1_0	:= join(with_FP1705_1_0, FP1710_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1710_1_0_score := right.score;
self.FP1710_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1710_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1710_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1710_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1710_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1710_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1710_1_0, named('with_FP1710_1_0'));

FP1806_1_0_score := Models.FP1806_1_0	( ungroup(clam), 6);
// output(FP1806_1_0_score, named('FP1806_1_0_score'));

with_FP1806_1_0	:= join(with_FP1710_1_0, FP1806_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1806_1_0_score := right.score;
self.FP1806_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1806_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1806_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1806_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1806_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1806_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1806_1_0, named('with_FP1806_1_0'));

FP1803_1_0_score := Models.FP1803_1_0	( ungroup(clam), 6);
// output(FP1803_1_0_score, named('FP1803_1_0_score'));

with_FP1803_1_0	:= join(with_FP1806_1_0, FP1803_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1803_1_0_score := right.score;
self.FP1803_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1803_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1803_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1803_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1803_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1803_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1803_1_0, named('with_FP1803_1_0'));




FP1609_2_0_score := Models.FP1609_2_0	( ungroup(clam), 6);
// output(FP1609_2_0_score, named('FP1609_2_0_score'));

with_FP1609_2_0	:= join(with_FP1803_1_0, FP1609_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1609_2_0_score := right.score;
self.FP1609_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1609_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1609_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1609_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1609_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1609_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1609_2_0, named('with_FP1609_2_0'));

FP1607_1_0_score := Models.FP1607_1_0	( ungroup(clam), 6);
// output(FP1607_1_0_score, named('FP1607_1_0_score'));

with_FP1607_1_0	:= join(with_FP1609_2_0, FP1607_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1607_1_0_score := right.score;
self.FP1607_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP1607_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP1607_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP1607_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP1607_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP1607_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1607_1_0, named('with_FP1607_1_0'));

FP1712_0_0_score := Models.FP1712_0_0	( ungroup(clam), 1);
// output(FP1712_0_0_score, named('FP1712_0_0_score'));

with_FP1712_0_0	:= join(with_FP1607_1_0, FP1712_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP1712_0_0_score := right.score;
self.FP1712_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_FP1712_0_0, named('with_FP1712_0_0'));

FP1406_1_0_score := Models.FP1406_1_0( ungroup(clam), 6);
// output(FP1406_1_0_score, named('FP1406_1_0_score'));

with_FP1406_1_0	:= join(with_FP1712_0_0, FP1406_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1406_1_0_score := right.score;
self.fp1406_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1406_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1406_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1406_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1406_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1406_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1406_1_0, named('with_FP1406_1_0'));

FP1307_1_0_score := Models.FP1307_1_0( ungroup(clam), 6);
// output(FP1310_1_0_score, named('FP1310_1_0_score'));

with_FP1307_1_0	:= join(with_FP1406_1_0, FP1307_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1307_1_0_score := right.score;
self.fp1307_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1307_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1307_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1307_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1307_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1307_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1307_1_0, named('with_FP1307_1_0'));

FP1303_2_0_score := Models.FP1303_2_0( ungroup(clam), 6, false);
// output(FP1303_2_0_score, named('FP1303_2_0_score'));

with_FP1303_2_0	:= join(with_FP1307_1_0, FP1303_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1303_2_0_score := right.score;
self := left), keep(1), left outer);
// output(with_FP1303_1_0, named('with_FP1303_1_0'));

fp1403_1_0_score := models.FP1403_1_0(clam, np31_iid_results, 6);
// output(FP1403_1_0_score, named('FP1403_1_0_score'));

with_FP1403_1_0	:= join(with_FP1303_2_0, FP1403_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1403_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_FP1403_1_0, named('with_FP1403_1_0'));

fp1409_2_0_score := models.FP1409_2_0(clambtst);
// output(FP1409_2_0_score, named('FP1409_2_0_score'));

with_FP1409_2_0	:= join(with_FP1403_1_0, fp1409_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1409_2_0_score := right.score;
self := left), keep(1), left outer);
// output(with_FP1409_2_0, named('with_FP1409_2_0'));

fp1403_2_0_score := models.FP1403_2_0(ungroup(clam), 6);
// output(FP1403_2_0_score, named('FP1403_2_0_score'));

with_FP1403_2_0	:= join(with_FP1409_2_0, FP1403_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1403_2_0_score := right.score;
self.fp1403_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1403_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1403_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1403_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1403_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1403_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1403_2_0, named('with_FP1403_2_0'));

fp1506_1_0_score := models.FP1506_1_0(ungroup(clam), 6);
// output(FP1506_1_0_score, named('FP1506_1_0_score'));

with_FP1506_1_0	:= join(with_FP1403_2_0, FP1506_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1506_1_0_score := right.score;
self.fp1506_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1506_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1506_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1506_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1506_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1506_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1506_1_0, named('with_FP1506_1_0'));

fp1509_1_0_score := models.FP1509_1_0(ungroup(clam), 6);
// output(FP1506_1_0_score, named('FP1506_1_0_score'));

with_FP1509_1_0	:= join(with_FP1506_1_0, FP1509_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1509_1_0_score := right.score;
self.fp1509_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1509_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1509_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1509_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1509_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1509_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP1509_1_0, named('with_FP1509_1_0'));


fp1509_2_0_score := models.fp1509_2_0(ungroup(clambtst), loadamount);
// output(FP1509_2_0_score, named('FP1509_2_0_score'));

with_fp1509_2_0	:= join(with_FP1509_1_0, fp1509_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1509_2_0_score := right.score;
self.fp1509_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1509_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1509_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1509_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1509_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1509_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_fp1509_2_0, named('with_fp1509_2_0'));

fp1510_2_0_score := models.fp1510_2_0(ungroup(clam), 6);
// output(fp1510_2_0_score, named('fp1510_2_0_score'));

with_fp1510_2_0	:= join(with_fp1509_2_0, fp1510_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1510_2_0_score := right.score;
self.fp1510_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1510_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1510_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1510_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1510_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1510_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_fp1510_2_0, named('with_fp1510_2_0'));

//=== MoneyLion Custom Model ===
fp1511_1_0_score := models.fp1511_1_0(ungroup(clam), 6);
// output(fp1511_1_0_score, named('fp1511_1_0_score'));

with_fp1511_1_0	:= join(with_fp1510_2_0, fp1511_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1511_1_0_score := right.score;
self.fp1511_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1511_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1511_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1511_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1511_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1511_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_fp1511_1_0, named('with_fp1511_1_0'));


//=== WestLake Custom Model ===
fp1512_1_0_score := models.fp1512_1_0(ungroup(clam), 6);
// output(fp1512_1_0_score, named('fp1512_1_0_score'));

with_fp1512_1_0	:= join(with_fp1511_1_0, fp1512_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp1512_1_0_score := right.score;
self.fp1512_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp1512_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp1512_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp1512_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp1512_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp1512_1_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_fp1512_1_0, named('with_fp1512_1_0'));


//=== Avenger Model ===
FP31604_0_0_score := Models.FP31604_0_0( ungroup(clam), 6 );

with_FP31604_0_0	:= join(with_fp1512_1_0, FP31604_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP31604_0_0_score := right.score;
self.FP31604_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP31604_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP31604_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP31604_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP31604_0_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP31604_0_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP31105_1_0, named('with_FP31105_1_0'));



FP31105_1_0_score := Models.FP31105_1_0(UNGROUP(clam_ip));
// output(FP31105_1_0_score, named('FP31105_1_0_score'));
with_FP31105_1_0	:= join(with_FP31604_0_0, FP31105_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP31105_1_0_score := right.score;
self.FP31105_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP31105_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP31105_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP31105_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP31105_1_0, named('with_FP31105_1_0'));


FP31203_1_0_score := Models.FP31203_1_0(UNGROUP(clam_ip),inputfluxgrade);
// output(FP31203_1_0_score, named('FP31203_1_0_score'));

with_FP31203_1_0	:= join(with_FP31105_1_0, FP31203_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP31203_1_0_score := right.score;
self.FP31203_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP31203_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP31203_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP31203_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP31203_1_0, named('with_FP31203_1_0'));

FP31310_2_0_score := Models.FP31310_2_0( ungroup(clam_ip), 6, retailzip, loadamount);
// output(FP31310_2_0_score, named('FP31310_2_0_score'));

with_FP31310_2_0	:= join(with_FP31203_1_0, FP31310_2_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.fp31310_2_0_score := right.score;
self.fp31310_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.fp31310_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.fp31310_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.fp31310_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.fp31310_2_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.fp31310_2_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);
// output(with_FP31310_2_0, named('with_FP31310_2_0'));

FP31505_0_0_score := Models.FP31505_0_Base( ungroup(clam_ip), 6, criminal);
FP3FDN1505_0_0_score := Models.FP3FDN1505_0_Base( ungroup(clam_ip), 6, criminal);

with_FP31505_0_0	:= join(with_FP31310_2_0, FP31505_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP31505_0_0_score := right.score;
self.FP31505_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP31505_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP31505_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP31505_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP31505_0_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP31505_0_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);

with_FP3FDN1505_0_0	:= join(with_FP31505_0_0, FP3FDN1505_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP3FDN1505_0_0_score := right.score;
self.FP3FDN1505_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP3FDN1505_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP3FDN1505_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP3FDN1505_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.FP3FDN1505_0_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self.FP3FDN1505_0_0_reason6 := if(exclude_reasons, '',  right.ri[6].hri);
self := left), keep(1), left outer);

 FP3710_0_0_score := Models.FP3710_0_0(ungroup(clam_ip));
    // output(FP3710_0_0_score, named('FP3710_0_0_score'));

   with_FP3710_0_0	:= join(with_FP3FDN1505_0_0, FP3710_0_0_score,
   left.seq=right.seq,
   transform(Models.layout_Runway,
   self.FP3710_0_0_score := right.score;
   self.FP3710_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
   self.FP3710_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
   self.FP3710_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
   self.FP3710_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
   self := left), keep(1), left outer);
   // output(with_FP3710_0_0, named('with_FP3710_0_0'));



 FP3904_1_0_score := Models.FP3904_1_0(ungroup(clam));
// output(FP3904_1_0_score, named('FP3904_0_0_score'));

with_FP3904_1_0	:= join(with_FP3710_0_0, FP3904_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP3904_1_0_score := right.score;
self.FP3904_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP3904_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP3904_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP3904_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP3904_1_0, named('with_FP3904_1_0'));


FP3905_1_0_score := Models.FP3905_1_0(ungroup(clam));
// output(FP3905_1_0_score, named('FP3905_0_0_score'));

with_FP3905_1_0	:= join(with_FP3904_1_0, FP3905_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.FP3905_1_0_score := right.score;
self.FP3905_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.FP3905_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.FP3905_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.FP3905_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_FP3905_1_0, named('with_FP3905_1_0'));


       
   FP5812_1_0_score := Models.FP5812_1_0(clam, num_reasons, ofac);
 // output(FP5812_1_0_score, named('FP5812_0_0_score'));

 with_FP5812_1_0	:= join(with_FP3905_1_0, FP5812_1_0_score,
 left.seq=right.seq,
 transform(Models.layout_Runway,
 self.FP5812_1_0_score := right.score;
 self.FP5812_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
 self.FP5812_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
 self.FP5812_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
 self.FP5812_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
 self := left), keep(1), left outer);
 // output(with_FP5812_1_0, named('with_FP5812_1_0'));
 
//192 roxie deployment to this point --- 

// return with_FP5812_1_0;



HCP1206_0_0_score := Models.HCP1206_0_0(hcpclam, 4);
 // output(HCP1206_0_0_score, named('HCP1206_0_0_score'));

 with_HCP1206_0_0	:= join(with_FP5812_1_0, HCP1206_0_0_score,
 left.seq=right.seq,
 transform(Models.layout_Runway,
 self.HCP1206_0_0_score := right.score;
 self.HCP1206_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
 self.HCP1206_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
 self.HCP1206_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
 self.HCP1206_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
 self := left), keep(1), left outer);
 
 // output(with_HCP1206_0_0, named('with_HCP1206_0_0'));		 
IDN605_1_0_score := Models.IDN605_1_0(clam, OFAC);
 // output(IDN605_1_0_score, named('IDN605_1_0_score'));

with_IDN605_1_0	:= join(with_HCP1206_0_0, IDN605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.IDN605_1_0_score := right.score;
self.IDN605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.IDN605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.IDN605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.IDN605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_IDN605_1_0, named('with_IDN605_1_0'));



IED1106_1_0_score := Models.IED1106_1_0(UNGROUP(clam), iscalifornia);
// output(IED1106_1_0_score, named('IEd1106_1_0_score'));

with_IED1106_1_0	:= join(with_IDN605_1_0, IED1106_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.IED1106_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_IED1106_1_0, named('with_IED1106_1_0'));



IEN1006_0_1_score := Models.IEN1006_0_1(clam, census);
// output(IEN1006_0_1_score, named('IEN1006_0_1_score'));

with_IEN1006_0_1	:= join(with_IED1106_1_0, IEN1006_0_1_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.IEN1006_0_1_score := right.estimated_income;
self := left), keep(1), left outer);
// output(with_IEN1006_0_1, named('with_IEN1006_0_1'));


MNC21106_0_0_score := Models.MNC21106_0_0(ungroup(clam));
// output(MNC21106_0_0_score, named('MNC21106_0_0_score'));

with_MNC21106_0_0	:= join(with_IEN1006_0_1, MNC21106_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MNC21106_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MNC21106_0_0, named('with_MNC21106_0_0'));



MPX1211_0_0_score := Models.MPX1211_0_0(ungroup(clam));
// output(MPX1211_0_0_score, named('MPX1211_0_0_score'));

with_MPX1211_0_0	:= join(with_MNC21106_0_0, MPX1211_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MPX1211_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MPX1211_0_0, named('with_MPX1211_0_0'));



MSD1010_0_0_score := Models.MSD1010_0_0(clam);
// output(MSD1010_0_0_score, named('MSD1010_0_0_score'));

with_MSD1010_0_0	:= join(with_MPX1211_0_0, MSD1010_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MSD1010_0_0_score := right.estimated_income;
self := left), keep(1), left outer);
// output(with_MSD1010_0_0, named('with_MSD1010_0_0'));


MSN1106_0_0_score := Models.MSN1106_0_0(clam);
// output(MSN1106_0_0_score, named('MSN1106_0_0_score'));

with_MSN1106_0_0	:= join(with_MSD1010_0_0, MSN1106_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MSN1106_0_0_score := right.score;
self.MSN1106_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.MSN1106_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.MSN1106_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.MSN1106_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_MSN1106_0_0, named('with_MSN1106_0_0'));

MSN605_1_0_score := Models.MSN605_1_0(paro_clam, census2000, ofac);
// output(MSN605_1_0_score, named('MSN605_1_0_score'));
    
with_MSN605_1_0	:= join(with_MSN1106_0_0, MSN605_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MSN605_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MSN605_1_0, named('with_MSN605_1_0'));


MSN610_0_0_score := Models.MSN610_0_0(clam, history_date);
// output(MSN610_0_0_score, named('MSN610_0_0_score'));
    
with_MSN610_0_0	:= join(with_MSN605_1_0, MSN610_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MSN610_0_0_score := (string)right.score;
self := left), keep(1), left outer);
// output(with_MSN610_0_0, named('with_MSN610_0_0'));


MSN1803_1_0_score := Models.MSN1803_1_0(UNGROUP(clam));
// output(MSN610_0_0_score, named('MSN610_0_0_score'));
    
with_MSN1803_1_0	:= join(with_MSN610_0_0, MSN1803_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MSN1803_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MSN1803_1_0, named('with_MSN1803_1_0'));


MV361006_0_0_score := Models.MV361006_0_0(UNGROUP(clam));
// output(MV361006_0_0_score, named('MV361006_0_0_score'));
    
with_MV361006_0_0	:= join(with_MSN1803_1_0, MV361006_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MV361006_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MV361006_0_0, named('with_MV361006_0_0'));

MV361006_1_0_score := Models.MV361006_1_0(UNGROUP(clam));
// output(MV361006_1_0_score, named('MV361006_1_0_score'));
    
with_MV361006_1_0	:= join(with_MV361006_0_0, MV361006_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MV361006_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MV361006_1_0, named('with_MV361006_1_0'));

MX361006_0_0_score := Models.MX361006_0_0(UNGROUP(clam));
// output(MX361006_0_0_score, named('MX361006_0_0_score'));
    
with_MX361006_0_0	:= join(with_MV361006_1_0, MX361006_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MX361006_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MX361006_0_0, named('with_MX361006_0_0'));

MX361006_1_0_score := Models.MX361006_1_0(UNGROUP(clam));
// output(MX361006_1_0_score, named('MX361006_1_0_score'));
    
with_MX361006_1_0	:= join(with_MX361006_0_0, MX361006_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.MX361006_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_MX361006_1_0, named('with_MX361006_1_0'));


RSB801_1_0_score := Models.RSB801_1_0(UNGROUP(bshell));
// output(RSB801_1_0_score, named('RSB801_1_0_score'));
    
with_RSB801_1_0	:= join(with_MX361006_1_0, RSB801_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.RSB801_1_0_score := (string)right.score_0_to_999 ;
self := left), keep(1), left outer);
// output(with_RSB801_1_0, named('with_RSB801_1_0'));


RSN1001_1_0_score := Models.RSN1001_1_0(clam);
// output(RSN1001_1_0_score, named('RSN1001_1_0_score'));
    
with_RSN1001_1_0	:= join(with_RSB801_1_0, RSN1001_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1001_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1001_1_0, named('with_RSN1001_1_0'));

RSN1009_1_0_score := Models.RSN1009_1_0(clam);
// output(RSN1009_1_0_score, named('RSN1009_1_0_score'));
    
with_RSN1009_1_0	:= join(with_RSN1001_1_0, RSN1009_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1009_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1009_1_0, named('with_RSN1009_1_0'));


RSN1010_1_0_score := Models.RSN1010_1_0(clam, recoverScoreBatchIn );
// output(RSN1010_1_0_score, named('RSN1010_1_0_score'));
    
with_RSN1010_1_0	:= join(with_RSN1009_1_0, RSN1010_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1010_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1010_1_0, named('with_RSN1010_1_0'));


RSN1103_1_0_score := Models.RSN1103_1_0(clam);
// output(RSN1103_1_0_score, named('RSN1103_1_0_score'));
    
with_RSN1103_1_0	:= join(with_RSN1010_1_0, RSN1103_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1103_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1103_1_0, named('with_RSN1103_1_0'));

           
RSN1105_1_0_score := Models.RSN1105_1_0(clam);
// output(RSN1105_1_0_score, named('RSN1105_1_0_score'));
    
with_RSN1105_1_0	:= join(with_RSN1103_1_0, RSN1105_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1105_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1105_1_0, named('with_RSN1105_1_0'));

RSN1105_2_0_score := Models.RSN1105_2_0(clam);
// output(RSN1105_2_0_score, named('RSN1105_2_0_score'));
    
with_RSN1105_2_0	:= join(with_RSN1105_1_0, RSN1105_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1105_2_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1105_2_0, named('with_RSN1105_2_0'));

RSN1105_3_0_score := Models.RSN1105_3_0(clam);
// output(RSN1105_3_0_score, named('RSN1105_3_0_score'));
    
with_RSN1105_3_0	:= join(with_RSN1105_2_0, RSN1105_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1105_3_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1105_3_0, named('with_RSN1105_3_0'));


RSN1108_1_0_score := Models.RSN1108_1_0(clam);
// output(RSN1108_1_0_score, named('RSN1108_1_0_score'));
    
with_RSN1108_1_0	:= join(with_RSN1105_3_0, RSN1108_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1108_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1108_1_0, named('with_RSN1108_1_0'));


RSN1108_2_0_score := Models.RSN1108_2_0(clam);
// output(RSN1108_2_0_score, named('RSN1108_2_0_score'));
    
with_RSN1108_2_0	:= join(with_RSN1108_1_0, RSN1108_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1108_2_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1108_2_0, named('with_RSN1108_2_0'));


RSN1108_3_0_score := Models.RSN1108_3_0(clam);
// output(RSN1108_3_0_score, named('RSN1108_3_0_score'));
    
with_RSN1108_3_0	:= join(with_RSN1108_2_0, RSN1108_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN1108_3_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN1108_3_0, named('with_RSN1108_3_0'));

RSN508_1_0_score := Models.RSN508_1_0(clam, recoverScoreBatchIn);
// output(RSN508_1_0_score, named('RSN508_1_0_score'));
    
with_RSN508_1_0	:= join(with_RSN1108_3_0, RSN508_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN508_1_0_score := right.address_index ;
self := left), keep(1), left outer);
// output(with_RSN508_1_0, named('with_RSN508_1_0'));



RSN509_1_0_score := Models.RSN509_1_0(clam, rsn_prep);
// output(RSN509_1_0_score, named('RSN509_1_0_score'));
    
with_RSN509_1_0	:= join(with_RSN508_1_0, RSN509_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN509_1_0_score := right.score ;
self := left), keep(1), left outer);
// output(with_RSN509_1_0, named('with_RSN509_1_0'));

RSN509_2_0_score := Models.RSN509_2_0(clam, rsn_prep);
// output(RSN509_2_0_score, named('RSN509_2_0_score'));
    
with_RSN509_2_0	:= join(with_RSN509_1_0, RSN509_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN509_2_0_score := right.score ;
self := left), keep(1), left outer);
// output(with_RSN509_2_0, named('with_RSN509_2_0'));


RSN604_2_0_score := Models.RSN604_2_0(clam, recoverScoreBatchIn);
// output(RSN604_2_0_score, named('RSN604_2_0_score'));
    
with_RSN604_2_0	:= join(with_RSN509_2_0, RSN604_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN604_2_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN604_2_0, named('with_RSN604_2_0'));

RSN607_0_0_score := Models.RSN607_0_0(clam, recoverScoreBatchIn);
// output(RSN607_0_0_score, named('RSN607_0_0_score'));
    
with_RSN607_0_0	:= join(with_RSN604_2_0, RSN607_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN607_0_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN607_0_0, named('with_RSN607_0_0'));

RSN607_1_0_score := Models.RSN607_1_0(clam, recoverScoreBatchIn);
// output(RSN607_1_0_score, named('RSN607_1_0_score'));
                
with_RSN607_1_0	:= join(with_RSN607_0_0, RSN607_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN607_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN607_1_0, named('with_RSN607_1_0'));

RSN702_1_0_score := Models.RSN702_1_0(clam, recoverScoreBatchIn  );
// output(RSN702_1_0_score, named('RSN702_1_0_score'));
      
with_RSN702_1_0	:= join(with_RSN607_1_0, RSN702_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN702_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN702_1_0, named('with_RSN702_1_0'));


RSN704_0_0_score := Models.RSN704_0_0(clam, recoverScoreBatchIn  );
// output(RSN704_0_0_score, named('RSN704_0_0_score'));
      
with_RSN704_0_0	:= join(with_RSN702_1_0, RSN704_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN704_0_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN704_0_0, named('with_RSN704_0_0'));


RSN704_1_0_score := Models.RSN704_1_0(clam, recoverScoreBatchIn  );
// output(RSN704_1_0_score, named('RSN704_1_0_score'));
      
with_RSN704_1_0	:= join(with_RSN704_0_0, RSN704_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN704_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN704_1_0, named('with_RSN704_1_0'));

       
RSN802_1_0_score := Models.RSN802_1_0(clam, recoverScoreBatchIn  );
// output(RSN802_1_0_score, named('RSN802_1_0_score'));
      
with_RSN802_1_0	:= join(with_RSN704_1_0, RSN802_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN802_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN802_1_0, named('with_RSN802_1_0'));

         
RSN803_1_0_score := Models.RSN803_1_0(clam, recoverScoreBatchIn  );
// output(RSN803_1_0_score, named('RSN803_1_0_score'));
      
with_RSN803_1_0	:= join(with_RSN802_1_0, RSN803_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN803_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN803_1_0, named('with_RSN803_1_0'));

RSN803_2_0_score := Models.RSN803_2_0(clam, skiptrace);
// output(RSN803_2_0_score, named('RSN803_2_0_score'));
      
with_RSN803_2_0	:= join(with_RSN803_1_0, RSN803_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN803_2_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN803_2_0, named('with_RSN803_2_0'));

RSN804_1_0_score := Models.RSN804_1_0(clam, skiptrace, census);
// output(RSN804_1_0_score, named('RSN804_1_0_score'));
      
with_RSN804_1_0	:= join(with_RSN803_2_0, RSN804_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN804_1_0_score := right.score ;
self := left), keep(1), left outer);
// output(with_RSN804_1_0, named('with_RSN804_1_0'));

RSN807_0_0_score := Models.RSN807_0_0(clam);
// output(RSN807_0_0_score, named('RSN807_0_0_score'));
      
with_RSN807_0_0	:= join(with_RSN804_1_0, RSN807_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN807_0_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN807_0_0, named('with_RSN807_0_0'));


RSN810_1_0_score := Models.RSN810_1_0(clam, recoverScoreBatchIn );
// output(RSN810_1_0_score, named('RSN810_1_0_score'));
      
with_RSN810_1_0	:= join(with_RSN807_0_0, RSN810_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN810_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN810_1_0, named('with_RSN810_1_0'));

RSN912_1_0_score := Models.RSN912_1_0(clam, recoverScoreBatchIn );
// output(RSN912_1_0_score, named('RSN912_1_0_score'));
      
with_RSN912_1_0	:= join(with_RSN810_1_0, RSN912_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RSN912_1_0_score := right.recover_score ;
self := left), keep(1), left outer);
// output(with_RSN912_1_0, named('with_RSN912_1_0'));

// return with_rsn912_1_0;


RVA1003_0_0_score := Models.RVA1003_0_0(clam, iscalifornia );
// output(RVA1003_0_0_score, named('RVA1003_0_0_score'));

with_RVA1003_0_0	:= join(with_RSN912_1_0, RVA1003_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1003_0_0_score := right.score ;
self.RVA1003_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1003_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1003_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1003_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1003_0_0, named('with_RVA1003_0_0'));


RVA1007_1_0_score := Models.RVA1007_1_0(clam, iscalifornia );
// output(RVA1007_1_0_score, named('RVA1007_1_0_score'));

with_RVA1007_1_0	:= join(with_RVA1003_0_0, RVA1007_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1007_1_0_score := right.score ;
self.RVA1007_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1007_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1007_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1007_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1007_1_0, named('with_RVA1007_1_0'));

RVA1007_2_0_score := Models.RVA1007_2_0(clam, iscalifornia );
// output(RVA1007_2_0_score, named('RVA1007_2_0_score'));

with_RVA1007_2_0	:= join(with_RVA1007_1_0, RVA1007_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1007_2_0_score := right.score ;
self.RVA1007_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1007_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1007_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1007_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1007_2_0, named('with_RVA1007_2_0'));


RVA1007_3_0_score := Models.RVA1007_3_0(clam, iscalifornia );
// output(RVA1007_3_0_score, named('RVA1007_3_0_score'));

with_RVA1007_3_0	:= join(with_RVA1007_2_0, RVA1007_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1007_3_0_score := right.score ;
self.RVA1007_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1007_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1007_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1007_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1007_3_0, named('with_RVA1007_3_0'));
         
                             
RVA1008_1_0_score := Models.RVA1008_1_0(clam, incalif, in_employment_years, in_employment_months, total_income);
// output(RVA1008_1_0_score, named('RVA1008_1_0_score'));
     
with_RVA1008_1_0	:= join(with_RVA1007_3_0, RVA1008_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1008_1_0_score := right.score ;
self.RVA1008_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1008_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1008_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1008_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1008_1_0, named('with_RVA1008_1_0'));

         
RVA1008_2_0_score := Models.RVA1008_2_0(UNGROUP(clam), iscalifornia );
// output(RVA1008_2_0_score, named('RVA1008_2_0_score'));
  
with_RVA1008_2_0	:= join(with_RVA1008_1_0, RVA1008_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1008_2_0_score := right.score ;
self.RVA1008_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1008_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1008_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1008_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1008_2_0, named('with_RVA1008_2_0'));
         

RVA1104_0_0_score := Models.RVA1104_0_0(clam, iscalifornia, xmlPrescreenOptOut );
// output(RVA1104_0_0_score, named('RVA1104_0_0_score'));
                             
with_RVA1104_0_0	:= join(with_RVA1008_2_0, RVA1104_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1104_0_0_score := right.score;
self.RVA1104_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1104_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1104_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1104_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1104_0_0, named('with_RVA1104_0_0'));														 																		 

RVA1304_1_0_score := Models.RVA1304_1_0(clam, iscalifornia);
// output(RVA1304_1_0_score, named('RVA1304_1_0_score'));
                             
with_RVA1304_1_0	:= join(with_RVA1104_0_0, RVA1304_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1304_1_0_score := right.score;
self.RVA1304_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1304_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1304_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1304_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1304_1_0, named('with_RVA1304_1_0'));														 																		 

RVA1304_2_0_score := Models.RVA1304_2_0(clam, iscalifornia);
// output(RVA1304_2_0_score, named('RVA1304_2_0_score'));
                             
with_RVA1304_2_0	:= join(with_RVA1304_1_0, RVA1304_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1304_2_0_score := right.score;
self.RVA1304_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1304_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1304_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1304_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1304_2_0, named('with_RVA1304_2_0'));			


RVA1305_1_0_score := Models.RVA1305_1_0(clam, iscalifornia);
// output(RVA1305_1_0_score, named('RVA1305_1_0_score'));
                             
with_RVA1305_1_0	:= join(with_RVA1304_2_0, RVA1305_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1305_1_0_score := right.score;
self.RVA1305_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1305_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1305_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1305_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1305_1_0, named('with_RVA1305_1_0'));													 																		 

RVA1306_1_0_score := Models.RVA1306_1_0(clam, iscalifornia);
// output(RVA1306_1_0_score, named('RVA1306_1_0_score'));
                             
with_RVA1306_1_0	:= join(with_RVA1305_1_0, RVA1306_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1306_1_0_score := right.score;
self.RVA1306_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1306_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1306_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1306_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1306_1_0, named('with_RVA1306_1_0'));														 																		 
                             
// RVA1309_1 ---------------------------------------------------------
RVA1309_1_0_score := Models.RVA1309_1_0(clam, iscalifornia, FALSE);
// output(RVA1309_1_0_score, named('RVA1309_1_0_score'));
                             
with_RVA1309_1_0	:= join(with_RVA1306_1_0, RVA1309_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1309_1_0_score := right.score;
self.RVA1309_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1309_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1309_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1309_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1309_1_0, named('with_RVA1309_1_0'));														 																		 
// -------------------------------------------------------------------

// RVA1310_1 ---------------------------------------------------------
RVA1310_1_0_score := Models.RVA1310_1_0(clam, iscalifornia);
// output(RVA1310_1_0_score, named('RVA1310_1_0_score'));
                             
with_RVA1310_1_0	:= join(with_RVA1309_1_0, RVA1310_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1310_1_0_score := right.score;
self.RVA1310_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1310_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1310_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1310_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1310_1_0, named('with_RVA1310_1_0'));														 																		 
// -------------------------------------------------------------------

// RVA1310_2 ---------------------------------------------------------
RVA1310_2_0_score := Models.RVA1310_2_0(clam, iscalifornia);
// output(RVA1310_2_0_score, named('RVA1310_2_0_score'));
                             
with_RVA1310_2_0	:= join(with_RVA1310_1_0, RVA1310_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1310_2_0_score := right.score;
self.RVA1310_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1310_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1310_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1310_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1310_2_0, named('with_RVA1310_2_0'));														 																		 
// -------------------------------------------------------------------

// RVA1310_3 ---------------------------------------------------------
RVA1310_3_0_score := Models.RVA1310_3_0(clam, iscalifornia);
// output(RVA1310_3_0_score, named('RVA1310_3_0_score'));
                             
with_RVA1310_3_0	:= join(with_RVA1310_2_0, RVA1310_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1310_3_0_score := right.score;
self.RVA1310_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1310_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1310_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1310_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1310_3_0, named('with_RVA1310_3_0'));														 																		 
// -------------------------------------------------------------------

// RVA1311_1 ---------------------------------------------------------
RVA1311_1_0_score := Models.RVA1311_1_0(clam, iscalifornia);
// output(RVA1311_1_0_score, named('RVA1311_1_0_score'));
                             
with_RVA1311_1_0	:= join(with_RVA1310_3_0, RVA1311_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1311_1_0_score := right.score;
self.RVA1311_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1311_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1311_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1311_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1311_1_0, named('with_RVA1311_1_0'));														 																		 
// -------------------------------------------------------------------

// RVA1311_2 ---------------------------------------------------------
RVA1311_2_0_score := Models.RVA1311_2_0(clam, iscalifornia);
// output(RVA1311_2_0_score, named('RVA1311_2_0_score'));
                             
with_RVA1311_2_0	:= join(with_RVA1311_1_0, RVA1311_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1311_2_0_score := right.score;
self.RVA1311_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1311_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1311_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1311_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1311_2_0, named('with_RVA1311_2_0'));														 																		 
// -------------------------------------------------------------------

// RVA1311_3 ---------------------------------------------------------
RVA1311_3_0_score := Models.RVA1311_3_0(clam, iscalifornia);
// output(RVA1311_3_0_score, named('RVA1311_3_0_score'));
                             
with_RVA1311_3_0	:= join(with_RVA1311_2_0, RVA1311_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1311_3_0_score := right.score;
self.RVA1311_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1311_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1311_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1311_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1311_3_0, named('with_RVA1311_3_0'));														 																		 
// -------------------------------------------------------------------

// RVA1503_0 ---------------------------------------------------------
RVA1503_0_0_score := Models.RVA1503_0_0(clam, lexIDOnlyOnInput);
// output(RVA1503_0_0_score, named('RVA1503_0_0_score'));
                             
with_RVA1503_0_0	:= join(with_RVA1311_3_0, RVA1503_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1503_0_0_score := right.score;
self.RVA1503_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1503_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1503_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1503_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1503_0_0, named('with_RVA1503_0_0'));														 																		 
// -------------------------------------------------------------------

// RVA1504_1 ---------------------------------------------------------
RVA1504_1_0_score := Models.RVA1504_1_0(clam, lexIDOnlyOnInput);
// output(RVA1503_0_0_score, named('RVA1503_0_0_score'));
                             
with_RVA1504_1_0	:= join(with_RVA1503_0_0, RVA1504_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1504_1_0_score := right.score;
self.RVA1504_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1504_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1504_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1504_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1504_1_0, named('with_RVA1504_1_0'));														 																		 
// -------------------------------------------------------------------

// RVA1504_2 ---------------------------------------------------------
RVA1504_2_0_score := Models.RVA1504_2_0(clam, lexIDOnlyOnInput);
// output(RVA1503_0_0_score, named('RVA1503_0_0_score'));
                             
with_RVA1504_2_0	:= join(with_RVA1504_1_0, RVA1504_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1504_2_0_score := right.score;
self.RVA1504_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1504_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1504_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1504_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1504_2_0, named('with_RVA1504_2_0'));														 																		 
// -------------------------------------------------------------------

// RVA1601_1 ---------------------------------------------------------
RVA1601_1_0_score := Models.RVA1601_1_0(clam);
                             
with_RVA1601_1_0	:= join(with_RVA1504_2_0, RVA1601_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1601_1_0_score := right.score;
self.RVA1601_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1601_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1601_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1601_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);

// RVA1603_1 ---------------------------------------------------------
RVA1603_1_0_score := Models.RVA1603_1_0(clam, lexIDOnlyOnInput);
                             
with_RVA1603_1_0	:= join(with_RVA1601_1_0, RVA1603_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1603_1_0_score := right.score;
self.RVA1603_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1603_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1603_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1603_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);

// RVA1605_1 ---------------------------------------------------------
RVA1605_1_0_score := Models.RVA1605_1_0(clam);
                             
with_RVA1605_1_0	:= join(with_RVA1603_1_0, RVA1605_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1605_1_0_score := right.score;
self.RVA1605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
													 																		 
// RVA1607_1 ---------------------------------------------------------
RVA1607_1_0_score := Models.RVA1607_1_0(clam);
                             
with_RVA1607_1_0	:= join(with_RVA1605_1_0, RVA1607_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1607_1_0_score := right.score;
self.RVA1607_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1607_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1607_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1607_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);

RVA611_0_0_score := Models.RVA611_0_0(clam, iscalifornia);
// output(RVA611_0_0_score, named('RVA611_0_0_score'));
                             
with_RVA611_0_0	:= join(with_RVA1607_1_0, RVA611_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA611_0_0_score := right.score;
self.RVA611_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA611_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA611_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA611_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA611_0_0, named('with_RVA611_0_0'));	
RVA707_0_0_score := Models.RVA707_0_0(clam, iscalifornia);
// output(RVA707_0_0_score, named('RVA707_0_0_score'));
                             
with_RVA707_0_0	:= join(with_RVA611_0_0, RVA707_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA707_0_0_score := right.score;
self.RVA707_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA707_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA707_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA707_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA707_0_0, named('with_RVA707_0_0'));	

RVA707_1_0_score := Models.RVA707_1_0(clam, iscalifornia);
// output(RVA707_1_0_score, named('RVA707_1_0_score'));
                             
with_RVA707_1_0	:= join(with_RVA707_0_0, RVA707_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA707_1_0_score := right.score;
self.RVA707_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA707_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA707_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA707_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA707_1_0, named('with_RVA707_1_0'));	

RVA709_1_0_score := Models.RVA709_1_0(clam, iscalifornia);
// output(RVA707_1_0_score, named('RVA709_1_0_score'));
                             
with_RVA709_1_0	:= join(with_RVA707_1_0, RVA709_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA709_1_0_score := right.score;
self.RVA709_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA709_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA709_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA709_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);;
self := left), keep(1), left outer);
// output(with_RVA709_1_0, named('with_RVA709_1_0'));	


RVA1611_1_0_score := Models.RVA1611_1_0(clam, False);
// output(RVA1611_1_0_score, named('RVA1611_1_0_score'));
                             
with_RVA1611_1_0 := join(with_RVA709_1_0, RVA1611_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1611_1_0_score := right.score;
self.RVA1611_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1611_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1611_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1611_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVA1611_1_0, named('with_RVA1611_1_0'));

RVA1611_2_0_score := Models.RVA1611_2_0(clam, False);
// output(RVA1611_2_0_score, named('RVA1611_2_0_score'));
                             
with_RVA1611_2_0 := join(with_RVA1611_1_0, RVA1611_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1611_2_0_score := right.score;
self.RVA1611_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1611_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1611_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1611_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
//output(with_RVA1611_2_0, named('with_RVA1611_2_0'));

RVA1811_1_0_score := Models.RVA1811_1_0(clam, False);
// output(RVA1811_1_0_score, named('RVA1811_1_0_score'));
                             
with_RVA1811_1_0 := join(with_RVA1611_2_0, RVA1811_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVA1811_1_0_score := right.score;
self.RVA1811_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVA1811_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVA1811_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVA1811_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
//output(with_RVA1811_1_0, named('with_RVA1811_1_0'));


RVB1003_0_0_score := Models.RVB1003_0_0(clam, iscalifornia);
// output(RVB1003_0_0_score, named('RVB1003_0_0_score'));
                             
with_RVB1003_0_0	:= join(with_RVA1811_1_0, RVB1003_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1003_0_0_score := right.score;
self.RVB1003_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1003_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1003_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1003_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1003_0_0, named('with_RVB1003_0_00'));	

RVB1104_0_0_score := Models.RVB1104_0_0(clam, iscalifornia, xmlPreScreenOptOut);
// output(RVB1104_0_0_score, named('RVB1104_0_0_score'));
                             
with_RVB1104_0_0 := join(with_RVB1003_0_0, RVB1104_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1104_0_0_score := right.score;
self.RVB1104_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1104_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1104_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1104_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1104_0_0, named('with_RVB1104_0_0'));	

RVB1104_1_0_score := Models.RVB1104_1_0(clam, iscalifornia, FALSE);
// output(RVB1104_1_0_score, named('RVB1104_1_0_score'));
                             
with_RVB1104_1_0 := join(with_RVB1104_0_0, RVB1104_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1104_1_0_score := right.score;
self.RVB1104_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1104_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1104_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1104_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1104_1_0, named('with_RVB1104_1_0'));	

RVB1310_1_0_score := Models.RVB1310_1_0(clam, iscalifornia, false);
// output(RVB1310_1_0_score, named('RVB1310_1_0_score'));
                             
with_RVB1310_1_0 := join(with_RVB1104_1_0, RVB1310_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1310_1_0_score := right.score;
self.RVB1310_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1310_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1310_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1310_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1310_1_0, named('with_RVB1310_1_0'));	

RVB1402_1_0_score := Models.RVB1402_1_0(clam, iscalifornia);
// output(RVB1402_1_0_score, named('RVB1402_1_0_score'));
                             
with_RVB1402_1_0 := join(with_RVB1310_1_0, RVB1402_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1402_1_0_score := right.score;
self.RVB1402_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1402_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1402_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1402_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1402_1_0, named('with_RVB1402_1_0'));	

RVB1503_0_0_score := Models.RVB1503_0_0(clam, lexIDOnlyOnInput);
// output(RVB1503_0_0_score, named('RVB1503_0_0_score'));
                             
with_RVB1503_0_0 := join(with_RVB1402_1_0, RVB1503_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1503_0_0_score := right.score;
self.RVB1503_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1503_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1503_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1503_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1503_0_0, named('with_RVB1503_0_0'));	

RVB609_0_0_score := Models.RVB609_0_0(clam, iscalifornia);
// output(RVB609_0_0_score, named('RVB609_0_0_score'));
                             
with_RVB609_0_0 := join(with_RVB1503_0_0, RVB609_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB609_0_0_score := right.score;
self.RVB609_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB609_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB609_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB609_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB609_0_0, named('with_RVB609_0_0'));	


RVB705_1_0_score := Models.RVB705_1_0(UNGROUP(clam), OFAC, iscalifornia);
// output(RVB705_1_0_score, named('RVB705_1_0_score'));
                             
with_RVB705_1_0 := join(with_RVB609_0_0, RVB705_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB705_1_0_score := right.score;
self.RVB705_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB705_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB705_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB705_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB705_1_0, named('with_RVB705_1_0'));

RVB1610_1_0_score := Models.RVB1610_1_0(clam);
// output(RVB1610_1_0_score, named('RVB1610_1_0_score'));
                             
with_RVB1610_1_0 := join(with_RVB705_1_0, RVB1610_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVB1610_1_0_score := right.score;
self.RVB1610_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVB1610_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVB1610_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVB1610_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVB1610_1_0, named('with_RVB1610_1_0'));

RVC1110_1_0_score := Models.RVC1110_1_0(UNGROUP(clam), iscalifornia, xmlPreScreenOptOut);
// output(RVC1110_1_0_score, named('RVC1110_1_0_score'));
                             
with_RVC1110_1_0 := join(with_RVB1610_1_0, RVC1110_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1110_1_0_score := right.score;
self.RVC1110_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1110_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1110_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1110_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1110_1_0, named('with_RVC1110_1_0'));



RVC1110_2_0_score := Models.RVC1110_2_0(UNGROUP(clam), iscalifornia, xmlPreScreenOptOut);
// output(RVC1110_2_0_score, named('RVC1110_2_0_score'));
                             
with_RVC1110_2_0 := join(with_RVC1110_1_0, RVC1110_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1110_2_0_score := right.score;
self.RVC1110_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1110_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1110_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1110_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1110_2_0, named('with_RVC1110_2_0'));

RVC1112_0_0_score := Models.RVC1112_0_0(clam, iscalifornia, xmlPreScreenOptOut);
// output(RVC1112_0_0_score, named('RVC1112_0_0_score'));
                             
with_RVC1112_0_0 := join(with_RVC1110_2_0, RVC1112_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1112_0_0_score := right.score;
self.RVC1112_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1112_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1112_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1112_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1112_0_0, named('with_RVC1112_0_0'));	

RVC1208_1_0_score := Models.RVC1208_1_0(clam, iscalifornia, xmlPreScreenOptOut);
// output(RVC1208_1_0_score, named('RVC1208_1_0_score'));
                             
with_RVC1208_1_0 := join(with_RVC1112_0_0, RVC1208_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1208_1_0_score := right.score;
self.RVC1208_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1208_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1208_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1208_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1208_1_0, named('with_RVC1208_1_0'));

RVC1210_1_0_score := Models.RVC1210_1_0(clam, isCalifornia, xmlPreScreenOptOut, returncode, pay_frequency);
// output(RVC1210_1_0_score, named('RVC1210_1_0_score'));
                             
with_RVC1210_1_0 := join(with_RVC1208_1_0, RVC1210_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1210_1_0_score := right.score;
self.RVC1210_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1210_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1210_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1210_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1210_1_0, named('with_RVC1210_1_0'));

RVC1301_1_0_score := ungroup(Models.RVC1301_1_0(clam));
// output(RVC1301_1_0_score, named('RVC1301_1_0_score'));
                             
with_RVC1301_1_0 := join(with_RVC1210_1_0, RVC1301_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1301_1_0_score := right.score;
self.RVC1301_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1301_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1301_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1301_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1301_1_0, named('with_RVC1301_1_0'));

RVC1307_1_0_score := Models.RVC1307_1_0(clam, iscalifornia);
// output(RVC1307_1_0_score, named('RVC1307_1_0_score'));
                             
with_RVC1307_1_0 := join(with_RVC1301_1_0, RVC1307_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1307_1_0_score := right.score;
self.RVC1307_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1307_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1307_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1307_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1307_1_0, named('with_RVC1307_1_0'));

RVC1405_1_0_score := Models.RVC1405_1_0(custom_clam, iscalifornia);
// output(RVC1405_1_0_score, named('RVC1405_1_0_score'));
                             
with_RVC1405_1_0 := join(with_RVC1307_1_0, RVC1405_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1405_1_0_score := right.score;
self.RVC1405_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1405_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1405_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1405_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1405_1_0, named('with_RVC1405_1_0'));

RVC1405_2_0_score := Models.RVC1405_2_0(custom_clam, iscalifornia);
// output(RVC1405_2_0_score, named('RVC1405_2_0_score'));
                             
with_RVC1405_2_0 := join(with_RVC1405_1_0, RVC1405_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1405_2_0_score := right.score;
self.RVC1405_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1405_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1405_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1405_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1405_2_0, named('with_RVC1405_2_0'));

RVC1405_3_0_score := Models.RVC1405_3_0(clam, iscalifornia);
// output(RVC1405_3_0_score, named('RVC1405_3_0_score'));
                             
with_RVC1405_3_0 := join(with_RVC1405_2_0, RVC1405_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1405_3_0_score := right.score;
self.RVC1405_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1405_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1405_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1405_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1405_3_0, named('with_RVC1405_3_0'));

RVC1405_4_0_score := Models.RVC1405_4_0(clam, iscalifornia);
// output(RVC1405_4_0_score, named('RVC1405_4_0_score'));
                             
with_RVC1405_4_0 := join(with_RVC1405_3_0, RVC1405_4_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1405_4_0_score := right.score;
self.RVC1405_4_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1405_4_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1405_4_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1405_4_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1405_4_0, named('with_RVC1405_4_0'));

RVC1412_1_0_score := Models.RVC1412_1_0(clam, iscalifornia, false);
// output(RVC1412_1_0_score, named('RVC1412_1_0_score'));
                             
with_RVC1412_1_0 := join(with_RVC1405_4_0, RVC1412_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1412_1_0_score := right.score;
self.RVC1412_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1412_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1412_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1412_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1412_1_0, named('with_RVC1412_1_0'));

RVC1412_2_0_score := Models.RVC1412_2_0(custom_clam, iscalifornia);
// output(RVC1412_2_0_score, named('RVC1412_2_0_score'));
                             
with_RVC1412_2_0 := join(with_RVC1412_1_0, RVC1412_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1412_2_0_score := right.score;
self.RVC1412_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1412_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1412_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1412_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1412_2_0, named('with_RVC1412_2_0'));

RVC1602_1_0_score := Models.RVC1602_1_0(clam, channel_inputs);
// output(RVC1602_1_0_score, named('RVC1602_1_0_score'));
                             
with_RVC1602_1_0 := join(with_RVC1412_2_0, RVC1602_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1602_1_0_score := right.score;
self.RVC1602_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1602_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1602_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1602_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1602_1_0, named('with_RVC1602_1_0'));


RVC1609_1_0_score := Models.RVC1609_1_0(clam );
// output(RVC1609_1_0_score, named('RVC1609_1_0_score'));
                             
with_RVC1609_1_0 := join(with_RVC1602_1_0, RVC1609_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1609_1_0_score := right.score;
self.RVC1609_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1609_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1609_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1609_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1609_1_0, named('with_RVC1609_1_0'));





RVC1703_1_0_score := Models.RVC1703_1_0(clam, iscalifornia);
// output(RVC1703_1_0_score, named('RVC1703_1_0_score'));
                             
with_RVC1703_1_0 := join(with_RVC1609_1_0, RVC1703_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1703_1_0_score := right.score;
self.RVC1703_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1703_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1703_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1703_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1703_1_0, named('with_RVC1703_1_0'));


RVC1801_1_0_score := Models.RVC1801_1_0(clam, iscalifornia);
// output(RVC1801_1_0_score, named('RVC1801_1_0_score'));
                             
with_RVC1801_1_0 := join(with_RVC1703_1_0, RVC1801_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1801_1_0_score := right.score;
self.RVC1801_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1801_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1801_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1801_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1801_1_0, named('with_RVC1801_1_0'));


RVC1805_1_0_score := Models.RVC1805_1_0(clam, iscalifornia);
// output(RVC1805_1_0_score, named('RVC1805_1_0_score'));
                             
with_RVC1805_1_0 := join(with_RVC1801_1_0, RVC1805_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1805_1_0_score := right.score;
self.RVC1805_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1805_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1805_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1805_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1805_1_0, named('with_RVC1805_1_0'));


RVC1805_2_0_score := Models.RVC1805_2_0(clam, iscalifornia);
// output(RVC1805_2_0_score, named('RVC1805_2_0_score'));
                             
with_RVC1805_2_0 := join(with_RVC1805_1_0, RVC1805_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVC1805_2_0_score := right.score;
self.RVC1805_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVC1805_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVC1805_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVC1805_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVC1805_2_0, named('with_RVC1805_2_0'));




RVD1010_0_0_score := Models.RVD1010_0_0(UNGROUP(clam), iscalifornia);
// output(RVD1010_0_0_score, named('RVD1010_0_0_score'));
                             
with_RVD1010_0_0 := join(with_RVC1805_2_0, RVD1010_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVD1010_0_0_score := right.score;
self.RVD1010_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVD1010_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVD1010_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVD1010_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVD1010_0_0, named('with_RVD1010_0_0'));



RVD1010_1_0_score := Models.RVD1010_1_0(UNGROUP(clam), iscalifornia);
// output(RVD1010_1_0_score, named('RVD1010_1_0_score'));
                             
with_RVD1010_1_0 := join(with_RVD1010_0_0, RVD1010_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVD1010_1_0_score := right.score;
self.RVD1010_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVD1010_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVD1010_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVD1010_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVD1010_1_0, named('with_RVD1010_1_0'));



RVD1010_2_0_score := Models.RVD1010_2_0(UNGROUP(clam), iscalifornia);
// output(RVD1010_2_0_score, named('RVD1010_2_0_score'));
                             
with_RVD1010_2_0 := join(with_RVD1010_1_0, RVD1010_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVD1010_2_0_score := right.score;
self.RVD1010_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVD1010_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVD1010_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVD1010_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVD1010_2_0, named('with_RVD1010_2_0'));

RVD1110_1_0_score := Models.RVD1110_1_0(clam);
// output(RVD1110_1_0_score, named('RVD1110_1_0_score'));
                            
with_RVD1110_1_0 := join(with_RVD1010_2_0, RVD1110_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVD1110_1_0_score := right.score;
self.RVD1110_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVD1110_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVD1110_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVD1110_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVD1110_1_0, named('with_RVD1110_1_0'));



RVD1801_1_0_score := Models.RVD1801_1_0(clam);
// output(RVD1801_1_0_score, named('RVD1801_1_0_score'));
                            
with_RVD1801_1_0 := join(with_RVD1110_1_0, RVD1801_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVD1801_1_0_score := right.score;
self.RVD1801_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVD1801_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVD1801_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVD1801_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVD1801_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self := left), keep(1), left outer);
// output(with_RVD1801_1_0, named('with_RVD1801_1_0'));



RVG1003_0_0_score := Models.RVG1003_0_0(clam);
// output(RVG1003_0_0_score, named('RVG1003_0_0_score'));
                            
with_RVG1003_0_0 := join(with_RVD1801_1_0, RVG1003_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1003_0_0_score := right.score;
self.RVG1003_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1003_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1003_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1003_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1003_0_0, named('with_RVG1003_0_0'));

RVG1103_0_0_score := Models.RVG1103_0_0(clam, isCalifornia, xmlPreScreenOptOut );
// output(RVG1103_0_0_score, named('RVG1103_0_0_score'));
                            
with_RVG1103_0_0 := join(with_RVG1003_0_0, RVG1103_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1103_0_0_score := right.score;
self.RVG1103_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1103_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1103_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1103_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1103_0_0, named('with_RVG1103_0_0'));


RVG1106_1_0_score := Models.RVG1106_1_0(clam, isCalifornia, xmlPreScreenOptOut );
// output(RVG1106_1_0_score, named('RVG1106_1_0_score'));
                            
with_RVG1106_1_0 := join(with_RVG1103_0_0, RVG1106_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1106_1_0_score := right.score;
self.RVG1106_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1106_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1106_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1106_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1106_1_0, named('with_RVG1106_1_0'));

RVG1201_1_0_score := Models.RVG1201_1_0(clam, isCalifornia, xmlPreScreenOptOut );
// output(RVG1201_1_0_score, named('RVG1201_1_0_score'));
                            
with_RVG1201_1_0 := join(with_RVG1106_1_0, RVG1201_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1201_1_0_score := right.score;
self.RVG1201_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1201_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1201_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1201_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1201_1_0, named('with_RVG1201_1_0'));

RVG1302_1_0_score := ungroup(Models.RVG1302_1_0(clam, isCalifornia));
// output(RVG1302_1_0_score, named('RVG1302_1_0_score'));
                            
with_RVG1302_1_0 := join(with_RVG1201_1_0, RVG1302_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1302_1_0_score := right.score;
self.RVG1302_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1302_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1302_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1302_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1302_1_0, named('with_RVG1302_1_0'));

RVG1304_1_0_score := ungroup(Models.RVG1304_1_0(clam, isCalifornia));
// output(RVG1304_1_0_score, named('RVG1304_1_0_score'));
                            
with_RVG1304_1_0 := join(with_RVG1302_1_0, RVG1304_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1304_1_0_score := right.score;
self.RVG1304_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1304_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1304_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1304_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1304_1_0, named('with_RVG1304_1_0'));

RVG1304_2_0_score := ungroup(Models.RVG1304_2_0(clam, isCalifornia));
// output(RVG1304_2_0_score, named('RVG1304_2_0_score'));
                            
with_RVG1304_2_0 := join(with_RVG1304_1_0, RVG1304_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1304_2_0_score := right.score;
self.RVG1304_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1304_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1304_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1304_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1304_2_0, named('with_RVG1304_2_0'));

RVG1502_0_0_score := ungroup(Models.RVG1502_0_0(clam, lexIDOnlyOnInput));
// output(RVG1502_0_0_score, named('RVG1502_0_0_score'));

with_RVG1502_0_0 := join(with_RVG1304_2_0,RVG1502_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1502_0_0_score := right.score;
self.RVG1502_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1502_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1502_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1502_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1502_0_0, named('with_RVG1502_0_0'));

RVG1511_1_0_score := ungroup(Models.RVG1511_1_0(clam, lexIDOnlyOnInput));
// output(RVG1511_1_0_score, named('RVG1511_1_0_score'));

with_RVG1511_1_0 := join(with_RVG1502_0_0,RVG1511_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1511_1_0_score := right.score;
self.RVG1511_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1511_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1511_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1511_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1511_1_0, named('with_RVG1511_1_0'));

RVG812_0_0_score := Models.RVG812_0_0(ungroup(clam), isCalifornia);
// output(RVG812_0_0_score, named('RVG812_0_0_score'));

with_RVG812_0_0 := join(with_RVG1511_1_0, RVG812_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG812_0_0_score := right.score;
self.RVG812_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG812_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG812_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG812_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG812_0_0, named('with_RVG812_0_0'));

RVG903_1_0_score := Models.RVG903_1_0(ungroup(clam), isCalifornia);
// output(RVG903_1_0_score, named('RVG903_1_0_score'));
                               
with_RVG903_1_0 := join(with_RVG812_0_0, RVG903_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG903_1_0_score := right.score;
self := left), keep(1), left outer);
// output(with_RVG903_1_0, named('with_RVG903_1_0'));

RVG1401_1_0_score := Models.RVG1401_1_0(clam, isCalifornia);
// output(RVG904_1_0_score, named('RVG904_1_0_score'));
                               
with_RVG1401_1_0 := join(with_RVG903_1_0, RVG1401_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1401_1_0_score := right.score;
self.RVG1401_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1401_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1401_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1401_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1401_1_0, named('with_RVG1401_1_0'));

RVG1401_2_0_score := Models.RVG1401_2_0(clam, isCalifornia);
// output(RVG904_1_0_score, named('RVG904_1_0_score'));
                               
with_RVG1401_2_0 := join(with_RVG1401_1_0, RVG1401_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1401_2_0_score := right.score;
self.RVG1401_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1401_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1401_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1401_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1401_2_0, named('with_RVG1401_2_0'));

RVG1310_1_0_score := Models.RVG1310_1_0(clam, isCalifornia);
// output(RVG1310_1_0_score, named('RVG1310_1_0_score'));
                               
with_RVG1310_1_0 := join(with_RVG1401_2_0, RVG1310_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1310_1_0_score := right.score;
self.RVG1310_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1310_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1310_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1310_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1310_1_0, named('with_RVG1310_1_0'));

RVG1404_1_0_score := Models.RVG1404_1_0(clam, isCalifornia);
// output(RVG1404_1_0_score, named('RVG1404_1_0_score'));
                               
with_RVG1404_1_0 := join(with_RVG1310_1_0, RVG1404_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1404_1_0_score := right.score;
self.RVG1404_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1404_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1404_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1404_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1404_1_0, named('with_RVG1404_1_0'));

/* ================ */
RVG1601_1_0_score := Models.RVG1601_1_0(group(clam, seq), channel_inputs);
// output(RVG1601_1_0_score, named('RVG1601_1_0_score'));

with_RVG1601_1_0 := join(with_RVG1404_1_0, RVG1601_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1601_1_0_score := right.score;
self.RVG1601_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1601_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1601_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1601_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1601_1_0, named('with_RVG1601_1_0'));
/* ================ */

/* ================ */
RVG1605_1_0_score := Models.RVG1605_1_0(group(clam, seq));
// output(RVG1601_1_0_score, named('RVG1601_1_0_score'));

with_RVG1605_1_0 := join(with_RVG1601_1_0, RVG1605_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1605_1_0_score := right.score;
self.RVG1605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1605_1_0, named('with_RVG1605_1_0'));
/* ================ */

/* ================ */
RVG1702_1_0_score := Models.RVG1702_1_0(clam);
// output(RVG1702_1_0_score, named('RVG1702_1_0_score'));
                             
with_RVG1702_1_0 := join(with_RVG1605_1_0, RVG1702_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1702_1_0_score := right.score;
self.RVG1702_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1702_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1702_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1702_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1702_1_0, named('with_RVG1702_1_0'));
/* ================ */








/* ================ */
RVG1705_1_0_score := Models.RVG1705_1_0(clam);
// output(RVG1702_1_0_score, named('RVG1702_1_0_score'));
                             
with_RVG1705_1_0 := join(with_RVG1702_1_0, RVG1705_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1705_1_0_score := right.score;
self.RVG1705_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1705_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1705_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1705_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1705_1_0, named('with_RVG1705_1_0'));
/* ================ */

/* ================ */
RVG1706_1_0_score := Models.RVG1706_1_0(clam);
// output(RVG1706_1_0_score, named('RVG1706_1_0_score'));
                             
with_RVG1706_1_0 := join(with_RVG1705_1_0, RVG1706_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1706_1_0_score := right.score;
self.RVG1706_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1706_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1706_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1706_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVG1706_1_0, named('with_RVG1706_1_0'));
/* ================ */

/* ================ */
RVG1802_1_0_score := Models.RVG1802_1_0(clam);
// output(RVG1802_1_0_score, named('RVG1802_1_0_score'));
                             
with_RVG1802_1_0 := join(with_RVG1706_1_0, RVG1802_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1802_1_0_score := right.score;
self.RVG1802_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1802_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1802_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1802_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVG1802_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self := left), keep(1), left outer);
// output(with_RVG1802_1_0, named('with_RVG1802_1_0'));
/* ================ */

/* ================ */
RVG1610_1_0_score := Models.RVG1610_1_0(clam);
// output(RVG1610_1_0_score, named('RVG1610_1_0_score'));
                             
with_RVG1610_1_0 := join(with_RVG1802_1_0, RVG1610_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVG1610_1_0_score := right.score;
self.RVG1610_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVG1610_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVG1610_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVG1610_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVG1610_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);
self := left), keep(1), left outer);
// output(with_RVG1610_1_0, named('with_RVG1610_1_0'));
/* ================ */


/* ================ */
RVP1012_1_0_score := Models.RVP1012_1_0(clam);
// output(RVP1012_1_0_score, named('RVP1012_1_0_score'));

with_RVP1012_1_0 := join(with_RVG1610_1_0, RVP1012_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1012_1_0_score := right.score;
self.RVP1012_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1012_1_0, named('with_RVP1012_1_0'));		
/* ================ */


/* ================ */
RVP1208_1_0_score := Models.RVP1208_1_0(clam);
// output(RVP1208_1_0_score, named('RVP1208_1_0_score'));
                               
with_RVP1208_1_0 := join(with_RVP1012_1_0, RVP1208_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1208_1_0_score := right.score;
self.RVP1208_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1208_1_0, named('with_RVP1208_1_0'));		
/* ================ */

/* ================ */
RVP1401_1_0_score := Models.RVP1401_1_0(clam);
// output(RVP1401_1_0_score, named('RVP1401_1_0_score'));
                               
with_RVP1401_1_0 := join(with_RVP1208_1_0, RVP1401_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1401_1_0_score := right.score;
self.RVP1401_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1401_1_0, named('with_RVP1401_1_0'));		
/* ================ */

/* ================ */
RVP1401_2_0_score := Models.RVP1401_2_0(clam);
// output(RVP1401_2_0_score, named('RVP1401_2_0_score'));
                               
with_RVP1401_2_0 := join(with_RVP1401_1_0, RVP1401_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1401_2_0_score := right.score;
self.RVP1401_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1401_2_0, named('with_RVP1401_2_0'));	
/* ================ */

/* ================ */
RVP1503_1_0_score := Models.RVP1503_1_0(clam);
// output(RVP1503_1_0_score, named('RVP1503_1_0_score'));
                               
with_RVP1503_1_0 := join(with_RVP1401_2_0, RVP1503_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1503_1_0_score := right.score;
self.RVP1503_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1503_1_0, named('with_RVP1503_1_0'));	
/* ================ */

/* ================ */
RVP1605_1_0_score := Models.RVP1605_1_0(clam);
// output(RVP1503_1_0_score, named('RVP1503_1_0_score'));
                               
with_RVP1605_1_0 := join(with_RVP1503_1_0, RVP1605_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1605_1_0_score := right.score;
self.RVP1605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP1605_1_0, named('with_RVP1605_1_0'));	
/* ================ */
                      


RVP1702_1_0_score := Models.RVP1702_1_0(clam);
// output(RVP1702_1_0_score, named('RVP1702_1_0_score'));

with_RVP1702_1_0 := join(with_RVP1605_1_0, RVP1702_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVP1702_1_0_score := right.score;
self.RVP1702_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self := left), keep(1), left outer);
// output(with_RVP804_0_0, named('with_RVP804_0_0'));		


RVR704_1_0_score := Models.RVR704_1_0(clam, isCalifornia);
// output(RVR704_1_0_score, named('RVR704_1_0_score'));
                                  
with_RVR704_1_0 := join(with_RVP1702_1_0, RVR704_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR704_1_0_score := right.score;
self.RVR704_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR704_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR704_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR704_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR704_1_0, named('with_RVR704_1_0'));	                         


RVR1008_1_0_score := Models.RVR1008_1_0(clam);
// output(RVR1008_1_0_score, named('RVR1008_1_0_score'));
                                  
with_RVR1008_1_0 := join(with_RVR704_1_0, RVR1008_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1008_1_0_score := right.score;
self.RVR1008_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1008_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1008_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1008_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1008_1_0, named('with_RVR1008_1_0'));		



RVR1103_0_0_score := Models.RVR1103_0_0(clam);
// output(RVR1103_0_0_score, named('RVR1103_0_0_score'));
                                  
with_RVR1103_0_0 := join(with_RVR1008_1_0, RVR1103_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1103_0_0_score := right.score;
self.RVR1103_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1103_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1103_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1103_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1103_0_0, named('with_RVR1103_0_0'));		



RVR1104_2_0_score := Models.RVR1104_2_0(clam, isCalifornia,xmlPrescreenOptOut);
// output(RVR1104_1_0_score, named('RVR1104_2_0_score'));
                                  
with_RVR1104_2_0 := join(with_RVR1103_0_0, RVR1104_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1104_2_0_score := right.score;
self.RVR1104_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1104_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1104_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1104_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1104_2_0, named('with_RVR1104_2_0'));		

RVR1210_1_0_score := Models.RVR1210_1_0(clam);
// output(RVR1210_1_0_score, named('RVR1210_1_0_score'));
                                  
with_RVR1210_1_0 := join(with_RVR1104_2_0, RVR1210_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1210_1_0_score := right.score;
self.RVR1210_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1210_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1210_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1210_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1210_1_0, named('with_RVR1210_1_0'));		

RVR1303_1_0_score := Models.RVR1303_1_0(clam, isCalifornia);
// output(RVR1303_1_0_score, named('RVR1303_1_0_score'));
                                  
with_RVR1303_1_0 := join(with_RVR1210_1_0, RVR1303_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1303_1_0_score := right.score;
self.RVR1303_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1303_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1303_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1303_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1303_1_0, named('with_RVR1303_1_0'));		

          
RVR1410_1_0_score := Models.RVR1410_1_0(clam, isCalifornia,false);
// output(RVR1410_1_0_score, named('RVR1410_1_0_score'));
                                  
with_RVR1410_1_0 := join(with_RVR1303_1_0, RVR1410_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR1410_1_0_score := right.score;
self.RVR1410_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR1410_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR1410_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR1410_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR1410_1_0, named('with_RVR1410_1_0'));
          

RVR803_1_0_score := Models.RVR803_1_0(clam, isCalifornia);
// output(RVR803_1_0_score, named('RVR803_1_0_score'));
                                  
with_RVR803_1_0 := join(with_RVR1410_1_0, RVR803_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVR803_1_0_score := right.score;
self.RVR803_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVR803_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVR803_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVR803_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVR803_1_0, named('with_RVR803_1_0'));	
   
RVS811_0_0_score := Models.RVS811_0_0(ungroup(clam), bshell);
   // output(RVS811_0_0_score, named('RVS811_0_0_score'));
                                           
   with_RVS811_0_0 := join(with_RVR803_1_0, RVS811_0_0_score,
   left.seq=(unsigned)right.seq,
   transform(Models.layout_Runway,
   self.RVS811_0_0_score := (string)right.scores[1].value;
    self.RVS811_0_0_reason1 := right.scores[1].OwnerAgentHighRiskIndicators[1].RiskCode;
    self.RVS811_0_0_reason2 := right.scores[1].OwnerAgentHighRiskIndicators[2].RiskCode;
    self.RVS811_0_0_reason3 := right.scores[1].OwnerAgentHighRiskIndicators[3].RiskCode;
    self.RVS811_0_0_reason4 := right.scores[1].OwnerAgentHighRiskIndicators[4].RiskCode;
   self := left), keep(1), left outer);
   // output(with_RVS811_0_0, named('with_RVS811_0_0'));		
   
	RVS1706_0_score := Models.RVS1706_0_2(clam);
// output(RVS1706_0_score, named('RVS1706_0_score'));
                                     
with_RVS1706_0 := join(with_RVS811_0_0, RVS1706_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVS1706_0_score := right.score;
self.RVS1706_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVS1706_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVS1706_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVS1706_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVS1706_0, named('with_RVS1706_0'));	 
	 

RVT1003_0_0_score := Models.RVT1003_0_0(clam);
// output(RVT1003_0_0_score, named('RVT1003_0_0_score'));
                                     
with_RVT1003_0_0 := join(with_RVS1706_0, RVT1003_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1003_0_0_score := right.score;
self.RVT1003_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1003_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1003_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1003_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self := left), keep(1), left outer);
// output(with_RVT1003_0_0, named('with_RVT1003_0_0'));			


RVT1104_0_0_score := Models.RVT1104_0_0(clam, iscalifornia, xmlPreScreenOptOut);
// output(RVT1104_0_0_score, named('RVT1104_0_0_score'));
                                        
with_RVT1104_0_0 := join(with_RVT1003_0_0, RVT1104_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1104_0_0_score := right.score;
self.RVT1104_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1104_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1104_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1104_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1104_0_0, named('with_RVT1104_0_0'));			


RVT1104_1_0_score := Models.RVT1104_1_0(clam, iscalifornia, xmlPreScreenOptOut  );
// output(RVT1104_1_0_score, named('RVT1104_1_0_score'));
                                        
with_RVT1104_1_0 := join(with_RVT1104_0_0, RVT1104_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1104_1_0_score := right.score;
self.RVT1104_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1104_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1104_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1104_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1104_1_0, named('with_RVT1104_1_0'));								

RVT1204_1_score := Models.RVT1204_1(clam, iscalifornia, xmlPreScreenOptOut  );
// output(RVT1204_1_score, named('RVT1204_1_score'));
                                        
with_RVT1204_1 := join(with_RVT1104_1_0, RVT1204_1_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1204_1_score := right.score;
self.RVT1204_1_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1204_1_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1204_1_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1204_1_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1204_1, named('with_RVT1204_1'));								

RVT1210_1_0_score := Models.RVT1210_1_0(clam, iscalifornia, xmlPreScreenOptOut  );
// output(RVT1210_1_0_score, named('RVT1210_1_0_score'));
                                        
with_RVT1210_1_0 := join(with_RVT1204_1, RVT1210_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1210_1_0_score := right.score;
self.RVT1210_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1210_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1210_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1210_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1210_1_0, named('with_RVT1210_1_0'));	

RVT1212_1_0_score := Models.RVT1212_1_0(clam, iscalifornia);
// output(RVT1212_1_0_score, named('RVT1212_1_0_score'));
                                        
with_RVT1212_1_0 := join(with_RVT1210_1_0, RVT1212_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1212_1_0_score := right.score;
self.RVT1212_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1212_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1212_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1212_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1212_1_0, named('with_RVT1212_1_0'));	

RVT1307_3_0_score := Models.RVT1307_3_0(clam, iscalifornia, FALSE);
// output(RVT1307_3_0_score, named('RVT1307_3_0_score'));
                                        
with_RVT1307_3_0 := join(with_RVT1212_1_0, RVT1307_3_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1307_3_0_score := right.score;
self.RVT1307_3_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1307_3_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1307_3_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1307_3_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1307_3_0, named('with_RVT1307_3_0'));	

RVT1402_1_0_score := Models.RVT1402_1_0(clam, iscalifornia);
// output(RVT1307_3_0_score, named('RVT1307_3_0_score'));
                                        
with_RVT1402_1_0 := join(with_RVT1307_3_0, RVT1402_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1402_1_0_score := right.score;
self.RVT1402_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1402_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1402_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1402_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1402_1_0, named('with_RVT1402_1_0'));	

RVT1503_0_0_score := Models.RVT1503_0_0(clam, lexIDOnlyOnInput);
// output(RVT1503_0_0_score, named('RVT1503_0_0_score'));
                                        
with_RVT1503_0_0 := join(with_RVT1402_1_0, RVT1503_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1503_0_0_score := right.score;
self.RVT1503_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1503_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1503_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1503_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1503_0_0, named('with_RVT1503_0_0'));	

//---------------------------------------------------------
RVT1601_1_0_score := Models.RVT1601_1_0(clam, lexIDOnlyOnInput);
// output(RVT1503_0_0_score, named('RVT1503_0_0_score'));
                                        
with_RVT1601_1_0 := join(with_RVT1503_0_0, RVT1601_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1601_1_0_score := right.score;
self.RVT1601_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1601_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1601_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1601_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1503_0_0, named('with_RVT1503_0_0'));	
//--------------------------------------------------------------------


RVT711_1_0_score := Models.RVT711_1_0(clam, isCalifornia);
// output(RVT711_1_0_score, named('RVT711_1_0_score'));
                                        
with_RVT711_1_0 := join(with_RVT1601_1_0, RVT711_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT711_1_0_score := right.score;
self.RVT711_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT711_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT711_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT711_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT711_1_0, named('with_RVT711_1_0'));	


RVT1605_1_0_score := Models.RVT1605_1_0(clam, isCalifornia);
// output(RVT1605_1_0_score, named('RVT1605_1_0_score'));
                                        
with_RVT1605_1_0 := join(with_RVT711_1_0, RVT1605_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1605_1_0_score := right.score;
self.RVT1605_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1605_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1605_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1605_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_RVT1605_1_0, named('with_RVT1605_1_0'));


RVT1605_2_0_score := Models.RVT1605_2_0(clam, isCalifornia);
// output(RVT1605_2_0_score, named('RVT1605_2_0_score'));
                                        

with_RVT1605_2_0 := join(with_RVT1605_1_0, RVT1605_2_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1605_2_0_score := right.score;
self.RVT1605_2_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1605_2_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1605_2_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1605_2_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);


self := left), keep(1), left outer);
// output(with_RVT1605_2_0, named('with_RVT1605_2_0'));

RVT1608_1_0_score := Models.RVT1608_1_0(clam);
// output(RVT1608_1_0_score, named('RVT1608_1_0_score'));
 
 /*  T-Mobile Thin file Model  */  
with_RVT1608_1_0 := join(with_RVT1605_2_0, RVT1608_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1608_1_0_score := right.score;
self.RVT1608_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1608_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1608_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1608_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVT1608_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);

self := left), keep(1), left outer);
// output(with_RVT1608_1_0, named('with_RVT1608_1_0'));

/*  T-Mobile Thick file Model  */  
RVT1608_2_score := Models.RVT1608_2(clam);
// output(RVT1608_2_score, named('RVT1608_2_score'));
                                        
with_RVT1608_2 := join(with_RVT1608_1_0, RVT1608_2_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1608_2_score := right.score;
self.RVT1608_2_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1608_2_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1608_2_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1608_2_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVT1608_2_reason5 := if(exclude_reasons, '',  right.ri[5].hri);

self := left), keep(1), left outer);
// output(with_RVT1608_2, named('with_RVT1608_2'));	

RVT1705_1_0_score := Models.RVT1705_1_0(clam, isCalifornia);
// output(RVT1608_1_0_score, named('RVT1608_1_0_score'));


with_RVT1705_1_0 := join(with_RVT1608_2, RVT1705_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.RVT1705_1_0_score := right.score;
self.RVT1705_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.RVT1705_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.RVT1705_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.RVT1705_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);
self.RVT1705_1_0_reason5 := if(exclude_reasons, '',  right.ri[5].hri);

self := left), keep(1), left outer);
// output(with_RVT1705_1_0, named('with_RVT1705_1_0'));


TBN509_0_0_score := Models.TBN509_0_0(clam);
// output(TBN509_0_0_score, named('TBN509_0_0__score'));
                                        
with_TBN509_0_0:= join(with_RVT1705_1_0, TBN509_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.TBN509_0_0_score := right.score;
self.TBN509_0_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.TBN509_0_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.TBN509_0_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.TBN509_0_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_TBN509_0_0, named('with_TBN509_0_0'));

TBN604_1_0_score := Models.TBN604_1_0(clam, ofac);
// output(TBN604_1_0_score, named('TBN604_1_0__score'));
                                        
with_TBN604_1_0:= join(with_TBN509_0_0, TBN604_1_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.TBN604_1_0_score := right.score;
self.TBN604_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.TBN604_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.TBN604_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self.TBN604_1_0_reason4 := if(exclude_reasons, '',  right.ri[4].hri);

self := left), keep(1), left outer);
// output(with_TBN604_1_0, named('with_TBN604_1_0'));


WIN704_0_0_score := Models.WIN704_0_0(clam, census, isFCRA );
// output(WIN704_0_0_score, named('WIN704_0_0__score'));
                                        
with_WIN704_0_0:= join(with_TBN604_1_0, WIN704_0_0_score,
left.seq=(unsigned)right.seq,
transform(Models.layout_Runway,
self.WIN704_0_0_score := right.wealth_indicator;          
self := left), keep(1), left outer);
// output(with_WIN704_0_0, named('with_WIN704_0_0'));

      
WOMV002_0_0_score := Models.WOMV002_0_0(UNGROUP(clam));
// output(WOMV002_0_0_score, named('WOMV002_0_0__score'));
                                        
with_WOMV002_0_0:= join(with_WIN704_0_0, WOMV002_0_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.WOMV002_0_0_score := right.score;
self := left), keep(1), left outer);
// output(with_WOMV002_0_0, named('with_WOMV002_0_0'));

                
WWN604_1_0_score := Models.WWN604_1_0(clam);
// output(WWN604_1_0_score, named('WWN604_1_0__score'));
                                        
with_WWN604_1_0:= join(with_WOMV002_0_0, WWN604_1_0_score,
left.seq=right.seq,
transform(Models.layout_Runway,
self.WWN604_1_0_score := (string)right.score;
self.WWN604_1_0_reason1 := if(exclude_reasons, '',  right.ri[1].hri);
self.WWN604_1_0_reason2 := if(exclude_reasons, '',  right.ri[2].hri);
self.WWN604_1_0_reason3 := if(exclude_reasons, '',  right.ri[3].hri);
self := left), keep(1), left outer);
// output(with_WWN604_1_0, named('with_WWN604_1_0'));

// output(business, named('business'));
// output(reasons, named('reasons'));
// output(clambtst, named('clambtst'));
// output(biid, named('biid'));
// output(indata, named('indata'));
// output(clam_ip, named('clam_ip'));
// output(modelvariables, named('modelvariables'));
// output(iid_results, named('iid_results'));
// output(cclam, named('cclam'));
// output(bshell, named('bshell'));
// output(recoverScoreBatchIn, named('recoverScoreBatchIn'));
// output(rsn_prep, named('rsn_prep'));
// output(input, named('input'));
// output(biidRisk, named('biidRisk'));

final := project(with_wwn604_1_0, transform(models.Layout_Runway,

self.seq	:= if(model_environment in [1,2,3], left.seq	, 0);
self.did	:= if(model_environment in [1,2,3], left.did	, 0);
self.NAP	:= if(model_environment in [1,2,3], left.NAP	, '');
self.NAS	:= if(model_environment in [1,2,3], left.NAS	, '');
self.CVI_score	:= if(model_environment in [1,2,3], left.CVI_score	, '');
self.CVI_reason1	:= if(model_environment in [1,2,3], left.CVI_reason1	, '');
self.CVI_reason2	:= if(model_environment in [1,2,3], left.CVI_reason2	, '');
self.CVI_reason3	:= if(model_environment in [1,2,3], left.CVI_reason3	, '');
self.CVI_reason4	:= if(model_environment in [1,2,3], left.CVI_reason4	, '');


self.AIN509_0_0_score	:= if(model_environment in [1,3], left.AIN509_0_0_score	, '');
self.AIN509_0_0_reason1	:= if(model_environment in [1,3], left.AIN509_0_0_reason1	, '');
self.AIN509_0_0_reason2	:= if(model_environment in [1,3], left.AIN509_0_0_reason2	, '');
self.AIN509_0_0_reason3	:= if(model_environment in [1,3], left.AIN509_0_0_reason3	, '');
self.AIN509_0_0_reason4	:= if(model_environment in [1,3], left.AIN509_0_0_reason4	, '');


self.AIN602_1_0_score	:= if(model_environment in [1,3], left.AIN602_1_0_score	, '');
self.AIN602_1_0_reason1	:= if(model_environment in [1,3], left.AIN602_1_0_reason1	, '');
self.AIN602_1_0_reason2	:= if(model_environment in [1,3], left.AIN602_1_0_reason2	, '');
self.AIN602_1_0_reason3	:= if(model_environment in [1,3], left.AIN602_1_0_reason3	, '');
self.AIN602_1_0_reason4	:= if(model_environment in [1,3], left.AIN602_1_0_reason4	, '');


self.AIN605_1_0_score	:= if(model_environment in [1,3], left.AIN605_1_0_score	, '');
self.AIN605_1_0_reason1	:= if(model_environment in [1,3], left.AIN605_1_0_reason1	, '');
self.AIN605_1_0_reason2	:= if(model_environment in [1,3], left.AIN605_1_0_reason2	, '');
self.AIN605_1_0_reason3	:= if(model_environment in [1,3], left.AIN605_1_0_reason3	, '');
self.AIN605_1_0_reason4	:= if(model_environment in [1,3], left.AIN605_1_0_reason4	, '');


self.AIN605_2_0_score	:= if(model_environment in [1,3], left.AIN605_2_0_score	, '');
self.AIN605_2_0_reason1	:= if(model_environment in [1,3], left.AIN605_2_0_reason1	, '');
self.AIN605_2_0_reason2	:= if(model_environment in [1,3], left.AIN605_2_0_reason2	, '');
self.AIN605_2_0_reason3	:= if(model_environment in [1,3], left.AIN605_2_0_reason3	, '');
self.AIN605_2_0_reason4	:= if(model_environment in [1,3], left.AIN605_2_0_reason4	, '');


self.AIN605_3_0_score	:= if(model_environment in [1,3], left.AIN605_3_0_score	, '');
self.AIN605_3_0_reason1	:= if(model_environment in [1,3], left.AIN605_3_0_reason1	, '');
self.AIN605_3_0_reason2	:= if(model_environment in [1,3], left.AIN605_3_0_reason2	, '');
self.AIN605_3_0_reason3	:= if(model_environment in [1,3], left.AIN605_3_0_reason3	, '');
self.AIN605_3_0_reason4	:= if(model_environment in [1,3], left.AIN605_3_0_reason4	, '');


self.AIN801_1_0_score	:= if(model_environment in [1,3], left.AIN801_1_0_score	, '');
self.AIN801_1_0_reason1	:= if(model_environment in [1,3], left.AIN801_1_0_reason1	, '');
self.AIN801_1_0_reason2	:= if(model_environment in [1,3], left.AIN801_1_0_reason2	, '');
self.AIN801_1_0_reason3	:= if(model_environment in [1,3], left.AIN801_1_0_reason3	, '');
self.AIN801_1_0_reason4	:= if(model_environment in [1,3], left.AIN801_1_0_reason4	, '');

self.ANMK909_0_1_score	:= if(model_environment in [1,3], left.ANMK909_0_1_score	, '');

self.AWN510_0_0_score	:= if(model_environment in [1,3], left.AWN510_0_0_score	, '');
self.AWN510_0_0_reason1	:= if(model_environment in [1,3], left.AWN510_0_0_reason1	, '');
self.AWN510_0_0_reason2	:= if(model_environment in [1,3], left.AWN510_0_0_reason2	, '');
self.AWN510_0_0_reason3	:= if(model_environment in [1,3], left.AWN510_0_0_reason3	, '');
self.AWN510_0_0_reason4	:= if(model_environment in [1,3], left.AWN510_0_0_reason4	, '');

self.AWN603_1_0_score	:= if(model_environment in [1,3], left.AWN603_1_0_score	, '');
self.AWN603_1_0_reason1	:= if(model_environment in [1,3], left.AWN603_1_0_reason1	, '');
self.AWN603_1_0_reason2	:= if(model_environment in [1,3], left.AWN603_1_0_reason2	, '');
self.AWN603_1_0_reason3	:= if(model_environment in [1,3], left.AWN603_1_0_reason3	, '');
self.AWN603_1_0_reason4	:= if(model_environment in [1,3], left.AWN603_1_0_reason4	, '');


self.BD3605_0_0_score	:= if(model_environment in [1,3], left.BD3605_0_0_score	, '');
self.BD3605_0_0_reason1	:= if(model_environment in [1,3], left.BD3605_0_0_reason1	, '');
self.BD3605_0_0_reason2	:= if(model_environment in [1,3], left.BD3605_0_0_reason2	, '');
self.BD3605_0_0_reason3	:= if(model_environment in [1,3], left.BD3605_0_0_reason3	, '');
self.BD3605_0_0_reason4	:= if(model_environment in [1,3], left.BD3605_0_0_reason4	, '');


self.BD5605_0_0_score	:= if(model_environment in [1,3], left.BD5605_0_0_score	, '');
self.BD5605_0_0_reason1	:= if(model_environment in [1,3], left.BD5605_0_0_reason1	, '');
self.BD5605_0_0_reason2	:= if(model_environment in [1,3], left.BD5605_0_0_reason2	, '');
self.BD5605_0_0_reason3	:= if(model_environment in [1,3], left.BD5605_0_0_reason3	, '');
self.BD5605_0_0_reason4	:= if(model_environment in [1,3], left.BD5605_0_0_reason4	, '');

self.BD5605_1_0_score	:= if(model_environment in [1,3], left.BD5605_1_0_score	, '');
self.BD5605_1_0_reason1	:= if(model_environment in [1,3], left.BD5605_1_0_reason1	, '');
self.BD5605_1_0_reason2	:= if(model_environment in [1,3], left.BD5605_1_0_reason2	, '');
self.BD5605_1_0_reason3	:= if(model_environment in [1,3], left.BD5605_1_0_reason3	, '');
self.BD5605_1_0_reason4	:= if(model_environment in [1,3], left.BD5605_1_0_reason4	, '');

self.BD5605_2_0_score	:= if(model_environment in [1,3], left.BD5605_2_0_score	, '');
self.BD5605_2_0_reason1	:= if(model_environment in [1,3], left.BD5605_2_0_reason1	, '');
self.BD5605_2_0_reason2	:= if(model_environment in [1,3], left.BD5605_2_0_reason2	, '');
self.BD5605_2_0_reason3	:= if(model_environment in [1,3], left.BD5605_2_0_reason3	, '');
self.BD5605_2_0_reason4	:= if(model_environment in [1,3], left.BD5605_2_0_reason4	, '');


self.BD5605_3_0_score	:= if(model_environment in [1,3], left.BD5605_3_0_score	, '');
self.BD5605_3_0_reason1	:= if(model_environment in [1,3], left.BD5605_3_0_reason1	, '');
self.BD5605_3_0_reason2	:= if(model_environment in [1,3], left.BD5605_3_0_reason2	, '');
self.BD5605_3_0_reason3	:= if(model_environment in [1,3], left.BD5605_3_0_reason3	, '');
self.BD5605_3_0_reason4	:= if(model_environment in [1,3], left.BD5605_3_0_reason4	, '');


self.BD9605_0_0_score	:= if(model_environment in [1,3], left.BD9605_0_0_score	, '');
self.BD9605_0_0_reason1	:= if(model_environment in [1,3], left.BD9605_0_0_reason1	, '');
self.BD9605_0_0_reason2	:= if(model_environment in [1,3], left.BD9605_0_0_reason2	, '');
self.BD9605_0_0_reason3	:= if(model_environment in [1,3], left.BD9605_0_0_reason3	, '');
self.BD9605_0_0_reason4	:= if(model_environment in [1,3], left.BD9605_0_0_reason4	, '');


self.BD9605_1_0_score	:= if(model_environment in [1,3], left.BD9605_1_0_score	, '');
self.BD9605_1_0_reason1	:= if(model_environment in [1,3], left.BD9605_1_0_reason1	, '');
self.BD9605_1_0_reason2	:= if(model_environment in [1,3], left.BD9605_1_0_reason2	, '');
self.BD9605_1_0_reason3	:= if(model_environment in [1,3], left.BD9605_1_0_reason3	, '');
self.BD9605_1_0_reason4	:= if(model_environment in [1,3], left.BD9605_1_0_reason4	, '');

self.CDN1109_1_0_score	:= if(model_environment in [1,3], left.CDN1109_1_0_score	, '');
self.CDN1109_1_0_reason1	:= if(model_environment in [1,3], left.CDN1109_1_0_reason1	, '');
self.CDN1109_1_0_reason2	:= if(model_environment in [1,3], left.CDN1109_1_0_reason2	, '');
self.CDN1109_1_0_reason3	:= if(model_environment in [1,3], left.CDN1109_1_0_reason3	, '');
self.CDN1109_1_0_reason4	:= if(model_environment in [1,3], left.CDN1109_1_0_reason4	, '');

self.CDN1205_1_0_score	:= if(model_environment in [1,3], left.CDN1205_1_0_score	, '');
self.CDN1205_1_0_reason1	:= if(model_environment in [1,3], left.CDN1205_1_0_reason1	, '');
self.CDN1205_1_0_reason2	:= if(model_environment in [1,3], left.CDN1205_1_0_reason2	, '');
self.CDN1205_1_0_reason3	:= if(model_environment in [1,3], left.CDN1205_1_0_reason3	, '');
self.CDN1205_1_0_reason4	:= if(model_environment in [1,3], left.CDN1205_1_0_reason4	, '');

self.CDN1305_1_0_score	:= if(model_environment in [1,3], left.CDN1305_1_0_score	, '');
self.CDN1305_1_0_reason1	:= if(model_environment in [1,3], left.CDN1305_1_0_reason1	, '');
self.CDN1305_1_0_reason2	:= if(model_environment in [1,3], left.CDN1305_1_0_reason2	, '');
self.CDN1305_1_0_reason3	:= if(model_environment in [1,3], left.CDN1305_1_0_reason3	, '');
self.CDN1305_1_0_reason4	:= if(model_environment in [1,3], left.CDN1305_1_0_reason4	, '');

self.CDN1404_1_0_score	:= if(model_environment in [1,3], left.CDN1404_1_0_score	, '');
self.CDN1404_1_0_reason1	:= if(model_environment in [1,3], left.CDN1404_1_0_reason1	, '');
self.CDN1404_1_0_reason2	:= if(model_environment in [1,3], left.CDN1404_1_0_reason2	, '');
self.CDN1404_1_0_reason3	:= if(model_environment in [1,3], left.CDN1404_1_0_reason3	, '');
self.CDN1404_1_0_reason4	:= if(model_environment in [1,3], left.CDN1404_1_0_reason4	, '');

self.CDN1410_1_0_score	:= if(model_environment in [1,3], left.CDN1410_1_0_score	, '');
self.CDN1410_1_0_reason1	:= if(model_environment in [1,3], left.CDN1410_1_0_reason1	, '');
self.CDN1410_1_0_reason2	:= if(model_environment in [1,3], left.CDN1410_1_0_reason2	, '');
self.CDN1410_1_0_reason3	:= if(model_environment in [1,3], left.CDN1410_1_0_reason3	, '');
self.CDN1410_1_0_reason4	:= if(model_environment in [1,3], left.CDN1410_1_0_reason4	, '');

self.CDN1506_1_0_score	:= if(model_environment in [1,3], left.CDN1506_1_0_score	, '');
self.CDN1506_1_0_reason1	:= if(model_environment in [1,3], left.CDN1506_1_0_reason1	, '');
self.CDN1506_1_0_reason2	:= if(model_environment in [1,3], left.CDN1506_1_0_reason2	, '');
self.CDN1506_1_0_reason3	:= if(model_environment in [1,3], left.CDN1506_1_0_reason3	, '');
self.CDN1506_1_0_reason4	:= if(model_environment in [1,3], left.CDN1506_1_0_reason4	, '');

self.CDN1508_1_0_score	:= if(model_environment in [1,3], left.CDN1508_1_0_score	, '');
self.CDN1508_1_0_reason1	:= if(model_environment in [1,3], left.CDN1508_1_0_reason1	, '');
self.CDN1508_1_0_reason2	:= if(model_environment in [1,3], left.CDN1508_1_0_reason2	, '');
self.CDN1508_1_0_reason3	:= if(model_environment in [1,3], left.CDN1508_1_0_reason3	, '');
self.CDN1508_1_0_reason4	:= if(model_environment in [1,3], left.CDN1508_1_0_reason4	, '');
self.CDN1508_1_0_reason5	:= if(model_environment in [1,3], left.CDN1508_1_0_reason5	, '');
self.CDN1508_1_0_reason6	:= if(model_environment in [1,3], left.CDN1508_1_0_reason6	, '');

self.CDN604_0_0_score	:= if(model_environment in [1,3], left.CDN604_0_0_score	, '');
self.CDN604_0_0_reason1	:= if(model_environment in [1,3], left.CDN604_0_0_reason1	, '');
self.CDN604_0_0_reason2	:= if(model_environment in [1,3], left.CDN604_0_0_reason2	, '');
self.CDN604_0_0_reason3	:= if(model_environment in [1,3], left.CDN604_0_0_reason3	, '');
self.CDN604_0_0_reason4	:= if(model_environment in [1,3], left.CDN604_0_0_reason4	, '');

/*  This is the flag ship for Order Score  */    
self.OSN1504_0_0_score	:= if(model_environment in [1,3], left.OSN1504_0_0_score	, '');
self.OSN1504_0_0_reason1	:= if(model_environment in [1,3], left.OSN1504_0_0_reason1	, '');
self.OSN1504_0_0_reason2	:= if(model_environment in [1,3], left.OSN1504_0_0_reason2	, '');
self.OSN1504_0_0_reason3	:= if(model_environment in [1,3], left.OSN1504_0_0_reason3	, '');
self.OSN1504_0_0_reason4	:= if(model_environment in [1,3], left.OSN1504_0_0_reason4	, '');
self.OSN1504_0_0_reason5	:= if(model_environment in [1,3], left.OSN1504_0_0_reason5	, '');
self.OSN1504_0_0_reason6	:= if(model_environment in [1,3], left.OSN1504_0_0_reason6	, '');

/*  This is the custom model for Vivid Seats within the Order Score Product  */    
self.OSN1608_1_0_score	:= if(model_environment in [1,3], left.OSN1608_1_0_score	, '');
self.OSN1608_1_0_reason1	:= if(model_environment in [1,3], left.OSN1608_1_0_reason1	, '');
self.OSN1608_1_0_reason2	:= if(model_environment in [1,3], left.OSN1608_1_0_reason2	, '');
self.OSN1608_1_0_reason3	:= if(model_environment in [1,3], left.OSN1608_1_0_reason3	, '');
self.OSN1608_1_0_reason4	:= if(model_environment in [1,3], left.OSN1608_1_0_reason4	, '');
self.OSN1608_1_0_reason5	:= if(model_environment in [1,3], left.OSN1608_1_0_reason5	, '');
self.OSN1608_1_0_reason6	:= if(model_environment in [1,3], left.OSN1608_1_0_reason6	, '');

/*  This is the custom model for Wallmart within the Order Score Product  */    
self.OSN1803_1_0_score	:= if(model_environment in [1,3], left.OSN1803_1_0_score	, '');
self.OSN1803_1_0_reason1	:= if(model_environment in [1,3], left.OSN1803_1_0_reason1	, '');
self.OSN1803_1_0_reason2	:= if(model_environment in [1,3], left.OSN1803_1_0_reason2	, '');
self.OSN1803_1_0_reason3	:= if(model_environment in [1,3], left.OSN1803_1_0_reason3	, '');
self.OSN1803_1_0_reason4	:= if(model_environment in [1,3], left.OSN1803_1_0_reason4	, '');
self.OSN1803_1_0_reason5	:= if(model_environment in [1,3], left.OSN1803_1_0_reason5	, '');
self.OSN1803_1_0_reason6	:= if(model_environment in [1,3], left.OSN1803_1_0_reason6	, '');

self.CDN604_1_0_score	:= if(model_environment in [1,3], left.CDN604_1_0_score	, '');

self.CDN604_2_0_score	:= if(model_environment in [1,3], left.CDN604_2_0_score	, '');
self.CDN604_2_0_reason1	:= if(model_environment in [1,3], left.CDN604_2_0_reason1	, '');
self.CDN604_2_0_reason2	:= if(model_environment in [1,3], left.CDN604_2_0_reason2	, '');
self.CDN604_2_0_reason3	:= if(model_environment in [1,3], left.CDN604_2_0_reason3	, '');
self.CDN604_2_0_reason4	:= if(model_environment in [1,3], left.CDN604_2_0_reason4	, '');


self.CDN604_3_0_score	:= if(model_environment in [1,3], left.CDN604_3_0_score	, '');
self.CDN604_3_0_reason1	:= if(model_environment in [1,3], left.CDN604_3_0_reason1	, '');
self.CDN604_3_0_reason2	:= if(model_environment in [1,3], left.CDN604_3_0_reason2	, '');
self.CDN604_3_0_reason3	:= if(model_environment in [1,3], left.CDN604_3_0_reason3	, '');
self.CDN604_3_0_reason4	:= if(model_environment in [1,3], left.CDN604_3_0_reason4	, '');


self.CDN604_4_0_score	:= if(model_environment in [1,3], left.CDN604_4_0_score	, '');
self.CDN604_4_0_reason1	:= if(model_environment in [1,3], left.CDN604_4_0_reason1	, '');
self.CDN604_4_0_reason2	:= if(model_environment in [1,3], left.CDN604_4_0_reason2	, '');
self.CDN604_4_0_reason3	:= if(model_environment in [1,3], left.CDN604_4_0_reason3	, '');
self.CDN604_4_0_reason4	:= if(model_environment in [1,3], left.CDN604_4_0_reason4	, '');


self.CDN605_1_0_score	:= if(model_environment in [1,3], left.CDN605_1_0_score	, '');
self.CDN605_1_0_reason1	:= if(model_environment in [1,3], left.CDN605_1_0_reason1	, '');
self.CDN605_1_0_reason2	:= if(model_environment in [1,3], left.CDN605_1_0_reason2	, '');
self.CDN605_1_0_reason3	:= if(model_environment in [1,3], left.CDN605_1_0_reason3	, '');
self.CDN605_1_0_reason4	:= if(model_environment in [1,3], left.CDN605_1_0_reason4	, '');


self.CDN606_2_0_score	:= if(model_environment in [1,3], left.CDN606_2_0_score	, '');
self.CDN606_2_0_reason1	:= if(model_environment in [1,3], left.CDN606_2_0_reason1	, '');
self.CDN606_2_0_reason2	:= if(model_environment in [1,3], left.CDN606_2_0_reason2	, '');
self.CDN606_2_0_reason3	:= if(model_environment in [1,3], left.CDN606_2_0_reason3	, '');
self.CDN606_2_0_reason4	:= if(model_environment in [1,3], left.CDN606_2_0_reason4	, '');


self.CDN706_1_0_score	:= if(model_environment in [1,3], left.CDN706_1_0_score	, '');
self.CDN706_1_0_bt_reason1	:= if(model_environment in [1,3], left.CDN706_1_0_bt_reason1	, '');
self.CDN706_1_0_bt_reason2	:= if(model_environment in [1,3], left.CDN706_1_0_bt_reason2	, '');
self.CDN706_1_0_bt_reason3	:= if(model_environment in [1,3], left.CDN706_1_0_bt_reason3	, '');
self.CDN706_1_0_bt_reason4	:= if(model_environment in [1,3], left.CDN706_1_0_bt_reason4	, '');

self.CDN706_1_0_st_reason1	:= if(model_environment in [1,3], left.CDN706_1_0_st_reason1	, '');
self.CDN706_1_0_st_reason2	:= if(model_environment in [1,3], left.CDN706_1_0_st_reason2	, '');
self.CDN706_1_0_st_reason3	:= if(model_environment in [1,3], left.CDN706_1_0_st_reason3	, '');
self.CDN706_1_0_st_reason4	:= if(model_environment in [1,3], left.CDN706_1_0_st_reason4	, '');


self.CDN707_1_0_score	:= if(model_environment in [1,3], left.CDN707_1_0_score	, '');
self.CDN707_1_0_reason1	:= if(model_environment in [1,3], left.CDN707_1_0_reason1	, '');
self.CDN707_1_0_reason2	:= if(model_environment in [1,3], left.CDN707_1_0_reason2	, '');
self.CDN707_1_0_reason3	:= if(model_environment in [1,3], left.CDN707_1_0_reason3	, '');
self.CDN707_1_0_reason4	:= if(model_environment in [1,3], left.CDN707_1_0_reason4	, '');


self.CDN712_0_0_score	:= if(model_environment in [1,3], left.CDN712_0_0_score	, '');
self.CDN712_0_0_reason1	:= if(model_environment in [1,3], left.CDN712_0_0_reason1	, '');
self.CDN712_0_0_reason2	:= if(model_environment in [1,3], left.CDN712_0_0_reason2	, '');
self.CDN712_0_0_reason3	:= if(model_environment in [1,3], left.CDN712_0_0_reason3	, '');
self.CDN712_0_0_reason4	:= if(model_environment in [1,3], left.CDN712_0_0_reason4	, '');


self.CDN806_1_0_score	:= if(model_environment in [1,3], left.CDN806_1_0_score	, '');
self.CDN806_1_0_reason1	:= if(model_environment in [1,3], left.CDN806_1_0_reason1	, '');
self.CDN806_1_0_reason2	:= if(model_environment in [1,3], left.CDN806_1_0_reason2	, '');
self.CDN806_1_0_reason3	:= if(model_environment in [1,3], left.CDN806_1_0_reason3	, '');
self.CDN806_1_0_reason4	:= if(model_environment in [1,3], left.CDN806_1_0_reason4	, '');

/*sunset nd10
self.CDN810_1_0_score	:= if(model_environment in [1,3], left.CDN810_1_0_score	, '');
self.CDN810_1_0_reason1	:= if(model_environment in [1,3], left.CDN810_1_0_reason1	, '');
self.CDN810_1_0_reason2	:= if(model_environment in [1,3], left.CDN810_1_0_reason2	, '');
self.CDN810_1_0_reason3	:= if(model_environment in [1,3], left.CDN810_1_0_reason3	, '');
self.CDN810_1_0_reason4	:= if(model_environment in [1,3], left.CDN810_1_0_reason4	, '');
*/

self.CDN908_1_0_score	:= if(model_environment in [1,3], left.CDN908_1_0_score	, '');
self.CDN908_1_0_reason1	:= if(model_environment in [1,3], left.CDN908_1_0_reason1	, '');
self.CDN908_1_0_reason2	:= if(model_environment in [1,3], left.CDN908_1_0_reason2	, '');
self.CDN908_1_0_reason3	:= if(model_environment in [1,3], left.CDN908_1_0_reason3	, '');
self.CDN908_1_0_reason4	:= if(model_environment in [1,3], left.CDN908_1_0_reason4	, '');


self.CEN509_0_0_score	:= if(model_environment in [1,3], left.CEN509_0_0_score	, '');

self.CSN1007_0_0_score	:= if(model_environment in [1,3], left.CSN1007_0_0_score	, '');

self.FD3510_0_0_score	:= if(model_environment in [1,3], left.FD3510_0_0_score	, '');
self.FD3510_0_0_reason1	:= if(model_environment in [1,3], left.FD3510_0_0_reason1	, '');
self.FD3510_0_0_reason2	:= if(model_environment in [1,3], left.FD3510_0_0_reason2	, '');
self.FD3510_0_0_reason3	:= if(model_environment in [1,3], left.FD3510_0_0_reason3	, '');
self.FD3510_0_0_reason4	:= if(model_environment in [1,3], left.FD3510_0_0_reason4	, '');


self.FD3606_0_0_score	:= if(model_environment in [1,3], left.FD3606_0_0_score	, '');
self.FD3606_0_0_reason1	:= if(model_environment in [1,3], left.FD3606_0_0_reason1	, '');
self.FD3606_0_0_reason2	:= if(model_environment in [1,3], left.FD3606_0_0_reason2	, '');
self.FD3606_0_0_reason3	:= if(model_environment in [1,3], left.FD3606_0_0_reason3	, '');
self.FD3606_0_0_reason4	:= if(model_environment in [1,3], left.FD3606_0_0_reason4	, '');


self.FD5510_0_0_score	:= if(model_environment in [1,3], left.FD5510_0_0_score	, '');
self.FD5510_0_0_reason1	:= if(model_environment in [1,3], left.FD5510_0_0_reason1	, '');
self.FD5510_0_0_reason2	:= if(model_environment in [1,3], left.FD5510_0_0_reason2	, '');
self.FD5510_0_0_reason3	:= if(model_environment in [1,3], left.FD5510_0_0_reason3	, '');
self.FD5510_0_0_reason4	:= if(model_environment in [1,3], left.FD5510_0_0_reason4	, '');

self.FD5603_1_0_score	:= if(model_environment in [1,3], left.FD5603_1_0_score	, '');
self.FD5603_1_0_reason1	:= if(model_environment in [1,3], left.FD5603_1_0_reason1	, '');
self.FD5603_1_0_reason2	:= if(model_environment in [1,3], left.FD5603_1_0_reason2	, '');
self.FD5603_1_0_reason3	:= if(model_environment in [1,3], left.FD5603_1_0_reason3	, '');
self.FD5603_1_0_reason4	:= if(model_environment in [1,3], left.FD5603_1_0_reason4	, '');

self.FD5603_2_0_score	:= if(model_environment in [1,3], left.FD5603_2_0_score	, '');
self.FD5603_2_0_reason1	:= if(model_environment in [1,3], left.FD5603_2_0_reason1	, '');
self.FD5603_2_0_reason2	:= if(model_environment in [1,3], left.FD5603_2_0_reason2	, '');
self.FD5603_2_0_reason3	:= if(model_environment in [1,3], left.FD5603_2_0_reason3	, '');
self.FD5603_2_0_reason4	:= if(model_environment in [1,3], left.FD5603_2_0_reason4	, '');


self.FD5603_3_0_score	:= if(model_environment in [1,3], left.FD5603_3_0_score	, '');
self.FD5603_3_0_reason1	:= if(model_environment in [1,3], left.FD5603_3_0_reason1	, '');
self.FD5603_3_0_reason2	:= if(model_environment in [1,3], left.FD5603_3_0_reason2	, '');
self.FD5603_3_0_reason3	:= if(model_environment in [1,3], left.FD5603_3_0_reason3	, '');
self.FD5603_3_0_reason4	:= if(model_environment in [1,3], left.FD5603_3_0_reason4	, '');


self.FD5607_1_0_score	:= if(model_environment in [1,3], left.FD5607_1_0_score	, '');
self.FD5607_1_0_reason1	:= if(model_environment in [1,3], left.FD5607_1_0_reason1	, '');
self.FD5607_1_0_reason2	:= if(model_environment in [1,3], left.FD5607_1_0_reason2	, '');
self.FD5607_1_0_reason3	:= if(model_environment in [1,3], left.FD5607_1_0_reason3	, '');
self.FD5607_1_0_reason4	:= if(model_environment in [1,3], left.FD5607_1_0_reason4	, '');


self.FD5609_1_0_score	:= if(model_environment in [1,3], left.FD5609_1_0_score	, '');
self.FD5609_1_0_reason1	:= if(model_environment in [1,3], left.FD5609_1_0_reason1	, '');
self.FD5609_1_0_reason2	:= if(model_environment in [1,3], left.FD5609_1_0_reason2	, '');
self.FD5609_1_0_reason3	:= if(model_environment in [1,3], left.FD5609_1_0_reason3	, '');
self.FD5609_1_0_reason4	:= if(model_environment in [1,3], left.FD5609_1_0_reason4	, '');


self.FD5609_2_0_score	:= if(model_environment in [1,3], left.FD5609_2_0_score	, '');
self.FD5609_2_0_reason1	:= if(model_environment in [1,3], left.FD5609_2_0_reason1	, '');
self.FD5609_2_0_reason2	:= if(model_environment in [1,3], left.FD5609_2_0_reason2	, '');
self.FD5609_2_0_reason3	:= if(model_environment in [1,3], left.FD5609_2_0_reason3	, '');
self.FD5609_2_0_reason4	:= if(model_environment in [1,3], left.FD5609_2_0_reason4	, '');


self.FD5709_1_0_score	:= if(model_environment in [1,3], left.FD5709_1_0_score	, '');
self.FD5709_1_0_reason1	:= if(model_environment in [1,3], left.FD5709_1_0_reason1	, '');
self.FD5709_1_0_reason2	:= if(model_environment in [1,3], left.FD5709_1_0_reason2	, '');
self.FD5709_1_0_reason3	:= if(model_environment in [1,3], left.FD5709_1_0_reason3	, '');
self.FD5709_1_0_reason4	:= if(model_environment in [1,3], left.FD5709_1_0_reason4	, '');

self.FD9510_0_0_score	:= if(model_environment in [1,3], left.FD9510_0_0_score	, '');
self.FD9510_0_0_reason1	:= if(model_environment in [1,3], left.FD9510_0_0_reason1	, '');
self.FD9510_0_0_reason2	:= if(model_environment in [1,3], left.FD9510_0_0_reason2	, '');
self.FD9510_0_0_reason3	:= if(model_environment in [1,3], left.FD9510_0_0_reason3	, '');
self.FD9510_0_0_reason4	:= if(model_environment in [1,3], left.FD9510_0_0_reason4	, '');

self.FD9603_1_0_score	:= if(model_environment in [1,3], left.FD9603_1_0_score	, '');
self.FD9603_1_0_reason1	:= if(model_environment in [1,3], left.FD9603_1_0_reason1	, '');
self.FD9603_1_0_reason2	:= if(model_environment in [1,3], left.FD9603_1_0_reason2	, '');
self.FD9603_1_0_reason3	:= if(model_environment in [1,3], left.FD9603_1_0_reason3	, '');
self.FD9603_1_0_reason4	:= if(model_environment in [1,3], left.FD9603_1_0_reason4	, '');

self.FD9603_2_0_score	:= if(model_environment in [1,3], left.FD9603_2_0_score	, '');
self.FD9603_2_0_reason1	:= if(model_environment in [1,3], left.FD9603_2_0_reason1	, '');
self.FD9603_2_0_reason2	:= if(model_environment in [1,3], left.FD9603_2_0_reason2	, '');
self.FD9603_2_0_reason3	:= if(model_environment in [1,3], left.FD9603_2_0_reason3	, '');
self.FD9603_2_0_reason4	:= if(model_environment in [1,3], left.FD9603_2_0_reason4	, '');

self.FD9603_3_0_score	:= if(model_environment in [1,3], left.FD9603_3_0_score	, '');
self.FD9603_3_0_reason1	:= if(model_environment in [1,3], left.FD9603_3_0_reason1	, '');
self.FD9603_3_0_reason2	:= if(model_environment in [1,3], left.FD9603_3_0_reason2	, '');
self.FD9603_3_0_reason3	:= if(model_environment in [1,3], left.FD9603_3_0_reason3	, '');
self.FD9603_3_0_reason4	:= if(model_environment in [1,3], left.FD9603_3_0_reason4	, '');

self.FD9603_4_0_score	:= if(model_environment in [1,3], left.FD9603_4_0_score	, '');
self.FD9603_4_0_reason1	:= if(model_environment in [1,3], left.FD9603_4_0_reason1	, '');
self.FD9603_4_0_reason2	:= if(model_environment in [1,3], left.FD9603_4_0_reason2	, '');
self.FD9603_4_0_reason3	:= if(model_environment in [1,3], left.FD9603_4_0_reason3	, '');
self.FD9603_4_0_reason4	:= if(model_environment in [1,3], left.FD9603_4_0_reason4	, '');


self.FD9604_1_0_score	:= if(model_environment in [1,3], left.FD9604_1_0_score	, '');
self.FD9604_1_0_reason1	:= if(model_environment in [1,3], left.FD9604_1_0_reason1	, '');
self.FD9604_1_0_reason2	:= if(model_environment in [1,3], left.FD9604_1_0_reason2	, '');
self.FD9604_1_0_reason3	:= if(model_environment in [1,3], left.FD9604_1_0_reason3	, '');
self.FD9604_1_0_reason4	:= if(model_environment in [1,3], left.FD9604_1_0_reason4	, '');


self.FD9606_0_0_score	:= if(model_environment in [1,3], left.FD9606_0_0_score	, '');
self.FD9606_0_0_reason1	:= if(model_environment in [1,3], left.FD9606_0_0_reason1	, '');
self.FD9606_0_0_reason2	:= if(model_environment in [1,3], left.FD9606_0_0_reason2	, '');
self.FD9606_0_0_reason3	:= if(model_environment in [1,3], left.FD9606_0_0_reason3	, '');
self.FD9606_0_0_reason4	:= if(model_environment in [1,3], left.FD9606_0_0_reason4	, '');

self.FD9607_1_0_score	:= if(model_environment in [1,3], left.FD9607_1_0_score	, '');
self.FD9607_1_0_reason1	:= if(model_environment in [1,3], left.FD9607_1_0_reason1	, '');
self.FD9607_1_0_reason2	:= if(model_environment in [1,3], left.FD9607_1_0_reason2	, '');
self.FD9607_1_0_reason3	:= if(model_environment in [1,3], left.FD9607_1_0_reason3	, '');
self.FD9607_1_0_reason4	:= if(model_environment in [1,3], left.FD9607_1_0_reason4	, '');


self.FP1109_0_0_score	:= if(model_environment in [1,3], left.FP1109_0_0_score	, '');
self.FP1109_0_0_reason1	:= if(model_environment in [1,3], left.FP1109_0_0_reason1	, '');
self.FP1109_0_0_reason2	:= if(model_environment in [1,3], left.FP1109_0_0_reason2	, '');
self.FP1109_0_0_reason3	:= if(model_environment in [1,3], left.FP1109_0_0_reason3	, '');
self.FP1109_0_0_reason4	:= if(model_environment in [1,3], left.FP1109_0_0_reason4	, '');

self.FP1210_1_0_score	:= if(model_environment in [1,3], left.FP1210_1_0_score	, '');

self.FP1303_1_0_score	:= if(model_environment in [1,3], left.FP1303_1_0_score	, '');
self.FP1303_1_0_reason1	:= if(model_environment in [1,3], left.FP1303_1_0_reason1	, '');
self.FP1303_1_0_reason2	:= if(model_environment in [1,3], left.FP1303_1_0_reason2	, '');
self.FP1303_1_0_reason3	:= if(model_environment in [1,3], left.FP1303_1_0_reason3	, '');
self.FP1303_1_0_reason4	:= if(model_environment in [1,3], left.FP1303_1_0_reason4	, '');

self.FP1303_2_0_score	:= if(model_environment in [1,3], left.FP1303_2_0_score	, '');

self.FP1310_1_0_score	:= if(model_environment in [1,3], left.FP1310_1_0_score	, '');
self.FP1310_1_0_reason1	:= if(model_environment in [1,3], left.FP1310_1_0_reason1	, '');
self.FP1310_1_0_reason2	:= if(model_environment in [1,3], left.FP1310_1_0_reason2	, '');
self.FP1310_1_0_reason3	:= if(model_environment in [1,3], left.FP1310_1_0_reason3	, '');
self.FP1310_1_0_reason4	:= if(model_environment in [1,3], left.FP1310_1_0_reason4	, '');
self.FP1310_1_0_reason5	:= if(model_environment in [1,3], left.FP1310_1_0_reason5	, '');
self.FP1310_1_0_reason6	:= if(model_environment in [1,3], left.FP1310_1_0_reason6	, '');

self.FP1401_1_0_score	:= if(model_environment in [1,3], left.FP1401_1_0_score	, '');
self.FP1401_1_0_reason1	:= if(model_environment in [1,3], left.FP1401_1_0_reason1	, '');
self.FP1401_1_0_reason2	:= if(model_environment in [1,3], left.FP1401_1_0_reason2	, '');
self.FP1401_1_0_reason3	:= if(model_environment in [1,3], left.FP1401_1_0_reason3	, '');
self.FP1401_1_0_reason4	:= if(model_environment in [1,3], left.FP1401_1_0_reason4	, '');
self.FP1401_1_0_reason5	:= if(model_environment in [1,3], left.FP1401_1_0_reason5	, '');
self.FP1401_1_0_reason6	:= if(model_environment in [1,3], left.FP1401_1_0_reason6	, '');

self.FP1404_1_0_score	:= if(model_environment in [1,3], left.FP1404_1_0_score	, '');
self.FP1404_1_0_reason1	:= if(model_environment in [1,3], left.FP1404_1_0_reason1	, '');
self.FP1404_1_0_reason2	:= if(model_environment in [1,3], left.FP1404_1_0_reason2	, '');
self.FP1404_1_0_reason3	:= if(model_environment in [1,3], left.FP1404_1_0_reason3	, '');
self.FP1404_1_0_reason4	:= if(model_environment in [1,3], left.FP1404_1_0_reason4	, '');
self.FP1404_1_0_reason5	:= if(model_environment in [1,3], left.FP1404_1_0_reason5	, '');
self.FP1404_1_0_reason6	:= if(model_environment in [1,3], left.FP1404_1_0_reason6	, '');

self.FP1407_1_0_score	:= if(model_environment in [1,3], left.FP1407_1_0_score	, '');
self.FP1407_1_0_reason1	:= if(model_environment in [1,3], left.FP1407_1_0_reason1	, '');
self.FP1407_1_0_reason2	:= if(model_environment in [1,3], left.FP1407_1_0_reason2	, '');
self.FP1407_1_0_reason3	:= if(model_environment in [1,3], left.FP1407_1_0_reason3	, '');
self.FP1407_1_0_reason4	:= if(model_environment in [1,3], left.FP1407_1_0_reason4	, '');
self.FP1407_1_0_reason5	:= if(model_environment in [1,3], left.FP1407_1_0_reason5	, '');
self.FP1407_1_0_reason6	:= if(model_environment in [1,3], left.FP1407_1_0_reason6	, '');

self.FP1407_2_0_score	:= if(model_environment in [1,3], left.FP1407_2_0_score	, '');
self.FP1407_2_0_reason1	:= if(model_environment in [1,3], left.FP1407_2_0_reason1	, '');
self.FP1407_2_0_reason2	:= if(model_environment in [1,3], left.FP1407_2_0_reason2	, '');
self.FP1407_2_0_reason3	:= if(model_environment in [1,3], left.FP1407_2_0_reason3	, '');
self.FP1407_2_0_reason4	:= if(model_environment in [1,3], left.FP1407_2_0_reason4	, '');
self.FP1407_2_0_reason5	:= if(model_environment in [1,3], left.FP1407_2_0_reason5	, '');
self.FP1407_2_0_reason6	:= if(model_environment in [1,3], left.FP1407_2_0_reason6	, '');

self.FP1611_1_0_score	:= if(model_environment in [1,3], left.FP1611_1_0_score	, '');
self.FP1611_1_0_reason1	:= if(model_environment in [1,3], left.FP1611_1_0_reason1	, '');
self.FP1611_1_0_reason2	:= if(model_environment in [1,3], left.FP1611_1_0_reason2	, '');
self.FP1611_1_0_reason3	:= if(model_environment in [1,3], left.FP1611_1_0_reason3	, '');
self.FP1611_1_0_reason4	:= if(model_environment in [1,3], left.FP1611_1_0_reason4	, '');
self.FP1611_1_0_reason5	:= if(model_environment in [1,3], left.FP1611_1_0_reason5	, '');
self.FP1611_1_0_reason6	:= if(model_environment in [1,3], left.FP1611_1_0_reason6	, '');

self.FP1610_1_0_score	:= if(model_environment in [1,3], left.FP1610_1_0_score	, '');
self.FP1610_1_0_reason1	:= if(model_environment in [1,3], left.FP1610_1_0_reason1	, '');
self.FP1610_1_0_reason2	:= if(model_environment in [1,3], left.FP1610_1_0_reason2	, '');
self.FP1610_1_0_reason3	:= if(model_environment in [1,3], left.FP1610_1_0_reason3	, '');
self.FP1610_1_0_reason4	:= if(model_environment in [1,3], left.FP1610_1_0_reason4	, '');
self.FP1610_1_0_reason5	:= if(model_environment in [1,3], left.FP1610_1_0_reason5	, '');
self.FP1610_1_0_reason6	:= if(model_environment in [1,3], left.FP1610_1_0_reason6	, '');

self.FP1610_2_0_score	:= if(model_environment in [1,3], left.FP1610_2_0_score	, '');
self.FP1610_2_0_reason1	:= if(model_environment in [1,3], left.FP1610_2_0_reason1	, '');
self.FP1610_2_0_reason2	:= if(model_environment in [1,3], left.FP1610_2_0_reason2	, '');
self.FP1610_2_0_reason3	:= if(model_environment in [1,3], left.FP1610_2_0_reason3	, '');
self.FP1610_2_0_reason4	:= if(model_environment in [1,3], left.FP1610_2_0_reason4	, '');
self.FP1610_2_0_reason5	:= if(model_environment in [1,3], left.FP1610_2_0_reason5	, '');
self.FP1610_2_0_reason6	:= if(model_environment in [1,3], left.FP1610_2_0_reason6	, '');

self.FP1609_1_0_score	:= if(model_environment in [1,3], left.FP1609_1_0_score	, '');
self.FP1609_1_0_reason1	:= if(model_environment in [1,3], left.FP1609_1_0_reason1	, '');
self.FP1609_1_0_reason2	:= if(model_environment in [1,3], left.FP1609_1_0_reason2	, '');
self.FP1609_1_0_reason3	:= if(model_environment in [1,3], left.FP1609_1_0_reason3	, '');
self.FP1609_1_0_reason4	:= if(model_environment in [1,3], left.FP1609_1_0_reason4	, '');
self.FP1609_1_0_reason5	:= if(model_environment in [1,3], left.FP1609_1_0_reason5	, '');
self.FP1609_1_0_reason6	:= if(model_environment in [1,3], left.FP1609_1_0_reason6	, '');

self.FP1702_2_0_score	:= if(model_environment in [1,3], left.FP1702_2_0_score	, '');
self.FP1702_2_0_reason1	:= if(model_environment in [1,3], left.FP1702_2_0_reason1	, '');
self.FP1702_2_0_reason2	:= if(model_environment in [1,3], left.FP1702_2_0_reason2	, '');
self.FP1702_2_0_reason3	:= if(model_environment in [1,3], left.FP1702_2_0_reason3	, '');
self.FP1702_2_0_reason4	:= if(model_environment in [1,3], left.FP1702_2_0_reason4	, '');
self.FP1702_2_0_reason5	:= if(model_environment in [1,3], left.FP1702_2_0_reason5	, '');
self.FP1702_2_0_reason6	:= if(model_environment in [1,3], left.FP1702_2_0_reason6	, '');

self.FP1702_1_0_score	:= if(model_environment in [1,3], left.FP1702_1_0_score	, '');
self.FP1702_1_0_reason1	:= if(model_environment in [1,3], left.FP1702_1_0_reason1	, '');
self.FP1702_1_0_reason2	:= if(model_environment in [1,3], left.FP1702_1_0_reason2	, '');
self.FP1702_1_0_reason3	:= if(model_environment in [1,3], left.FP1702_1_0_reason3	, '');
self.FP1702_1_0_reason4	:= if(model_environment in [1,3], left.FP1702_1_0_reason4	, '');
self.FP1702_1_0_reason5	:= if(model_environment in [1,3], left.FP1702_1_0_reason5	, '');
self.FP1702_1_0_reason6	:= if(model_environment in [1,3], left.FP1702_1_0_reason6	, '');

self.FP1706_1_0_score	:= if(model_environment in [1,3], left.FP1706_1_0_score	, '');
self.FP1706_1_0_reason1	:= if(model_environment in [1,3], left.FP1706_1_0_reason1	, '');
self.FP1706_1_0_reason2	:= if(model_environment in [1,3], left.FP1706_1_0_reason2	, '');
self.FP1706_1_0_reason3	:= if(model_environment in [1,3], left.FP1706_1_0_reason3	, '');
self.FP1706_1_0_reason4	:= if(model_environment in [1,3], left.FP1706_1_0_reason4	, '');
self.FP1706_1_0_reason5	:= if(model_environment in [1,3], left.FP1706_1_0_reason5	, '');
self.FP1706_1_0_reason6	:= if(model_environment in [1,3], left.FP1706_1_0_reason6	, '');

self.FP1705_1_0_score	:= if(model_environment in [1,3], left.FP1705_1_0_score	, '');
self.FP1705_1_0_reason1	:= if(model_environment in [1,3], left.FP1705_1_0_reason1	, '');
self.FP1705_1_0_reason2	:= if(model_environment in [1,3], left.FP1705_1_0_reason2	, '');
self.FP1705_1_0_reason3	:= if(model_environment in [1,3], left.FP1705_1_0_reason3	, '');
self.FP1705_1_0_reason4	:= if(model_environment in [1,3], left.FP1705_1_0_reason4	, '');
self.FP1705_1_0_reason5	:= if(model_environment in [1,3], left.FP1705_1_0_reason5	, '');
self.FP1705_1_0_reason6	:= if(model_environment in [1,3], left.FP1705_1_0_reason6	, '');


self.FP1710_1_0_score	:= if(model_environment in [1,3], left.FP1710_1_0_score	, '');
self.FP1710_1_0_reason1	:= if(model_environment in [1,3], left.FP1710_1_0_reason1	, '');
self.FP1710_1_0_reason2	:= if(model_environment in [1,3], left.FP1710_1_0_reason2	, '');
self.FP1710_1_0_reason3	:= if(model_environment in [1,3], left.FP1710_1_0_reason3	, '');
self.FP1710_1_0_reason4	:= if(model_environment in [1,3], left.FP1710_1_0_reason4	, '');
self.FP1710_1_0_reason5	:= if(model_environment in [1,3], left.FP1710_1_0_reason5	, '');
self.FP1710_1_0_reason6	:= if(model_environment in [1,3], left.FP1710_1_0_reason6	, '');

self.FP1806_1_0_score	:= if(model_environment in [1,3], left.FP1806_1_0_score	, '');
self.FP1806_1_0_reason1	:= if(model_environment in [1,3], left.FP1806_1_0_reason1	, '');
self.FP1806_1_0_reason2	:= if(model_environment in [1,3], left.FP1806_1_0_reason2	, '');
self.FP1806_1_0_reason3	:= if(model_environment in [1,3], left.FP1806_1_0_reason3	, '');
self.FP1806_1_0_reason4	:= if(model_environment in [1,3], left.FP1806_1_0_reason4	, '');
self.FP1806_1_0_reason5	:= if(model_environment in [1,3], left.FP1806_1_0_reason5	, '');
self.FP1806_1_0_reason6	:= if(model_environment in [1,3], left.FP1806_1_0_reason6	, '');

self.FP1803_1_0_score	:= if(model_environment in [1,3], left.FP1803_1_0_score	, '');
self.FP1803_1_0_reason1	:= if(model_environment in [1,3], left.FP1803_1_0_reason1	, '');
self.FP1803_1_0_reason2	:= if(model_environment in [1,3], left.FP1803_1_0_reason2	, '');
self.FP1803_1_0_reason3	:= if(model_environment in [1,3], left.FP1803_1_0_reason3	, '');
self.FP1803_1_0_reason4	:= if(model_environment in [1,3], left.FP1803_1_0_reason4	, '');
self.FP1803_1_0_reason5	:= if(model_environment in [1,3], left.FP1803_1_0_reason5	, '');
self.FP1803_1_0_reason6	:= if(model_environment in [1,3], left.FP1803_1_0_reason6	, '');


self.FP1802_1_0_score	:= if(model_environment in [1,3], left.FP1802_1_0_score	, '');
self.FP1802_1_0_reason1	:= if(model_environment in [1,3], left.FP1802_1_0_reason1	, '');
self.FP1802_1_0_reason2	:= if(model_environment in [1,3], left.FP1802_1_0_reason2	, '');
self.FP1802_1_0_reason3	:= if(model_environment in [1,3], left.FP1802_1_0_reason3	, '');
self.FP1802_1_0_reason4	:= if(model_environment in [1,3], left.FP1802_1_0_reason4	, '');
self.FP1802_1_0_reason5	:= if(model_environment in [1,3], left.FP1802_1_0_reason5	, '');
self.FP1802_1_0_reason6	:= if(model_environment in [1,3], left.FP1802_1_0_reason6	, '');

self.FP1801_1_0_score	:= if(model_environment in [1,3], left.FP1801_1_0_score	, '');
self.FP1801_1_0_reason1	:= if(model_environment in [1,3], left.FP1801_1_0_reason1	, '');
self.FP1801_1_0_reason2	:= if(model_environment in [1,3], left.FP1801_1_0_reason2	, '');
self.FP1801_1_0_reason3	:= if(model_environment in [1,3], left.FP1801_1_0_reason3	, '');
self.FP1801_1_0_reason4	:= if(model_environment in [1,3], left.FP1801_1_0_reason4	, '');
self.FP1801_1_0_reason5	:= if(model_environment in [1,3], left.FP1801_1_0_reason5	, '');
self.FP1801_1_0_reason6	:= if(model_environment in [1,3], left.FP1801_1_0_reason6	, '');



self.FP1609_2_0_score	:= if(model_environment in [1,3], left.FP1609_2_0_score	, '');
self.FP1609_2_0_reason1	:= if(model_environment in [1,3], left.FP1609_2_0_reason1	, '');
self.FP1609_2_0_reason2	:= if(model_environment in [1,3], left.FP1609_2_0_reason2	, '');
self.FP1609_2_0_reason3	:= if(model_environment in [1,3], left.FP1609_2_0_reason3	, '');
self.FP1609_2_0_reason4	:= if(model_environment in [1,3], left.FP1609_2_0_reason4	, '');
self.FP1609_2_0_reason5	:= if(model_environment in [1,3], left.FP1609_2_0_reason5	, '');
self.FP1609_2_0_reason6	:= if(model_environment in [1,3], left.FP1609_2_0_reason6	, '');

self.FP1508_1_0_score	:= if(model_environment in [1,3], left.FP1508_1_0_score	, '');
self.FP1508_1_0_reason1	:= if(model_environment in [1,3], left.FP1508_1_0_reason1	, '');
self.FP1508_1_0_reason2	:= if(model_environment in [1,3], left.FP1508_1_0_reason2	, '');
self.FP1508_1_0_reason3	:= if(model_environment in [1,3], left.FP1508_1_0_reason3	, '');
self.FP1508_1_0_reason4	:= if(model_environment in [1,3], left.FP1508_1_0_reason4	, '');
self.FP1508_1_0_reason5	:= if(model_environment in [1,3], left.FP1508_1_0_reason5	, '');
self.FP1508_1_0_reason6	:= if(model_environment in [1,3], left.FP1508_1_0_reason6	, '');

self.FP1607_1_0_score	:= if(model_environment in [1,3], left.FP1607_1_0_score	, '');
self.FP1607_1_0_reason1	:= if(model_environment in [1,3], left.FP1607_1_0_reason1	, '');
self.FP1607_1_0_reason2	:= if(model_environment in [1,3], left.FP1607_1_0_reason2	, '');
self.FP1607_1_0_reason3	:= if(model_environment in [1,3], left.FP1607_1_0_reason3	, '');
self.FP1607_1_0_reason4	:= if(model_environment in [1,3], left.FP1607_1_0_reason4	, '');
self.FP1607_1_0_reason5	:= if(model_environment in [1,3], left.FP1607_1_0_reason5	, '');
self.FP1607_1_0_reason6	:= if(model_environment in [1,3], left.FP1607_1_0_reason6	, '');

self.FP1606_1_0_score	:= if(model_environment in [1,3], left.FP1606_1_0_score	, '');
self.FP1606_1_0_reason1	:= if(model_environment in [1,3], left.FP1606_1_0_reason1	, '');
self.FP1606_1_0_reason2	:= if(model_environment in [1,3], left.FP1606_1_0_reason2	, '');
self.FP1606_1_0_reason3	:= if(model_environment in [1,3], left.FP1606_1_0_reason3	, '');
self.FP1606_1_0_reason4	:= if(model_environment in [1,3], left.FP1606_1_0_reason4	, '');
self.FP1606_1_0_reason5	:= if(model_environment in [1,3], left.FP1606_1_0_reason5	, '');
self.FP1606_1_0_reason6	:= if(model_environment in [1,3], left.FP1606_1_0_reason6	, '');

self.FP1712_0_0_score	:= if(model_environment in [1,3], left.FP1712_0_0_score	, '');
self.FP1712_0_0_reason1	:= if(model_environment in [1,3], left.FP1712_0_0_reason1	, '');

self.FP1406_1_0_score	:= if(model_environment in [1,3], left.FP1406_1_0_score	, '');
self.FP1406_1_0_reason1	:= if(model_environment in [1,3], left.FP1406_1_0_reason1	, '');
self.FP1406_1_0_reason2	:= if(model_environment in [1,3], left.FP1406_1_0_reason2	, '');
self.FP1406_1_0_reason3	:= if(model_environment in [1,3], left.FP1406_1_0_reason3	, '');
self.FP1406_1_0_reason4	:= if(model_environment in [1,3], left.FP1406_1_0_reason4	, '');
self.FP1406_1_0_reason5	:= if(model_environment in [1,3], left.FP1406_1_0_reason5	, '');
self.FP1406_1_0_reason6	:= if(model_environment in [1,3], left.FP1406_1_0_reason6	, '');

self.FP1307_1_0_score	:= if(model_environment in [1,3], left.FP1307_1_0_score	, '');
self.FP1307_1_0_reason1	:= if(model_environment in [1,3], left.FP1307_1_0_reason1	, '');
self.FP1307_1_0_reason2	:= if(model_environment in [1,3], left.FP1307_1_0_reason2	, '');
self.FP1307_1_0_reason3	:= if(model_environment in [1,3], left.FP1307_1_0_reason3	, '');
self.FP1307_1_0_reason4	:= if(model_environment in [1,3], left.FP1307_1_0_reason4	, '');
self.FP1307_1_0_reason5	:= if(model_environment in [1,3], left.FP1307_1_0_reason5	, '');
self.FP1307_1_0_reason6	:= if(model_environment in [1,3], left.FP1307_1_0_reason6	, '');

self.FP1403_1_0_score   := if(model_environment in [1,3], left.FP1403_1_0_score	, '');

self.FP1409_2_0_score   := if(model_environment in [1,3], left.FP1409_2_0_score	, '');

self.FP1403_2_0_score	:= if(model_environment in [1,3], left.FP1403_2_0_score	, '');
self.FP1403_2_0_reason1	:= if(model_environment in [1,3], left.FP1403_2_0_reason1	, '');
self.FP1403_2_0_reason2	:= if(model_environment in [1,3], left.FP1403_2_0_reason2	, '');
self.FP1403_2_0_reason3	:= if(model_environment in [1,3], left.FP1403_2_0_reason3	, '');
self.FP1403_2_0_reason4	:= if(model_environment in [1,3], left.FP1403_2_0_reason4	, '');
self.FP1403_2_0_reason5	:= if(model_environment in [1,3], left.FP1403_2_0_reason5	, '');
self.FP1403_2_0_reason6	:= if(model_environment in [1,3], left.FP1403_2_0_reason6	, '');

self.FP1506_1_0_score	:= if(model_environment in [1,3], left.FP1506_1_0_score	, '');
self.FP1506_1_0_reason1	:= if(model_environment in [1,3], left.FP1506_1_0_reason1	, '');
self.FP1506_1_0_reason2	:= if(model_environment in [1,3], left.FP1506_1_0_reason2	, '');
self.FP1506_1_0_reason3	:= if(model_environment in [1,3], left.FP1506_1_0_reason3	, '');
self.FP1506_1_0_reason4	:= if(model_environment in [1,3], left.FP1506_1_0_reason4	, '');
self.FP1506_1_0_reason5	:= if(model_environment in [1,3], left.FP1506_1_0_reason5	, '');
self.FP1506_1_0_reason6	:= if(model_environment in [1,3], left.FP1506_1_0_reason6	, '');

self.FP1509_1_0_score	:= if(model_environment in [1,3], left.FP1509_1_0_score	, '');
self.FP1509_1_0_reason1	:= if(model_environment in [1,3], left.FP1509_1_0_reason1	, '');
self.FP1509_1_0_reason2	:= if(model_environment in [1,3], left.FP1509_1_0_reason2	, '');
self.FP1509_1_0_reason3	:= if(model_environment in [1,3], left.FP1509_1_0_reason3	, '');
self.FP1509_1_0_reason4	:= if(model_environment in [1,3], left.FP1509_1_0_reason4	, '');
self.FP1509_1_0_reason5	:= if(model_environment in [1,3], left.FP1509_1_0_reason5	, '');
self.FP1509_1_0_reason6	:= if(model_environment in [1,3], left.FP1509_1_0_reason6	, '');

self.FP1509_2_0_score	:= if(model_environment in [1,3], left.FP1509_2_0_score	, '');
self.FP1509_2_0_reason1	:= if(model_environment in [1,3], left.FP1509_2_0_reason1	, '');
self.FP1509_2_0_reason2	:= if(model_environment in [1,3], left.FP1509_2_0_reason2	, '');
self.FP1509_2_0_reason3	:= if(model_environment in [1,3], left.FP1509_2_0_reason3	, '');
self.FP1509_2_0_reason4	:= if(model_environment in [1,3], left.FP1509_2_0_reason4	, '');
self.FP1509_2_0_reason5	:= if(model_environment in [1,3], left.FP1509_2_0_reason5	, '');
self.FP1509_2_0_reason6	:= if(model_environment in [1,3], left.FP1509_2_0_reason6	, '');

self.FP1510_2_0_score	:= if(model_environment in [1,3], left.FP1510_2_0_score	, '');
self.FP1510_2_0_reason1	:= if(model_environment in [1,3], left.FP1510_2_0_reason1	, '');
self.FP1510_2_0_reason2	:= if(model_environment in [1,3], left.FP1510_2_0_reason2	, '');
self.FP1510_2_0_reason3	:= if(model_environment in [1,3], left.FP1510_2_0_reason3	, '');
self.FP1510_2_0_reason4	:= if(model_environment in [1,3], left.FP1510_2_0_reason4	, '');
self.FP1510_2_0_reason5	:= if(model_environment in [1,3], left.FP1510_2_0_reason5	, '');
self.FP1510_2_0_reason6	:= if(model_environment in [1,3], left.FP1510_2_0_reason6	, '');

//=== Money Lion custom model ===
self.fp1511_1_0_score	:= if(model_environment in [1,3], left.fp1511_1_0_score	, '');
self.fp1511_1_0_reason1	:= if(model_environment in [1,3], left.fp1511_1_0_reason1	, '');
self.fp1511_1_0_reason2	:= if(model_environment in [1,3], left.fp1511_1_0_reason2	, '');
self.fp1511_1_0_reason3	:= if(model_environment in [1,3], left.fp1511_1_0_reason3	, '');
self.fp1511_1_0_reason4	:= if(model_environment in [1,3], left.fp1511_1_0_reason4	, '');
self.fp1511_1_0_reason5	:= if(model_environment in [1,3], left.fp1511_1_0_reason5	, '');
self.fp1511_1_0_reason6	:= if(model_environment in [1,3], left.fp1511_1_0_reason6	, '');

//=== WestLake custom model ===
self.fp1512_1_0_score	:= if(model_environment in [1,3],   left.fp1512_1_0_score	, '');
self.fp1512_1_0_reason1	:= if(model_environment in [1,3], left.fp1512_1_0_reason1	, '');
self.fp1512_1_0_reason2	:= if(model_environment in [1,3], left.fp1512_1_0_reason2	, '');
self.fp1512_1_0_reason3	:= if(model_environment in [1,3], left.fp1512_1_0_reason3	, '');
self.fp1512_1_0_reason4	:= if(model_environment in [1,3], left.fp1512_1_0_reason4	, '');
self.fp1512_1_0_reason5	:= if(model_environment in [1,3], left.fp1512_1_0_reason5	, '');
self.fp1512_1_0_reason6	:= if(model_environment in [1,3], left.fp1512_1_0_reason6	, '');

//=== Avenger model ===
self.fp31604_0_0_score	:= if(model_environment in [1,3],   left.fp31604_0_0_score	, '');
self.fp31604_0_0_reason1	:= if(model_environment in [1,3], left.fp31604_0_0_reason1	, '');
self.fp31604_0_0_reason2	:= if(model_environment in [1,3], left.fp31604_0_0_reason2	, '');
self.fp31604_0_0_reason3	:= if(model_environment in [1,3], left.fp31604_0_0_reason3	, '');
self.fp31604_0_0_reason4	:= if(model_environment in [1,3], left.fp31604_0_0_reason4	, '');
self.fp31604_0_0_reason5	:= if(model_environment in [1,3], left.fp31604_0_0_reason5	, '');
self.fp31604_0_0_reason6	:= if(model_environment in [1,3], left.fp31604_0_0_reason6	, '');

self.FP31105_1_0_score	:= if(model_environment in [1,3], left.FP31105_1_0_score	, '');
self.FP31105_1_0_reason1	:= if(model_environment in [1,3], left.FP31105_1_0_reason1	, '');
self.FP31105_1_0_reason2	:= if(model_environment in [1,3], left.FP31105_1_0_reason2	, '');
self.FP31105_1_0_reason3	:= if(model_environment in [1,3], left.FP31105_1_0_reason3	, '');
self.FP31105_1_0_reason4	:= if(model_environment in [1,3], left.FP31105_1_0_reason4	, '');

self.FP31203_1_0_score	:= if(model_environment in [1,3], left.FP31203_1_0_score	, '');
self.FP31203_1_0_reason1	:= if(model_environment in [1,3], left.FP31203_1_0_reason1	, '');
self.FP31203_1_0_reason2	:= if(model_environment in [1,3], left.FP31203_1_0_reason2	, '');
self.FP31203_1_0_reason3	:= if(model_environment in [1,3], left.FP31203_1_0_reason3	, '');
self.FP31203_1_0_reason4	:= if(model_environment in [1,3], left.FP31203_1_0_reason4	, '');
 
self.FP31310_2_0_score	:= if(model_environment in [1,3], left.FP31310_2_0_score	, '');
self.FP31310_2_0_reason1	:= if(model_environment in [1,3], left.FP31310_2_0_reason1	, '');
self.FP31310_2_0_reason2	:= if(model_environment in [1,3], left.FP31310_2_0_reason2	, '');
self.FP31310_2_0_reason3	:= if(model_environment in [1,3], left.FP31310_2_0_reason3	, '');
self.FP31310_2_0_reason4	:= if(model_environment in [1,3], left.FP31310_2_0_reason4	, '');
self.FP31310_2_0_reason5	:= if(model_environment in [1,3], left.FP31310_2_0_reason5	, '');
self.FP31310_2_0_reason6	:= if(model_environment in [1,3], left.FP31310_2_0_reason6	, '');

self.FP31505_0_0_score	:= if(model_environment in [1,3], left.FP31505_0_0_score	, '');
self.FP31505_0_0_reason1	:= if(model_environment in [1,3], left.FP31505_0_0_reason1	, '');
self.FP31505_0_0_reason2	:= if(model_environment in [1,3], left.FP31505_0_0_reason2	, '');
self.FP31505_0_0_reason3	:= if(model_environment in [1,3], left.FP31505_0_0_reason3	, '');
self.FP31505_0_0_reason4	:= if(model_environment in [1,3], left.FP31505_0_0_reason4	, '');
self.FP31505_0_0_reason5	:= if(model_environment in [1,3], left.FP31505_0_0_reason5	, '');
self.FP31505_0_0_reason6	:= if(model_environment in [1,3], left.FP31505_0_0_reason6	, '');
     
self.FP3FDN1505_0_0_score	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_score	, '');
self.FP3FDN1505_0_0_reason1	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason1	, '');
self.FP3FDN1505_0_0_reason2	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason2	, '');
self.FP3FDN1505_0_0_reason3	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason3	, '');
self.FP3FDN1505_0_0_reason4	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason4	, '');
self.FP3FDN1505_0_0_reason5	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason5	, '');
self.FP3FDN1505_0_0_reason6	:= if(model_environment in [1,3], left.FP3FDN1505_0_0_reason6	, '');

self.FP3710_0_0_score	:= if(model_environment in [1,3], left.FP3710_0_0_score	, '');
self.FP3710_0_0_reason1	:= if(model_environment in [1,3], left.FP3710_0_0_reason1	, '');
self.FP3710_0_0_reason2	:= if(model_environment in [1,3], left.FP3710_0_0_reason2	, '');
self.FP3710_0_0_reason3	:= if(model_environment in [1,3], left.FP3710_0_0_reason3	, '');
self.FP3710_0_0_reason4	:= if(model_environment in [1,3], left.FP3710_0_0_reason4	, '');


self.FP3904_1_0_score	:= if(model_environment in [1,3], left.FP3904_1_0_score	, '');
self.FP3904_1_0_reason1	:= if(model_environment in [1,3], left.FP3904_1_0_reason1	, '');
self.FP3904_1_0_reason2	:= if(model_environment in [1,3], left.FP3904_1_0_reason2	, '');
self.FP3904_1_0_reason3	:= if(model_environment in [1,3], left.FP3904_1_0_reason3	, '');
self.FP3904_1_0_reason4	:= if(model_environment in [1,3], left.FP3904_1_0_reason4	, '');


self.FP3905_1_0_score	:= if(model_environment in [1,3], left.FP3905_1_0_score	, '');
self.FP3905_1_0_reason1	:= if(model_environment in [1,3], left.FP3905_1_0_reason1	, '');
self.FP3905_1_0_reason2	:= if(model_environment in [1,3], left.FP3905_1_0_reason2	, '');
self.FP3905_1_0_reason3	:= if(model_environment in [1,3], left.FP3905_1_0_reason3	, '');
self.FP3905_1_0_reason4	:= if(model_environment in [1,3], left.FP3905_1_0_reason4	, '');


self.FP5812_1_0_score	:= if(model_environment in [1,3], left.FP5812_1_0_score	, '');
self.FP5812_1_0_reason1	:= if(model_environment in [1,3], left.FP5812_1_0_reason1	, '');
self.FP5812_1_0_reason2	:= if(model_environment in [1,3], left.FP5812_1_0_reason2	, '');
self.FP5812_1_0_reason3	:= if(model_environment in [1,3], left.FP5812_1_0_reason3	, '');
self.FP5812_1_0_reason4	:= if(model_environment in [1,3], left.FP5812_1_0_reason4	, '');

self.HCP1206_0_0_score	:= if(model_environment in [1,3], left.HCP1206_0_0_score	, '');
self.HCP1206_0_0_reason1	:= if(model_environment in [1,3], left.HCP1206_0_0_reason1	, '');
self.HCP1206_0_0_reason2	:= if(model_environment in [1,3], left.HCP1206_0_0_reason2	, '');
self.HCP1206_0_0_reason3	:= if(model_environment in [1,3], left.HCP1206_0_0_reason3	, '');
self.HCP1206_0_0_reason4	:= if(model_environment in [1,3], left.HCP1206_0_0_reason4	, '');

self.IDN605_1_0_score	:= if(model_environment in [1,3], left.IDN605_1_0_score	, '');
self.IDN605_1_0_reason1	:= if(model_environment in [1,3], left.IDN605_1_0_reason1	, '');
self.IDN605_1_0_reason2	:= if(model_environment in [1,3], left.IDN605_1_0_reason2	, '');
self.IDN605_1_0_reason3	:= if(model_environment in [1,3], left.IDN605_1_0_reason3	, '');
self.IDN605_1_0_reason4	:= if(model_environment in [1,3], left.IDN605_1_0_reason4	, '');

self.IED1106_1_0_score	:= if(model_environment in [1,2], left.IED1106_1_0_score	, '');

self.IEN1006_0_1_score	:= if(model_environment in [1,3], left.IEN1006_0_1_score	, 0);

self.MNC21106_0_0_score	:= if(model_environment in [1,2], left.MNC21106_0_0_score	, 0);

self.MPX1211_0_0_score	:= if(model_environment in [1,2], left.MPX1211_0_0_score	, 0);

self.MSD1010_0_0_score	:= if(model_environment in [1,2], left.MSD1010_0_0_score	, 0);

self.MSN1106_0_0_score	:= if(model_environment in [1,3], left.MSN1106_0_0_score	, '');
self.MSN1106_0_0_reason1	:= if(model_environment in [1,3], left.MSN1106_0_0_reason1	, '');
self.MSN1106_0_0_reason2	:= if(model_environment in [1,3], left.MSN1106_0_0_reason2	, '');
self.MSN1106_0_0_reason3	:= if(model_environment in [1,3], left.MSN1106_0_0_reason3	, '');
self.MSN1106_0_0_reason4	:= if(model_environment in [1,3], left.MSN1106_0_0_reason4	, '');

self.MSN605_1_0_score	:= if(model_environment in [1,3], left.MSN605_1_0_score	, '');

self.MSN610_0_0_score	:= if(model_environment in [1,3], left.MSN610_0_0_score	, '');

self.MSN1803_1_0_score	:= if(model_environment in [1,3], left.MSN1803_1_0_score	, '');

self.MV361006_0_0_score	:= if(model_environment in [1,2], left.MV361006_0_0_score	, 0);

self.MV361006_1_0_score	:= if(model_environment in [1,2], left.MV361006_1_0_score	, 0);

self.MX361006_0_0_score	:= if(model_environment in [1,2], left.MX361006_0_0_score	, 0);

self.MX361006_1_0_score	:= if(model_environment in [1,2], left.MX361006_1_0_score	, 0);

self.RSB801_1_0_score	:= if(model_environment in [1,3], left.RSB801_1_0_score	, '');

self.RSN1001_1_0_score	:= if(model_environment in [1,3], left.RSN1001_1_0_score	, '');

self.RSN1009_1_0_score	:= if(model_environment in [1,3], left.RSN1009_1_0_score	, '');

self.RSN1010_1_0_score	:= if(model_environment in [1,3], left.RSN1010_1_0_score	, '');

self.RSN1103_1_0_score	:= if(model_environment in [1,3], left.RSN1103_1_0_score	, '');

self.RSN1105_1_0_score	:= if(model_environment in [1,3], left.RSN1105_1_0_score	, '');

self.RSN1105_2_0_score	:= if(model_environment in [1,3], left.RSN1105_2_0_score	, '');

self.RSN1105_3_0_score	:= if(model_environment in [1,3], left.RSN1105_3_0_score	, '');

self.RSN1108_1_0_score	:= if(model_environment in [1,3], left.RSN1108_1_0_score	, '');

self.RSN1108_2_0_score	:= if(model_environment in [1,3], left.RSN1108_2_0_score	, '');

self.RSN1108_3_0_score	:= if(model_environment in [1,3], left.RSN1108_3_0_score	, '');

self.RSN508_1_0_score	:= if(model_environment in [1,3], left.RSN508_1_0_score	, '');

self.RSN509_1_0_score	:= if(model_environment in [1,3], left.RSN509_1_0_score	, '');

self.RSN509_2_0_score	:= if(model_environment in [1,3], left.RSN509_2_0_score	, '');

self.RSN604_2_0_score	:= if(model_environment in [1,3], left.RSN604_2_0_score	, '');

self.RSN607_0_0_score	:= if(model_environment in [1,3], left.RSN607_0_0_score	, '');

self.RSN607_1_0_score	:= if(model_environment in [1,3], left.RSN607_1_0_score	, '');

self.RSN702_1_0_score	:= if(model_environment in [1,3], left.RSN702_1_0_score	, '');

self.RSN704_0_0_score	:= if(model_environment in [1,3], left.RSN704_0_0_score	, '');

self.RSN704_1_0_score	:= if(model_environment in [1,3], left.RSN704_1_0_score	, '');

self.RSN802_1_0_score	:= if(model_environment in [1,3], left.RSN802_1_0_score	, '');

self.RSN803_1_0_score	:= if(model_environment in [1,3], left.RSN803_1_0_score	, '');

self.RSN803_2_0_score	:= if(model_environment in [1,3], left.RSN803_2_0_score	, '');

self.RSN804_1_0_score	:= if(model_environment in [1,3], left.RSN804_1_0_score	, '');

self.RSN807_0_0_score	:= if(model_environment in [1,3], left.RSN807_0_0_score	, '');

self.RSN810_1_0_score	:= if(model_environment in [1,3], left.RSN810_1_0_score	, '');

self.RSN912_1_0_score	:= if(model_environment in [1,3], left.RSN912_1_0_score	, '');

self.RVA1003_0_0_score	:= if(model_environment in [1,2], left.RVA1003_0_0_score	, '');
self.RVA1003_0_0_reason1	:= if(model_environment in [1,2], left.RVA1003_0_0_reason1	, '');
self.RVA1003_0_0_reason2	:= if(model_environment in [1,2], left.RVA1003_0_0_reason2	, '');
self.RVA1003_0_0_reason3	:= if(model_environment in [1,2], left.RVA1003_0_0_reason3	, '');
self.RVA1003_0_0_reason4	:= if(model_environment in [1,2], left.RVA1003_0_0_reason4	, '');

self.RVA1007_1_0_score	:= if(model_environment in [1,2], left.RVA1007_1_0_score	, '');
self.RVA1007_1_0_reason1	:= if(model_environment in [1,2], left.RVA1007_1_0_reason1	, '');
self.RVA1007_1_0_reason2	:= if(model_environment in [1,2], left.RVA1007_1_0_reason2	, '');
self.RVA1007_1_0_reason3	:= if(model_environment in [1,2], left.RVA1007_1_0_reason3	, '');
self.RVA1007_1_0_reason4	:= if(model_environment in [1,2], left.RVA1007_1_0_reason4	, '');


self.RVA1007_2_0_score	:= if(model_environment in [1,2], left.RVA1007_2_0_score	, '');
self.RVA1007_2_0_reason1	:= if(model_environment in [1,2], left.RVA1007_2_0_reason1	, '');
self.RVA1007_2_0_reason2	:= if(model_environment in [1,2], left.RVA1007_2_0_reason2	, '');
self.RVA1007_2_0_reason3	:= if(model_environment in [1,2], left.RVA1007_2_0_reason3	, '');
self.RVA1007_2_0_reason4	:= if(model_environment in [1,2], left.RVA1007_2_0_reason4	, '');


self.RVA1007_3_0_score	:= if(model_environment in [1,2], left.RVA1007_3_0_score	, '');
self.RVA1007_3_0_reason1	:= if(model_environment in [1,2], left.RVA1007_3_0_reason1	, '');
self.RVA1007_3_0_reason2	:= if(model_environment in [1,2], left.RVA1007_3_0_reason2	, '');
self.RVA1007_3_0_reason3	:= if(model_environment in [1,2], left.RVA1007_3_0_reason3	, '');
self.RVA1007_3_0_reason4	:= if(model_environment in [1,2], left.RVA1007_3_0_reason4	, '');


self.RVA1008_1_0_score	:= if(model_environment in [1,2], left.RVA1008_1_0_score	, '');
self.RVA1008_1_0_reason1	:= if(model_environment in [1,2], left.RVA1008_1_0_reason1	, '');
self.RVA1008_1_0_reason2	:= if(model_environment in [1,2], left.RVA1008_1_0_reason2	, '');
self.RVA1008_1_0_reason3	:= if(model_environment in [1,2], left.RVA1008_1_0_reason3	, '');
self.RVA1008_1_0_reason4	:= if(model_environment in [1,2], left.RVA1008_1_0_reason4	, '');


self.RVA1008_2_0_score	:= if(model_environment in [1,2], left.RVA1008_2_0_score	, '');
self.RVA1008_2_0_reason1	:= if(model_environment in [1,2], left.RVA1008_2_0_reason1	, '');
self.RVA1008_2_0_reason2	:= if(model_environment in [1,2], left.RVA1008_2_0_reason2	, '');
self.RVA1008_2_0_reason3	:= if(model_environment in [1,2], left.RVA1008_2_0_reason3	, '');
self.RVA1008_2_0_reason4	:= if(model_environment in [1,2], left.RVA1008_2_0_reason4	, '');

self.RVA1104_0_0_score	:= if(model_environment in [1,2], left.RVA1104_0_0_score	, '');
self.RVA1104_0_0_reason1	:= if(model_environment in [1,2], left.RVA1104_0_0_reason1	, '');
self.RVA1104_0_0_reason2	:= if(model_environment in [1,2], left.RVA1104_0_0_reason2	, '');
self.RVA1104_0_0_reason3	:= if(model_environment in [1,2], left.RVA1104_0_0_reason3	, '');
self.RVA1104_0_0_reason4	:= if(model_environment in [1,2], left.RVA1104_0_0_reason4	, '');

self.RVA1304_1_0_score	:= if(model_environment in [1,2], left.RVA1304_1_0_score	, '');
self.RVA1304_1_0_reason1	:= if(model_environment in [1,2], left.RVA1304_1_0_reason1	, '');
self.RVA1304_1_0_reason2	:= if(model_environment in [1,2], left.RVA1304_1_0_reason2	, '');
self.RVA1304_1_0_reason3	:= if(model_environment in [1,2], left.RVA1304_1_0_reason3	, '');
self.RVA1304_1_0_reason4	:= if(model_environment in [1,2], left.RVA1304_1_0_reason4	, '');

self.RVA1304_2_0_score	:= if(model_environment in [1,2], left.RVA1304_2_0_score	, '');
self.RVA1304_2_0_reason1	:= if(model_environment in [1,2], left.RVA1304_2_0_reason1	, '');
self.RVA1304_2_0_reason2	:= if(model_environment in [1,2], left.RVA1304_2_0_reason2	, '');
self.RVA1304_2_0_reason3	:= if(model_environment in [1,2], left.RVA1304_2_0_reason3	, '');
self.RVA1304_2_0_reason4	:= if(model_environment in [1,2], left.RVA1304_2_0_reason4	, '');

self.RVA1305_1_0_score	:= if(model_environment in [1,2], left.RVA1305_1_0_score	, '');
self.RVA1305_1_0_reason1	:= if(model_environment in [1,2], left.RVA1305_1_0_reason1	, '');
self.RVA1305_1_0_reason2	:= if(model_environment in [1,2], left.RVA1305_1_0_reason2	, '');
self.RVA1305_1_0_reason3	:= if(model_environment in [1,2], left.RVA1305_1_0_reason3	, '');
self.RVA1305_1_0_reason4	:= if(model_environment in [1,2], left.RVA1305_1_0_reason4	, '');

self.RVA1306_1_0_score	:= if(model_environment in [1,2], left.RVA1306_1_0_score	, '');
self.RVA1306_1_0_reason1	:= if(model_environment in [1,2], left.RVA1306_1_0_reason1	, '');
self.RVA1306_1_0_reason2	:= if(model_environment in [1,2], left.RVA1306_1_0_reason2	, '');
self.RVA1306_1_0_reason3	:= if(model_environment in [1,2], left.RVA1306_1_0_reason3	, '');
self.RVA1306_1_0_reason4	:= if(model_environment in [1,2], left.RVA1306_1_0_reason4	, '');

self.RVA1309_1_0_score	:= if(model_environment in [1,2], left.RVA1309_1_0_score	, '');
self.RVA1309_1_0_reason1	:= if(model_environment in [1,2], left.RVA1309_1_0_reason1	, '');
self.RVA1309_1_0_reason2	:= if(model_environment in [1,2], left.RVA1309_1_0_reason2	, '');
self.RVA1309_1_0_reason3	:= if(model_environment in [1,2], left.RVA1309_1_0_reason3	, '');
self.RVA1309_1_0_reason4	:= if(model_environment in [1,2], left.RVA1309_1_0_reason4	, '');

self.RVA1310_1_0_score	  := if(model_environment in [1,2], left.RVA1310_1_0_score	  , '');
self.RVA1310_1_0_reason1	:= if(model_environment in [1,2], left.RVA1310_1_0_reason1	, '');
self.RVA1310_1_0_reason2	:= if(model_environment in [1,2], left.RVA1310_1_0_reason2	, '');
self.RVA1310_1_0_reason3	:= if(model_environment in [1,2], left.RVA1310_1_0_reason3	, '');
self.RVA1310_1_0_reason4	:= if(model_environment in [1,2], left.RVA1310_1_0_reason4	, '');

self.RVA1310_2_0_score	  := if(model_environment in [1,2], left.RVA1310_2_0_score	  , '');
self.RVA1310_2_0_reason1	:= if(model_environment in [1,2], left.RVA1310_2_0_reason1	, '');
self.RVA1310_2_0_reason2	:= if(model_environment in [1,2], left.RVA1310_2_0_reason2	, '');
self.RVA1310_2_0_reason3	:= if(model_environment in [1,2], left.RVA1310_2_0_reason3	, '');
self.RVA1310_2_0_reason4	:= if(model_environment in [1,2], left.RVA1310_2_0_reason4	, '');

self.RVA1310_3_0_score	  := if(model_environment in [1,2], left.RVA1310_3_0_score	  , '');
self.RVA1310_3_0_reason1	:= if(model_environment in [1,2], left.RVA1310_3_0_reason1	, '');
self.RVA1310_3_0_reason2	:= if(model_environment in [1,2], left.RVA1310_3_0_reason2	, '');
self.RVA1310_3_0_reason3	:= if(model_environment in [1,2], left.RVA1310_3_0_reason3	, '');
self.RVA1310_3_0_reason4	:= if(model_environment in [1,2], left.RVA1310_3_0_reason4	, '');

self.RVA1311_1_0_score	  := if(model_environment in [1,2], left.RVA1311_1_0_score	  , '');
self.RVA1311_1_0_reason1	:= if(model_environment in [1,2], left.RVA1311_1_0_reason1	, '');
self.RVA1311_1_0_reason2	:= if(model_environment in [1,2], left.RVA1311_1_0_reason2	, '');
self.RVA1311_1_0_reason3	:= if(model_environment in [1,2], left.RVA1311_1_0_reason3	, '');
self.RVA1311_1_0_reason4	:= if(model_environment in [1,2], left.RVA1311_1_0_reason4	, '');

self.RVA1311_2_0_score	  := if(model_environment in [1,2], left.RVA1311_2_0_score	  , '');
self.RVA1311_2_0_reason1	:= if(model_environment in [1,2], left.RVA1311_2_0_reason1	, '');
self.RVA1311_2_0_reason2	:= if(model_environment in [1,2], left.RVA1311_2_0_reason2	, '');
self.RVA1311_2_0_reason3	:= if(model_environment in [1,2], left.RVA1311_2_0_reason3	, '');
self.RVA1311_2_0_reason4	:= if(model_environment in [1,2], left.RVA1311_2_0_reason4	, '');

self.RVA1311_3_0_score	  := if(model_environment in [1,2], left.RVA1311_3_0_score	  , '');
self.RVA1311_3_0_reason1	:= if(model_environment in [1,2], left.RVA1311_3_0_reason1	, '');
self.RVA1311_3_0_reason2	:= if(model_environment in [1,2], left.RVA1311_3_0_reason2	, '');
self.RVA1311_3_0_reason3	:= if(model_environment in [1,2], left.RVA1311_3_0_reason3	, '');
self.RVA1311_3_0_reason4	:= if(model_environment in [1,2], left.RVA1311_3_0_reason4	, '');

self.RVA1503_0_0_score	:= if(model_environment in [1,2], left.RVA1503_0_0_score	, '');
self.RVA1503_0_0_reason1	:= if(model_environment in [1,2], left.RVA1503_0_0_reason1	, '');
self.RVA1503_0_0_reason2	:= if(model_environment in [1,2], left.RVA1503_0_0_reason2	, '');
self.RVA1503_0_0_reason3	:= if(model_environment in [1,2], left.RVA1503_0_0_reason3	, '');
self.RVA1503_0_0_reason4	:= if(model_environment in [1,2], left.RVA1503_0_0_reason4	, '');


self.RVA1504_1_0_score	:= if(model_environment in [1,2], left.RVA1504_1_0_score	, '');
self.RVA1504_1_0_reason1	:= if(model_environment in [1,2], left.RVA1504_1_0_reason1	, '');
self.RVA1504_1_0_reason2	:= if(model_environment in [1,2], left.RVA1504_1_0_reason2	, '');
self.RVA1504_1_0_reason3	:= if(model_environment in [1,2], left.RVA1504_1_0_reason3	, '');
self.RVA1504_1_0_reason4	:= if(model_environment in [1,2], left.RVA1504_1_0_reason4	, '');

self.RVA1504_2_0_score	:= if(model_environment in [1,2], left.RVA1504_2_0_score	, '');
self.RVA1504_2_0_reason1	:= if(model_environment in [1,2], left.RVA1504_2_0_reason1	, '');
self.RVA1504_2_0_reason2	:= if(model_environment in [1,2], left.RVA1504_2_0_reason2	, '');
self.RVA1504_2_0_reason3	:= if(model_environment in [1,2], left.RVA1504_2_0_reason3	, '');
self.RVA1504_2_0_reason4	:= if(model_environment in [1,2], left.RVA1504_2_0_reason4	, '');

self.RVA1601_1_0_score  := if(model_environment in [1,2], left.RVA1601_1_0_score           , '');
self.RVA1601_1_0_reason1   := if(model_environment in [1,2], left.RVA1601_1_0_reason1     , '');
self.RVA1601_1_0_reason2   := if(model_environment in [1,2], left.RVA1601_1_0_reason2     , '');
self.RVA1601_1_0_reason3   := if(model_environment in [1,2], left.RVA1601_1_0_reason3     , '');
self.RVA1601_1_0_reason4   := if(model_environment in [1,2], left.RVA1601_1_0_reason4     , '');

self.RVA1603_1_0_score	:= if(model_environment in [1,2], left.RVA1603_1_0_score	, '');
self.RVA1603_1_0_reason1	:= if(model_environment in [1,2], left.RVA1603_1_0_reason1	, '');
self.RVA1603_1_0_reason2	:= if(model_environment in [1,2], left.RVA1603_1_0_reason2	, '');
self.RVA1603_1_0_reason3	:= if(model_environment in [1,2], left.RVA1603_1_0_reason3	, '');
self.RVA1603_1_0_reason4	:= if(model_environment in [1,2], left.RVA1603_1_0_reason4	, '');

self.RVA1605_1_0_score	:= if(model_environment in [1,2], left.RVA1605_1_0_score	, '');
self.RVA1605_1_0_reason1	:= if(model_environment in [1,2], left.RVA1605_1_0_reason1	, '');
self.RVA1605_1_0_reason2	:= if(model_environment in [1,2], left.RVA1605_1_0_reason2	, '');
self.RVA1605_1_0_reason3	:= if(model_environment in [1,2], left.RVA1605_1_0_reason3	, '');
self.RVA1605_1_0_reason4	:= if(model_environment in [1,2], left.RVA1605_1_0_reason4	, '');

self.RVA1607_1_0_score	:= if(model_environment in [1,2], left.RVA1607_1_0_score	, '');
self.RVA1607_1_0_reason1	:= if(model_environment in [1,2], left.RVA1607_1_0_reason1	, '');
self.RVA1607_1_0_reason2	:= if(model_environment in [1,2], left.RVA1607_1_0_reason2	, '');
self.RVA1607_1_0_reason3	:= if(model_environment in [1,2], left.RVA1607_1_0_reason3	, '');
self.RVA1607_1_0_reason4	:= if(model_environment in [1,2], left.RVA1607_1_0_reason4	, '');

self.RVA611_0_0_score	:= if(model_environment in [1,2], left.RVA611_0_0_score	, '');
self.RVA611_0_0_reason1	:= if(model_environment in [1,2], left.RVA611_0_0_reason1	, '');
self.RVA611_0_0_reason2	:= if(model_environment in [1,2], left.RVA611_0_0_reason2	, '');
self.RVA611_0_0_reason3	:= if(model_environment in [1,2], left.RVA611_0_0_reason3	, '');
self.RVA611_0_0_reason4	:= if(model_environment in [1,2], left.RVA611_0_0_reason4	, '');

self.RVA707_0_0_score	:= if(model_environment in [1,2], left.RVA707_0_0_score	, '');
self.RVA707_0_0_reason1	:= if(model_environment in [1,2], left.RVA707_0_0_reason1	, '');
self.RVA707_0_0_reason2	:= if(model_environment in [1,2], left.RVA707_0_0_reason2	, '');
self.RVA707_0_0_reason3	:= if(model_environment in [1,2], left.RVA707_0_0_reason3	, '');
self.RVA707_0_0_reason4	:= if(model_environment in [1,2], left.RVA707_0_0_reason4	, '');


self.RVA707_1_0_score	:= if(model_environment in [1,2], left.RVA707_1_0_score	, '');
self.RVA707_1_0_reason1	:= if(model_environment in [1,2], left.RVA707_1_0_reason1	, '');
self.RVA707_1_0_reason2	:= if(model_environment in [1,2], left.RVA707_1_0_reason2	, '');
self.RVA707_1_0_reason3	:= if(model_environment in [1,2], left.RVA707_1_0_reason3	, '');
self.RVA707_1_0_reason4	:= if(model_environment in [1,2], left.RVA707_1_0_reason4	, '');

self.RVA709_1_0_score	:= if(model_environment in [1,2], left.RVA709_1_0_score	, '');
self.RVA709_1_0_reason1	:= if(model_environment in [1,2], left.RVA709_1_0_reason1	, '');
self.RVA709_1_0_reason2	:= if(model_environment in [1,2], left.RVA709_1_0_reason2	, '');
self.RVA709_1_0_reason3	:= if(model_environment in [1,2], left.RVA709_1_0_reason3	, '');
self.RVA709_1_0_reason4	:= if(model_environment in [1,2], left.RVA709_1_0_reason4	, '');


self.RVA1611_1_0_score	:= if(model_environment in [1,2], left.RVA1611_1_0_score	, '');
self.RVA1611_1_0_reason1	:= if(model_environment in [1,2], left.RVA1611_1_0_reason1	, '');
self.RVA1611_1_0_reason2	:= if(model_environment in [1,2], left.RVA1611_1_0_reason2	, '');
self.RVA1611_1_0_reason3	:= if(model_environment in [1,2], left.RVA1611_1_0_reason3	, '');
self.RVA1611_1_0_reason4	:= if(model_environment in [1,2], left.RVA1611_1_0_reason4	, '');


self.RVA1611_2_0_score	:= if(model_environment in [1,2], left.RVA1611_2_0_score	, '');
self.RVA1611_2_0_reason1	:= if(model_environment in [1,2], left.RVA1611_2_0_reason1	, '');
self.RVA1611_2_0_reason2	:= if(model_environment in [1,2], left.RVA1611_2_0_reason2	, '');
self.RVA1611_2_0_reason3	:= if(model_environment in [1,2], left.RVA1611_2_0_reason3	, '');
self.RVA1611_2_0_reason4	:= if(model_environment in [1,2], left.RVA1611_2_0_reason4	, '');

self.RVA1811_1_0_score	:= if(model_environment in [1,2], left.RVA1811_1_0_score	, '');
self.RVA1811_1_0_reason1	:= if(model_environment in [1,2], left.RVA1811_1_0_reason1	, '');
self.RVA1811_1_0_reason2	:= if(model_environment in [1,2], left.RVA1811_1_0_reason2	, '');
self.RVA1811_1_0_reason3	:= if(model_environment in [1,2], left.RVA1811_1_0_reason3	, '');
self.RVA1811_1_0_reason4	:= if(model_environment in [1,2], left.RVA1811_1_0_reason4	, '');


self.RVB1003_0_0_score	:= if(model_environment in [1,2], left.RVB1003_0_0_score	, '');
self.RVB1003_0_0_reason1	:= if(model_environment in [1,2], left.RVB1003_0_0_reason1	, '');
self.RVB1003_0_0_reason2	:= if(model_environment in [1,2], left.RVB1003_0_0_reason2	, '');
self.RVB1003_0_0_reason3	:= if(model_environment in [1,2], left.RVB1003_0_0_reason3	, '');
self.RVB1003_0_0_reason4	:= if(model_environment in [1,2], left.RVB1003_0_0_reason4	, '');


self.RVB1104_0_0_score	:= if(model_environment in [1,2], left.RVB1104_0_0_score	, '');
self.RVB1104_0_0_reason1	:= if(model_environment in [1,2], left.RVB1104_0_0_reason1	, '');
self.RVB1104_0_0_reason2	:= if(model_environment in [1,2], left.RVB1104_0_0_reason2	, '');
self.RVB1104_0_0_reason3	:= if(model_environment in [1,2], left.RVB1104_0_0_reason3	, '');
self.RVB1104_0_0_reason4	:= if(model_environment in [1,2], left.RVB1104_0_0_reason4	, '');

self.RVB1104_1_0_score	:= if(model_environment in [1,2], left.RVB1104_1_0_score	, '');
self.RVB1104_1_0_reason1	:= if(model_environment in [1,2], left.RVB1104_1_0_reason1	, '');
self.RVB1104_1_0_reason2	:= if(model_environment in [1,2], left.RVB1104_1_0_reason2	, '');
self.RVB1104_1_0_reason3	:= if(model_environment in [1,2], left.RVB1104_1_0_reason3	, '');
self.RVB1104_1_0_reason4	:= if(model_environment in [1,2], left.RVB1104_1_0_reason4	, '');

self.RVB1310_1_0_score	:= if(model_environment in [1,2], left.RVB1310_1_0_score	, '');
self.RVB1310_1_0_reason1	:= if(model_environment in [1,2], left.RVB1310_1_0_reason1	, '');
self.RVB1310_1_0_reason2	:= if(model_environment in [1,2], left.RVB1310_1_0_reason2	, '');
self.RVB1310_1_0_reason3	:= if(model_environment in [1,2], left.RVB1310_1_0_reason3	, '');
self.RVB1310_1_0_reason4	:= if(model_environment in [1,2], left.RVB1310_1_0_reason4	, '');

self.RVB1402_1_0_score	:= if(model_environment in [1,2], left.RVB1402_1_0_score	, '');
self.RVB1402_1_0_reason1	:= if(model_environment in [1,2], left.RVB1402_1_0_reason1	, '');
self.RVB1402_1_0_reason2	:= if(model_environment in [1,2], left.RVB1402_1_0_reason2	, '');
self.RVB1402_1_0_reason3	:= if(model_environment in [1,2], left.RVB1402_1_0_reason3	, '');
self.RVB1402_1_0_reason4	:= if(model_environment in [1,2], left.RVB1402_1_0_reason4	, '');

self.RVB1503_0_0_score	:= if(model_environment in [1,2], left.RVB1503_0_0_score	, '');
self.RVB1503_0_0_reason1	:= if(model_environment in [1,2], left.RVB1503_0_0_reason1	, '');
self.RVB1503_0_0_reason2	:= if(model_environment in [1,2], left.RVB1503_0_0_reason2	, '');
self.RVB1503_0_0_reason3	:= if(model_environment in [1,2], left.RVB1503_0_0_reason3	, '');
self.RVB1503_0_0_reason4	:= if(model_environment in [1,2], left.RVB1503_0_0_reason4	, '');

self.RVB609_0_0_score	:= if(model_environment in [1,2], left.RVB609_0_0_score	, '');
self.RVB609_0_0_reason1	:= if(model_environment in [1,2], left.RVB609_0_0_reason1	, '');
self.RVB609_0_0_reason2	:= if(model_environment in [1,2], left.RVB609_0_0_reason2	, '');
self.RVB609_0_0_reason3	:= if(model_environment in [1,2], left.RVB609_0_0_reason3	, '');
self.RVB609_0_0_reason4	:= if(model_environment in [1,2], left.RVB609_0_0_reason4	, '');

self.RVB705_1_0_score	:= if(model_environment in [1,2], left.RVB705_1_0_score	, '');
self.RVB705_1_0_reason1	:= if(model_environment in [1,2], left.RVB705_1_0_reason1	, '');
self.RVB705_1_0_reason2	:= if(model_environment in [1,2], left.RVB705_1_0_reason2	, '');
self.RVB705_1_0_reason3	:= if(model_environment in [1,2], left.RVB705_1_0_reason3	, '');
self.RVB705_1_0_reason4	:= if(model_environment in [1,2], left.RVB705_1_0_reason4	, '');

self.RVB1610_1_0_score	:= if(model_environment in [1,2], left.RVB1610_1_0_score	, '');
self.RVB1610_1_0_reason1	:= if(model_environment in [1,2], left.RVB1610_1_0_reason1	, '');
self.RVB1610_1_0_reason2	:= if(model_environment in [1,2], left.RVB1610_1_0_reason2	, '');
self.RVB1610_1_0_reason3	:= if(model_environment in [1,2], left.RVB1610_1_0_reason3	, '');
self.RVB1610_1_0_reason4	:= if(model_environment in [1,2], left.RVB1610_1_0_reason4	, '');

self.RVC1110_1_0_score	:= if(model_environment in [1,2], left.RVC1110_1_0_score	, '');
self.RVC1110_1_0_reason1	:= if(model_environment in [1,2], left.RVC1110_1_0_reason1	, '');
self.RVC1110_1_0_reason2	:= if(model_environment in [1,2], left.RVC1110_1_0_reason2	, '');
self.RVC1110_1_0_reason3	:= if(model_environment in [1,2], left.RVC1110_1_0_reason3	, '');
self.RVC1110_1_0_reason4	:= if(model_environment in [1,2], left.RVC1110_1_0_reason4	, '');


self.RVC1110_2_0_score	:= if(model_environment in [1,2], left.RVC1110_2_0_score	, '');
self.RVC1110_2_0_reason1	:= if(model_environment in [1,2], left.RVC1110_2_0_reason1	, '');
self.RVC1110_2_0_reason2	:= if(model_environment in [1,2], left.RVC1110_2_0_reason2	, '');
self.RVC1110_2_0_reason3	:= if(model_environment in [1,2], left.RVC1110_2_0_reason3	, '');
self.RVC1110_2_0_reason4	:= if(model_environment in [1,2], left.RVC1110_2_0_reason4	, '');


self.RVC1112_0_0_score	:= if(model_environment in [1,2], left.RVC1112_0_0_score	, '');
self.RVC1112_0_0_reason1	:= if(model_environment in [1,2], left.RVC1112_0_0_reason1	, '');
self.RVC1112_0_0_reason2	:= if(model_environment in [1,2], left.RVC1112_0_0_reason2	, '');
self.RVC1112_0_0_reason3	:= if(model_environment in [1,2], left.RVC1112_0_0_reason3	, '');
self.RVC1112_0_0_reason4	:= if(model_environment in [1,2], left.RVC1112_0_0_reason4	, '');

self.RVC1208_1_0_score	:= if(model_environment in [1,2], left.RVC1208_1_0_score	, '');
self.RVC1208_1_0_reason1	:= if(model_environment in [1,2], left.RVC1208_1_0_reason1	, '');
self.RVC1208_1_0_reason2	:= if(model_environment in [1,2], left.RVC1208_1_0_reason2	, '');
self.RVC1208_1_0_reason3	:= if(model_environment in [1,2], left.RVC1208_1_0_reason3	, '');
self.RVC1208_1_0_reason4	:= if(model_environment in [1,2], left.RVC1208_1_0_reason4	, '');

self.RVC1210_1_0_score	:= if(model_environment in [1,2], left.RVC1210_1_0_score	, '');
self.RVC1210_1_0_reason1	:= if(model_environment in [1,2], left.RVC1210_1_0_reason1	, '');
self.RVC1210_1_0_reason2	:= if(model_environment in [1,2], left.RVC1210_1_0_reason2	, '');
self.RVC1210_1_0_reason3	:= if(model_environment in [1,2], left.RVC1210_1_0_reason3	, '');
self.RVC1210_1_0_reason4	:= if(model_environment in [1,2], left.RVC1210_1_0_reason4	, '');

self.RVC1301_1_0_score	:= if(model_environment in [1,2], left.RVC1301_1_0_score	, '');
self.RVC1301_1_0_reason1	:= if(model_environment in [1,2], left.RVC1301_1_0_reason1	, '');
self.RVC1301_1_0_reason2	:= if(model_environment in [1,2], left.RVC1301_1_0_reason2	, '');
self.RVC1301_1_0_reason3	:= if(model_environment in [1,2], left.RVC1301_1_0_reason3	, '');
self.RVC1301_1_0_reason4	:= if(model_environment in [1,2], left.RVC1301_1_0_reason4	, '');

self.RVC1307_1_0_score	:= if(model_environment in [1,2], left.RVC1307_1_0_score	, '');
self.RVC1307_1_0_reason1	:= if(model_environment in [1,2], left.RVC1307_1_0_reason1	, '');
self.RVC1307_1_0_reason2	:= if(model_environment in [1,2], left.RVC1307_1_0_reason2	, '');
self.RVC1307_1_0_reason3	:= if(model_environment in [1,2], left.RVC1307_1_0_reason3	, '');
self.RVC1307_1_0_reason4	:= if(model_environment in [1,2], left.RVC1307_1_0_reason4	, '');

self.RVC1405_1_0_score	:= if(model_environment in [1,2], left.RVC1405_1_0_score	, '');
self.RVC1405_1_0_reason1	:= if(model_environment in [1,2], left.RVC1405_1_0_reason1	, '');
self.RVC1405_1_0_reason2	:= if(model_environment in [1,2], left.RVC1405_1_0_reason2	, '');
self.RVC1405_1_0_reason3	:= if(model_environment in [1,2], left.RVC1405_1_0_reason3	, '');
self.RVC1405_1_0_reason4	:= if(model_environment in [1,2], left.RVC1405_1_0_reason4	, '');

self.RVC1405_2_0_score	:= if(model_environment in [1,2], left.RVC1405_2_0_score	, '');
self.RVC1405_2_0_reason1	:= if(model_environment in [1,2], left.RVC1405_2_0_reason1	, '');
self.RVC1405_2_0_reason2	:= if(model_environment in [1,2], left.RVC1405_2_0_reason2	, '');
self.RVC1405_2_0_reason3	:= if(model_environment in [1,2], left.RVC1405_2_0_reason3	, '');
self.RVC1405_2_0_reason4	:= if(model_environment in [1,2], left.RVC1405_2_0_reason4	, '');

self.RVC1405_3_0_score	:= if(model_environment in [1,2], left.RVC1405_3_0_score	, '');
self.RVC1405_3_0_reason1	:= if(model_environment in [1,2], left.RVC1405_3_0_reason1	, '');
self.RVC1405_3_0_reason2	:= if(model_environment in [1,2], left.RVC1405_3_0_reason2	, '');
self.RVC1405_3_0_reason3	:= if(model_environment in [1,2], left.RVC1405_3_0_reason3	, '');
self.RVC1405_3_0_reason4	:= if(model_environment in [1,2], left.RVC1405_3_0_reason4	, '');

self.RVC1405_4_0_score	:= if(model_environment in [1,2], left.RVC1405_4_0_score	, '');
self.RVC1405_4_0_reason1	:= if(model_environment in [1,2], left.RVC1405_4_0_reason1	, '');
self.RVC1405_4_0_reason2	:= if(model_environment in [1,2], left.RVC1405_4_0_reason2	, '');
self.RVC1405_4_0_reason3	:= if(model_environment in [1,2], left.RVC1405_4_0_reason3	, '');
self.RVC1405_4_0_reason4	:= if(model_environment in [1,2], left.RVC1405_4_0_reason4	, '');

self.RVC1412_1_0_score	:= if(model_environment in [1,2], left.RVC1412_1_0_score	, '');
self.RVC1412_1_0_reason1	:= if(model_environment in [1,2], left.RVC1412_1_0_reason1	, '');
self.RVC1412_1_0_reason2	:= if(model_environment in [1,2], left.RVC1412_1_0_reason2	, '');
self.RVC1412_1_0_reason3	:= if(model_environment in [1,2], left.RVC1412_1_0_reason3	, '');
self.RVC1412_1_0_reason4	:= if(model_environment in [1,2], left.RVC1412_1_0_reason4	, '');

self.RVC1412_2_0_score	:= if(model_environment in [1,2], left.RVC1412_2_0_score	, '');
self.RVC1412_2_0_reason1	:= if(model_environment in [1,2], left.RVC1412_2_0_reason1	, '');
self.RVC1412_2_0_reason2	:= if(model_environment in [1,2], left.RVC1412_2_0_reason2	, '');
self.RVC1412_2_0_reason3	:= if(model_environment in [1,2], left.RVC1412_2_0_reason3	, '');
self.RVC1412_2_0_reason4	:= if(model_environment in [1,2], left.RVC1412_2_0_reason4	, '');

self.RVC1602_1_0_score	:= if(model_environment in [1,2], left.RVC1602_1_0_score	, '');
self.RVC1602_1_0_reason1	:= if(model_environment in [1,2], left.RVC1602_1_0_reason1	, '');
self.RVC1602_1_0_reason2	:= if(model_environment in [1,2], left.RVC1602_1_0_reason2	, '');
self.RVC1602_1_0_reason3	:= if(model_environment in [1,2], left.RVC1602_1_0_reason3	, '');
self.RVC1602_1_0_reason4	:= if(model_environment in [1,2], left.RVC1602_1_0_reason4	, '');

self.RVC1609_1_0_score	:= if(model_environment in [1,2], left.RVC1609_1_0_score	, '');
self.RVC1609_1_0_reason1	:= if(model_environment in [1,2], left.RVC1609_1_0_reason1	, '');
self.RVC1609_1_0_reason2	:= if(model_environment in [1,2], left.RVC1609_1_0_reason2	, '');
self.RVC1609_1_0_reason3	:= if(model_environment in [1,2], left.RVC1609_1_0_reason3	, '');
self.RVC1609_1_0_reason4	:= if(model_environment in [1,2], left.RVC1609_1_0_reason4	, '');

self.RVC1703_1_0_score	:= if(model_environment in [1,2], left.RVC1703_1_0_score	, '');
self.RVC1703_1_0_reason1	:= if(model_environment in [1,2], left.RVC1703_1_0_reason1	, '');
self.RVC1703_1_0_reason2	:= if(model_environment in [1,2], left.RVC1703_1_0_reason2	, '');
self.RVC1703_1_0_reason3	:= if(model_environment in [1,2], left.RVC1703_1_0_reason3	, '');
self.RVC1703_1_0_reason4	:= if(model_environment in [1,2], left.RVC1703_1_0_reason4	, '');

self.RVC1801_1_0_score	:= if(model_environment in [1,2], left.RVC1801_1_0_score	, '');
self.RVC1801_1_0_reason1	:= if(model_environment in [1,2], left.RVC1801_1_0_reason1	, '');
self.RVC1801_1_0_reason2	:= if(model_environment in [1,2], left.RVC1801_1_0_reason2	, '');
self.RVC1801_1_0_reason3	:= if(model_environment in [1,2], left.RVC1801_1_0_reason3	, '');
self.RVC1801_1_0_reason4	:= if(model_environment in [1,2], left.RVC1801_1_0_reason4	, '');

self.RVC1805_1_0_score	:= if(model_environment in [1,2], left.RVC1805_1_0_score	, '');
self.RVC1805_1_0_reason1	:= if(model_environment in [1,2], left.RVC1805_1_0_reason1	, '');
self.RVC1805_1_0_reason2	:= if(model_environment in [1,2], left.RVC1805_1_0_reason2	, '');
self.RVC1805_1_0_reason3	:= if(model_environment in [1,2], left.RVC1805_1_0_reason3	, '');
self.RVC1805_1_0_reason4	:= if(model_environment in [1,2], left.RVC1805_1_0_reason4	, '');

self.RVC1805_2_0_score	:= if(model_environment in [1,2], left.RVC1805_2_0_score	, '');
self.RVC1805_2_0_reason1	:= if(model_environment in [1,2], left.RVC1805_2_0_reason1	, '');
self.RVC1805_2_0_reason2	:= if(model_environment in [1,2], left.RVC1805_2_0_reason2	, '');
self.RVC1805_2_0_reason3	:= if(model_environment in [1,2], left.RVC1805_2_0_reason3	, '');
self.RVC1805_2_0_reason4	:= if(model_environment in [1,2], left.RVC1805_2_0_reason4	, '');

self.RVD1010_0_0_score	:= if(model_environment in [1,2], left.RVD1010_0_0_score	, '');
self.RVD1010_0_0_reason1	:= if(model_environment in [1,2], left.RVD1010_0_0_reason1	, '');
self.RVD1010_0_0_reason2	:= if(model_environment in [1,2], left.RVD1010_0_0_reason2	, '');
self.RVD1010_0_0_reason3	:= if(model_environment in [1,2], left.RVD1010_0_0_reason3	, '');
self.RVD1010_0_0_reason4	:= if(model_environment in [1,2], left.RVD1010_0_0_reason4	, '');

self.RVD1010_1_0_score	:= if(model_environment in [1,2], left.RVD1010_1_0_score	, '');
self.RVD1010_1_0_reason1	:= if(model_environment in [1,2], left.RVD1010_1_0_reason1	, '');
self.RVD1010_1_0_reason2	:= if(model_environment in [1,2], left.RVD1010_1_0_reason2	, '');
self.RVD1010_1_0_reason3	:= if(model_environment in [1,2], left.RVD1010_1_0_reason3	, '');
self.RVD1010_1_0_reason4	:= if(model_environment in [1,2], left.RVD1010_1_0_reason4	, '');


self.RVD1010_2_0_score	:= if(model_environment in [1,2], left.RVD1010_2_0_score	, '');
self.RVD1010_2_0_reason1	:= if(model_environment in [1,2], left.RVD1010_2_0_reason1	, '');
self.RVD1010_2_0_reason2	:= if(model_environment in [1,2], left.RVD1010_2_0_reason2	, '');
self.RVD1010_2_0_reason3	:= if(model_environment in [1,2], left.RVD1010_2_0_reason3	, '');
self.RVD1010_2_0_reason4	:= if(model_environment in [1,2], left.RVD1010_2_0_reason4	, '');


self.RVD1110_1_0_score	:= if(model_environment in [1,2], left.RVD1110_1_0_score	, '');
self.RVD1110_1_0_reason1	:= if(model_environment in [1,2], left.RVD1110_1_0_reason1	, '');
self.RVD1110_1_0_reason2	:= if(model_environment in [1,2], left.RVD1110_1_0_reason2	, '');
self.RVD1110_1_0_reason3	:= if(model_environment in [1,2], left.RVD1110_1_0_reason3	, '');
self.RVD1110_1_0_reason4	:= if(model_environment in [1,2], left.RVD1110_1_0_reason4	, '');

self.RVD1801_1_0_score	:= if(model_environment in [1,2], left.RVD1801_1_0_score	, '');
self.RVD1801_1_0_reason1	:= if(model_environment in [1,2], left.RVD1801_1_0_reason1	, '');
self.RVD1801_1_0_reason2	:= if(model_environment in [1,2], left.RVD1801_1_0_reason2	, '');
self.RVD1801_1_0_reason3	:= if(model_environment in [1,2], left.RVD1801_1_0_reason3	, '');
self.RVD1801_1_0_reason4	:= if(model_environment in [1,2], left.RVD1801_1_0_reason4	, '');
self.RVD1801_1_0_reason5	:= if(model_environment in [1,2], left.RVD1801_1_0_reason5	, '');


self.RVG1003_0_0_score	:= if(model_environment in [1,2], left.RVG1003_0_0_score	, '');
self.RVG1003_0_0_reason1	:= if(model_environment in [1,2], left.RVG1003_0_0_reason1	, '');
self.RVG1003_0_0_reason2	:= if(model_environment in [1,2], left.RVG1003_0_0_reason2	, '');
self.RVG1003_0_0_reason3	:= if(model_environment in [1,2], left.RVG1003_0_0_reason3	, '');
self.RVG1003_0_0_reason4	:= if(model_environment in [1,2], left.RVG1003_0_0_reason4	, '');


self.RVG1103_0_0_score	:= if(model_environment in [1,2], left.RVG1103_0_0_score	, '');
self.RVG1103_0_0_reason1	:= if(model_environment in [1,2], left.RVG1103_0_0_reason1	, '');
self.RVG1103_0_0_reason2	:= if(model_environment in [1,2], left.RVG1103_0_0_reason2	, '');
self.RVG1103_0_0_reason3	:= if(model_environment in [1,2], left.RVG1103_0_0_reason3	, '');
self.RVG1103_0_0_reason4	:= if(model_environment in [1,2], left.RVG1103_0_0_reason4	, '');


self.RVG1106_1_0_score	:= if(model_environment in [1,2], left.RVG1106_1_0_score	, '');
self.RVG1106_1_0_reason1	:= if(model_environment in [1,2], left.RVG1106_1_0_reason1	, '');
self.RVG1106_1_0_reason2	:= if(model_environment in [1,2], left.RVG1106_1_0_reason2	, '');
self.RVG1106_1_0_reason3	:= if(model_environment in [1,2], left.RVG1106_1_0_reason3	, '');
self.RVG1106_1_0_reason4	:= if(model_environment in [1,2], left.RVG1106_1_0_reason4	, '');

self.RVG1201_1_0_score	:= if(model_environment in [1,2], left.RVG1201_1_0_score	, '');
self.RVG1201_1_0_reason1	:= if(model_environment in [1,2], left.RVG1201_1_0_reason1	, '');
self.RVG1201_1_0_reason2	:= if(model_environment in [1,2], left.RVG1201_1_0_reason2	, '');
self.RVG1201_1_0_reason3	:= if(model_environment in [1,2], left.RVG1201_1_0_reason3	, '');
self.RVG1201_1_0_reason4	:= if(model_environment in [1,2], left.RVG1201_1_0_reason4	, '');

self.RVG1302_1_0_score	:= if(model_environment in [1,2], left.RVG1302_1_0_score	, '');
self.RVG1302_1_0_reason1	:= if(model_environment in [1,2], left.RVG1302_1_0_reason1	, '');
self.RVG1302_1_0_reason2	:= if(model_environment in [1,2], left.RVG1302_1_0_reason2	, '');
self.RVG1302_1_0_reason3	:= if(model_environment in [1,2], left.RVG1302_1_0_reason3	, '');
self.RVG1302_1_0_reason4	:= if(model_environment in [1,2], left.RVG1302_1_0_reason4	, '');

self.RVG1304_1_0_score	:= if(model_environment in [1,2], left.RVG1304_1_0_score	, '');
self.RVG1304_1_0_reason1	:= if(model_environment in [1,2], left.RVG1304_1_0_reason1	, '');
self.RVG1304_1_0_reason2	:= if(model_environment in [1,2], left.RVG1304_1_0_reason2	, '');
self.RVG1304_1_0_reason3	:= if(model_environment in [1,2], left.RVG1304_1_0_reason3	, '');
self.RVG1304_1_0_reason4	:= if(model_environment in [1,2], left.RVG1304_1_0_reason4	, '');

self.RVG1304_2_0_score	:= if(model_environment in [1,2], left.RVG1304_2_0_score	, '');
self.RVG1304_2_0_reason1	:= if(model_environment in [1,2], left.RVG1304_2_0_reason1	, '');
self.RVG1304_2_0_reason2	:= if(model_environment in [1,2], left.RVG1304_2_0_reason2	, '');
self.RVG1304_2_0_reason3	:= if(model_environment in [1,2], left.RVG1304_2_0_reason3	, '');
self.RVG1304_2_0_reason4	:= if(model_environment in [1,2], left.RVG1304_2_0_reason4	, '');

//=== Money Lion RiskView custom model ===
self.RVG1511_1_0_score	:= if(model_environment in [1,2], left.RVG1511_1_0_score	, '');
self.RVG1511_1_0_reason1	:= if(model_environment in [1,2], left.RVG1511_1_0_reason1	, '');
self.RVG1511_1_0_reason2	:= if(model_environment in [1,2], left.RVG1511_1_0_reason2	, '');
self.RVG1511_1_0_reason3	:= if(model_environment in [1,2], left.RVG1511_1_0_reason3	, '');
self.RVG1511_1_0_reason4	:= if(model_environment in [1,2], left.RVG1511_1_0_reason4	, '');

self.RVG812_0_0_score	:= if(model_environment in [1,2], left.RVG812_0_0_score	, '');
self.RVG812_0_0_reason1	:= if(model_environment in [1,2], left.RVG812_0_0_reason1	, '');
self.RVG812_0_0_reason2	:= if(model_environment in [1,2], left.RVG812_0_0_reason2	, '');
self.RVG812_0_0_reason3	:= if(model_environment in [1,2], left.RVG812_0_0_reason3	, '');
self.RVG812_0_0_reason4	:= if(model_environment in [1,2], left.RVG812_0_0_reason4	, '');

self.RVG903_1_0_score	:= if(model_environment in [1,2], left.RVG903_1_0_score	, '');

self.RVG1401_1_0_score	:= if(model_environment in [1,2], left.RVG1401_1_0_score	, '');
self.RVG1401_1_0_reason1	:= if(model_environment in [1,2], left.RVG1401_1_0_reason1	, '');
self.RVG1401_1_0_reason2	:= if(model_environment in [1,2], left.RVG1401_1_0_reason2	, '');
self.RVG1401_1_0_reason3	:= if(model_environment in [1,2], left.RVG1401_1_0_reason3	, '');
self.RVG1401_1_0_reason4	:= if(model_environment in [1,2], left.RVG1401_1_0_reason4	, '');

self.RVG1401_2_0_score	:= if(model_environment in [1,2], left.RVG1401_2_0_score	, '');
self.RVG1401_2_0_reason1	:= if(model_environment in [1,2], left.RVG1401_2_0_reason1	, '');
self.RVG1401_2_0_reason2	:= if(model_environment in [1,2], left.RVG1401_2_0_reason2	, '');
self.RVG1401_2_0_reason3	:= if(model_environment in [1,2], left.RVG1401_2_0_reason3	, '');
self.RVG1401_2_0_reason4	:= if(model_environment in [1,2], left.RVG1401_2_0_reason4	, '');

self.RVG1310_1_0_score	:= if(model_environment in [1,2], left.RVG1310_1_0_score	, '');
self.RVG1310_1_0_reason1	:= if(model_environment in [1,2], left.RVG1310_1_0_reason1	, '');
self.RVG1310_1_0_reason2	:= if(model_environment in [1,2], left.RVG1310_1_0_reason2	, '');
self.RVG1310_1_0_reason3	:= if(model_environment in [1,2], left.RVG1310_1_0_reason3	, '');
self.RVG1310_1_0_reason4	:= if(model_environment in [1,2], left.RVG1310_1_0_reason4	, '');

self.RVG1404_1_0_score	:= if(model_environment in [1,2], left.RVG1404_1_0_score	, '');
self.RVG1404_1_0_reason1	:= if(model_environment in [1,2], left.RVG1404_1_0_reason1	, '');
self.RVG1404_1_0_reason2	:= if(model_environment in [1,2], left.RVG1404_1_0_reason2	, '');
self.RVG1404_1_0_reason3	:= if(model_environment in [1,2], left.RVG1404_1_0_reason3	, '');
self.RVG1404_1_0_reason4	:= if(model_environment in [1,2], left.RVG1404_1_0_reason4	, '');

self.RVG1502_0_0_score	:= if(model_environment in [1,2], left.RVG1502_0_0_score	, '');
self.RVG1502_0_0_reason1	:= if(model_environment in [1,2], left.RVG1502_0_0_reason1	, '');
self.RVG1502_0_0_reason2	:= if(model_environment in [1,2], left.RVG1502_0_0_reason2	, '');
self.RVG1502_0_0_reason3	:= if(model_environment in [1,2], left.RVG1502_0_0_reason3	, '');
self.RVG1502_0_0_reason4	:= if(model_environment in [1,2], left.RVG1502_0_0_reason4	, '');

self.RVG1601_1_0_score	:= if(model_environment in [1,2], left.RVG1601_1_0_score	, '');
self.RVG1601_1_0_reason1	:= if(model_environment in [1,2], left.RVG1601_1_0_reason1	, '');
self.RVG1601_1_0_reason2	:= if(model_environment in [1,2], left.RVG1601_1_0_reason2	, '');
self.RVG1601_1_0_reason3	:= if(model_environment in [1,2], left.RVG1601_1_0_reason3	, '');
self.RVG1601_1_0_reason4	:= if(model_environment in [1,2], left.RVG1601_1_0_reason4	, '');
self.RVG1601_1_0_reason5	:= if(model_environment in [1,2], left.RVG1601_1_0_reason5	, '');

self.RVG1605_1_0_score	:= if(model_environment in [1,2], left.RVG1605_1_0_score	, '');
self.RVG1605_1_0_reason1	:= if(model_environment in [1,2], left.RVG1605_1_0_reason1	, '');
self.RVG1605_1_0_reason2	:= if(model_environment in [1,2], left.RVG1605_1_0_reason2	, '');
self.RVG1605_1_0_reason3	:= if(model_environment in [1,2], left.RVG1605_1_0_reason3	, '');
self.RVG1605_1_0_reason4	:= if(model_environment in [1,2], left.RVG1605_1_0_reason4	, '');
self.RVG1605_1_0_reason5	:= if(model_environment in [1,2], left.RVG1605_1_0_reason5	, '');

self.RVG1702_1_0_score	:= if(model_environment in [1,2], left.RVG1702_1_0_score	, '');
self.RVG1702_1_0_reason1	:= if(model_environment in [1,2], left.RVG1702_1_0_reason1	, '');
self.RVG1702_1_0_reason2	:= if(model_environment in [1,2], left.RVG1702_1_0_reason2	, '');
self.RVG1702_1_0_reason3	:= if(model_environment in [1,2], left.RVG1702_1_0_reason3	, '');
self.RVG1702_1_0_reason4	:= if(model_environment in [1,2], left.RVG1702_1_0_reason4	, '');

self.RVG1705_1_0_score	:= if(model_environment in [1,2], left.RVG1705_1_0_score	, '');
self.RVG1705_1_0_reason1	:= if(model_environment in [1,2], left.RVG1705_1_0_reason1	, '');
self.RVG1705_1_0_reason2	:= if(model_environment in [1,2], left.RVG1705_1_0_reason2	, '');
self.RVG1705_1_0_reason3	:= if(model_environment in [1,2], left.RVG1705_1_0_reason3	, '');
self.RVG1705_1_0_reason4	:= if(model_environment in [1,2], left.RVG1705_1_0_reason4	, '');

self.RVG1706_1_0_score	:= if(model_environment in [1,2], left.RVG1706_1_0_score	, '');
self.RVG1706_1_0_reason1	:= if(model_environment in [1,2], left.RVG1706_1_0_reason1	, '');
self.RVG1706_1_0_reason2	:= if(model_environment in [1,2], left.RVG1706_1_0_reason2	, '');
self.RVG1706_1_0_reason3	:= if(model_environment in [1,2], left.RVG1706_1_0_reason3	, '');
self.RVG1706_1_0_reason4	:= if(model_environment in [1,2], left.RVG1706_1_0_reason4	, '');

self.RVG1610_1_0_score	:= if(model_environment in [1,2], left.RVG1610_1_0_score	, '');
self.RVG1610_1_0_reason1	:= if(model_environment in [1,2], left.RVG1610_1_0_reason1	, '');
self.RVG1610_1_0_reason2	:= if(model_environment in [1,2], left.RVG1610_1_0_reason2	, '');
self.RVG1610_1_0_reason3	:= if(model_environment in [1,2], left.RVG1610_1_0_reason3	, '');
self.RVG1610_1_0_reason4	:= if(model_environment in [1,2], left.RVG1610_1_0_reason4	, '');
self.RVG1610_1_0_reason5	:= if(model_environment in [1,2], left.RVG1610_1_0_reason5	, '');

self.RVG1802_1_0_score	:= if(model_environment in [1,2], left.RVG1802_1_0_score	, '');
self.RVG1802_1_0_reason1	:= if(model_environment in [1,2], left.RVG1802_1_0_reason1	, '');
self.RVG1802_1_0_reason2	:= if(model_environment in [1,2], left.RVG1802_1_0_reason2	, '');
self.RVG1802_1_0_reason3	:= if(model_environment in [1,2], left.RVG1802_1_0_reason3	, '');
self.RVG1802_1_0_reason4	:= if(model_environment in [1,2], left.RVG1802_1_0_reason4	, '');
self.RVG1802_1_0_reason5	:= if(model_environment in [1,2], left.RVG1802_1_0_reason5	, '');

self.RVP1012_1_0_score	:= if(model_environment in [1,2], left.RVP1012_1_0_score	, '');
self.RVP1012_1_0_reason1	:= if(model_environment in [1,2], left.RVP1012_1_0_reason1	, '');

self.RVP1208_1_0_score	:= if(model_environment in [1,2], left.RVP1208_1_0_score	, '');
self.RVP1208_1_0_reason1	:= if(model_environment in [1,2], left.RVP1208_1_0_reason1	, '');

self.RVP1401_1_0_score	:= if(model_environment in [1,2], left.RVP1401_1_0_score	, '');
self.RVP1401_1_0_reason1	:= if(model_environment in [1,2], left.RVP1401_1_0_reason1	, '');

self.RVP1401_2_0_score	:= if(model_environment in [1,2], left.RVP1401_2_0_score	, '');
self.RVP1401_2_0_reason1	:= if(model_environment in [1,2], left.RVP1401_2_0_reason1	, '');

self.RVP1503_1_0_score	:= if(model_environment in [1,2], left.RVP1503_1_0_score	, '');
self.RVP1503_1_0_reason1	:= if(model_environment in [1,2], left.RVP1503_1_0_reason1	, '');

self.RVP1605_1_0_score	:= if(model_environment in [1,2], left.RVP1605_1_0_score	, '');
self.RVP1605_1_0_reason1	:= if(model_environment in [1,2], left.RVP1605_1_0_reason1	, '');

self.RVP1702_1_0_score	:= if(model_environment in [1,2], left.RVP1702_1_0_score	, '');
self.RVP1702_1_0_reason1	:= if(model_environment in [1,2], left.RVP1702_1_0_reason1	, '');

self.RVR704_1_0_score	:= if(model_environment in [1,2], left.RVR704_1_0_score	, '');
self.RVR704_1_0_reason1	:= if(model_environment in [1,2], left.RVR704_1_0_reason1	, '');
self.RVR704_1_0_reason2	:= if(model_environment in [1,2], left.RVR704_1_0_reason2	, '');
self.RVR704_1_0_reason3	:= if(model_environment in [1,2], left.RVR704_1_0_reason3	, '');
self.RVR704_1_0_reason4	:= if(model_environment in [1,2], left.RVR704_1_0_reason4	, '');

self.RVR1008_1_0_score	:= if(model_environment in [1,2], left.RVR1008_1_0_score	, '');
self.RVR1008_1_0_reason1	:= if(model_environment in [1,2], left.RVR1008_1_0_reason1	, '');
self.RVR1008_1_0_reason2	:= if(model_environment in [1,2], left.RVR1008_1_0_reason2	, '');
self.RVR1008_1_0_reason3	:= if(model_environment in [1,2], left.RVR1008_1_0_reason3	, '');
self.RVR1008_1_0_reason4	:= if(model_environment in [1,2], left.RVR1008_1_0_reason4	, '');


self.RVR1103_0_0_score	:= if(model_environment in [1,2], left.RVR1103_0_0_score	, '');
self.RVR1103_0_0_reason1	:= if(model_environment in [1,2], left.RVR1103_0_0_reason1	, '');
self.RVR1103_0_0_reason2	:= if(model_environment in [1,2], left.RVR1103_0_0_reason2	, '');
self.RVR1103_0_0_reason3	:= if(model_environment in [1,2], left.RVR1103_0_0_reason3	, '');
self.RVR1103_0_0_reason4	:= if(model_environment in [1,2], left.RVR1103_0_0_reason4	, '');


self.RVR1104_2_0_score	:= if(model_environment in [1,2], left.RVR1104_2_0_score	, '');
self.RVR1104_2_0_reason1	:= if(model_environment in [1,2], left.RVR1104_2_0_reason1	, '');
self.RVR1104_2_0_reason2	:= if(model_environment in [1,2], left.RVR1104_2_0_reason2	, '');
self.RVR1104_2_0_reason3	:= if(model_environment in [1,2], left.RVR1104_2_0_reason3	, '');
self.RVR1104_2_0_reason4	:= if(model_environment in [1,2], left.RVR1104_2_0_reason4	, '');

self.RVR1210_1_0_score	:= if(model_environment in [1,2], left.RVR1210_1_0_score	, '');
self.RVR1210_1_0_reason1	:= if(model_environment in [1,2], left.RVR1210_1_0_reason1	, '');
self.RVR1210_1_0_reason2	:= if(model_environment in [1,2], left.RVR1210_1_0_reason2	, '');
self.RVR1210_1_0_reason3	:= if(model_environment in [1,2], left.RVR1210_1_0_reason3	, '');
self.RVR1210_1_0_reason4	:= if(model_environment in [1,2], left.RVR1210_1_0_reason4	, '');

self.RVR1303_1_0_score	:= if(model_environment in [1,2], left.RVR1303_1_0_score	, '');
self.RVR1303_1_0_reason1	:= if(model_environment in [1,2], left.RVR1303_1_0_reason1	, '');
self.RVR1303_1_0_reason2	:= if(model_environment in [1,2], left.RVR1303_1_0_reason2	, '');
self.RVR1303_1_0_reason3	:= if(model_environment in [1,2], left.RVR1303_1_0_reason3	, '');
self.RVR1303_1_0_reason4	:= if(model_environment in [1,2], left.RVR1303_1_0_reason4	, '');

self.RVR1410_1_0_score	:= if(model_environment in [1,2], left.RVR1410_1_0_score	, '');
self.RVR1410_1_0_reason1	:= if(model_environment in [1,2], left.RVR1410_1_0_reason1	, '');
self.RVR1410_1_0_reason2	:= if(model_environment in [1,2], left.RVR1410_1_0_reason2	, '');
self.RVR1410_1_0_reason3	:= if(model_environment in [1,2], left.RVR1410_1_0_reason3	, '');
self.RVR1410_1_0_reason4	:= if(model_environment in [1,2], left.RVR1410_1_0_reason4	, '');

self.RVR803_1_0_score	:= if(model_environment in [1,2], left.RVR803_1_0_score	, '');
self.RVR803_1_0_reason1	:= if(model_environment in [1,2], left.RVR803_1_0_reason1	, '');
self.RVR803_1_0_reason2	:= if(model_environment in [1,2], left.RVR803_1_0_reason2	, '');
self.RVR803_1_0_reason3	:= if(model_environment in [1,2], left.RVR803_1_0_reason3	, '');
self.RVR803_1_0_reason4	:= if(model_environment in [1,2], left.RVR803_1_0_reason4	, '');


self.RVS811_0_0_score	:= if(model_environment in [1,3], left.RVS811_0_0_score	, '');
self.RVS811_0_0_reason1	:= if(model_environment in [1,3], left.RVS811_0_0_reason1	, '');
self.RVS811_0_0_reason2	:= if(model_environment in [1,3], left.RVS811_0_0_reason2	, '');
self.RVS811_0_0_reason3	:= if(model_environment in [1,3], left.RVS811_0_0_reason3	, '');
self.RVS811_0_0_reason4	:= if(model_environment in [1,3], left.RVS811_0_0_reason4	, '');

self.RVS1706_0_score	:= if(model_environment in [1,2], left.RVS1706_0_score	, '');
self.RVS1706_0_reason1	:= if(model_environment in [1,2], left.RVS1706_0_reason1	, '');
self.RVS1706_0_reason2	:= if(model_environment in [1,2], left.RVS1706_0_reason2	, '');
self.RVS1706_0_reason3	:= if(model_environment in [1,2], left.RVS1706_0_reason3	, '');
self.RVS1706_0_reason4	:= if(model_environment in [1,2], left.RVS1706_0_reason4	, '');


self.RVT1003_0_0_score	:= if(model_environment in [1,2], left.RVT1003_0_0_score	, '');
self.RVT1003_0_0_reason1	:= if(model_environment in [1,2], left.RVT1003_0_0_reason1	, '');
self.RVT1003_0_0_reason2	:= if(model_environment in [1,2], left.RVT1003_0_0_reason2	, '');
self.RVT1003_0_0_reason3	:= if(model_environment in [1,2], left.RVT1003_0_0_reason3	, '');
self.RVT1003_0_0_reason4	:= if(model_environment in [1,2], left.RVT1003_0_0_reason4	, '');

self.RVT1104_0_0_score	:= if(model_environment in [1,2], left.RVT1104_0_0_score	, '');
self.RVT1104_0_0_reason1	:= if(model_environment in [1,2], left.RVT1104_0_0_reason1	, '');
self.RVT1104_0_0_reason2	:= if(model_environment in [1,2], left.RVT1104_0_0_reason2	, '');
self.RVT1104_0_0_reason3	:= if(model_environment in [1,2], left.RVT1104_0_0_reason3	, '');
self.RVT1104_0_0_reason4	:= if(model_environment in [1,2], left.RVT1104_0_0_reason4	, '');

self.RVT1104_1_0_score	:= if(model_environment in [1,2], left.RVT1104_1_0_score	, '');
self.RVT1104_1_0_reason1	:= if(model_environment in [1,2], left.RVT1104_1_0_reason1	, '');
self.RVT1104_1_0_reason2	:= if(model_environment in [1,2], left.RVT1104_1_0_reason2	, '');
self.RVT1104_1_0_reason3	:= if(model_environment in [1,2], left.RVT1104_1_0_reason3	, '');
self.RVT1104_1_0_reason4	:= if(model_environment in [1,2], left.RVT1104_1_0_reason4	, '');

self.RVT1204_1_score	:= if(model_environment in [1,2], left.RVT1204_1_score	, '');
self.RVT1204_1_reason1	:= if(model_environment in [1,2], left.RVT1204_1_reason1	, '');
self.RVT1204_1_reason2	:= if(model_environment in [1,2], left.RVT1204_1_reason2	, '');
self.RVT1204_1_reason3	:= if(model_environment in [1,2], left.RVT1204_1_reason3	, '');
self.RVT1204_1_reason4	:= if(model_environment in [1,2], left.RVT1204_1_reason4	, '');

self.RVT1210_1_0_score	:= if(model_environment in [1,2], left.RVT1210_1_0_score	, '');
self.RVT1210_1_0_reason1	:= if(model_environment in [1,2], left.RVT1210_1_0_reason1	, '');
self.RVT1210_1_0_reason2	:= if(model_environment in [1,2], left.RVT1210_1_0_reason2	, '');
self.RVT1210_1_0_reason3	:= if(model_environment in [1,2], left.RVT1210_1_0_reason3	, '');
self.RVT1210_1_0_reason4	:= if(model_environment in [1,2], left.RVT1210_1_0_reason4	, '');

self.RVT1212_1_0_score	:= if(model_environment in [1,2], left.RVT1212_1_0_score	, '');
self.RVT1212_1_0_reason1	:= if(model_environment in [1,2], left.RVT1212_1_0_reason1	, '');
self.RVT1212_1_0_reason2	:= if(model_environment in [1,2], left.RVT1212_1_0_reason2	, '');
self.RVT1212_1_0_reason3	:= if(model_environment in [1,2], left.RVT1212_1_0_reason3	, '');
self.RVT1212_1_0_reason4	:= if(model_environment in [1,2], left.RVT1212_1_0_reason4	, '');

self.RVT1307_3_0_score	:= if(model_environment in [1,2], left.RVT1307_3_0_score	, '');
self.RVT1307_3_0_reason1	:= if(model_environment in [1,2], left.RVT1307_3_0_reason1	, '');
self.RVT1307_3_0_reason2	:= if(model_environment in [1,2], left.RVT1307_3_0_reason2	, '');
self.RVT1307_3_0_reason3	:= if(model_environment in [1,2], left.RVT1307_3_0_reason3	, '');
self.RVT1307_3_0_reason4	:= if(model_environment in [1,2], left.RVT1307_3_0_reason4	, '');

self.RVT1402_1_0_score	:= if(model_environment in [1,2], left.RVT1402_1_0_score	, '');
self.RVT1402_1_0_reason1	:= if(model_environment in [1,2], left.RVT1402_1_0_reason1	, '');
self.RVT1402_1_0_reason2	:= if(model_environment in [1,2], left.RVT1402_1_0_reason2	, '');
self.RVT1402_1_0_reason3	:= if(model_environment in [1,2], left.RVT1402_1_0_reason3	, '');
self.RVT1402_1_0_reason4	:= if(model_environment in [1,2], left.RVT1402_1_0_reason4	, '');

self.RVT1503_0_0_score	:= if(model_environment in [1,2], left.RVT1503_0_0_score	, '');
self.RVT1503_0_0_reason1	:= if(model_environment in [1,2], left.RVT1503_0_0_reason1	, '');
self.RVT1503_0_0_reason2	:= if(model_environment in [1,2], left.RVT1503_0_0_reason2	, '');
self.RVT1503_0_0_reason3	:= if(model_environment in [1,2], left.RVT1503_0_0_reason3	, '');
self.RVT1503_0_0_reason4	:= if(model_environment in [1,2], left.RVT1503_0_0_reason4	, '');

self.RVT1601_1_0_score	:= if(model_environment in [1,2], left.RVT1601_1_0_score	, '');
self.RVT1601_1_0_reason1	:= if(model_environment in [1,2], left.RVT1601_1_0_reason1	, '');
self.RVT1601_1_0_reason2	:= if(model_environment in [1,2], left.RVT1601_1_0_reason2	, '');
self.RVT1601_1_0_reason3	:= if(model_environment in [1,2], left.RVT1601_1_0_reason3	, '');
self.RVT1601_1_0_reason4	:= if(model_environment in [1,2], left.RVT1601_1_0_reason4	, '');

self.RVT711_1_0_score	:= if(model_environment in [1,2], left.RVT711_1_0_score	, '');
self.RVT711_1_0_reason1	:= if(model_environment in [1,2], left.RVT711_1_0_reason1	, '');
self.RVT711_1_0_reason2	:= if(model_environment in [1,2], left.RVT711_1_0_reason2	, '');
self.RVT711_1_0_reason3	:= if(model_environment in [1,2], left.RVT711_1_0_reason3	, '');
self.RVT711_1_0_reason4	:= if(model_environment in [1,2], left.RVT711_1_0_reason4	, '');

self.RVT1605_1_0_score	:= if(model_environment in [1,2], left.RVT1605_1_0_score	, '');
self.RVT1605_1_0_reason1	:= if(model_environment in [1,2], left.RVT1605_1_0_reason1	, '');
self.RVT1605_1_0_reason2	:= if(model_environment in [1,2], left.RVT1605_1_0_reason2	, '');
self.RVT1605_1_0_reason3	:= if(model_environment in [1,2], left.RVT1605_1_0_reason3	, '');
self.RVT1605_1_0_reason4	:= if(model_environment in [1,2], left.RVT1605_1_0_reason4	, '');

self.RVT1605_2_0_score	:= if(model_environment in [1,2], left.RVT1605_2_0_score	, '');
self.RVT1605_2_0_reason1	:= if(model_environment in [1,2], left.RVT1605_2_0_reason1	, '');
self.RVT1605_2_0_reason2	:= if(model_environment in [1,2], left.RVT1605_2_0_reason2	, '');
self.RVT1605_2_0_reason3	:= if(model_environment in [1,2], left.RVT1605_2_0_reason3	, '');
self.RVT1605_2_0_reason4	:= if(model_environment in [1,2], left.RVT1605_2_0_reason4	, '');

self.RVT1608_1_0_score	:= if(model_environment in [1,2], left.RVT1608_1_0_score	, '');
self.RVT1608_1_0_reason1	:= if(model_environment in [1,2], left.RVT1608_1_0_reason1	, '');
self.RVT1608_1_0_reason2	:= if(model_environment in [1,2], left.RVT1608_1_0_reason2	, '');
self.RVT1608_1_0_reason3	:= if(model_environment in [1,2], left.RVT1608_1_0_reason3	, '');
self.RVT1608_1_0_reason4	:= if(model_environment in [1,2], left.RVT1608_1_0_reason4	, '');
self.RVT1608_1_0_reason5	:= if(model_environment in [1,2], left.RVT1608_1_0_reason5	, '');

self.RVT1608_2_score	  := if(model_environment in [1,2], left.RVT1608_2_score	, '');
self.RVT1608_2_reason1	:= if(model_environment in [1,2], left.RVT1608_2_reason1	, '');
self.RVT1608_2_reason2	:= if(model_environment in [1,2], left.RVT1608_2_reason2	, '');
self.RVT1608_2_reason3	:= if(model_environment in [1,2], left.RVT1608_2_reason3	, '');
self.RVT1608_2_reason4	:= if(model_environment in [1,2], left.RVT1608_2_reason4	, '');
self.RVT1608_2_reason5	:= if(model_environment in [1,2], left.RVT1608_2_reason5	, '');

self.RVT1705_1_0_score	:= if(model_environment in [1,2], left.RVT1705_1_0_score	, '');
self.RVT1705_1_0_reason1	:= if(model_environment in [1,2], left.RVT1705_1_0_reason1	, '');
self.RVT1705_1_0_reason2	:= if(model_environment in [1,2], left.RVT1705_1_0_reason2	, '');
self.RVT1705_1_0_reason3	:= if(model_environment in [1,2], left.RVT1705_1_0_reason3	, '');
self.RVT1705_1_0_reason4	:= if(model_environment in [1,2], left.RVT1705_1_0_reason4	, '');
self.RVT1705_1_0_reason5	:= if(model_environment in [1,2], left.RVT1705_1_0_reason5	, '');

self.TBN509_0_0_score	:= if(model_environment in [1,3], left.TBN509_0_0_score	, '');
self.TBN509_0_0_reason1	:= if(model_environment in [1,3], left.TBN509_0_0_reason1	, '');
self.TBN509_0_0_reason2	:= if(model_environment in [1,3], left.TBN509_0_0_reason2	, '');
self.TBN509_0_0_reason3	:= if(model_environment in [1,3], left.TBN509_0_0_reason3	, '');
self.TBN509_0_0_reason4	:= if(model_environment in [1,3], left.TBN509_0_0_reason4	, '');

self.TBN604_1_0_score	:= if(model_environment in [1,3], left.TBN604_1_0_score	, '');
self.TBN604_1_0_reason1	:= if(model_environment in [1,3], left.TBN604_1_0_reason1	, '');
self.TBN604_1_0_reason2	:= if(model_environment in [1,3], left.TBN604_1_0_reason2	, '');
self.TBN604_1_0_reason3	:= if(model_environment in [1,3], left.TBN604_1_0_reason3	, '');
self.TBN604_1_0_reason4	:= if(model_environment in [1,3], left.TBN604_1_0_reason4	, '');

self.WIN704_0_0_score	:= if(model_environment in [1,2,3], left.WIN704_0_0_score	, 0);

self.WOMV002_0_0_score	:= if(model_environment in [1,2], left.WOMV002_0_0_score	, 0);

self.WWN604_1_0_score	:= if(model_environment in [1,3], left.WWN604_1_0_score	, '');
self.WWN604_1_0_reason1	:= if(model_environment in [1,3], left.WWN604_1_0_reason1	, '');
self.WWN604_1_0_reason2	:= if(model_environment in [1,3], left.WWN604_1_0_reason2	, '');
self.WWN604_1_0_reason3	:= if(model_environment in [1,3], left.WWN604_1_0_reason3	, '');
self.WWN604_1_0_reason4	:= if(model_environment in [1,3], left.WWN604_1_0_reason4	, '');

) );  // end of the project into final


return final;


END;

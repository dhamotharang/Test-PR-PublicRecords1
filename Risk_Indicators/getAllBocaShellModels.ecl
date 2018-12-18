import models, easi, riskwise, _Control;
onThor := _Control.Environment.OnThor;

EXPORT getAllBocaShellModels(grouped dataset(risk_indicators.Layout_Boca_Shell) bsData_pre, 
	boolean isFCRA, 
	dataset(easi.layout_census) easi_census) := function

#IF(onThor)
	bsData := group(sort(distribute(bsData_pre, hash64(seq)), seq, local), seq, local);
#ELSE
	bsData := bsData_pre;
#END

// compile time on roxie is dramatically better without models included.  
// 95% of the time you don't need them included in your test anyway, so just turn them off
// if you do need the model results, you can always get those from the Models.Runway_Service.
#if(_Control.LibraryUse.ForceOff_Bocashell_Models)

	wModels := bsData;
	
#else
// output models if archive run
rvAuto := Models.RVA611_0_0(BSdata, false);// setting isCalifornia to false
rvBank := Models.RVB609_0_0(BSdata, false);// setting isCalifornia to false
rvRetail := Models.RVR611_0_0(BSdata, false);// setting isCalifornia to false
rvTelecom := Models.RVT612_0(BSdata, false);// setting isCalifornia to false

// output riskview version 2 models in archive run for 2.5
rvBank2 := models.RVB711_0_0(group(BSdata), false, false);
rvRetail2 := models.RVR711_0_0(BSdata, false, false);
rvAuto2 := models.RVA711_0_0(BSdata, false);
rvTelecom2 := models.RVT711_0_0(BSdata);

// output riskview MSB score and Prescreen score in archive run for 3.0
rvMoney2 := Models.RVG812_0_0(group(BSdata), false);
rvPrescreen2 := Models.RVP804_0_0(BSdata);

rvBank3 := Models.RVB1003_0_0(BSdata, false, false);
rvRetail3 := Models.RVR1003_0_0(BSdata, false, false);
rvAuto3 := Models.RVA1003_0_0(BSdata, false, false);
rvTelecom3 := Models.RVT1003_0_0(BSdata, false, false);
rvMoney3 := Models.RVG1003_0_0(BSdata, false, false);
rvPrescreen3 := Models.RVP1003_0_0(BSdata, false, false);

rvBank4      := Models.RVB1104_0_0(BSdata, false, false);
rvRetail4    := Models.RVR1103_0_0(BSdata, false, false);
rvAuto4      := Models.RVA1104_0_0(BSdata, false, false);
rvTelecom4   := Models.RVT1104_0_0(BSdata, false, false);
rvMoney4     := Models.RVG1103_0_0(BSdata, false, false);
rvPrescreen4 := Models.RVP1104_0_0(BSdata, false, false);

fd3 := Models.FD3510_0_0(BSdata, false/*OFAC*/, isFCRA, false/*inCalif*/, false, true, false);
fd6 := Models.FD3606_0_0(BSdata, easi_census, false, isFCRA, false, false, false);

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

clam_ip := project( BSdata,
	transform( bs_with_ip,
		self.bs := left,
		self.ip := []
	)
);

fp := Models.FP3710_0_0(ungroup(clam_ip));
fp2 := Models.FP1109_0_0(ungroup(clam_ip), 6, false);	// do we want the criminal reason codes output?
fp3 := Models.FP31505_0_Base(ungroup(clam_ip), 6, false, false);	// false, false = no criminal or FDN reason codes
fp3_FDN := Models.FP3FDN1505_0_Base(ungroup(clam_ip), 6, false);	// false = no criminal reason codes, but we do want FDN reason codes

rvBank5 := models.RVB1503_0_0(bsdata);
rvAuto5 := models.RVA1503_0_0(bsdata);
rvTelecom5 := models.RVT1503_0_0(bsdata);
rvMoney5 := models.RVG1502_0_0(bsdata);
rvCrossInd5 := models.RVS1706_0_2(bsdata); 

Layout_Boca_Shell doModels(Layout_Boca_Shell le, Models.Layout_ModelOut ri, integer i) := transform
	self.rv_scores.auto := if(i=1, ri.score, le.rv_scores.auto);
	self.rv_scores.bankcard := if(i=2, ri.score, le.rv_scores.bankcard);
	self.rv_scores.retail := if(i=3, ri.score, le.rv_scores.retail);
	self.rv_scores.telecom := if(i=4, ri.score, le.rv_scores.telecom);
	self.rv_scores.reason1 := if(i=1, ri.ri[1].hri, le.rv_scores.reason1);
	self.rv_scores.reason2 := if(i=1, ri.ri[2].hri, le.rv_scores.reason2);
	self.rv_scores.reason3 := if(i=1, ri.ri[3].hri, le.rv_scores.reason3);
	self.rv_scores.reason4 := if(i=1, ri.ri[4].hri, le.rv_scores.reason4);
	
	self.rv_scores.bankcardv2 := if(i=5, ri.score, le.rv_scores.bankcardv2);
	self.rv_scores.retailv2 := if(i=6, ri.score, le.rv_scores.retailv2);
	self.rv_scores.autov2 := if(i=7, ri.score, le.rv_scores.autov2);
	self.rv_scores.telecomv2 := if(i=8, ri.score, le.rv_scores.telecomv2);
	self.rv_scores.reason1v2 := if(i=5, ri.ri[1].hri, le.rv_scores.reason1v2);
	self.rv_scores.reason2v2 := if(i=5, ri.ri[2].hri, le.rv_scores.reason2v2);
	self.rv_scores.reason3v2 := if(i=5, ri.ri[3].hri, le.rv_scores.reason3v2);
	self.rv_scores.reason4v2 := if(i=5, ri.ri[4].hri, le.rv_scores.reason4v2);
	
	self.rv_scores.msbv2 := if(i=12, ri.score, le.rv_scores.msbv2);
	self.rv_scores.prescreenv2 := if(i=13, ri.score, le.rv_scores.prescreenv2);
	
	self.rv_scores.bankcardV3 := if(i=14, ri.score, le.rv_scores.bankcardV3);
	self.rv_scores.reason1bV3 := if(i=14, ri.ri[1].hri, le.rv_scores.reason1bV3);
	self.rv_scores.reason2bV3 := if(i=14, ri.ri[2].hri, le.rv_scores.reason2bV3);
	self.rv_scores.reason3bV3 := if(i=14, ri.ri[3].hri, le.rv_scores.reason3bV3);
	self.rv_scores.reason4bV3 := if(i=14, ri.ri[4].hri, le.rv_scores.reason4bV3);
	
	self.rv_scores.retailV3 := if(i=15, ri.score, le.rv_scores.retailV3);
	self.rv_scores.reason1rV3 := if(i=15, ri.ri[1].hri, le.rv_scores.reason1rV3);
	self.rv_scores.reason2rV3 := if(i=15, ri.ri[2].hri, le.rv_scores.reason2rV3);
	self.rv_scores.reason3rV3 := if(i=15, ri.ri[3].hri, le.rv_scores.reason3rV3);
	self.rv_scores.reason4rV3 := if(i=15, ri.ri[4].hri, le.rv_scores.reason4rV3);
	
	self.rv_scores.autoV3 := if(i=16, ri.score, le.rv_scores.autoV3);
	self.rv_scores.reason1aV3 := if(i=16, ri.ri[1].hri, le.rv_scores.reason1aV3);
	self.rv_scores.reason2aV3 := if(i=16, ri.ri[2].hri, le.rv_scores.reason2aV3);
	self.rv_scores.reason3aV3 := if(i=16, ri.ri[3].hri, le.rv_scores.reason3aV3);
	self.rv_scores.reason4aV3 := if(i=16, ri.ri[4].hri, le.rv_scores.reason4aV3);
	
	self.rv_scores.telecomV3 := if(i=17, ri.score, le.rv_scores.telecomV3);
	self.rv_scores.reason1tV3 := if(i=17, ri.ri[1].hri, le.rv_scores.reason1tV3);
	self.rv_scores.reason2tV3 := if(i=17, ri.ri[2].hri, le.rv_scores.reason2tV3);
	self.rv_scores.reason3tV3 := if(i=17, ri.ri[3].hri, le.rv_scores.reason3tV3);
	self.rv_scores.reason4tV3 := if(i=17, ri.ri[4].hri, le.rv_scores.reason4tV3);
	
	self.rv_scores.msbV3 := if(i=18, ri.score, le.rv_scores.msbV3);
	self.rv_scores.reason1mV3 := if(i=18, ri.ri[1].hri, le.rv_scores.reason1mV3);
	self.rv_scores.reason2mV3 := if(i=18, ri.ri[2].hri, le.rv_scores.reason2mV3);
	self.rv_scores.reason3mV3 := if(i=18, ri.ri[3].hri, le.rv_scores.reason3mV3);
	self.rv_scores.reason4mV3 := if(i=18, ri.ri[4].hri, le.rv_scores.reason4mV3);
	
	self.rv_scores.prescreenV3 := if(i=19, ri.score, le.rv_scores.prescreenV3);
	
	// flagship v4
	self.rv_scores.bankcardv4  := if( i=20, ri.score, le.rv_scores.bankcardv4 );
	self.rv_scores.reason1bv4  := if( i=20, ri.ri[1].hri, le.rv_scores.reason1bv4 );
	self.rv_scores.reason2bv4  := if( i=20, ri.ri[2].hri, le.rv_scores.reason2bv4 );
	self.rv_scores.reason3bv4  := if( i=20, ri.ri[3].hri, le.rv_scores.reason3bv4 );
	self.rv_scores.reason4bv4  := if( i=20, ri.ri[4].hri, le.rv_scores.reason4bv4 );
	self.rv_scores.reason5bv4  := if( i=20, ri.ri[5].hri, le.rv_scores.reason5bv4 );
	self.rv_scores.retailv4    := if( i=21, ri.score, le.rv_scores.retailv4 );
	self.rv_scores.reason1rv4  := if( i=21, ri.ri[1].hri, le.rv_scores.reason1rv4 );
	self.rv_scores.reason2rv4  := if( i=21, ri.ri[2].hri, le.rv_scores.reason2rv4 );
	self.rv_scores.reason3rv4  := if( i=21, ri.ri[3].hri, le.rv_scores.reason3rv4 );
	self.rv_scores.reason4rv4  := if( i=21, ri.ri[4].hri, le.rv_scores.reason4rv4 );
	self.rv_scores.reason5rv4  := if( i=21, ri.ri[5].hri, le.rv_scores.reason5rv4 );
	self.rv_scores.autov4      := if( i=22, ri.score, le.rv_scores.autov4 );
	self.rv_scores.reason1av4  := if( i=22, ri.ri[1].hri, le.rv_scores.reason1av4 );
	self.rv_scores.reason2av4  := if( i=22, ri.ri[2].hri, le.rv_scores.reason2av4 );
	self.rv_scores.reason3av4  := if( i=22, ri.ri[3].hri, le.rv_scores.reason3av4 );
	self.rv_scores.reason4av4  := if( i=22, ri.ri[4].hri, le.rv_scores.reason4av4 );
	self.rv_scores.reason5av4  := if( i=22, ri.ri[5].hri, le.rv_scores.reason5av4 );
	self.rv_scores.telecomv4   := if( i=23, ri.score, le.rv_scores.telecomv4 );
	self.rv_scores.reason1tv4  := if( i=23, ri.ri[1].hri, le.rv_scores.reason1tv4 );
	self.rv_scores.reason2tv4  := if( i=23, ri.ri[2].hri, le.rv_scores.reason2tv4 );
	self.rv_scores.reason3tv4  := if( i=23, ri.ri[3].hri, le.rv_scores.reason3tv4 );
	self.rv_scores.reason4tv4  := if( i=23, ri.ri[4].hri, le.rv_scores.reason4tv4 );
	self.rv_scores.reason5tv4  := if( i=23, ri.ri[5].hri, le.rv_scores.reason5tv4 );
	self.rv_scores.msbv4       := if( i=24, ri.score, le.rv_scores.msbv4 );
	self.rv_scores.reason1mv4  := if( i=24, ri.ri[1].hri, le.rv_scores.reason1mv4 );
	self.rv_scores.reason2mv4  := if( i=24, ri.ri[2].hri, le.rv_scores.reason2mv4 );
	self.rv_scores.reason3mv4  := if( i=24, ri.ri[3].hri, le.rv_scores.reason3mv4 );
	self.rv_scores.reason4mv4  := if( i=24, ri.ri[4].hri, le.rv_scores.reason4mv4 );
	self.rv_scores.reason5mv4  := if( i=24, ri.ri[5].hri, le.rv_scores.reason5mv4 );
	self.rv_scores.prescreenv4 := if( i=25, ri.score, le.rv_scores.prescreenv4 );
	
		//	In the event that the minimum input requirements mentioned in Req 1.2.1 are not met, a Roxie exception should be returned that indicates the minimum input requirements were not met and therefore a valid response was not returned
input_ok := if(( 
							((trim(le.Shell_Input.fname)<>'' and trim(le.Shell_Input.lname)<>'') ) and  	// name check
							(trim(le.Shell_Input.ssn)<>'' or   																																																		// ssn check
								( trim(le.Shell_Input.in_streetAddress)<>'' and 																																													// address check
								(trim(le.Shell_Input.z5)<>'' OR (trim(le.Shell_Input.in_city)<>'' AND trim(le.Shell_Input.in_state)<>'')))												// zip or city/state check
							)
								),
							true,
							false
						);
		

		// flagship v5
	self.rv_scores.bankcardv5  := if( i=26 and input_ok, ri.score, le.rv_scores.bankcardv5 );
	self.rv_scores.reason1bv5  := if( i=26 and input_ok, ri.ri[1].hri, le.rv_scores.reason1bv5 );
	self.rv_scores.reason2bv5  := if( i=26 and input_ok, ri.ri[2].hri, le.rv_scores.reason2bv5 );
	self.rv_scores.reason3bv5  := if( i=26 and input_ok, ri.ri[3].hri, le.rv_scores.reason3bv5 );
	self.rv_scores.reason4bv5  := if( i=26 and input_ok, ri.ri[4].hri, le.rv_scores.reason4bv5 );
	// self.rv_scores.reason5bv5  := if( i=26, ri.ri[5].hri, le.rv_scores.reason5bv5 );  // bankcard doesn't have a 5th reason code since it doesn't use inquiries data
	self.rv_scores.autov5      := if( i=27 and input_ok, ri.score, le.rv_scores.autov5 );
	self.rv_scores.reason1av5  := if( i=27 and input_ok, ri.ri[1].hri, le.rv_scores.reason1av5 );
	self.rv_scores.reason2av5  := if( i=27 and input_ok, ri.ri[2].hri, le.rv_scores.reason2av5 );
	self.rv_scores.reason3av5  := if( i=27 and input_ok, ri.ri[3].hri, le.rv_scores.reason3av5 );
	self.rv_scores.reason4av5  := if( i=27 and input_ok, ri.ri[4].hri, le.rv_scores.reason4av5 );
	self.rv_scores.reason5av5  := if( i=27 and input_ok, ri.ri[5].hri, le.rv_scores.reason5av5 );
	self.rv_scores.telecomv5   := if( i=28 and input_ok, ri.score, le.rv_scores.telecomv5 );
	self.rv_scores.reason1tv5  := if( i=28 and input_ok, ri.ri[1].hri, le.rv_scores.reason1tv5 );
	self.rv_scores.reason2tv5  := if( i=28 and input_ok, ri.ri[2].hri, le.rv_scores.reason2tv5 );
	self.rv_scores.reason3tv5  := if( i=28 and input_ok, ri.ri[3].hri, le.rv_scores.reason3tv5 );
	self.rv_scores.reason4tv5  := if( i=28 and input_ok, ri.ri[4].hri, le.rv_scores.reason4tv5 );
	self.rv_scores.reason5tv5  := if( i=28 and input_ok, ri.ri[5].hri, le.rv_scores.reason5tv5 );
	self.rv_scores.msbv5       := if( i=29 and input_ok, ri.score, le.rv_scores.msbv5 );
	self.rv_scores.reason1mv5  := if( i=29 and input_ok, ri.ri[1].hri, le.rv_scores.reason1mv5 );
	self.rv_scores.reason2mv5  := if( i=29 and input_ok, ri.ri[2].hri, le.rv_scores.reason2mv5 );
	self.rv_scores.reason3mv5  := if( i=29 and input_ok, ri.ri[3].hri, le.rv_scores.reason3mv5 );
	self.rv_scores.reason4mv5  := if( i=29 and input_ok, ri.ri[4].hri, le.rv_scores.reason4mv5 );
	self.rv_scores.reason5mv5  := if( i=29 and input_ok, ri.ri[5].hri, le.rv_scores.reason5mv5 );
	self.rv_scores.crossindv5  := if( i=30 and input_ok, ri.score, le.rv_scores.crossindv5 );
	self.rv_scores.reason1cv5  := if( i=30 and input_ok, ri.ri[1].hri, le.rv_scores.reason1cv5 );
	self.rv_scores.reason2cv5  := if( i=30 and input_ok, ri.ri[2].hri, le.rv_scores.reason2cv5 );
	self.rv_scores.reason3cv5  := if( i=30 and input_ok, ri.ri[3].hri, le.rv_scores.reason3cv5 );
	self.rv_scores.reason4cv5  := if( i=30 and input_ok, ri.ri[4].hri, le.rv_scores.reason4cv5 );
	self.rv_scores.reason5cv5  := if( i=30 and input_ok, ri.ri[5].hri, le.rv_scores.reason5cv5 );
	
	self.fd_scores.fd3 := if(i=9, ri.score, le.fd_scores.fd3);
	self.fd_scores.fd6 := if(i=10, ri.score, le.fd_scores.fd6);
	self.fd_scores.reason1 := if(i=9, ri.ri[1].hri, le.fd_scores.reason1);
	self.fd_scores.reason2 := if(i=9, ri.ri[2].hri, le.fd_scores.reason2);
	self.fd_scores.reason3 := if(i=9, ri.ri[3].hri, le.fd_scores.reason3);
	self.fd_scores.reason4 := if(i=9, ri.ri[4].hri, le.fd_scores.reason4);
	
	self.fd_scores.fraudpoint := if(i=11, ri.score, le.fd_scores.fraudpoint);
	self.fd_scores.reason1fp := if(i=11, ri.ri[1].hri, le.fd_scores.reason1fp);
	self.fd_scores.reason2fp := if(i=11, ri.ri[2].hri, le.fd_scores.reason2fp);
	self.fd_scores.reason3fp := if(i=11, ri.ri[3].hri, le.fd_scores.reason3fp);
	self.fd_scores.reason4fp := if(i=11, ri.ri[4].hri, le.fd_scores.reason4fp);
	self.fd_scores.reason5fp := if(i=11, ri.ri[5].hri, le.fd_scores.reason5fp);
	self.fd_scores.reason6fp := if(i=11, ri.ri[6].hri, le.fd_scores.reason6fp);
	
	
	
	
	self := le;
end;

#IF(onThor)
	wAuto := join(BSdata, distribute(rvAuto, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,1), left outer, local);
#ELSE
	wAuto := join(BSdata, rvAuto, left.seq=right.seq, doModels(LEFT,RIGHT,1), left outer);
#END
#IF(onThor)
	wBank := join(wAuto, distribute(rvBank, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,2), left outer, local);
#ELSE
	wBank := join(wAuto, rvBank, left.seq=right.seq, doModels(LEFT,RIGHT,2), left outer);
#END
#IF(onThor)
	wRetail := join(wBank, distribute(rvRetail, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,3), left outer, local);
#ELSE
	wRetail := join(wBank, rvRetail, left.seq=right.seq, doModels(LEFT,RIGHT,3), left outer);
#END
#IF(onThor)
	wTelecom := join(wRetail, distribute(rvTelecom, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,4), left outer, local);
#ELSE
	wTelecom := join(wRetail, rvTelecom, left.seq=right.seq, doModels(LEFT,RIGHT,4), left outer);
#END
#IF(onThor)
	wBank2 := join(wTelecom, distribute(rvBank2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,5), left outer, local);
#ELSE
	wBank2 := join(wTelecom, rvBank2, left.seq=right.seq, doModels(LEFT,RIGHT,5), left outer);
#END

#IF(onThor)
	wRetail2 := join(wBank2, distribute(rvRetail2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,6), left outer, local);
#ELSE
	wRetail2 := join(wBank2, rvRetail2, left.seq=right.seq, doModels(LEFT,RIGHT,6), left outer);
#END

#IF(onThor)
	wAuto2 := join(wRetail2, distribute(rvAuto2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,7), left outer, local);
#ELSE
	wAuto2 := join(wRetail2, rvAuto2, left.seq=right.seq, doModels(LEFT,RIGHT,7), left outer);
#END
#IF(onThor)
	wTelecom2 := join(wAuto2, distribute(rvTelecom2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,8), left outer, local);
#ELSE
	wTelecom2 := join(wAuto2, rvTelecom2, left.seq=right.seq, doModels(LEFT,RIGHT,8), left outer);
#END
#IF(onThor)
	wMoney2 := join(wTelecom2, distribute(rvMoney2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,12), left outer, local);
#ELSE
	wMoney2 := join(wTelecom2, rvMoney2, left.seq=right.seq, doModels(LEFT,RIGHT,12), left outer);
#END
#IF(onThor)
	wPrescreen2 := join(wMoney2, distribute(rvPrescreen2, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,13), left outer, local);
#ELSE
	wPrescreen2 := join(wMoney2, rvPrescreen2, left.seq=right.seq, doModels(LEFT,RIGHT,13), left outer);
#END
#IF(onThor)
	wBank3 := join(wPrescreen2, distribute(rvBank3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,14), left outer, local);
#ELSE
	wBank3 := join(wPrescreen2, rvBank3, left.seq=right.seq, doModels(LEFT,RIGHT,14), left outer);
#END
#IF(onThor)
	wRetail3 := join(wBank3, distribute(rvRetail3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,15), left outer, local);
#ELSE
	wRetail3 := join(wBank3, rvRetail3, left.seq=right.seq, doModels(LEFT,RIGHT,15), left outer);
#END
#IF(onThor)
	wAuto3 := join(wRetail3, distribute(rvAuto3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,16), left outer, local);
#ELSE
	wAuto3 := join(wRetail3, rvAuto3, left.seq=right.seq, doModels(LEFT,RIGHT,16), left outer);
#END
#IF(onThor)
	wTelecom3 := join(wAuto3, distribute(rvTelecom3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,17), left outer, local);
#ELSE
	wTelecom3 := join(wAuto3, rvTelecom3, left.seq=right.seq, doModels(LEFT,RIGHT,17), left outer);
#END
#IF(onThor)
	wMoney3 := join(wTelecom3, distribute(rvMoney3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,18), left outer, local);
#ELSE
	wMoney3 := join(wTelecom3, rvMoney3, left.seq=right.seq, doModels(LEFT,RIGHT,18), left outer);
#END
#IF(onThor)
	wPrescreen3 := join(wMoney3, distribute(rvPrescreen3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,19), left outer, local);
#ELSE
	wPrescreen3 := join(wMoney3, rvPrescreen3, left.seq=right.seq, doModels(LEFT,RIGHT,19), left outer);
#END

#IF(onThor)
	wBank4 := join(wPrescreen3, distribute(rvBank4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,20), left outer, local);
#ELSE
	wBank4 := join(wPrescreen3, rvBank4, left.seq=right.seq, doModels(LEFT,RIGHT,20), left outer);
#END
#IF(onThor)
	wRetail4 := join(wBank4, distribute(rvRetail4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,21), left outer, local);
#ELSE
	wRetail4 := join(wBank4, rvRetail4, left.seq=right.seq, doModels(LEFT,RIGHT,21), left outer);
#END
#IF(onThor)
	wAuto4 := join(wRetail4, distribute(rvAuto4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,22), left outer, local);
#ELSE
	wAuto4 := join(wRetail4, rvAuto4, left.seq=right.seq, doModels(LEFT,RIGHT,22), left outer);
#END
#IF(onThor)
	wTelecom4 := join(wAuto4, distribute(rvTelecom4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,23), left outer, local);
#ELSE
	wTelecom4 := join(wAuto4, rvTelecom4, left.seq=right.seq, doModels(LEFT,RIGHT,23), left outer);
#END
#IF(onThor)
	wMoney4 := join(wTelecom4, distribute(rvMoney4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,24), left outer, local);
#ELSE
	wMoney4 := join(wTelecom4, rvMoney4, left.seq=right.seq, doModels(LEFT,RIGHT,24), left outer);
#END
#IF(onThor)
	wPrescreen4 := join(wMoney4, distribute(rvPrescreen4, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,25), left outer, local);
#ELSE
	wPrescreen4 := join(wMoney4, rvPrescreen4, left.seq=right.seq, doModels(LEFT,RIGHT,25), left outer);
#END
#IF(onThor)
	wBank5 := join(wPrescreen4, distribute(rvBank5, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,26), left outer, local);
#ELSE
	wBank5 := join(wPrescreen4, rvBank5, left.seq=right.seq, doModels(LEFT,RIGHT,26), left outer);
#END
#IF(onThor)
	wAuto5 := join(wBank5, distribute(rvAuto5, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,27), left outer, local);
#ELSE
	wAuto5 := join(wBank5, rvAuto5, left.seq=right.seq, doModels(LEFT,RIGHT,27), left outer);
#END
#IF(onThor)
	wTelecom5 := join(wAuto5, distribute(rvTelecom5, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,28), left outer, local);
#ELSE
	wTelecom5 := join(wAuto5, rvTelecom5, left.seq=right.seq, doModels(LEFT,RIGHT,28), left outer);
#END
#IF(onThor)
	wMoney5 := join(wTelecom5, distribute(rvMoney5, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,29), left outer, local);
#ELSE
	wMoney5 := join(wTelecom5, rvMoney5, left.seq=right.seq, doModels(LEFT,RIGHT,29), left outer);
#END
#IF(onThor)
	wCrossInd5 := join(wMoney5, distribute(rvCrossInd5, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,30), left outer, local);
#ELSE
	wCrossInd5 := join(wMoney5, rvCrossInd5, left.seq=right.seq, doModels(LEFT,RIGHT,30), left outer);
#END

// FRAUD MODELS
#IF(onThor)
	wFD3 := join(BSdata, distribute(fd3, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,9), left outer, local);
#ELSE
	wFD3 := join(BSdata, fd3, left.seq=right.seq, doModels(LEFT,RIGHT,9), left outer);
#END
#IF(onThor)
	wFD6 := join(wFD3, distribute(fd6, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,10), left outer, local);
#ELSE
	wFD6 := join(wFD3, fd6, left.seq=right.seq, doModels(LEFT,RIGHT,10), left outer);
#END
#IF(onThor)
	wFP := join(wFD6, distribute(fp, hash64(seq)), left.seq=right.seq, doModels(LEFT,RIGHT,11), left outer, local);
#ELSE
	wFP := join(wFD6, fp, left.seq=right.seq, doModels(LEFT,RIGHT,11), left outer);
#END

// need a special join for FP1109_0 because the layout is different (it has indices)
Layout_Boca_Shell doFP1109Model(Layout_Boca_Shell le, models.layouts.layout_fp1109 ri) := transform
	self.fd_scores.fraudpointV2 := ri.score;
	self.fd_scores.StolenIdentityIndex := ri.StolenIdentityIndex;
	self.fd_scores.SyntheticIdentityIndex := ri.SyntheticIdentityIndex;
	self.fd_scores.ManipulatedIdentityIndex := ri.ManipulatedIdentityIndex;
	self.fd_scores.VulnerableVictimIndex := ri.VulnerableVictimIndex;
	self.fd_scores.FriendlyFraudIndex := ri.FriendlyFraudIndex;
	self.fd_scores.SuspiciousActivityIndex := ri.SuspiciousActivityIndex;
	self.fd_scores.reason1FPV2 := ri.ri[1].hri;
	self.fd_scores.reason2FPV2 := ri.ri[2].hri;
	self.fd_scores.reason3FPV2 := ri.ri[3].hri;
	self.fd_scores.reason4FPV2 := ri.ri[4].hri;
	self.fd_scores.reason5FPV2 := ri.ri[5].hri;
	self.fd_scores.reason6FPV2 := ri.ri[6].hri;
	
	self := le;
end;

#IF(onThor)
	wFP2 := join(wFP, distribute(fp2, hash64(seq)), left.seq=right.seq, doFP1109Model(LEFT,RIGHT), left outer, local);
#ELSE
	wFP2 := join(wFP, fp2, left.seq=right.seq, doFP1109Model(LEFT,RIGHT), left outer);
#END



// new Flagship models for Fraudpoint 3 - same output as FP1109
Layout_Boca_Shell doFP31505Model(Layout_Boca_Shell le, models.layouts.layout_fp1109 ri) := transform
//RQ-14827 FP 3 & FP 3 FDN min input to match FP XML service																					
input_fp3_ok := Risk_Indicators.iid_constants.FP3_FDN_Min_Input(le.Shell_Input.fname, le.Shell_Input.lname, le.Shell_Input.ssn, le.Shell_Input.in_streetAddress, le.Shell_Input.z5);																																					
																							
	self.fd_scores.fraudpoint_V3 := if(input_fp3_ok, ri.score, le.fd_scores.fraudpoint_V3 );
	self.fd_scores.StolenIdentityIndex_V3 := if(  input_fp3_ok, ri.StolenIdentityIndex, le.fd_scores.StolenIdentityIndex_V3 );
	self.fd_scores.SyntheticIdentityIndex_V3 := if(  input_fp3_ok, ri.SyntheticIdentityIndex, le.fd_scores.SyntheticIdentityIndex_V3 );
	self.fd_scores.ManipulatedIdentityIndex_V3 := if(  input_fp3_ok, ri.ManipulatedIdentityIndex, le.fd_scores.ManipulatedIdentityIndex_V3 );
	self.fd_scores.VulnerableVictimIndex_V3 := if(  input_fp3_ok, ri.VulnerableVictimIndex, le.fd_scores.VulnerableVictimIndex_V3 );
	self.fd_scores.FriendlyFraudIndex_V3 := if(  input_fp3_ok, ri.FriendlyFraudIndex, le.fd_scores.FriendlyFraudIndex_V3 );
	self.fd_scores.SuspiciousActivityIndex_V3 := if(  input_fp3_ok, ri.SuspiciousActivityIndex, le.fd_scores.SuspiciousActivityIndex_V3 );
	self.fd_scores.reason1FP_V3 := if(  input_fp3_ok, ri.ri[1].hri, le.fd_scores.reason1FP_V3 );
	self.fd_scores.reason2FP_V3 := if(  input_fp3_ok, ri.ri[2].hri, le.fd_scores.reason2FP_V3 );
	self.fd_scores.reason3FP_V3 := if(  input_fp3_ok, ri.ri[3].hri, le.fd_scores.reason3FP_V3 );
	self.fd_scores.reason4FP_V3 := if(  input_fp3_ok, ri.ri[4].hri, le.fd_scores.reason4FP_V3 );
	self.fd_scores.reason5FP_V3 := if(  input_fp3_ok, ri.ri[5].hri, le.fd_scores.reason5FP_V3 );
	self.fd_scores.reason6FP_V3 := if(  input_fp3_ok, ri.ri[6].hri, le.fd_scores.reason6FP_V3 );
	self := le;
end;

#IF(onThor)
	wFP3 := join(wFP2, distribute(fp3, hash64(seq)), left.seq=right.seq, doFP31505Model(LEFT,RIGHT), left outer, local);
#ELSE
	wFP3 := join(wFP2, fp3, left.seq=right.seq, doFP31505Model(LEFT,RIGHT), left outer);
#END

Layout_Boca_Shell doFP3FDN1505Model(Layout_Boca_Shell le, models.layouts.layout_fp1109 ri) := transform
//RQ-14827 FP 3 & FP 3 FDN min input to match FP XML service			
input_fp3_FDN_ok := Risk_Indicators.iid_constants.FP3_FDN_Min_Input(le.Shell_Input.fname, le.Shell_Input.lname, le.Shell_Input.ssn, le.Shell_Input.in_streetAddress, le.Shell_Input.z5);																			

	self.fd_scores.fraudpoint_V3_FDN := if(input_fp3_FDN_ok, ri.score, le.fd_scores.fraudpoint_V3_FDN );
	self.fd_scores.StolenIdentityIndex_V3_FDN := if(input_fp3_FDN_ok, ri.StolenIdentityIndex, le.fd_scores.StolenIdentityIndex_V3_FDN );
	self.fd_scores.SyntheticIdentityIndex_V3_FDN := if(input_fp3_FDN_ok, ri.SyntheticIdentityIndex, le.fd_scores.SyntheticIdentityIndex_V3_FDN );
	self.fd_scores.ManipulatedIdentityIndex_V3_FDN := if(input_fp3_FDN_ok, ri.ManipulatedIdentityIndex, le.fd_scores.ManipulatedIdentityIndex_V3_FDN );
	self.fd_scores.VulnerableVictimIndex_V3_FDN := if(input_fp3_FDN_ok, ri.VulnerableVictimIndex, le.fd_scores.VulnerableVictimIndex_V3_FDN );
	self.fd_scores.FriendlyFraudIndex_V3_FDN := if(input_fp3_FDN_ok, ri.FriendlyFraudIndex, le.fd_scores.FriendlyFraudIndex_V3_FDN );
	self.fd_scores.SuspiciousActivityIndex_V3_FDN := if(input_fp3_FDN_ok, ri.SuspiciousActivityIndex, le.fd_scores.SuspiciousActivityIndex_V3_FDN );
	self.fd_scores.reason1FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[1].hri, le.fd_scores.reason1FP_V3_FDN );
	self.fd_scores.reason2FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[2].hri, le.fd_scores.reason2FP_V3_FDN );
	self.fd_scores.reason3FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[3].hri, le.fd_scores.reason3FP_V3_FDN );
	self.fd_scores.reason4FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[4].hri, le.fd_scores.reason4FP_V3_FDN );
	self.fd_scores.reason5FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[5].hri, le.fd_scores.reason5FP_V3_FDN );
	self.fd_scores.reason6FP_V3_FDN := if(input_fp3_FDN_ok, ri.ri[6].hri, le.fd_scores.reason6FP_V3_FDN );	
	self := le;
end;

#IF(onThor)
	wFP3_FDN := join(wFP3, distribute(fp3_FDN, hash64(seq)), left.seq=right.seq, doFP3FDN1505Model(LEFT,RIGHT), left outer, local);
#ELSE
	wFP3_FDN := join(wFP3, fp3_FDN, left.seq=right.seq, doFP3FDN1505Model(LEFT,RIGHT), left outer);
#END

wModels1 := if(isFCRA, wCrossInd5, wFP3_FDN);



// blank out the reason codes from all models if they are 00 or 000
wModels := project(wModels1, transform(layout_boca_shell, 

self.rv_scores.reason1	:= if(left.rv_scores.reason1	in ['00', '000'], '', left.rv_scores.reason1	);
self.rv_scores.reason2	:= if(left.rv_scores.reason2	in ['00', '000'], '', left.rv_scores.reason2	);
self.rv_scores.reason3	:= if(left.rv_scores.reason3	in ['00', '000'], '', left.rv_scores.reason3	);
self.rv_scores.reason4	:= if(left.rv_scores.reason4	in ['00', '000'], '', left.rv_scores.reason4	);
self.rv_scores.reason1V2	:= if(left.rv_scores.reason1V2	in ['00', '000'], '', left.rv_scores.reason1V2	);
self.rv_scores.reason2V2	:= if(left.rv_scores.reason2V2	in ['00', '000'], '', left.rv_scores.reason2V2	);
self.rv_scores.reason3V2	:= if(left.rv_scores.reason3V2	in ['00', '000'], '', left.rv_scores.reason3V2	);
self.rv_scores.reason4V2	:= if(left.rv_scores.reason4V2	in ['00', '000'], '', left.rv_scores.reason4V2	);
self.rv_scores.reason1bV3	:= if(left.rv_scores.reason1bV3	in ['00', '000'], '', left.rv_scores.reason1bV3	);
self.rv_scores.reason2bV3	:= if(left.rv_scores.reason2bV3	in ['00', '000'], '', left.rv_scores.reason2bV3	);
self.rv_scores.reason3bV3	:= if(left.rv_scores.reason3bV3	in ['00', '000'], '', left.rv_scores.reason3bV3	);
self.rv_scores.reason4bV3	:= if(left.rv_scores.reason4bV3	in ['00', '000'], '', left.rv_scores.reason4bV3	);
self.rv_scores.reason1rV3	:= if(left.rv_scores.reason1rV3	in ['00', '000'], '', left.rv_scores.reason1rV3	);
self.rv_scores.reason2rV3	:= if(left.rv_scores.reason2rV3	in ['00', '000'], '', left.rv_scores.reason2rV3	);
self.rv_scores.reason3rV3	:= if(left.rv_scores.reason3rV3	in ['00', '000'], '', left.rv_scores.reason3rV3	);
self.rv_scores.reason4rV3	:= if(left.rv_scores.reason4rV3	in ['00', '000'], '', left.rv_scores.reason4rV3	);
self.rv_scores.reason1aV3	:= if(left.rv_scores.reason1aV3	in ['00', '000'], '', left.rv_scores.reason1aV3	);
self.rv_scores.reason2aV3	:= if(left.rv_scores.reason2aV3	in ['00', '000'], '', left.rv_scores.reason2aV3	);
self.rv_scores.reason3aV3	:= if(left.rv_scores.reason3aV3	in ['00', '000'], '', left.rv_scores.reason3aV3	);
self.rv_scores.reason4aV3	:= if(left.rv_scores.reason4aV3	in ['00', '000'], '', left.rv_scores.reason4aV3	);
self.rv_scores.reason1tV3	:= if(left.rv_scores.reason1tV3	in ['00', '000'], '', left.rv_scores.reason1tV3	);
self.rv_scores.reason2tV3	:= if(left.rv_scores.reason2tV3	in ['00', '000'], '', left.rv_scores.reason2tV3	);
self.rv_scores.reason3tV3	:= if(left.rv_scores.reason3tV3	in ['00', '000'], '', left.rv_scores.reason3tV3	);
self.rv_scores.reason4tV3	:= if(left.rv_scores.reason4tV3	in ['00', '000'], '', left.rv_scores.reason4tV3	);
self.rv_scores.reason1mV3	:= if(left.rv_scores.reason1mV3	in ['00', '000'], '', left.rv_scores.reason1mV3	);
self.rv_scores.reason2mV3	:= if(left.rv_scores.reason2mV3	in ['00', '000'], '', left.rv_scores.reason2mV3	);
self.rv_scores.reason3mV3	:= if(left.rv_scores.reason3mV3	in ['00', '000'], '', left.rv_scores.reason3mV3	);
self.rv_scores.reason4mV3	:= if(left.rv_scores.reason4mV3	in ['00', '000'], '', left.rv_scores.reason4mV3	);
self.rv_scores.reason1bV4	:= if(left.rv_scores.reason1bV4	in ['00', '000'], '', left.rv_scores.reason1bV4	);
self.rv_scores.reason2bV4	:= if(left.rv_scores.reason2bV4	in ['00', '000'], '', left.rv_scores.reason2bV4	);
self.rv_scores.reason3bV4	:= if(left.rv_scores.reason3bV4	in ['00', '000'], '', left.rv_scores.reason3bV4	);
self.rv_scores.reason4bV4	:= if(left.rv_scores.reason4bV4	in ['00', '000'], '', left.rv_scores.reason4bV4	);
self.rv_scores.reason5bV4	:= if(left.rv_scores.reason5bV4	in ['00', '000'], '', left.rv_scores.reason5bV4	);
self.rv_scores.reason1rV4	:= if(left.rv_scores.reason1rV4	in ['00', '000'], '', left.rv_scores.reason1rV4	);
self.rv_scores.reason2rV4	:= if(left.rv_scores.reason2rV4	in ['00', '000'], '', left.rv_scores.reason2rV4	);
self.rv_scores.reason3rV4	:= if(left.rv_scores.reason3rV4	in ['00', '000'], '', left.rv_scores.reason3rV4	);
self.rv_scores.reason4rV4	:= if(left.rv_scores.reason4rV4	in ['00', '000'], '', left.rv_scores.reason4rV4	);
self.rv_scores.reason5rV4	:= if(left.rv_scores.reason5rV4	in ['00', '000'], '', left.rv_scores.reason5rV4	);
self.rv_scores.reason1aV4	:= if(left.rv_scores.reason1aV4	in ['00', '000'], '', left.rv_scores.reason1aV4	);
self.rv_scores.reason2aV4	:= if(left.rv_scores.reason2aV4	in ['00', '000'], '', left.rv_scores.reason2aV4	);
self.rv_scores.reason3aV4	:= if(left.rv_scores.reason3aV4	in ['00', '000'], '', left.rv_scores.reason3aV4	);
self.rv_scores.reason4aV4	:= if(left.rv_scores.reason4aV4	in ['00', '000'], '', left.rv_scores.reason4aV4	);
self.rv_scores.reason5aV4	:= if(left.rv_scores.reason5aV4	in ['00', '000'], '', left.rv_scores.reason5aV4	);
self.rv_scores.reason1tV4	:= if(left.rv_scores.reason1tV4	in ['00', '000'], '', left.rv_scores.reason1tV4	);
self.rv_scores.reason2tV4	:= if(left.rv_scores.reason2tV4	in ['00', '000'], '', left.rv_scores.reason2tV4	);
self.rv_scores.reason3tV4	:= if(left.rv_scores.reason3tV4	in ['00', '000'], '', left.rv_scores.reason3tV4	);
self.rv_scores.reason4tV4	:= if(left.rv_scores.reason4tV4	in ['00', '000'], '', left.rv_scores.reason4tV4	);
self.rv_scores.reason5tV4	:= if(left.rv_scores.reason5tV4	in ['00', '000'], '', left.rv_scores.reason5tV4	);
self.rv_scores.reason1mV4	:= if(left.rv_scores.reason1mV4	in ['00', '000'], '', left.rv_scores.reason1mV4	);
self.rv_scores.reason2mV4	:= if(left.rv_scores.reason2mV4	in ['00', '000'], '', left.rv_scores.reason2mV4	);
self.rv_scores.reason3mV4	:= if(left.rv_scores.reason3mV4	in ['00', '000'], '', left.rv_scores.reason3mV4	);
self.rv_scores.reason4mV4	:= if(left.rv_scores.reason4mV4	in ['00', '000'], '', left.rv_scores.reason4mV4	);
self.rv_scores.reason5mV4	:= if(left.rv_scores.reason5mV4	in ['00', '000'], '', left.rv_scores.reason5mV4	);
self.rv_scores.reason1bv5	:= if(left.rv_scores.reason1bv5 in ['00', '000'], '', left.rv_scores.reason1bv5	);
self.rv_scores.reason2bv5	:= if(left.rv_scores.reason2bv5	in ['00', '000'], '', left.rv_scores.reason2bv5	);
self.rv_scores.reason3bv5	:= if(left.rv_scores.reason3bv5	in ['00', '000'], '', left.rv_scores.reason3bv5	);
self.rv_scores.reason4bv5	:= if(left.rv_scores.reason4bv5	in ['00', '000'], '', left.rv_scores.reason4bv5	);
self.rv_scores.reason1av5	:= if(left.rv_scores.reason1av5	in ['00', '000'], '', left.rv_scores.reason1av5	);
self.rv_scores.reason2av5	:= if(left.rv_scores.reason2av5	in ['00', '000'], '', left.rv_scores.reason2av5	);
self.rv_scores.reason3av5	:= if(left.rv_scores.reason3av5	in ['00', '000'], '', left.rv_scores.reason3av5	);
self.rv_scores.reason4av5	:= if(left.rv_scores.reason4av5	in ['00', '000'], '', left.rv_scores.reason4av5	);
self.rv_scores.reason5av5	:= if(left.rv_scores.reason5av5	in ['00', '000'], '', left.rv_scores.reason5av5	);
self.rv_scores.reason1tv5	:= if(left.rv_scores.reason1tv5	in ['00', '000'], '', left.rv_scores.reason1tv5	);
self.rv_scores.reason2tv5	:= if(left.rv_scores.reason2tv5	in ['00', '000'], '', left.rv_scores.reason2tv5	);
self.rv_scores.reason3tv5	:= if(left.rv_scores.reason3tv5	in ['00', '000'], '', left.rv_scores.reason3tv5	);
self.rv_scores.reason4tv5	:= if(left.rv_scores.reason4tv5	in ['00', '000'], '', left.rv_scores.reason4tv5	);
self.rv_scores.reason5tv5	:= if(left.rv_scores.reason5tv5	in ['00', '000'], '', left.rv_scores.reason5tv5	);
self.rv_scores.reason1mv5	:= if(left.rv_scores.reason1mv5	in ['00', '000'], '', left.rv_scores.reason1mv5	);
self.rv_scores.reason2mv5	:= if(left.rv_scores.reason2mv5	in ['00', '000'], '', left.rv_scores.reason2mv5	);
self.rv_scores.reason3mv5	:= if(left.rv_scores.reason3mv5	in ['00', '000'], '', left.rv_scores.reason3mv5	);
self.rv_scores.reason4mv5	:= if(left.rv_scores.reason4mv5	in ['00', '000'], '', left.rv_scores.reason4mv5	);
self.rv_scores.reason5mv5	:= if(left.rv_scores.reason5mv5	in ['00', '000'], '', left.rv_scores.reason5mv5	);
self.rv_scores.reason1cv5	:= if(left.rv_scores.reason1cv5	in ['00', '000'], '', left.rv_scores.reason1cv5	);
self.rv_scores.reason2cv5	:= if(left.rv_scores.reason2cv5	in ['00', '000'], '', left.rv_scores.reason2cv5	);
self.rv_scores.reason3cv5	:= if(left.rv_scores.reason3cv5	in ['00', '000'], '', left.rv_scores.reason3cv5	);
self.rv_scores.reason4cv5	:= if(left.rv_scores.reason4cv5	in ['00', '000'], '', left.rv_scores.reason4cv5	);
self.rv_scores.reason5cv5	:= if(left.rv_scores.reason5cv5	in ['00', '000'], '', left.rv_scores.reason5cv5	);

self.fd_scores.reason1	:= if(left.fd_scores.reason1	in ['00', '000'], '', left.fd_scores.reason1	);
self.fd_scores.reason2	:= if(left.fd_scores.reason2	in ['00', '000'], '', left.fd_scores.reason2	);
self.fd_scores.reason3	:= if(left.fd_scores.reason3	in ['00', '000'], '', left.fd_scores.reason3	);
self.fd_scores.reason4	:= if(left.fd_scores.reason4	in ['00', '000'], '', left.fd_scores.reason4	);
self.fd_scores.reason1FP	:= if(left.fd_scores.reason1FP	in ['00', '000'], '', left.fd_scores.reason1FP	);
self.fd_scores.reason2FP	:= if(left.fd_scores.reason2FP	in ['00', '000'], '', left.fd_scores.reason2FP	);
self.fd_scores.reason3FP	:= if(left.fd_scores.reason3FP	in ['00', '000'], '', left.fd_scores.reason3FP	);
self.fd_scores.reason4FP	:= if(left.fd_scores.reason4FP	in ['00', '000'], '', left.fd_scores.reason4FP	);
self.fd_scores.reason5FP	:= if(left.fd_scores.reason5FP	in ['00', '000'], '', left.fd_scores.reason5FP	);
self.fd_scores.reason6FP	:= if(left.fd_scores.reason6FP	in ['00', '000'], '', left.fd_scores.reason6FP	);
self.fd_scores.reason1FPV2	:= if(left.fd_scores.reason1FPV2	in ['00', '000'], '', left.fd_scores.reason1FPV2	);
self.fd_scores.reason2FPV2	:= if(left.fd_scores.reason2FPV2	in ['00', '000'], '', left.fd_scores.reason2FPV2	);
self.fd_scores.reason3FPV2	:= if(left.fd_scores.reason3FPV2	in ['00', '000'], '', left.fd_scores.reason3FPV2	);
self.fd_scores.reason4FPV2	:= if(left.fd_scores.reason4FPV2	in ['00', '000'], '', left.fd_scores.reason4FPV2	);
self.fd_scores.reason5FPV2	:= if(left.fd_scores.reason5FPV2	in ['00', '000'], '', left.fd_scores.reason5FPV2	);
self.fd_scores.reason6FPV2	:= if(left.fd_scores.reason6FPV2	in ['00', '000'], '', left.fd_scores.reason6FPV2	);
self.fd_scores.reason1FP_V3	:= if(left.fd_scores.reason1FP_V3	in ['00', '000'], '', left.fd_scores.reason1FP_V3	);
self.fd_scores.reason2FP_V3	:= if(left.fd_scores.reason2FP_V3	in ['00', '000'], '', left.fd_scores.reason2FP_V3	);
self.fd_scores.reason3FP_V3	:= if(left.fd_scores.reason3FP_V3	in ['00', '000'], '', left.fd_scores.reason3FP_V3	);
self.fd_scores.reason4FP_V3	:= if(left.fd_scores.reason4FP_V3	in ['00', '000'], '', left.fd_scores.reason4FP_V3	);
self.fd_scores.reason5FP_V3	:= if(left.fd_scores.reason5FP_V3	in ['00', '000'], '', left.fd_scores.reason5FP_V3	);
self.fd_scores.reason6FP_V3	:= if(left.fd_scores.reason6FP_V3	in ['00', '000'], '', left.fd_scores.reason6FP_V3	);
self.fd_scores.reason1FP_V3_fdn	:= if(left.fd_scores.reason1FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason1FP_V3_fdn	);
self.fd_scores.reason2FP_V3_fdn	:= if(left.fd_scores.reason2FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason2FP_V3_fdn	);
self.fd_scores.reason3FP_V3_fdn	:= if(left.fd_scores.reason3FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason3FP_V3_fdn	);
self.fd_scores.reason4FP_V3_fdn	:= if(left.fd_scores.reason4FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason4FP_V3_fdn	);
self.fd_scores.reason5FP_V3_fdn	:= if(left.fd_scores.reason5FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason5FP_V3_fdn	);
self.fd_scores.reason6FP_V3_fdn	:= if(left.fd_scores.reason6FP_V3_fdn	in ['00', '000'], '', left.fd_scores.reason6FP_V3_fdn	);
	
	self := left));

#end

return ungroup(wModels);

end;




export RiskwiseMainFLGO_Soapcall(dataset(riskwise.Layout_FLG1) indataset,  string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876')  := function

dist_dataset := DISTRIBUTE(indataset, RANDOM());

riskwise.Layout_FLGO myFail(dist_dataset le) :=
TRANSFORM
	SELF.riskwiseid := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'RiskWise.RiskwiseMainFLGO', {dist_dataset}, 
				DATASET(riskwise.Layout_FLGO),
				PARALLEL(30), onFail(myFail(LEFT)));
				

return resu;

end;

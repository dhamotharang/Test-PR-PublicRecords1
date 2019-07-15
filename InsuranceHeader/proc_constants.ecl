IMPORT _Control;

EXPORT proc_constants := MODULE

	EXPORT cluster			:= _Control.TargetQueue.Prod_NonFCRA_Linking;
	EXPORT cluster2			:= 'hthor_prod_eclcc';
	EXPORT clusterFCRA  := _Control.TargetQueue.Prod_FCRA_Linking;
	EXPORT startIter		:= 1;
	EXPORT numIters			:= 3;
	EXPORT pollingFreq	:= '2';
	EXPORT outECL				:= FALSE;
	EXPORT stopCondition := 1500000;
	
	EXPORT emailList := 'Manish.Shah@LexisNexisrisk.com' + 
											',Ayeesha.Kayttala@lexisnexisrisk.com' +
											',Cody.Fouts@lexisnexisrisk.com' +
											',insdataops@risk.lexisnexis.com';

END;
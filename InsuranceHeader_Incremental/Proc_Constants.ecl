IMPORT _Control;

EXPORT Proc_Constants := MODULE

	EXPORT default_cluster			:= MAP(_Control.ThisEnvironment.Name = 'Alpha_Dev' => 'thor400_198_linking_eclcc_dev',
	                                   _Control.ThisEnvironment.Name = 'Prod'      => _Control.TargetQueue.Prod_NonFCRA_eclcc,
																		 '');
																		 
	EXPORT default_cluster_FCRA			:= MAP(_Control.ThisEnvironment.Name = 'Alpha_Dev' => 'thor400_198_linking_eclcc_dev',
	                                   _Control.ThisEnvironment.Name = 'Prod'      => _Control.TargetQueue.Prod_FCRA_eclcc,
																		 '');
																		 
	EXPORT priority_cluster			:= MAP(_Control.ThisEnvironment.Name = 'Alpha_Dev' => 'thor400_198_linking_eclcc_dev',
	                                   _Control.ThisEnvironment.Name = 'Prod'      => _Control.TargetQueue.Prod_NonFCRA_eclcc,
																		 '');
	EXPORT startIter						:= 1;
	EXPORT numIters							:= 1;
	EXPORT pollingFreq					:= '3';
	EXPORT outECL								:= FALSE;
	EXPORT emailNotify  				:= 'Cody.Fouts@lexisnexisrisk.com;Ayeesha.Kayttala@lexisnexisrisk.com;Aleida.Lima@lexisnexisrisk.com';
	EXPORT emailNotifyAll  			:= 'Cody.Fouts@lexisnexisrisk.com;Ayeesha.Kayttala@lexisnexisrisk.com;Aleida.Lima@lexisnexisrisk.com';
  EXPORT emailNotifyBoca      := 'Cody.Fouts@lexisnexisrisk.com;Ayeesha.Kayttala@lexisnexisrisk.com;Aleida.Lima@lexisnexisrisk.com;Gabriel.Marcan@lexisnexisrisk.com;Debendra.Kumar@lexisnexis.com';
END;
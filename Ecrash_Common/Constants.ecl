IMPORT _control, orbit;

EXPORT Constants := MODULE
	EXPORT BocaForeignProd := '~foreign::'+ _control.IPAddress.prod_thor_dali;
	EXPORT WeightScoreHdrLnk := 30;
	EXPORT DistanceHdrLnk := 3;
	
	EXPORT DevTHOR := 'thor40_241'; //_Control.TargetQueue.Thor400_72_Dev;
  EXPORT ProdTHOR := 'thor400_44'; //_Control.TargetQueue.Prod_NonFCRA; 
  EXPORT THORDest := IF(_control.ThisEnvironment.Name <> 'Prod', DevTHOR, ProdTHOR);
	
	EXPORT DevHTHOR := 'hthor_dev';   //Alpha Dev HTHOR Cluster
  EXPORT ProdHTHOR := 'hthor_prod'; //Alpha Prod HTHOR Cluster
  EXPORT HTHORDest := IF(_control.ThisEnvironment.Name <> 'Prod', DevHTHOR, ProdHTHOR);
	
	  // ###########################################################################
  //                      Email settings.
	// @DataOpsEmailTarget   : Insurance Operations and Orbit Entry errors
  // @DevEmailTarget       : Development Email receving team  
  // @BuildEmailTarget     : Insurance Ecrash Data Build, data_ops_email_target
  // @DataQAEmailTarget    : Insurance Data QA team (Create Build Instances and Idop Entries) 
  // @DataRecEmailTarget   : Data Receiving Team 
  // ###########################################################################
	EXPORT DataOpsEmailTarget := 'InsDataOps@lexisnexis.com'; 
  EXPORT DevEmailTarget := 'ravi.gadi@lexisnexis.com, srilatha.katkuri@lexisnexis.com, manasa.reddy@lexisnexis.com';
	EXPORT ProdEmailTarget := 'DataDevelopment-Ins@lexisnexis.com' + ', ' + DataOpsEmailTarget;
	EXPORT BuildEmailTarget	:= IF (_control.ThisEnvironment.Name <> 'Prod', DevEmailTarget, ProdEmailTarget);
	EXPORT DataQAEmailTarget := 'alp-qadata.team@lexisnexis.com';
	EXPORT DataRecEmailTarget := 'datareceiving@lexisnexis.com, ALP-MediaOps@choicepoint.com';

	EXPORT  LowerCaseAlphabet := 'abcdefghijklmnopqrstuvwxyz';
		
	//Vehicle party main Rollup
	EXPORT VinaLength	:= 17;
	EXPORT OrigNameType := ['1', '4'];
END;
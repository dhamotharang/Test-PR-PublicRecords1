IMPORT Suppress;

//Prof license LexIds: 766749184, 208581863, 1509208525, 17, 52
//One Click: 46, 240, 1058075, 13205509

EXPORT key_OptOutSrc(boolean isFCRA = false) :=  FUNCTION

	//CCPA-120
	rec := Suppress.Layout_CCPA_Opt_Out;

	key := DATASET ([
    {766749184, 0, 'ccpa-test', '20190531', [1]} // prof license
  ], rec);
	RETURN key;
	
END;

IMPORT ut,PRTE2_Common;

// The three true's are for  overwrite?  replicate?  asSuperFile?
fp := PRTE2_Common.Constants.Add_Foreign_prod;	// function
targetThor := 'thor50_dev02';

fnCopy (STRING FN) := fileservices.fcopy(fp(FN),targetThor,FN,,,,,true,true,true );

fn1 := '~thor_data400::base::iverification';

Act1 := fnCopy(fn1);

SEQUENTIAL(act1);


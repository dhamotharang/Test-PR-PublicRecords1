EXPORT modRunTests(DATASET(modLayouts.lSampleLayout) dInData, ROW(modLayouts.ProfileRec) rInRow, STRING sMode, modConstants.fPrototypeThorCall fFunctionIdAppendThor, modConstants.fPrototypeRoxieCall fFunctionIdAppendRoxie, modConstants.fPrototypeIDFunctionsCall fFunctionIdFunctions, modConstants.fPrototypeMMFCall fFunctionMMF):= MODULE   

// DEFUALT FOR ROXE. DONT CHANGE!!!
EXPORT mode1 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,
                            /*iDistance*/rInRow.distance, 
                            /*iWeight*/iWeight := rInRow.weight) : INDEPENDENT;

// DEFUALT FOR THOR. DONT CHANGE!!!
EXPORT mode2 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,
                            /*iDistance*/rInRow.distance, 
                            /*iWeight*/iWeight := rInRow.weight) : INDEPENDENT;

EXPORT mode3 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/TRUE, /*zipRadius*/FALSE) : INDEPENDENT;

EXPORT mode4 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/FALSE, /*zipRadius*/TRUE) : INDEPENDENT;

EXPORT mode5 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/FALSE, /*zipRadius*/FALSE) : INDEPENDENT;

EXPORT mode6 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/FALSE, /*zipRadius*/FALSE) : INDEPENDENT;
														
EXPORT mode7 := fFunctionIdFunctions(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/FALSE, /*zipRadius*/FALSE) : INDEPENDENT;

EXPORT mode8 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight, /*inUrl*/inUrl := modConstants.sRoxieCertVIPSoapcallURL) : INDEPENDENT;

EXPORT mode9 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight) : INDEPENDENT;     

EXPORT mode10 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight, /*inUrl*/inUrl := modConstants.sRoxieDev1Way1SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_3_11_0') : INDEPENDENT; // testing using SALT 3.11.0 folder

EXPORT mode11 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight, /*inUrl*/inUrl := modConstants.sRoxieDev1Way1SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_3_11_9') : INDEPENDENT;  // testing using SALT 3.11.9 folder   
														
EXPORT mode12 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight,/*bForce*/bDisableForce := FALSE,
                            /*isFuzzy*/isFuzzy := TRUE, /*zipRadius*/zipRadius := FALSE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way5SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_2') : INDEPENDENT; //prod

EXPORT mode13 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*iWeight*/iWeight := rInRow.weight,/*bForce*/bDisableForce := FALSE,
                            /*isFuzzy*/isFuzzy := TRUE, /*zipRadius*/zipRadius := TRUE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way5SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_2') : INDEPENDENT;  //local		
														
EXPORT mode14 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := FALSE,
                            /*iWeight*/iWeight := rInRow.weight,/*bForce*/bDisableForce := FALSE,
                            /*isFuzzy*/isFuzzy := TRUE, /*zipRadius*/zipRadius := TRUE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way5SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_3') : INDEPENDENT; //prod

EXPORT mode15 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE,
                            /*iWeight*/iWeight := rInRow.weight,/*bForce*/bDisableForce := FALSE,
                            /*isFuzzy*/isFuzzy := TRUE, /*zipRadius*/zipRadius := TRUE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way5SoapcallURL,
                            /* inSvcName*/ inSvcName:= 'bizlinkfull.svcAppend_3') : INDEPENDENT;  //local

EXPORT mode16 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/TRUE, /*zipRadius*/TRUE, /*inUrl*/inUrl := modConstants.sRoxieDev154SoapcallURL) : INDEPENDENT; // Thor setting to match Roxie defaults as of 20190912
														
EXPORT mode17 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := FALSE,
                            /*iWeight*/iWeight := rInRow.weight) : INDEPENDENT; 

EXPORT mode18 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE,
                            /*iWeight*/iWeight := rInRow.weight) : INDEPENDENT;  

EXPORT mode19 := fFunctionIdAppendThor(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/TRUE, /*zipRadius*/FALSE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way1SoapcallURL) : INDEPENDENT; // Thor setting to match Roxie defaults, except zip radius
														
EXPORT mode20 := fFunctionIdAppendRoxie(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance,
                            /*bSegmentation*/FALSE, /*iWeight*/rInRow.weight,/*bForce*/FALSE,
                            /*isFuzzy*/TRUE, /*zipRadius*/FALSE, /*inUrl*/inUrl := modConstants.sRoxieDev1Way1SoapcallURL) : INDEPENDENT; // Roxie defaults, except zip radius

EXPORT mode21 := fFunctionMMF(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := FALSE) : INDEPENDENT;

EXPORT mode22 := fFunctionMMF(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE, bUseSourceRid := TRUE) : INDEPENDENT;

EXPORT mode23 := fFunctionMMF(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE, iWeight := 44, bUseSourceRid := TRUE) : INDEPENDENT;

EXPORT mode24 := fFunctionMMF(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE) : INDEPENDENT;

EXPORT mode25 := fFunctionMMF(dInData,
                            /*iScore*/rInRow.score,/*iDistance*/rInRow.distance, bSegmentation := TRUE, iWeight := 38) : INDEPENDENT;

END;
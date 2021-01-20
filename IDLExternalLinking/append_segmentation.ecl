/*
	append the necessary segmentation key information to the parameter that is later used to decide
	the best lexID to choose.
*/
EXPORT append_segmentation(trimRes) := FUNCTIONMACRO;
IMPORT InsuranceHeader_PostProcess, _Control;
 
	#UNIQUENAME(normrec)
	%normrec% := record  
		RECORDOF(trimRes.results) res;
		unsigned6 id;
	end;
 
	#UNIQUENAME(seg)
	%seg% :=  #IF(InsuranceHeader_xLink.Environment.isCurrentBoca)
  	InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;
  	#ELSE  
  		InsuranceHeader_PostProcess.segmentation_keys.key_did;
    #END

	#UNIQUENAME(trimResNorm)
	%trimResNorm% := NORMALIZE(trimRes,left.results,TRANSFORM(%normrec%,self.id := left.reference, self.res := right));
	#UNIQUENAME(trimReswSegKey)	
	#UNIQUENAME(trimReswSeg)
														 
	 %trimReswSegKey% := JOIN(%trimResNorm%,%seg%,
                       KEYED(left.res.did = right.did),
                        transform(RECORDOF(LEFT),
	 													 string tempInd := TRIM(right.ind); 
                              self.res.lexID_type := right.lexID_type;                            
	 													 self.res.cluster_cnt := right.cnt;
	 													 self.res.ind := IF(tempInd = IDLExternalLinking.Constants.DEAD_IND and right.cnt=1, 'DEAD_SINGLETON', tempInd); // dead singleton is not good in the context.														 
	 													 self.res.best_ssn5 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn5,
	 													 self.res.best_ssn4 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn4,														
	 													 self.res.match_best_ssn := (left.res.ssn5<>'' and left.res.ssn5=self.res.best_ssn5 or left.res.ssn5weight=0) and 
	 																(left.res.ssn4 <> '' and left.res.ssn4=self.res.best_ssn4) and left.res.ssn4weight>0 ;																	
	 													 self.res.best_dob := right.dob,                             
                              self.res := left.res,                             
                              self := left), left outer, keep(1));
	// #IF(__TARGET_PLATFORM__ in ['thor', 'thorlcr'])
	#IF(_Control.ThisEnvironment.IsPlatformThor)
		#UNIQUENAME(trimReswSegPull)
  	%trimReswSegPull% := JOIN(DISTRIBUTE(%trimResNorm%, RES.DID),DISTRIBUTE(pull(%seg%),DID),
                      left.res.did = right.did,
                       transform(RECORDOF(LEFT),
														 string tempInd := TRIM(right.ind); 
                             self.res.lexID_type := right.lexID_type;                            
														 self.res.cluster_cnt := right.cnt;
														 self.res.ind := IF(tempInd = IDLExternalLinking.Constants.DEAD_IND and right.cnt=1, 'DEAD_SINGLETON', tempInd); // dead singleton is not good in the context.														 
														 self.res.best_ssn5 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn5,
														 self.res.best_ssn4 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn4,														
														 self.res.match_best_ssn := (left.res.ssn5<>'' and left.res.ssn5=self.res.best_ssn5 or left.res.ssn5weight=0) and 
																	(left.res.ssn4 <> '' and left.res.ssn4=self.res.best_ssn4) and left.res.ssn4weight>0 ;																	
														 self.res.best_dob := right.dob,                             
                             self.res := left.res,                             
                             self := left), left outer, keep(1), LOCAL);

		%trimReswSeg% := IF (thorlib.nodes() < 400 OR count(%trimResNorm%) < 13000000 , %trimReswSegKey%, %trimReswSegPull%);
	#ELSE 
		%trimReswSeg% := %trimReswSegKey%;
	#END;

	// filter out lexIDs that are insurance only if enviroment is Boca/PR.	
  #UNIQUENAME(trimReswSegIns) 
  #IF(InsuranceHeader_xLink.Environment.isCurrentBoca)
     %trimReswSegIns% := %trimReswSeg%(res.LexID_type<>IDLExternalLinking.Constants.INSURANCE_LEXID_TYPE AND res.did<IDLExternalLinking.Constants.INSURANCE_LEXID);
  #ELSE
     %trimReswSegIns% := %trimReswSeg%
  #END;
  
	#UNIQUENAME(trimResParentOnly)
	%trimResParentOnly% := PROJECT(trimRes,TRANSFORM(recordof(left),self.Results:=[],self:=left));
	#UNIQUENAME(trimResDeNorm)
	// #IF(__TARGET_PLATFORM__ in ['thor', 'thorlcr'])
	#IF(_Control.ThisEnvironment.IsPlatformThor)
		%trimResDeNorm% := DENORMALIZE(DISTRIBUTE(%trimResParentOnly%, reference),DISTRIBUTE(%trimReswSegIns%, ID),
											LEFT.reference = RIGHT.id, 
													TRANSFORM(RECORDOF(LEFT),
															self.results := sort(LEFT.results + RIGHT.res, -weight),
															self := left), LOCAL);
	#ELSE
		%trimResDeNorm% := DENORMALIZE(%trimResParentOnly%,%trimReswSegIns%,
											LEFT.reference = RIGHT.id,
													TRANSFORM(RECORDOF(LEFT),
															 self.results := sort(LEFT.results + RIGHT.res, -weight),
															self := left));
	#END
// OUTPUT(%trimResNorm%, NAMED('trimResNorm'));  
// OUTPUT(%trimReswSeg%, NAMED('trimReswSeg')); 
// OUTPUT(sort(%trimReswSeg%, res.reference, res.weight), NAMED('trimReswSegSort'));
// OUTPUT(%trimReswSeg%(res.LexID_type<>IDLExternalLinking.Constants.INSURANCE_LEXID), NAMED('trimReswSegfilter')); 
// OUTPUT(%trimResParentOnly%, NAMED('trimResParentOnly')); 
// OUTPUT(%trimResDeNorm%, NAMED('trimResDeNorm'));    
  RETURN %trimResDeNorm%;
  ENDMACRO;
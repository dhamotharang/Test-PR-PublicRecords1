/**
  This macro selects a LexID based on segmentation rules
		1. If results has more than Constants.GOOD_CANDIDATES_THESHOLD candidates within distance, 
			it is too ambiguous to select a good LexID
		2. If there is only one LexID tag as Constants.GOOD_CLUSTERS, this should be the LexID to return
		3. If there are more than one LexID tag as Constants.GOOD_CLUSTERS, but they are of high
		  confidence(name, ssn and dob match), select the LexID with the highest score.
		4. Make sure that if a LexID will be return the score for that LexID is greater than
			Constants.GOOD_SCORE if not (Constants.SCORE_SEG).

**/

EXPORT mac_segmentation(trimRes, resOut, weight_score, distance) := MACRO;
IMPORT InsuranceHeader_PostProcess;
 
	#UNIQUENAME(normrec)
	%normrec% := record
		RECORDOF(trimRes.results) res;
		unsigned6 id;
	end;
 
	#UNIQUENAME(seg)
	%seg% := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;

	#UNIQUENAME(trimResNorm)
	%trimResNorm% := NORMALIZE(trimRes,left.results,TRANSFORM(%normrec%,self.id := left.reference, self.res := right));
	#UNIQUENAME(trimReswSeg)
														 
	%trimReswSeg% := JOIN(%trimResNorm%,%seg%,
                      KEYED(left.res.did = right.did),
                       transform(RECORDOF(LEFT),
														 string tempInd := TRIM(right.ind);
														 self.res.cluster_cnt := right.cnt;
														 self.res.ind := IF(tempInd = IDLExternalLinking.Constants.DEAD_IND and right.cnt=1, 'DEAD_SINGLETON', tempInd); // dead singleton is not good in the context.
														 self.res.best_ssn5 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn5,
														 self.res.best_ssn4 := InsuranceHeader_xLink.mod_SSNParse(right.ssn).ssn4,
														 self.res.match_best_ssn := (left.res.ssn5<>'' and left.res.ssn5=self.res.best_ssn5 or left.res.ssn5weight=0) and
																	(left.res.ssn4 <> '' and left.res.ssn4=self.res.best_ssn4) and left.res.ssn4weight>0 ;
														 self.res.best_dob := right.dob,
                             self.res := left.res,
                             self := left), left outer, keep(1));

	#UNIQUENAME(trimResParentOnly)
	%trimResParentOnly% := PROJECT(trimRes,TRANSFORM(recordof(left),self.Results:=[],self:=left));
	#UNIQUENAME(trimResDeNorm)
	%trimResDeNorm% := DENORMALIZE(DISTRIBUTE(%trimResParentOnly%, reference),DISTRIBUTE(%trimReswSeg%, ID),
											LEFT.reference = RIGHT.id, 
													TRANSFORM(RECORDOF(LEFT),
															self.results := LEFT.results + RIGHT.res,
															self := left), LOCAL);
 
	// for the requests that were NOT assigned a DID using distance, try segmentation
	#UNIQUENAME(resultsSegmentation)
	%resultsSegmentation% := PROJECT(%trimResDeNorm%,
             TRANSFORM(RECORDOF(LEFT), 
             resTemp := sort(LEFT.results, -weight);												
						 integer withinWeightDist := resTemp[1].weight - distance;
							withinDistRes := resTemp(weight>=withinWeightDist);
							withinDistCount := COUNT(withinDistRes);							
             
						// check how many are in GOOD_CLUSTERS
						goodRes := withinDistRes(ind IN IDLExternalLinking.Constants.GOOD_CLUSTERS);						
						goodResCount := count(goodRes);
												
						// high confidence results, it should return one.
						resHighWeight := SORT(withinDistRes(
                 (FNAMEWeight+LNAMEWeight > IDLExternalLinking.Constants.NAME_WEIGHT_THRESHOLD 
                        or MAINNAMEWeight > IDLExternalLinking.Constants.NAME_WEIGHT_THRESHOLD)
                        and (SSN4Weight + SSN5Weight) > IDLExternalLinking.Constants.SSN_WEIGHT_THRESHOLD
                        and DOBWeight > IDLExternalLinking.Constants.DOB_WEIGHT_THRESHOLD), -weight, DID);
												
						resMatchSSN := goodRes(match_best_ssn);
            foundSSN := count(goodRes(ssn5weight>=0 and ssn4weight>0));
						
						// if there are more than one GOOD CLUSTER, it does not return any good result.                                                                                                                                                                                                                                                                                                                                                                                                                                             
           self.xIDL := IF(withinDistCount > IDLExternalLinking.Constants.GOOD_CANDIDATES_THESHOLD, 0,
							IF(goodResCount = 1 and goodRes[1].weight >= weight_score, goodRes[1].did, 
							IF(count(resHighWeight) > 0, resHighWeight[1].did,					 
							//looking for best ssn match if more than one candidate matches on the ssn.
							IF(goodResCount > 1 and count(resMatchSSN) =1 and foundSSN >1 , resMatchSSN[1].did,0
					 )))); // 0 here to not return any good did
					 
           xIDLScore := LEFT.RESULTS(did=self.xIDL)[1].score;
					// IF selected a DID to return it's score must be 75 or higher
          self.score := IF(self.xIDL>0, 
                      IF (xIDLScore >= IDLExternalLinking.Constants.GOOD_SCORE, xIDLScore, IDLExternalLinking.Constants.SCORE_SEG), 0);
 		
                self := left));         
              
         resOut := %resultsSegmentation%;
				 // output(%trimReswSeg%, named('trimReswSeg'));
				 // output(%trimResDeNorm%, named('trimResDeNorm'));
				 
ENDMACRO;
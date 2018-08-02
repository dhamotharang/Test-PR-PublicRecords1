
IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT Common_WIP := MODULE

EXPORT AppendSeq(rawData, datasetToJoinTo, rawIncludesUniqueID) := FUNCTIONMACRO
		
				
		//if rawData has uniqueID field, assuming unquieness - otherwise remove duplicate rows
		//should only have duplicate rows if a given business was added to the file twice
		LOCAL uniqueRawRows := IF(rawIncludesUniqueID = FALSE, DEDUP(rawData, ALL), rawData);
		
		LOCAL joinResult := JOIN(uniqueRawRows, datasetToJoinTo, 
												LEFT.UltID        = RIGHT.Associated.UltID AND  
										    LEFT.OrgID        = RIGHT.Associated.OrgID AND  
										    LEFT.SeleID       = RIGHT.Associated.SeleID AND 
                        LEFT.uniqueID     = RIGHT.Associated.seq,
                        /* add a seq # history date to the raw data so that it be used to in joins by the calling routine */ 
                        /* The seq # in this case is actually a DID for this process                                      */
                        /* so I need the seq to be larger to prevent truncation                                           */
												TRANSFORM({RECORDOF(LEFT), UNSIGNED6 seq, UNSIGNED4 historyDate},
																	SELF.seq         := RIGHT.Associated.seq;
																	SELF.historyDate := RIGHT.historyDate;
																	SELF := LEFT), 
												FEW); 
												
		RETURN joinResult;										
	ENDMACRO;
  
  END;
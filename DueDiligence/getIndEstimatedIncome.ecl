IMPORT Census_Data, DueDiligence;

/*
	Following Keys being used:
			Census_Data.Key_Smart_Jury
*/
EXPORT getIndEstimatedIncome(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION

    
    
    addEstimatedIncome := JOIN(indata,  Census_Data.Key_Smart_Jury, 	
                                KEYED(LEFT.individual.state = RIGHT.stusab) AND 
                                KEYED(LEFT.individual.county = RIGHT.county) AND
                                KEYED(LEFT.individual.geo_blk[1..6] = RIGHT.tract) AND 
                                KEYED(LEFT.individual.geo_blk[7] = RIGHT.blkgrp),
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal, 
                                            SELF.estimatedIncome  := (INTEGER)RIGHT.income;
                                            SELF := LEFT;), 
                                LEFT OUTER,            
                                ATMOST(DueDiligence.Constants.MAX_ATMOST_1000), 
                                KEEP(1));
                        
    
    
    // OUTPUT(addEstimatedIncome, NAMED('addEstimatedIncome'));
    
    
    RETURN addEstimatedIncome;                    
END;

import   Risk_Indicators, RiskWise;

EXPORT OrderScore_GetScore (GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,  
																						DATASET(RiskWise.Layout_CD2I) cd2i_in,
																						boolean ipid_only = FALSE,
																						string9 genericModelName,
                                            String Delivery,
										                        Integer Total_amount  ) := FUNCTION
																						
DEBUG_MODE  := false;	                       //Set to TRUE during round 1 and round 2 validation
isFCRA      := FALSE;
IBICID      := TRUE;
WantstoSeeBillToShipToDifferenceFlag  := TRUE;
WantstoSeeEA                          := TRUE;    
																				

#If(DEBUG_MODE)   /*   call the model being validate using DEBUG_MODE = TRUE   */   
	getScore := models.OSN1803_1_0( clam, IBICID, 
		                              WantstoSeeBillToShipToDifferenceFlag,
																	isFCRA,
																	WantsToSeeEA,
                                  Delivery,
                                  Total_Amount
                                  ); 	
		
#ELSE
  /* Determine the model being requested and call it - It must be one of these valid models */   
	getScore := map(
		ipid_only                          => dataset( [], models.Layout_ModelOut ),                                    // don't call a score for ipid-only transactions
		genericModelName = 'osn1504_0'     => models.OSN1504_0_0( clam, ungroup(cd2i_in), IBICID, WantstoSeeBillToShipToDifferenceFlag, isFCRA, WantstoSeeEA),     // Order Insight 5.1 Flagship	
		genericModelName = 'osn1608_1'     => models.OSN1608_1_0( clam, IBICID, 
		                                                                WantstoSeeBillToShipToDifferenceFlag,
																																		isFCRA,
																																		WantsToSeeEA),
		genericModelName = 'osn1803_1'     => models.OSN1803_1_0( clam, IBICID, 
		                                                                WantstoSeeBillToShipToDifferenceFlag,
																																		isFCRA,
																																		WantsToSeeEA,
                                                                    Delivery, 
                                                                    Total_amount),
    genericModelName <> ''             => fail(Models.Layout_ModelOut, 'Invalid service/model input combination'),
		                                      dataset( [], models.Layout_ModelOut )                                     // for transactions with an invalid modelname specified
	                                        );																																										
#END
 

	RETURN(getScore);
END;    
																						
    
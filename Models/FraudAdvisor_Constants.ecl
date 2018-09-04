IMPORT risk_indicators;


EXPORT FraudAdvisor_Constants := MODULE

//***This must be set to FALSE before moving the code to CERT/PROD
EXPORT VALIDATION_MODE := FALSE;

//***Enter your valid FP3 custom model here
EXPORT fraudpoint3_custom_models := ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',
                                     'fp1607_1', 'fp1712_0', 'fp1508_1', 'fp1802_1', 'fp1705_1','fp1801_1','fp1806_1', 'fp1710_1'];
																		 
																		 
																		 
//***The ‘custom_models’ set are all possible models and so add any new model name to this set.  
//***The model requested must be in this set or the query will return an “Invalid model” error. 
EXPORT XML_custom_models := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'idn6051', 'fd5609_2', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp31203_1', 'fp31105_1',
									'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1',
									'fp1403_2',	'fp1409_2', 'fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1509_2','fp1509_1',
									'fp1510_2', 'fp1511_1', 'fp1512_1','fp31604_0', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2',
                  'fp1702_1','fp1706_1','fp1609_2','fp1607_1', 'fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1',
									'fp1710_1'];
									
									
//***Does your model have any vehicle fields (from Boca Shell).
EXPORT DoVechicle_List  := ['fp31105_1','fp3904_1', 'fp1407_1', 'fp1407_2', 'fp1506_1','fp1509_2', 
                                    'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1610_1', 
																		'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1',
                                    'fp1706_1', 'fp1609_2', 'fp1607_1', 'fp1508_1','fp1705_1','fp1801_1',
                                    'fp1806_1']; 
																		
//***Does your model use fields from Boca Shell 53.																		
EXPORT BS_Version53_List := ['fp1712_0','fp1508_1','fp1802_1','fp1801_1', 'fp1806_1', 'fp1710_1'];  
									
									
//***Enter your model here to use the standard BS Options when calling the Boca Shell Function
EXPORT ThisSet_for_BSOPTIONS :=  ['fp31203_1', 'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1','fp1404_1',
																					'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1506_1', 'fp1509_2','fp1509_1', 'fp31505_0',
																					'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1511_1','fp1512_1', 'fp1610_1', 
																					'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',
                                          'fp1607_1','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1', 'fp1710_1']; 
																					
																					
//***The standard # of Reason Codes are 6 so enter your model here to override the default of 4 reason codes
EXPORT ThisSet_for_Reason_Code_Temps  := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'fp3710_9', 'fp31203_1', 'fp31105_1', 
                         'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1404_1',
		                     'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1403_2', 'fp1506_1', 'fp1509_2','fp1509_1',
												 'fp1510_2','fp1511_1', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1606_1','fp1702_2',
												 'fp1702_1','fp1706_1','fp1609_2','fp1607_1','fp1802_1','fp1705_1','fp1801_1', 
												 'fp1806_1', 'fp1710_1']; 
												 
												 
//***If the customer requests the Fraud Point Risk indexes (example stolenidenty Index) enter your model
EXPORT List_Include_RiskIndices  :=  ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1',
                                      'fp1609_2','fp1607_1','fp1508_1',
                                      'fp1802_1','fp1705_1','fp1801_1','fp1806_1', 'fp1710_1'];
																								
																								
 //***All Models will get a short description sent back with the response    
EXPORT getModel_Description( STRING model_name) := FUNCTION


     FP_Model_Description := map(model_name = 'fp31505_0'		=> 'FraudPointFP31505_0',
													       model_name = 'fp3fdn1505_0'	=> 'FraudPointFP3FDN1505_0',
													       model_name = 'fp31505_9'		=> 'FraudPointFP31505_9',
													       model_name = 'fp3fdn1505_9'	=> 'FraudPointFP3FDN1505_9',
													       model_name = 'fp1610_1'	=> 'FraudPointFP1610_1',
													       model_name = 'fp1610_2'	=> 'FraudPointFP1610_2',
													       model_name = 'fp1609_1'	=> 'FraudPointFP1609_1',
													       model_name = 'fp1611_1'	=> 'FraudPointFP1611_1',
													       model_name = 'fp1606_1'	=> 'FraudPointFP1606_1',
													       model_name = 'fp1702_2'	=> 'FraudPointFP1702_2',
													       model_name = 'fp1702_1'	=> 'FraudPointFP1702_1',
													       model_name = 'fp1706_1'	=> 'FraudPointFP1706_1',
													       model_name = 'fp1609_2'	=> 'FraudPointFP1609_2',
													       model_name = 'fp1607_1'	=> 'FraudPointFP1607_1',
													       model_name = 'fp1712_0'	=> 'FraudPointFP1712_0',
													       model_name = 'fp1508_1'	=> 'FraudPointFP1508_1',
													       model_name = 'fp1802_1'	=> 'FraudPointFP1802_1',
                                 model_name = 'fp1705_1'	=> 'FraudPointFP1705_1',
                                 model_name = 'fp1801_1'	=> 'FraudPointFP1801_1',
                                 model_name = 'fp1806_1'	=> 'FraudPointFP1806_1',
                                 model_name = 'fp1710_1'	=> 'FraudPointFP1710_1',
                          																	 'FraudPoint');
			RETURN FP_Model_Description;
	END;  //***Ends the FUNCTION
	

//***All Custom Models need a billing index.  THis MUST match what the ESP/MBS set up for Billing the customer	
EXPORT getBilling_Index (STRING model_name)  := FUNCTION

        FP_BillingIndex  := case( model_name,
				     
		         'fp31505_0' 	 => risk_indicators.BillingIndex.FP31505_0,
		         'fp3fdn1505_0' => risk_indicators.BillingIndex.FP3FDN1505_0,
		         'fp31505_9' 	 => risk_indicators.BillingIndex.FP31505_9,
		         'fp3fdn1505_9' => risk_indicators.BillingIndex.FP3FDN1505_9,
		         'fp1610_1' => Risk_Indicators.BillingIndex.FP1610_1,
		         'fp1610_2' => Risk_Indicators.BillingIndex.FP1610_2,
		         'fp1609_1' => Risk_Indicators.BillingIndex.FP1609_1,
		         'fp1611_1' => Risk_Indicators.BillingIndex.FP1611_1,
		         'fp1606_1' => Risk_Indicators.BillingIndex.FP1606_1,
		         'fp1702_2' => Risk_Indicators.BillingIndex.FP1702_2,
		         'fp1702_1' => Risk_Indicators.BillingIndex.FP1702_1,
		         'fp1706_1' => Risk_Indicators.BillingIndex.FP1706_1,
		         'fp1609_2' => Risk_Indicators.BillingIndex.FP1609_2,
		         'fp1607_1' => Risk_Indicators.BillingIndex.FP1607_1,
		         'fp1712_0' => Risk_Indicators.BillingIndex.FP1712_0,
		         'fp1508_1' => Risk_Indicators.BillingIndex.FP1508_1,
		         'fp1802_1' => Risk_Indicators.BillingIndex.FP1802_1,
             'fp1705_1' => Risk_Indicators.BillingIndex.FP1705_1,
             'fp1801_1' => Risk_Indicators.BillingIndex.FP1801_1,
             'fp1806_1' => Risk_Indicators.BillingIndex.FP1806_1, 
             'fp1710_1' => Risk_Indicators.BillingIndex.FP1710_1, 
		                       ''
               );
	    RETURN FP_BillingIndex;
	END;  //***Ends the FUNCTION
																		 
END;
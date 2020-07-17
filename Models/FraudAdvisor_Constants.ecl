IMPORT models, risk_indicators, STD, riskwise, easi;


EXPORT FraudAdvisor_Constants := MODULE

//This must be set to FALSE before moving the code to CERT/PROD
// EXPORT VALIDATION_MODE := TRUE;
EXPORT VALIDATION_MODE := False;

EXPORT attrV1 := 'version1';                       //version1 attributes
EXPORT attrV2 := 'fraudpointattrv2';               //version2 attributes
EXPORT IDattr := 'idattributes';                   //idattributes
EXPORT attrV201 := 'fraudpointattrv201';
EXPORT attrV202 := 'fraudpointattrv202';
// EXPORT attrV203 := 'fraudpointattrv203';        //effectively removed, but leaving this here as a reminder
EXPORT attrvparo := 'fraudpointattrvparo';
EXPORT attrvTMX := 'fraudpointattrv202_diattrv1';

//The ‘fraudpoint2_models’ set are models that return risk indicies and so need the expanded layout.
EXPORT fraudpoint2_models := ['fp1109_0', 'fp1109_9', 'fp1307_2', 'fp1307_1', 'fp31310_2',
	         'fp1509_2','fp1512_1','fp31604_0', 'fp1303_1','fp1404_1','fp1407_1','fp1407_2'];

//The ‘fraudpoint3_models’ set are the FraudPoint 3.0 flagship models only.
EXPORT fraudpoint3_models := ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];

//Enter your valid FP3 custom model here
EXPORT fraudpoint3_custom_models := ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',


                                     'fp1607_1', 'fp1712_0', 'fp1508_1', 'fp1802_1', 'fp1705_1','fp1801_1','fp1806_1', 'fp1710_1','fp1803_1','fp1704_1','fp1902_1', 'fp1908_1', 'fp1909_1', 'fp1909_2'];
//The ‘bill_to_ship_to_models’ set are models that use the new second input address that was introduced in Fraudpoint 3.0.
EXPORT bill_to_ship_to_models := ['fp1409_2', 'fp1509_2'];
																		 
EXPORT Paro_models := ['msn1803_1', 'rsn804_1'];																		 
																		 
//The ‘custom_models’ set are all possible models and so add any new model name to this set.  
//The model requested must be in this set or the query will return an “Invalid model” error. 
EXPORT XML_custom_models := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'idn6051', 'fd5609_2', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp31203_1', 'fp31105_1',
                             'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1',
                             'fp1403_2',	'fp1409_2', 'fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1509_2','fp1509_1',
                             'fp1510_2', 'fp1511_1', 'fp1512_1','fp31604_0', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2',
                             'fp1702_1','fp1706_1','fp1609_2','fp1607_1', 'fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1',
                             'fp1710_1', Paro_models,'fp1803_1','fp1704_1','fp1902_1','di31906_0', 'fp1908_1', 'fp1909_1', 'fp1909_2'];									
									
//Does your model have any vehicle fields (from Boca Shell).
EXPORT DoVechicle_List  := ['fp31105_1','fp3904_1', 'fp1407_1', 'fp1407_2', 'fp1506_1','fp1509_2', 
                                    'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1610_1', 
																		'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1',
                                    'fp1706_1', 'fp1609_2', 'fp1607_1', 'fp1508_1','fp1705_1','fp1801_1',

                                    'fp1806_1','fp1902_1', 'fp1909_1', 'fp1909_2']; 																		
//Does your model use fields from Boca Shell 53.																		
EXPORT BS_Version53_List := ['fp1712_0','fp1508_1','fp1802_1','fp1801_1', 'fp1806_1', 'fp1710_1', Paro_models,'fp1803_1'];  
									
									
									
//Enter your model here to use the standard BS Options when calling the Boca Shell Function
EXPORT ThisSet_for_BSOPTIONS :=  ['fp31203_1', 'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1','fp1404_1', 'fp1407_1', 
                                  'fp1407_2', 'fp1406_1', 'fp1506_1', 'fp1509_2','fp1509_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9',
                                  'fp3fdn1505_9', 'fp1511_1','fp1512_1', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1',
                                  'fp1702_2','fp1702_1','fp1706_1','fp1609_2','fp1607_1','fp1508_1','fp1802_1','fp1705_1','fp1801_1',

                                  'fp1806_1','fp1710_1','fp1803_1','fp1704_1','fp1902_1','fp1908_1']; 
																					
																					
//The standard # of Reason Codes are 6 so enter your model here to override the default of 4 reason codes
EXPORT ThisSet_for_Reason_Code_Temps  := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'fp3710_9', 'fp31203_1', 'fp31105_1', 
                                          'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1',
                                          'fp1403_2', 'fp1506_1', 'fp1509_2','fp1509_1', 'fp1510_2','fp1511_1', 'fp1610_1', 'fp1610_2',
                                          'fp1609_1', 'fp1606_1','fp1702_2', 'fp1702_1','fp1706_1','fp1609_2', 'fp1607_1', 'fp1802_1',
 
                                          'fp1705_1','fp1801_1', 'fp1806_1', 'fp1710_1','fp1803_1','fp1704_1','fp1902_1','fp1908_1']; 
                                          
												 
												 
//If the customer requests the Fraud Point Risk indexes (example stolenidenty Index) enter your model
EXPORT List_Include_RiskIndices  :=  [fraudpoint2_models, 'fp31310_2','fp1509_2','fp1512_1','fp31604_0','fp1303_1','fp1404_1','fp1407_1','fp1407_2',
                                      'fp1610_1','fp1610_2','fp1609_1','fp1611_1','fp1606_1','fp1702_2','fp1702_1','fp1609_2','fp1607_1','fp1508_1',

                                      'fp1802_1','fp1705_1','fp1801_1','fp1806_1', 'fp1710_1','fp1803_1','fp1704_1','fp1902_1', 'fp1908_1'];

//Include model here if we need the model name returned in the description field
//(Pretty much all new models do this)
EXPORT List_detailed_model_description := ['ain801_1','fp31505_0','fp31505_9','fp3fdn1505_0','fp3fdn1505_9','fp1509_1','fp1510_2','fp1511_1','fp1509_2',
                                           'fp1512_1','fp31604_0','fp1610_1','fp1610_2','fp1609_1','fp1611_1','fp1606_1','fp1702_2','fp1702_1','fp1706_1',
                                           'fp1609_2','fp1607_1','fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1','fp1806_1','fp1710_1','fp1803_1',
                                          																					

                                           'fp1704_1','fp1902_1','di31906_0', 'fp1908_1', 'fp1909_1', 'fp1909_2', Paro_models];																							
EXPORT FP_model_params := INTERFACE
  EXPORT Grouped Dataset(risk_indicators.Layout_Boca_Shell) _clam := Group(Dataset([], risk_indicators.Layout_Boca_Shell), seq);
  EXPORT Grouped Dataset(risk_indicators.layout_bocashell_btst_out) _clam_BtSt :=  Group(Dataset([], risk_indicators.layout_bocashell_btst_out), bill_to_out.seq);
  EXPORT Dataset(models.layouts.bs_with_ip) _clam_ip :=  Dataset([], models.layouts.bs_with_ip);
  EXPORT Grouped Dataset(Risk_Indicators.Layout_Output) IID_ret := Group(Dataset([], Risk_Indicators.Layout_Output), seq);
  EXPORT Dataset(Models.Layouts.Layout_Model_Options) modeloptions := Dataset([], Models.Layouts.Layout_Model_Options);
  EXPORT Dataset(riskwise.Layout_SkipTrace) _skiptrace := Dataset([], riskwise.Layout_SkipTrace);
  EXPORT Dataset(easi.layout_census) _easicensus := Dataset([], easi.layout_census);
  EXPORT Dataset(Models.Layout_FraudAttributes) _FDatributes := Dataset([], Models.Layout_FraudAttributes);
	
END;



 //All Models will get a short description sent back with the response    
EXPORT getModel_Description( STRING model_name) := FUNCTION

    FP_Model_Description := map(STD.STR.ToLowerCase(model_name) in List_detailed_model_description	=> 'FraudPoint' + STD.STR.ToUpperCase(trim(model_name)),
                                                                                                       'FraudPoint');
    RETURN FP_Model_Description;
	END;
	

//All Custom Models need a billing index.  THis MUST match what the ESP/MBS set up for Billing the customer	
EXPORT getBilling_Index (STRING model_name)  := FUNCTION

        FP_BillingIndex  := case( model_name,
              'fp31505_0'    => risk_indicators.BillingIndex.FP31505_0,
              'fp3fdn1505_0' => risk_indicators.BillingIndex.FP3FDN1505_0,
              'fp31505_9'    => risk_indicators.BillingIndex.FP31505_9,
              'fp3fdn1505_9' => risk_indicators.BillingIndex.FP3FDN1505_9,
              'fp1610_1'     => Risk_Indicators.BillingIndex.FP1610_1,
              'fp1610_2'     => Risk_Indicators.BillingIndex.FP1610_2,
              'fp1609_1'     => Risk_Indicators.BillingIndex.FP1609_1,
              'fp1611_1'     => Risk_Indicators.BillingIndex.FP1611_1,
              'fp1606_1'     => Risk_Indicators.BillingIndex.FP1606_1,
              'fp1702_2'     => Risk_Indicators.BillingIndex.FP1702_2,
              'fp1702_1'     => Risk_Indicators.BillingIndex.FP1702_1,
              'fp1706_1'     => Risk_Indicators.BillingIndex.FP1706_1,
              'fp1609_2'     => Risk_Indicators.BillingIndex.FP1609_2,
              'fp1607_1'     => Risk_Indicators.BillingIndex.FP1607_1,
              'fp1712_0'     => Risk_Indicators.BillingIndex.FP1712_0,
              'fp1508_1'     => Risk_Indicators.BillingIndex.FP1508_1,
              'fp1802_1'     => Risk_Indicators.BillingIndex.FP1802_1,
              'fp1705_1'     => Risk_Indicators.BillingIndex.FP1705_1,
              'fp1801_1'     => Risk_Indicators.BillingIndex.FP1801_1,
              'fp1806_1'     => Risk_Indicators.BillingIndex.FP1806_1, 
              'fp1710_1'     => Risk_Indicators.BillingIndex.FP1710_1, 
              'fp3710_0'     => risk_indicators.BillingIndex.FP3710_0,
              'fp3710_9'     => risk_indicators.BillingIndex.FP3710_9,
              'fp3904_1'     => risk_indicators.BillingIndex.FP3904_1,
              'fp3905_1'     => risk_indicators.BillingIndex.FP3905_1,
              'fd5609_2'     => risk_indicators.BillingIndex.FD5609_2,
              'ain801_1'     => Risk_Indicators.BillingIndex.AIN801_1,
              'fp31203_1'    => Risk_Indicators.BillingIndex.FP31203_1,
              'fp31105_1'    => Risk_Indicators.BillingIndex.FP31105_1,
              'fp1303_1'     => Risk_Indicators.BillingIndex.FP1303_1,
              'fp1310_1'     => Risk_Indicators.BillingIndex.FP1310_1,
              'fp1401_1'     => Risk_Indicators.BillingIndex.FP1401_1,
              'fp1404_1'     => Risk_Indicators.BillingIndex.FP1404_1,
              'fp1407_1'     => Risk_Indicators.BillingIndex.FP1407_1,
              'fp1407_2'     => Risk_Indicators.BillingIndex.FP1407_2,
              'fp1406_1'     => Risk_Indicators.BillingIndex.FP1406_1,
              'fp1403_2'     => Risk_Indicators.BillingIndex.FP1403_2,
              'fp1409_2'     => Risk_Indicators.BillingIndex.FP1409_2,
              'fp1506_1'     => Risk_Indicators.BillingIndex.FP1506_1,
              'fp1509_1'     => Risk_Indicators.BillingIndex.FP1509_1,
              'fp1510_2'     => Risk_Indicators.BillingIndex.FP1510_2,
              'fp1511_1'     => Risk_Indicators.BillingIndex.FP1511_1,
              'fp1109_0'     => risk_indicators.BillingIndex.FP1109_0,
              'fp1109_9'     => risk_indicators.BillingIndex.FP1109_9,
              'fp1307_2'     => Risk_Indicators.BillingIndex.FP1307_2,
              'fp1307_1'     => Risk_Indicators.BillingIndex.FP1307_1,
              'fp31310_2'    => Risk_Indicators.BillingIndex.FP31310_2,
              'fp1509_2'     => Risk_Indicators.BillingIndex.FP1509_2,
              'fp1512_1'     => Risk_Indicators.BillingIndex.FP1512_1,
              'fp31604_0'    => Risk_Indicators.BillingIndex.FP31604_0,
              'msn1803_1'    => Risk_Indicators.BillingIndex.MSN1803_1,
              'rsn804_1'     => Risk_Indicators.BillingIndex.RSN804_1,
              'msnrsn_1'     => Risk_Indicators.BillingIndex.MSNRSN_1,
              'fp1803_1'     => Risk_Indicators.BillingIndex.FP1803_1, 
              'fp1704_1'     => Risk_Indicators.BillingIndex.FP1704_1, 
              'fp1902_1'     => Risk_Indicators.BillingIndex.FP1902_1, 
              'di31906_0'    => Risk_Indicators.BillingIndex.DI31906_0, 
              'fp1908_1'    => Risk_Indicators.BillingIndex.fp1908_1, 
              'fp1909_1'    => Risk_Indicators.BillingIndex.fp1909_1,               
              'fp1909_2'     => Risk_Indicators.BillingIndex.FP1909_2,
              ''
               );
	    RETURN FP_BillingIndex;
	END;
																		 
END;

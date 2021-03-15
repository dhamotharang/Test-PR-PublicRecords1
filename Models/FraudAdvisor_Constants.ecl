IMPORT models, risk_indicators, STD, riskwise, easi;


EXPORT FraudAdvisor_Constants := MODULE

//This must be set to FALSE before moving the code to CERT/PROD
// EXPORT VALIDATION_MODE := TRUE;
EXPORT VALIDATION_MODE := FALSE;

EXPORT LUCI_atmost := 10; //max atmost for the LUCI model joins. (maybe just 1?)

EXPORT attrV1 := 'version1';                       //version1 attributes
EXPORT attrV2 := 'fraudpointattrv2';               //version2 attributes
EXPORT IDattr := 'idattributes';                   //idattributes
EXPORT attrV201 := 'fraudpointattrv201';
EXPORT attrV202 := 'fraudpointattrv202';
// EXPORT attrV203 := 'fraudpointattrv203';        //effectively removed, but leaving this here as a reminder
EXPORT attrvparo := 'fraudpointattrvparo';
EXPORT attrvTMX := 'fraudpointattrv202_diattrv1';
EXPORT attrIDA := 'fraudintelattrv0.0';

//The ‘fraudpoint2_models’ set are models that return risk indicies and so need the expanded layout.
EXPORT fraudpoint2_models := ['fp1109_0', 'fp1109_9', 'fp1307_2', 'fp1307_1', 'fp31310_2',
	         'fp1509_2','fp1512_1','fp31604_0', 'fp1303_1','fp1404_1','fp1407_1','fp1407_2'];

//The ‘fraudpoint3_models’ set are the FraudPoint 3.0 flagship models only.
EXPORT fraudpoint3_models := ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];

//Set of models that need to check GLB purpose
EXPORT GLB_models := [fraudpoint3_models, 'fibn12010_0'];

//Enter your valid FP3 custom model here
EXPORT fraudpoint3_custom_models := ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',
                                     'fp1607_1', 'fp1712_0', 'fp1508_1', 'fp1802_1', 'fp1705_1','fp1801_1','fp1806_1', 'fp1710_1','fp1803_1',
                                     'fp1704_1','fp1902_1', 'fp1907_1','fp1907_2', 'fp1908_1', 'fp1909_1', 'fp1909_2'];
//The ‘bill_to_ship_to_models’ set are models that use the new second input address that was introduced in Fraudpoint 3.0.
EXPORT bill_to_ship_to_models := ['fp1409_2', 'fp1509_2'];
																		 
EXPORT Paro_models := ['msn1803_1', 'rsn804_1'];	

//Set of Fraud Intelligence models (IDA combined models)
EXPORT IDA_models_set := ['fibn12010_0'];
EXPORT IDA_network_notify := 'netn12103_0';
EXPORT IDA_non_models_set := [IDA_network_notify];
EXPORT IDA_services := ['idareport', 'idareport_uat','idareport_retro'];															 															 
																		 
//The ‘custom_models’ set are all possible models and so add any new model name to this set.  
//The model requested must be in this set or the query will return an “Invalid model” error. 
EXPORT XML_custom_models := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'idn6051', 'fd5609_2', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp31203_1', 'fp31105_1',
                             'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1',
                             'fp1403_2',	'fp1409_2', 'fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1509_2','fp1509_1',
                             'fp1510_2', 'fp1511_1', 'fp1512_1','fp31604_0', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2',
                             'fp1702_1','fp1706_1','fp1609_2','fp1607_1', 'fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1',
                             'fp1710_1', Paro_models,'fp1803_1','fp1704_1','fp1902_1','di31906_0','fp1908_1', 'fp1909_1', 'fp1909_2','fp1907_1','fp1907_2',
                             IDA_models_set, IDA_non_models_set];									
//Does your model have any vehicle fields (from Boca Shell).
EXPORT DoVechicle_List  := ['fp31105_1','fp3904_1', 'fp1407_1', 'fp1407_2', 'fp1506_1','fp1509_2', 
                                    'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1610_1', 
																		'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1',
                                    'fp1706_1', 'fp1609_2', 'fp1607_1', 'fp1508_1','fp1705_1','fp1801_1',
                                    'fp1806_1','fp1902_1', 'fp1909_1', 'fp1909_2','fp1907_1','fp1907_2']; 
																		//Does your model use fields from Boca Shell 53.																		
EXPORT BS_Version53_List := ['fp1712_0','fp1508_1','fp1802_1','fp1801_1', 'fp1806_1', 'fp1710_1', Paro_models,'fp1803_1'];  
									
									
									
//Enter your model here to use the standard BS Options when calling the Boca Shell Function
EXPORT ThisSet_for_BSOPTIONS :=  ['fp31203_1', 'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1','fp1404_1', 'fp1407_1', 
                                  'fp1407_2', 'fp1406_1', 'fp1506_1', 'fp1509_2','fp1509_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9',
                                  'fp3fdn1505_9', 'fp1511_1','fp1512_1', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1',
                                  'fp1702_2','fp1702_1','fp1706_1','fp1609_2','fp1607_1','fp1508_1','fp1802_1','fp1705_1','fp1801_1',
                                  'fp1806_1','fp1710_1','fp1803_1','fp1704_1','fp1902_1', 'fp1908_1', 'fp1907_1','fp1907_2']; 
																					
																					
//The standard # of Reason Codes are 6 so enter your model here to override the default of 4 reason codes
EXPORT ThisSet_for_Reason_Code_Temps  := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'fp3710_9', 'fp31203_1', 'fp31105_1','fp1310_1', 'fp1401_1',
                                          'fp31310_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1403_2', 'fp1506_1', 'fp1509_2',
                                          'fp1509_1', 'fp1510_2','fp1511_1', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1606_1','fp1702_2', 'fp1702_1',
                                          'fp1706_1','fp1609_2', 'fp1607_1', 'fp1802_1', 'fp1705_1','fp1801_1', 'fp1806_1', 'fp1710_1','fp1803_1',
                                          'fp1704_1','fp1902_1', 'fp1908_1', 'fp1907_1','fp1907_2','fp1909_1','fp1909_2', IDA_models_set]; 
                                          
												 
												 
//If the customer requests the Fraud Point Risk indexes (example stolenidenty Index) enter your model
EXPORT List_Include_RiskIndices  :=  [fraudpoint2_models, 'fp31310_2','fp1509_2','fp1512_1','fp31604_0','fp1303_1','fp1404_1','fp1407_1','fp1407_2',
                                      'fp1610_1','fp1610_2','fp1609_1','fp1611_1','fp1606_1','fp1702_2','fp1702_1','fp1609_2','fp1607_1','fp1508_1',
                                      'fp1802_1','fp1705_1','fp1801_1','fp1806_1', 'fp1710_1','fp1803_1','fp1704_1','fp1902_1', 'fp1908_1', 'fp1907_1',
                                      'fp1907_2','fp1909_1','fp1909_2'];

//Include model here if we need the model name returned in the description field
//(Pretty much all new models do this)
EXPORT List_detailed_model_description := ['ain801_1','fp31505_0','fp31505_9','fp3fdn1505_0','fp3fdn1505_9','fp1509_1','fp1510_2','fp1511_1','fp1509_2',
                                           'fp1512_1','fp31604_0','fp1610_1','fp1610_2','fp1609_1','fp1611_1','fp1606_1','fp1702_2','fp1702_1','fp1706_1',
                                           'fp1609_2','fp1607_1','fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1','fp1806_1','fp1710_1','fp1803_1',
                                           'fp1704_1','fp1902_1','di31906_0', 'fp1908_1', 'fp1909_1', 'fp1909_2', 'fp1907_1','fp1907_2', Paro_models,
                                           IDA_models_set, IDA_non_models_set];																																														




EXPORT FP_model_params := INTERFACE
  EXPORT Grouped Dataset(risk_indicators.Layout_Boca_Shell) _clam := Group(Dataset([], risk_indicators.Layout_Boca_Shell), seq);
  EXPORT Grouped Dataset(risk_indicators.layout_bocashell_btst_out) _clam_BtSt :=  Group(Dataset([], risk_indicators.layout_bocashell_btst_out), bill_to_out.seq);
  EXPORT Dataset(models.layouts.bs_with_ip) _clam_ip :=  Dataset([], models.layouts.bs_with_ip);
  EXPORT Grouped Dataset(Risk_Indicators.Layout_Output) IID_ret := Group(Dataset([], Risk_Indicators.Layout_Output), seq);
  EXPORT Dataset(Models.Layouts.Layout_Model_Options) modeloptions := Dataset([], Models.Layouts.Layout_Model_Options);
  EXPORT Dataset(riskwise.Layout_SkipTrace) _skiptrace := Dataset([], riskwise.Layout_SkipTrace);
  EXPORT Dataset(easi.layout_census) _easicensus := Dataset([], easi.layout_census);
  EXPORT Dataset(Models.Layout_FraudAttributes) _FDattributes := Dataset([], Models.Layout_FraudAttributes);
	EXPORT Dataset(Risk_Indicators.layouts.layout_IDA_out) IDAattributes := Dataset([], Risk_Indicators.layouts.layout_IDA_out);
END;



 //All Models will get a short description sent back with the response    
EXPORT getModel_Description( STRING model_name) := FUNCTION

    FP_Model_Description := map(STD.STR.ToLowerCase(model_name) in IDA_models_set	                  => 'FraudIntelligence' + STD.STR.ToUpperCase(trim(model_name)),
                                STD.STR.ToLowerCase(model_name) in IDA_non_models_set	              => 'FraudIntelligence' + STD.STR.ToUpperCase(trim(model_name)),
                                STD.STR.ToLowerCase(model_name) in List_detailed_model_description	=> 'FraudPoint' + STD.STR.ToUpperCase(trim(model_name)),
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
              'fp1908_1'     => Risk_Indicators.BillingIndex.fp1908_1, 
              'fp1909_1'     => Risk_Indicators.BillingIndex.fp1909_1,               
              'fp1909_2'     => Risk_Indicators.BillingIndex.FP1909_2,
              'fp1907_1'     => Risk_Indicators.BillingIndex.FP1907_1,
              'fp1907_2'     => Risk_Indicators.BillingIndex.FP1907_2,
              'fibn12010_0'  => Risk_Indicators.BillingIndex.FIBN12010_0,
              'netn12103_0'  => Risk_Indicators.BillingIndex.NETN12103_0,
              ''
               );
	    RETURN FP_BillingIndex;
	END;
  
  //IDA frivolous lists
  EXPORT Friv_phone_list := ['0000000000','0123456789','1111110001','1111110002','1111111111','1234567890','2222222222','3105550111',
                             '3333333333','4444444444','5555555555','6666666666','7777777777','8888888888','9999999999'];
  
  EXPORT Friv_address_list := ['1600 PENNSYLVANIA AVENUE NW 20502', '1600 PENNSYLVANIA AVENUE 20502',
                               '1600 PENNSYLVANIA AVE 20502', '1600 PENNSYLVANIA 20502'];
  
  EXPORT Friv_city_list := ['FANTASY ISLAND'];
  
  EXPORT Friv_name_list := ['ANAKIN SKYWALKER', 'BARACK OBAMA', 'BAT MAN', 'BIG AL', 'BILBO BAGGINS', 'BO PEEP', 'BUGS BUNNY', 'BUGZ BUNNY',
                            'BUZZ LIGHTYEAR', 'CAPTAIN HOOK', 'CAPTAIN TEAGUE', 'CHESHIRE CAT', 'CHICKEN LITTLE', 'COUNTRY BEARS',
                            'CRUELLA DEVIL', 'DAFFY DUCK', 'DAISY DUCK', 'DARKWING DUCK', 'DARTH VADER', 'DONALD DUCK', 'EASTER BUNNY',
                            'EEGA BEEVA', 'ELMER FUDD', 'EVIL MANTA', 'FAIRY GODMOTHER', 'FAT CAT', 'FFEWDDUR FFLAM', 'FOXY LOXY', 'FRODO BAGGINS',
                            'FROU FROU', 'GANDALF GREY', 'GANDALF WHITE', 'GOOSEY LOOSEY', 'GUS GOOSE', 'HAN SOLO', 'HARDY BOYS', 'HARDY BOYZ',
                            'HARRY POTTER', 'HONKER MUDDLEFOOT', 'HORACE HORSECOLLAR', 'HOT SAUCE', 'HULK HOGAN', 'JACK SPARROW', 'JANE DOE',
                            'JARJAR BINKS', 'JESSICA RABBIT', 'JESUS CHRIST', 'JOHN DOE', 'LADY KLUCK', 'LADY TREMAINE', 'LAUNCHPAD MCQUACK',
                            'LUKE SKYWALKER', 'MADAM MIM', 'MAD HATTER', 'MARY POPPINS', 'MAX GOOF', 'MELODY MOUSE', 'MICHELLE OBAMA', 'MICKEY MOUSE',
                            'MILLIE MOUSE', 'MINNIE MOUSE', 'MORCUPINE PORCUPINE', 'MORTIMER MOUSE', 'MOTHER RABBIT', 'MR. INCREDIBLE', 'MR. PERFECT',
                            'MR. POTATOHEAD', 'MR. WOOLENSWORTH', 'MRS. POTATOHEAD', 'OSAMA BINLADEN', 'PEPE LEPEW', 'PETER PAN', 'PRINCE CHARMING',
                            'PUFF DRAGON', 'ROBIN HOOD', 'ROCKY BULLWINKLE', 'ROGER RABBIT', 'SANTA CLAUS', 'SCOOBY DOO', 'SCRAPPY DOO',
                            'SCROOGE MCDUCK', 'SNOW WHITE', 'SPIDER MAN', 'ST NICK', 'SUPER MAN', 'TURKEY LURKEY', 'WHITE RABBIT', 'WINNIE POOH',
                            'WIZARD OZ', 'WOLVERINE X'];

  EXPORT Friv_ssn_list := ['000000000','000111111','009999999','010010101','010101010','011111111','011111111','022222222','033333333','044444444',
                           '055555555','066666666','077777777','088888888','099999999','100101000','101010101','111111111','111221111','111222333',
                           '111222333','111223333','111223333','122222222','123121231','123123123','123345678','123456789','133333333','141111111',
                           '144444444','155555555','166666666','177777777','188888888','211111111','222222222','222222222','234567890','234567891',
                           '300000000','311111111','311111111','411111111','444444444','456789123','511111111','555555555','555667777','980000000',
                           '999999999'];
  
  
																		 
END;

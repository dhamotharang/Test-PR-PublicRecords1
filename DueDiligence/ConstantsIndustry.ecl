EXPORT ConstantsIndustry := MODULE



    /////////////////////////////////
    //    Industry Risk Levels
    //Higher the number, bigger risk
    /////////////////////////////////
    EXPORT RISK_LEVEL_ENUM := ENUM(UNSIGNED1, UNKNOWN = 0, LOW, MEDIUM, HIGH,
                                              AUTOMOTIVE, LEGAL_ACCT_TELEM_FLIGHT_TRAVEL,
                                              CASINO_GAMING, NON_BANK_FIN_INST,
                                              MSB, CASH_INTENSE_RETAIL,
                                              CASH_INTENSE_NON_RETAIL);
    
    
    
    
    
    EXPORT CIB_GROUPING := [RISK_LEVEL_ENUM.CASH_INTENSE_NON_RETAIL, RISK_LEVEL_ENUM.CASH_INTENSE_RETAIL];
    EXPORT FINANCIAL_GROUPING := [RISK_LEVEL_ENUM.MSB, RISK_LEVEL_ENUM.NON_BANK_FIN_INST, RISK_LEVEL_ENUM.CASINO_GAMING];
    EXPORT MISC_CATEGORY_GROUPING := [RISK_LEVEL_ENUM.LEGAL_ACCT_TELEM_FLIGHT_TRAVEL, RISK_LEVEL_ENUM.AUTOMOTIVE];
    EXPORT MED_LOW_RISK_GROUPING := [RISK_LEVEL_ENUM.MEDIUM, RISK_LEVEL_ENUM.LOW];
    
    
   
    
    
    
    

    /////////////////////////////////
    //      Industry Categories
    /////////////////////////////////
    EXPORT CASH_INTENSIVE_BUSINESS_RETAIL := 'CIBR';
    EXPORT CASH_INTENSIVE_BUSINESS_NON_RETAIL := 'CIBNR';
    EXPORT MONEY_SERVICE_BUSINESS := 'MSB';
    EXPORT NON_BANK_FINANCIAL_INSTITUTIONS := 'NBFI';
    EXPORT CASINO_AND_GAMING := 'CAG';
    EXPORT LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL := 'LEGAL';
    EXPORT AUTOMOTIVE := 'AUTO';
    EXPORT OTHER := 'OTHER';
    
    
    
    /////////////////////////////////
    //       NAICs Categories
    /////////////////////////////////
    //Cash Intensive Businesses
    EXPORT NAICS_CIB_RETAIL := ['442110', '442210', '442299', '443111', '443112',
                                '443120', '444110', '444120', '444210', '444220',
                                '445120', '445310', '446110', '447110', '448120',
                                '448150', '448190', '448210', '451110', '451120',
                                '451130', '451140', '451211', '451220', '452111',
                                '452112', '452998', '453110', '453210', '453220',
                                '453310', '453998', '454210'];
                                
    EXPORT NAICS_CIB_NON_RETAIL := ['423930', '424940', '485310', '713120', '713990',
                                    '722110', '722211', '722212', '811192', '812112',
                                    '812113', '812310', '812930', '812990']; 

    //Money Services Businesses											
    EXPORT NAICS_MSB := ['523130', '522390', '522320', '522291'];

    //Non-Bank Finaancial Institutions
    EXPORT NAICS_NBFI := ['522298', '522291', '448310', '423940']; 	       

    //Casinos & Gaming
    EXPORT NAICS_CASGAM := ['721120', '713290', '713210'];   

    //Legal, Accountant, Telemarketer, Flight Training or Travel Agency
    EXPORT NAICS_LEGTRAV := ['611512', '561990', '561510', '561422', '541211', '541110'];   

    //Automotive
    EXPORT NAICS_AUTO := ['811224', '811121', '811118', '811113', '811111', '441310', 
                          '441229', '441228', '441222', '441210', '441120', '441110'];
                          
     
     
     
    /////////////////////////////////
    //     SIC Categories
    /////////////////////////////////
    //Cash Intensive Businesses
    EXPORT SIC_CIB_RETAIL := ['5021', '5023', '5031', '5044', '5049', '5083', '5085', '5091', '5092',
                              '5111', '5112', '5113', '5122', '5131', '5136', '5137', '5139', '5153', '5159',
                              '5162', '5181', '5182', '5191', '5192', '5193', '5199', '5231', '5261',
                              '5292', '5311', '5411', '5541', '5611', '5621', '5632', '5661', '5699', '5712',
                              '5713', '5714', '5719', '5736', '5912', '5932', '5941', '5942', '5943', '5945',
                              '5947', '5949', '5962', '5992', '7699'];
    
    EXPORT SIC_CIB_NON_RETAIL := ['4121', '5093', '5194', '5999', '7215',
                                  '7231', '7299', '7521', '7542', '7993']; 
                          
    //Money Services Businesses											
    EXPORT SIC_MSB := ['7389', '6799', '6221', '6162', '6153', '6141', '6099'];		
                          
    //Non-Bank Finaancial Institutions
    EXPORT SIC_NBFI := ['7631', '6159', '6153', '6141', '6111', 
                        '6082', '6081', '6019', '5944', '5932', '5094']; 	

    //Casinos & Gaming
    EXPORT SIC_CASGAM := ['7999', '7993', '7011'];  

    //Legal, Accountant, Telemarketer, Flight Training or Travel Agency
    EXPORT SIC_LEGTRAV := ['8721', '8299', '8249', '8111', '7389', '7299', '4724'];

    //Automotive
    EXPORT SIC_AUTO := ['7539', '7538', '7537', '7532', '5731', 
                        '5599', '5571', '5561', '5551', '5531', 
                        '5521', '5511', '5015', '5013'];
    
    
      
    
    
    
    
    
    
    /////////////////////////////////
    //     Industry Risk Level
    /////////////////////////////////
    EXPORT RISK_LEVEL_HIGH := 'HIGH';
    EXPORT RISK_LEVEL_MEDIUM := 'MEDIUM';
    EXPORT RISK_LEVEL_LOW := 'LOW';
    EXPORT RISK_LEVEL_UNKNOWN := 'UNKNOWN';
    
    
    
    

    /////////////////////////////////
    //      NAICS Risk Levels
    /////////////////////////////////
    EXPORT NAICS_RISK_HIGH :=  ['42','44','45','48','49'];
    EXPORT NAICS_RISK_MED :=  ['23','31','32','33','52','53','54','56','71','72','81','92'];
    EXPORT NAICS_RISK_LOW :=  ['11','21','22','51','55','61','62'];

    EXPORT NAICS_RISK_HIGH_EXCEP := ['332991', '332992', '332993', '332994', '332996', '333249', '522190', '522220', '522291', '522293',
                                      '522298', '522320', '522390', '523110', '523120', '523130', '523140', '523210', '523910', '523920',
                                      '523930', '523991', '523999', '525910', '525990', '531210', '541110', '541191', '541199', '541211',
                                      '541219', '561422', '561499', '561510', '561520', '561599', '561990', '611512', '713210', '713290',
                                      '721120', '722310', '722320', '722330', '722410', '722511', '722513', '722514', '722515', '811192',
                                      '812930', '812990', '813211', '813212', '813312', '813219', '813311', '813312', '813319', '813930',
                                      '813940'];




          


    /////////////////////////////////
    //        SIC Risk Levels
    /////////////////////////////////
    EXPORT SIC_LENGTH_2_RISK_HIGH	:= ['58'];

    EXPORT SIC_LENGTH_4_RISK_HIGH	:= ['3111', '3151', '3199', '3911', '4724', 
                                      '4725', '4729', '4789', '5094', '5411', 
                                      '5499', '5500', '5511', '5521', '5551', 
                                      '5561', '5571', '5599', '6081', '6082', 
                                      '6211', '6722', '6799', '8111', '8721'];
                                      
    EXPORT SIC_LENGTH_6_RISK_HIGH	:= ['315100', '315199', '608100', '608199', '608200', 
                                      '608299', '609901', '738914', '799913'];																	
                                      
    EXPORT SIC_LENGTH_8_RISK_HIGH	:= ['31510000', '47310101', '47310102', '47310102', '59329904', 
                                      '60810000', '60819901', '60820000', '60990100', '60990101', 
                                      '60990102', '60990103', '60999901', '60999902', '60999903', 
                                      '60999906', '60999908', '60999908', '70110301', '73891005', 
                                      '73891400', '73891402', '79930401', '79930402', '79930403', 
                                      '79990803', '79990804', '79991301', '79991302', '79991303', 
                                      '79991304', '79991305', '79991306'];																	

    EXPORT SIC_FIRST_2_STAR_RISK_HIGH := ['58']; //must match on first 2 char
                                      
    EXPORT SIC_FIRST_4_STAR_RISK_HIGH := ['3111', '3199', '3911', '4724', '4725',
                                          '4729', '4789', '5094', '5411', '5499',
                                          '5511', '5521', '5551', '5561', '5571',
                                          '5599', '6211', '6722', '6799', '8111',
                                          '8721']; //must match on first 4 char	

    EXPORT SIC_FIRST_6_STAR_RISK_HIGH := ['315199']; //must match on first 6 char		
    
                                         

END;
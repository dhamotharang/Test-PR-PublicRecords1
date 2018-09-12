﻿﻿// Billing index rule of thumb:
// ECL index % 100 + 30 == ESP index
// e.g., sub-prime auto is 108; 108%100+30 = 38



export BillingIndex := MODULE
		export RVBankcard_v1        := '1';
		export RVAuto_v1            := '2';
		export RVTelecom_v1         := '3';
		export RVRetail_v1          := '4';

		export RVAuto_v2            := '104';
		export RVBankcard_v2        := '105';
		export RVTelecom_v2         := '106';
		export RVRetail_v2          := '107';
		export RVMoney_v2           := '113'; // RiskView Money Service

		export RVA_aid605_1         := '100';
		export RVA_aid607_0         := '101';
		export RVA_rva707_1         := '102';
		export RVA_rva707_0         := '108'; // sub-prime auto


		export RVR_rvr803_1         := '110'; // Custom Retail Models
		export RVPreScreen_v1       := '111'; // Risk View Prescreen Model
		export RVFSB_generic        := '112'; // RiskView For Small Business default model (RVS811_0_0)
		export RVG_rvg903_1         := '114'; // Custom Money Models
		export RVG_rvg904_1         := '118'; // Custom RV Money for ThinkCash

		// flagship v3
		export RVAuto_v3            := '119'; // RVA1003.0.0 - Auto 
		export RVBankcard_v3        := '120'; // RVB1003.0.0 - Bankcard 
		export RVTelecom_v3         := '121'; // RVT1003.0.0 - Telecom/Wireless
		export RVRetail_v3          := '122'; // RVR1003.0.0 - Retail 
		export RVMoney_v3           := '123'; // RVG1003.0.0 - Money Service Business
		export RVPreScreen_v3       := '124'; // RVP1003.0.0 - Prescreen     
		export RVA_rva1007_1		:= '125'; // RVA1007.1.0 - Santander
		export RVA_rva1007_2		:= '126'; // RVA1007.2.0 - Santander
		export RVD_rvd1010_0        := '127';
		export RVD_rvd1010_1        := '128';
		export RVD_rvd1010_2        := '129';
		export RVR1008_1            := '132'; // RVR1008.1.0 - Valued Services Custom RiskView Model
		
		// flagship RV4
		export RVAuto_v4            := '133';
		export RVBankcard_v4        := '134';
		export RVTelecom_v4         := '135';
		export RVRetail_v4          := '136';
		export RVMoney_v4           := '137';
		export RVPreScreen_v4       := '138';
		
		export RV_Custom_IE9121     := '139';
		export RVG1106_1            := '140';
		export RVA1008_1            := '141';
		export RVT1104_1            := '142';
		export IED1106_1            := '144'; // tracfone custom RV4 income estimator
		EXPORT RVA1007_3			:= '145'; // RVA1007.3.0 - Harley - Custom RV3 Model
		export RVR1104_2            := '146'; // BlueStem custom RV4
		EXPORT RVC1112_0            := '147'; // Flagship Payment Score RiskView v4
		export RVD1110_1      		:= '148'; // RVD1110.1.0 - Republic Bank - Custom RiskView Model
		export RVP1012_1      		:= '149'; // Axcess Financial prescreen v3
		export RVG1201_1      		:= '150'; // CompuCredit custom money
		export RVR1104_3            := '151'; // GE Custom RV4 Retail
		export RVC1110_1			:= '152'; // Ascension Point Custom RV4 Payment Score
		export RVC1110_2			:= '153'; // Ascension Point Custom RV4 Probate Score
		export RVT1204_1			:= '154'; // Verizon Wireless - Riskview custom telcom 
		export RVP1208_1			:= '155'; // DM Services - Riskview custom prescreen score
		export RVC1208_1			:= '156'; // CCS - Riskview custom Payment score
		export RVT1210_1			:= '157'; // T-Mobile - Riskview custom telcom
		export RVR1210_1			:= '159'; // DM Services - Riskview custom retail
		export RVR1303_1			:= '160'; // Bluestem - Riskview custom retail score
		export RVC1210_1			:= '161'; // Epic Loans - Riskview custom payment score
		export RVT1212_1			:= '162'; // T-Mobile (full file) - Riskview custom telcom
		export RVC1301_1			:= '163'; // Credit Protection Agency - Riskview custom payment score
		export RVG1302_1			:= '164'; // Progressive Insurance - custom money
		export RVA1304_1			:= '165'; // Santander - custom auto
		export RVA1304_2			:= '166'; // Santander - custom auto
		export RVG1304_1			:= '167'; // Strategic Link Consulting - VIP
		export RVG1304_2			:= '168'; // Strategic Link Consulting - New
		export RVA1306_1			:= '169'; // CIG Financial - Riskview custom auto
		export RVA1305_1			:= '170'; // CarMax riskview customer auto
		export RVA1309_1			:= '171'; // SFG Financial - Riskview custom auto
		export RVC1307_1			:= '172'; // Rossman & Co 
		export RVA1310_1			:= '173'; // Auto Acceptance custom - Direct Loan
		export RVA1310_2			:= '174'; // Auto Acceptance custom - Indirect Loan
		export RVA1310_3			:= '175'; // Auto Acceptance custom - Consumer Loan
		export RVT1307_3			:= '176'; // At&t - custom model
		export RVA1311_1			:= '177'; // Coastal Credit - custom auto
		export RVA1311_2			:= '178'; // Coastal Credit - custom auto
		export RVA1311_3			:= '179'; // Southern Auto Finance Company
		export RVG1401_1			:= '180'; // Strategic Link VIP
		export RVG1401_2			:= '181'; // Strategic Link New Customers
		export RVR1311_1			:= '182'; // Target
		export RVT1402_1			:= '183'; //Fortiva Financial
		export RVP1401_1			:= '184'; // DM
		export RVP1401_2			:= '185'; // DM
		export RVG1310_1			:= '186'; //General Financial
		export RVG1404_1			:= '187'; //Advance America
		export RVC1405_1      := '188'; //Strategic Link All Debt
		export RVC1405_2      := '189'; //Strategic Link Third Party Debt
		export RVC1405_3      := '190'; //MBVA Accounts Receivable
		export RVC1405_4			:= '191'; //MBVA
		export RVB1310_1			:= '192'; //BofA
		export RVB1402_1			:= '193'; //RBS Citizens
		export RVC1412_1			:= '194'; // Harvest Strategy Group Custom Payment
		export RVP1503_1			:= '195'; // Oportun
    export RVB1104_1			:= '196'; // Oportun
    export IED1002_0			:= '197'; // Estimated income
		export RVR1410_1			:= '198'; // Blue Stem

		export PVA1602_0			:= '199'; //PowerView pass through to Equifax (aka. Equifax ADRS) shouldn't be any billing for this call.
		export FXD1607_0			:= '200'; //FICO Score XD pass through to Equifax (aka. Equifax FICO Score XD) shouldn't bill for this call.

		export RVC1412_2			:= '201'; //Immediate Credit Recovery
		export RVT1605_1			:= '202'; // Verizon - Telecom
		export RVT1605_2			:= '203'; // Verizon - Wireless 
		export RVC1703_1			:= '204'; // Rossman & Co //batch only
		export RVC1801_1			:= '205'; // TSI //batch only
		export RVT1705_1      := '206'; // Huntington	
		
    export RVC1805_1			:= '207'; // Phillips & Cohen //batch only (207 % 100 + 30 = 137)             
    export RVC1805_2			:= '208'; // Phillips & Cohen //batch only (208 % 100 + 30 = 138)
	
		// Chargeback Defender Version 1
		export CBD_v1 						:= '10';	// CDN712_0
		export CBD1109_1					:= '11';	// Best Buy Custom Chargeback Defender
		export CBD1305_1					:= '12';	// Tiger Direct Custom Chargeback Defender ???Confirm with Terrence!!
		export CBD1404_1          := '13';    // Best Buy Custom Chargeback Defender
		export CBD1410_1          := '14';
		export CBD1506_1          := '15';
		
		export OSN1504_0					:= '16'; // Order Score Flagship for ChargeBack Defender - NOT used by OrderScore service

		export CBD_IdentityAttr_v1				:= '20';	// Chargeback Defender Basic Attributes
		export CBD_RelationshipAttr_v1 		:= '21';	// Chargeback Defender All Attributes
		
		export CBD_IdentityAttr_v4      	:= '145';
		export CBD_RelationshipAttr_v4  	:= '146';
		export CBD_VelocityAttr_v4      	:= '147';
		export CBD_1404_1                   := '148';   
		
		// fraudadvisor / fraudpoint		
		export FP3710_0       := '109'; // FraudPoint
		export FP3904_1       := '115'; // FraudPoint for Avon
		export FP3905_1       := '116'; // Another FraudPoint for Avon
		export FD5609_2       := '117'; // legacy model being plugged into nugen fraudpoint
		export AIN801_1       := '130'; // AIN801.1.0 - WFS3/4 - Custom FraudPoint Model
		export FP3710_9       := '131'; // FP3710.9.0 - FraudPoint Flagship Model with Criminal Risk Codes
		export FP1109_0       := '132'; // FP1109.0.0 - FraudPoint 2.0 Flagship Model
		export FP1109_9       := '133'; // FP1109.0.0 - FraudPoint 2.0 Flagship Model with Criminal Risk Codes
		export FP31203_1      := '134'; // Wells Fargo Dealer Services
		export FP31105_1      := '143'; // FP31105.1.0 - Key Bank - Custom FraudPoint Model
		export FP1210_1       := '158'; // FP1210.1.0 - TRIS State of GA - Custom FraudPoint Model
		export FP1303_1       := '136'; // FP1303.1.0 - Axcess Financial - Custom FraudPoint Model
		export FP1310_1       := '137'; // FP1310.1.0 - Axcess Financial - Custom FraudPoint Model
		export FP1401_1       := '138'; // FP1401.1.0 - Fraudpoint for Avon - Custom FraudPoint Model
		export FP31310_2      := '139'; // FP31310.2.0 - Fraudpoint for GreenDot - Custom FraudPoint Model
		export FP1307_1       := '140'; // FP1307.1.0 - Fraudpoint for Cash Call - Custom FraudPoint Model
		export FP1307_2       := '141'; // FP1307.2.0 - Fraudpoint indices returned with fp1109_0 info for PNC - Custom FraudPoint Model
		export FP1404_1       := '142'; // FP1404.1.0 - Fraudpoint for Axcess - Custom FraudPoint Model
		export FP1407_1       := '143'; // FP1407.1.0 - Fraudpoint for Axcess WLNI - Custom FraudPoint Model
		export FP1406_1       := '144'; // FP1406.1.0 - Sprint Assurance - Custom FraudPoint Model
		export FP1403_2       := '145'; // FP1403.2.0 - Target (previously np31) - Custom FraudPoint Model
		export FP1409_2				:= '146'; // FP1409.2.0 - GE Synchrony
		export FP1407_2       := '147'; // FP1407.2.0 - Fraudpoint for Axcess WLNI - Custom FraudPoint Model, with IT override
		export FP1506_1       := '148'; // FP1407.2.0 - Fraudpoint for Tiger Financial
		export FP31505_0      := '149'; // FP31505.0.0 - Fraudpoint 3.0 non-FDN Flagship model
		export FP3FDN1505_0   := '150'; // FP3FDN1505.0.0 - Fraudpoint 3.0 FDN Flagship model
		export FP1509_2   		:= '151'; // FP1509.2.0 - Fraudpoint custom for GreenDot
    export FP1509_1   		:= '152'; // FP1509.1.0 - Fraudpoint custom for Republic Bank
		export FP31505_9      := '153'; // FP31505.9.0 - Fraudpoint 3.0 non-FDN Flagship model (with criminal)
		export FP3FDN1505_9   := '154'; // FP3FDN1505.9.0 - Fraudpoint 3.0 FDN Flagship model (with criminal)		
		export FP1510_2   		:= '155'; // FP1510.2.0 - Fraudpoint 3.0 Custom Model for Target
		export FP1512_1   		:= '156'; // FP1512.1.0 - Fraudpoint 3.0 Custom Model for Westlake
		//export FP1603_1   		:= '157'; // FP1603.1.0 - Fraudpoint 3.0 Custom Model for BarClays
		export FP1511_1			:= '158'; //FP1511.1 - Fraudpoint 3.0 Custom Model for Moneylions 
		export FP31604_0    := '159'; //fp31604.0 - Fraudpoint 3.0 Avenger model
		export FP1610_1			:= '160'; //FP1610_1 - Fraudpoint 3.0 Custom Model for Axcess Financial
		export FP1609_1			:= '161'; //FP1609_1 - Fraudpoint 3.0 Custom Model for Total Management
		export FP1611_1			:= '162'; //FP1611_1 - Fraudpoint 3.0 Custom Model for Axcess Financial (162 % 100 + 30 = 92)
		export FP1606_1			:= '163'; //FP1606_1 - Fraudpoint 3.0 Custom Model for CashCall & LoanMe (163 % 100 + 30 = 93)
		export FP1610_2			:= '164'; //FP1610_2 - Fraudpoint 3.0 Custom Model for Axcess Financial (164 % 100 + 30 = 94)
    export FP1702_1			:= '165'; //FP1702_1 - Fraudpoint 3.0 Custom Model for Kohls online (165 % 100 + 30 = 95)
		export FP1706_1		  := '166'; //FP1706_1 - Fraudpoint 3.0 Custom Model for MetaBank (166 % 100 + 30 = 96)
		export FP1702_2			:= '167'; //FP1702_2 - Fraudpoint 3.0 Custom Model for Kohls POS (167 % 100 + 30 = 97)	
		export FP1609_2			:= '168'; //FP1609_2 - Fraudpoint 3.0 Custom Model for Discovery (168 % 100 + 30 = 98)	
		export FP1607_1			:= '169'; //FP1607_1 - Fraudpoint 3.0 Custom Model for TracPhone (169 % 100 + 30 = 99)	
		export FP1712_0			:= '170'; //FP1712_0 - Fraudpoint/Shell Custom Model for Bureau Fraud (170 % 100 + 30 = 100)	
		export FP1508_1			:= '171'; //FP1508_1 - Fraudpoint 3.0 Custom Model for Discovery = 100) (171 % 100 + 30 = 101)             
	  export FP1705_1     := '172'; //FP1705_1 - Fraudpoint 3.0 Custom Model for Huntington = 102 (172 % 100 + 30 = 102)             
    export FP1802_1     := '173'; //FP1508_1 - Fraudpoint 3.0 Custom Model for Direct financial  (173 % 100 + 30 = 103)             
    export FP1801_1     := '174'; //FP1801_1 - Fraudpoint 3.0 Custom Model for Digital (174 % 100 + 30 = 104)             
    export FP1710_1     := '175'; //FP1710_1 - Fraudpoint 3.0 Custom Model for Borrow Works (175 % 100 + 30 = 105)
    export FP1806_1     := '176'; //FP1806_1 - Fraudpoint 3.0 Custom Model for Discover (176 % 100 + 30 = 106)             
END;

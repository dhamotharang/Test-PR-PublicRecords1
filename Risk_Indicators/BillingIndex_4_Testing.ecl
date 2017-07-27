// Billing index rule of thumb:
// ECL index % 100 + 30 == ESP index
// e.g., sub-prime auto is 108; 108%100+30 = 38



export BillingIndex_4_Testing := MODULE
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
		export RVAuto_v3            := '119'; // RVA1003.0.0 – Auto 
		export RVBankcard_v3        := '120'; // RVB1003.0.0 – Bankcard 
		export RVTelecom_v3         := '121'; // RVT1003.0.0 – Telecom/Wireless
		export RVRetail_v3          := '122'; // RVR1003.0.0 – Retail 
		export RVMoney_v3           := '123'; // RVG1003.0.0 – Money Service Business
		export RVPreScreen_v3       := '124'; // RVP1003.0.0 – Prescreen     
		export RVA_rva1007_1			:= '125'; // RVA1007.1.0 - Santander
		export RVA_rva1007_2			:= '126'; // RVA1007.2.0 - Santander
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
		EXPORT RVA1007_3						:= '145'; // RVA1007.3.0 - Harley - Custom RV3 Model
		export RVR1104_2            := '146'; // BlueStem custom RV4
    EXPORT RVC1112_0            := '147'; // Flagship Payment Score RiskView v4
		export RVD1110_1      			:= '148'; // RVD1110.1.0 - Republic Bank - Custom RiskView Model
		export RVP1012_1      			:= '149'; // Axcess Financial prescreen v3
		export RVG1201_1      			:= '150'; // CompuCredit custom money
		export RVR1104_3            := '151'; // GE Custom RV4 Retail
		export RVC1110_1						:= '152'; // Ascension Point Custom RV4 Payment Score
		export RVC1110_2						:= '153'; // Ascension Point Custom RV4 Probate Score
		export RVT1204_1						:= '154'; // Verizon Wireless - Riskview custom telcom 
		export RVP1208_1						:= '155'; // DM Services - Riskview custom prescreen score
		export RVC1208_1						:= '156'; // CCS - Riskview custom Payment score
		export RVT1210_1						:= '157'; // T-Mobile - Riskview custom telcom
		export RVR1210_1						:= '159'; // DM Services - Riskview custom retail
		export RVR1303_1						:= '160'; // Bluestem - Riskview custom retail score
		export RVC1210_1						:= '161'; // Epic Loans - Riskview custom payment score
		export RVT1212_1						:= '162'; // T-Mobile (full file) - Riskview custom telcom
		export RVC1301_1						:= '163'; // Credit Protection Agency - Riskview custom payment score
		export RVG1302_1						:= '164'; // Progressive Insurance - custom money
		export RVA1304_1						:= '165'; // Santander - custom auto
		export RVA1304_2						:= '166'; // Santander - custom auto

		// Chargeback Defender Version 1
		export CBD_v1 									:= '10';	// CDN712_0
		export CBD1109_1								:= '11';	// Best Buy Custom Chargeback Defender
		export CBD1305_1								:= '12';	// Tiger Direct Custom Chargeback Defender ???Confirm with Terrence!!
		export CBD_IdentityAttr_v1			:= '20';	// Chargeback Defender Basic Attributes
		export CBD_RelationshipAttr_v1 	:= '21';	// Chargeback Defender All Attributes
		
		export CBD_IdentityAttr_v4      := '145';
		export CBD_RelationshipAttr_v4  := '146';
		export CBD_VelocityAttr_v4      := '147';
		
		// fraudadvisor / fraudpoint		
		export FP3710_0             := '109'; // FraudPoint
		export FP3904_1             := '115'; // FraudPoint for Avon
		export FP3905_1             := '116'; // Another FraudPoint for Avon
		export FD5609_2             := '117'; // legacy model being plugged into nugen fraudpoint
		export AIN801_1             := '130'; // AIN801.1.0 - WFS3/4 - Custom FraudPoint Model
		export FP3710_9             := '131'; // FP3710.9.0 - FraudPoint Flagship Model with Criminal Risk Codes
		export FP1109_0             := '132'; // FP1109.0.0 - FraudPoint 2.0 Flagship Model
		export FP1109_9             := '133'; // FP1109.0.0 - FraudPoint 2.0 Flagship Model with Criminal Risk Codes
		export FP31203_1            := '134'; // Wells Fargo Dealer Services
		export FP31105_1            := '143'; // FP31105.1.0 - Key Bank - Custom FraudPoint Model
		export FP1210_1             := '158'; // FP1210.1.0 - TRIS State of GA - Custom FraudPoint Model
		export FP1303_1             := '136'; // FP1303.1.0 - Axcess Financial - Custom FraudPoint Model
		
END;


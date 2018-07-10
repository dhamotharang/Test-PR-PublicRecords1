import Models, Seed_Files;

export RV_TestSeed_Function(dataset(Layout_Input) inData, string30 account_value, string20 TestDataTableName, string svcname, string modelname ) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	layout_rvSeq := RECORD
		unsigned4 seq;
		Models.Layout_Model;
	END;


	idx := map(
			/* Flagship v1 */
			svcname='models.rvbankcard_service' and modelname = ''         => Risk_Indicators.BillingIndex.RVBankcard_v1,
			svcname='models.rvauto_service'     and modelname = ''         => Risk_Indicators.BillingIndex.RVAuto_v1,
			svcname='models.rvtelecom_service'  and modelname = ''         => Risk_Indicators.BillingIndex.RVTelecom_v1,
			svcname='models.rvretail_service'   and modelname = ''         => Risk_Indicators.BillingIndex.RVRetail_v1,

			/* Flagship v2 */
			svcname='models.rvauto_service'     and modelname = 'rva711_0' => Risk_Indicators.BillingIndex.RVAuto_v2,
			svcname='models.rvbankcard_service' and modelname = 'rvb711_0' => Risk_Indicators.BillingIndex.RVBankcard_v2,
			svcname='models.rvtelecom_service'  and modelname = 'rvt711_0' => Risk_Indicators.BillingIndex.RVTelecom_v2,
			svcname='models.rvretail_service'   and modelname = 'rvr711_0' => Risk_Indicators.BillingIndex.RVRetail_v2,
			svcname='models.rvmoney_service'    and modelname = 'rvg812_0' => Risk_Indicators.BillingIndex.RVMoney_v2,
			
			/* Flagship v3 */
			svcname='models.rvauto_service'      and modelname = 'rva1003_0' => Risk_Indicators.BillingIndex.RVAuto_v3,
			svcname='models.rvbankcard_service'  and modelname = 'rvb1003_0' => Risk_Indicators.BillingIndex.RVBankcard_v3,
			svcname='models.rvtelecom_service'   and modelname = 'rvt1003_0' => Risk_Indicators.BillingIndex.RVTelecom_v3,
			svcname='models.rvretail_service'    and modelname = 'rvr1003_0' => Risk_Indicators.BillingIndex.RVRetail_v3,
			svcname='models.rvmoney_service'     and modelname = 'rvg1003_0' => Risk_Indicators.BillingIndex.RVMoney_v3,
			svcname='models.rvprescreen_service' and modelname = 'rvp1003_0' => Risk_Indicators.BillingIndex.RVPrescreen_v3,
			
			/* Flagship v4 */
			modelname = 'rva1104_0' => Risk_Indicators.BillingIndex.RVAuto_v4,
			modelname = 'rvb1104_0' => Risk_Indicators.BillingIndex.RVBankcard_v4,
			modelname = 'rvt1104_0' => Risk_Indicators.BillingIndex.RVTelecom_v4,
			modelname = 'rvr1103_0' => Risk_Indicators.BillingIndex.RVRetail_v4,
			modelname = 'rvg1103_0' => Risk_Indicators.BillingIndex.RVMoney_v4,
			modelname = 'rvp1104_0' => Risk_Indicators.BillingIndex.RVPrescreen_v4,

			// Payment Score - Technically a Flagship v4 - but being requested as a custom...
			modelname = 'rvc1112_0' => Risk_Indicators.BillingIndex.RVC1112_0,
			                                                                  
			/* Custom retail models */
			svcname='models.rvretail_service'   and modelname = 'rvr803_1' => Risk_Indicators.BillingIndex.RVR_rvr803_1,
			svcname='models.rvretail_service'   and modelname = 'rvd1010_0' => Risk_Indicators.BillingIndex.RVD_rvd1010_0,
			svcname='models.rvretail_service'   and modelname = 'rvd1010_1' => Risk_Indicators.BillingIndex.RVD_rvd1010_1,
			svcname='models.rvretail_service'   and modelname = 'rvd1010_2' => Risk_Indicators.BillingIndex.RVD_rvd1010_2,
														  
			/* Custom auto models */
			svcname='models.rvauto_service'     and modelname = 'aid605_1' => Risk_Indicators.BillingIndex.RVA_aid605_1,
			svcname='models.rvauto_service'     and modelname = 'aid607_0' => Risk_Indicators.BillingIndex.RVA_aid607_0,
			svcname='models.rvauto_service'     and modelname = 'rva707_1' => Risk_Indicators.BillingIndex.RVA_rva707_1,
			svcname='models.rvauto_service'     and modelname = 'rva1007_1' => Risk_Indicators.BillingIndex.RVA_rva1007_1,
			svcname='models.rvauto_service'     and modelname = 'rva1007_2' => Risk_Indicators.BillingIndex.RVA_rva1007_2,
			svcname='models.rvauto_service'     and modelname = 'rva707_0' => Risk_Indicators.BillingIndex.RVA_rva707_0, // sub-prime auto
			
			svcname='models.rvmoney_service'    and modelname = 'rvg904_1' => Risk_Indicators.BillingIndex.RVG_rvg904_1, // thinkcash
			modelname = 'rvg1106_1' => Risk_Indicators.BillingIndex.RVG1106_1, // compucredit
			
			
			modelname = 'rva1007_3' => Risk_Indicators.BillingIndex.RVA1007_3, // Harley
      modelname = 'rvr1008_1' => Risk_Indicators.BillingIndex.RVR1008_1, // Valued Services
			
			modelname = 'ie912_1'   => Risk_Indicators.BillingIndex.RV_Custom_IE9121,
			modelname = 'rva1008_1' => Risk_Indicators.BillingIndex.RVA1008_1,
			modelname = 'rvt1104_1' => Risk_Indicators.BillingIndex.RVT1104_1,
			modelname = 'ie912_1'   => Risk_Indicators.BillingIndex.RV_Custom_IE9121,
			modelname = 'ied1106_1' => Risk_Indicators.BillingIndex.IED1106_1,
			modelname = 'rvd1110_1' => Risk_Indicators.BillingIndex.RVD1110_1,
			modelname = 'rvr1104_2' => Risk_Indicators.BillingIndex.RVR1104_2,
			modelname = 'rvg1201_1' => Risk_Indicators.BillingIndex.RVG1201_1,
			modelname = 'rvr1104_3' => Risk_Indicators.BillingIndex.RVR1104_3,
			modelname = 'rvt1204_1' => Risk_Indicators.BillingIndex.RVT1204_1,
			modelname = 'rvt1210_1' => Risk_Indicators.BillingIndex.RVT1210_1,
			modelname = 'rvr1303_1' => Risk_Indicators.BillingIndex.RVR1303_1,
			modelname = 'rvc1210_1' => Risk_Indicators.BillingIndex.RVC1210_1,
			modelname = 'rvt1212_1' => Risk_Indicators.BillingIndex.RVT1212_1,
			modelname = 'rvg1302_1' => Risk_Indicators.BillingIndex.RVG1302_1,
			modelname = 'rva1304_1' => Risk_Indicators.BillingIndex.RVA1304_1,
			modelname = 'rva1304_2' => Risk_Indicators.BillingIndex.RVA1304_2,
			modelname = 'rvg1304_1' => Risk_Indicators.BillingIndex.RVG1304_1,
			modelname = 'rvg1304_2' => Risk_Indicators.BillingIndex.RVG1304_2,
			modelname = 'rva1306_1' => Risk_Indicators.BillingIndex.RVA1306_1,
			modelname = 'rva1305_1' => Risk_Indicators.BillingIndex.RVA1305_1,
			modelname = 'rva1310_1' => Risk_Indicators.BillingIndex.RVA1310_1,
			modelname = 'rva1310_2' => Risk_Indicators.BillingIndex.RVA1310_2,
			modelname = 'rva1310_3' => Risk_Indicators.BillingIndex.RVA1310_3,
			modelname = 'rvt1307_3' => Risk_Indicators.BillingIndex.RVT1307_3,
			modelname = 'rva1311_1' => Risk_Indicators.BillingIndex.RVA1311_1,
			modelname = 'rva1311_2' => Risk_Indicators.BillingIndex.RVA1311_2,
			modelname = 'rva1311_3' => Risk_Indicators.BillingIndex.RVA1311_3,
			modelname = 'rvg1401_1' => Risk_Indicators.BillingIndex.RVG1401_1,
			modelname = 'rvg1401_2' => Risk_Indicators.BillingIndex.RVG1401_2,	
			modelname = 'rvt1402_1' => Risk_Indicators.BillingIndex.RVT1402_1,	
			modelname = 'rvg1310_1' => Risk_Indicators.BillingIndex.RVG1310_1,	
			modelname = 'rvg1404_1' => Risk_Indicators.BillingIndex.RVG1404_1,	
			modelname = 'rvr1311_1' => Risk_Indicators.BillingIndex.RVR1311_1,	
			modelname = 'rvr1410_1' => Risk_Indicators.BillingIndex.RVR1410_1,	
			modelname = 'rvb1310_1' => Risk_Indicators.BillingIndex.RVB1310_1,
			modelname = 'rvb1402_1' => Risk_Indicators.BillingIndex.RVB1402_1,
			modelname = 'rvb1104_1' => Risk_Indicators.BillingIndex.RVB1104_1,
			modelname = 'ied1002_0' => Risk_Indicators.BillingIndex.IED1002_0,
			modelname = 'pva1602_0' => Risk_Indicators.BillingIndex.PVA1602_0,
			modelname = 'fxd1607_0' => Risk_Indicators.BillingIndex.FXD1607_0,
			modelname = 'rvt1605_1' => Risk_Indicators.BillingIndex.RVT1605_1,
			modelname = 'rvt1605_2' => Risk_Indicators.BillingIndex.RVT1605_2,
			modelname = 'rvt1705_1' => Risk_Indicators.BillingIndex.RVT1705_1,
			''		
			);
	
	
	key_modelname := map(
		svcname = 'models.rvauto_service'     and modelname = 'aid607_0' => 'AutoAID607_0',
		svcname = 'models.rvauto_service'     and modelname = 'rva707_1' => 'AutoRVA7071',
		svcname = 'models.rvauto_service'     and modelname = 'rva1007_1' => 'AutoRVA10071',
		svcname = 'models.rvauto_service'     and modelname = 'rva1007_2' => 'AutoRVA10072',
		svcname = 'models.rvauto_service'     and modelname = 'aid605_1' => 'AutoAID605_1',
		svcname = 'models.rvauto_service'     and modelname = ''         => 'Auto',
		svcname = 'models.rvauto_service'     and modelname in ['rva711_0','rva707_0'] => 'Auto_v2', // custom auto rva707_0 gets the same testseeds as flagship auto v2
		svcname = 'models.rvbankcard_service' and modelname = ''         => 'BankCard',
		svcname = 'models.rvbankcard_service' and modelname = 'rvb711_0' => 'BankCard_v2',
		svcname = 'models.rvretail_service'   and modelname = ''         => 'Retail',
		svcname = 'models.rvretail_service'   and modelname = 'rvr711_0' => 'Retail_v2',
		svcname = 'models.rvtelecom_service'  and modelname = ''         => 'Telecom',
		svcname = 'models.rvtelecom_service'  and modelname = 'rvt711_0' => 'Telecom_v2',
		svcname = 'models.rvretail_service'   and modelname = 'rvr803_1' => 'Retail_v2',
		svcname = 'models.rvmoney_service'    and modelname = 'rvg812_0' => 'Money_v2',
		svcname = 'models.rvmoney_service'    and modelname = 'rvg904_1' => 'MoneyRVG9041',
		
		svcname='models.rvretail_service'     and modelname='rvd1010_0' => 'RetailRVD10100',
		svcname='models.rvretail_service'     and modelname='rvd1010_1' => 'RetailRVD10101',
		svcname='models.rvretail_service'     and modelname='rvd1010_2' => 'RetailRVD10102',
		
		// flagship v3
		svcname = 'models.rvauto_service'      and modelname = 'rva1003_0' => 'Auto_v3',
		svcname = 'models.rvbankcard_service'  and modelname = 'rvb1003_0' => 'BankCard_v3',
		svcname = 'models.rvmoney_service'     and modelname = 'rvg1003_0' => 'Money_v3',
		svcname = 'models.rvprescreen_service' and modelname = 'rvp1003_0' => 'PreScreen_v3',
		svcname = 'models.rvretail_service'    and modelname = 'rvr1003_0' => 'Retail_v3',
		svcname = 'models.rvtelecom_service'   and modelname = 'rvt1003_0' => 'Telecom_v3',
		
		// Custom v3
		modelname = 'rva1007_3' => 'AutoRVA10073',
    modelname = 'rvr1008_1' => 'RetailRVR10081',
		
		// flagship v4
		modelname = 'rva1104_0' => 'Auto_v4',
		modelname = 'rvb1104_0' => 'BankCard_v4',
		modelname = 'rvg1103_0' => 'Money_v4',
		modelname = 'rvp1104_0' => 'PreScreen_v4',
		modelname = 'rvr1103_0' => 'Retail_v4',
		modelname = 'rvt1104_0' => 'Telecom_v4',
		
		// Payment Score - Technically a Flagship - but being requested as a custom...
		modelname = 'rvc1112_0' => 'Payment_v4',
		
		modelname = 'ie912_1'   => 'IncomeIE91210',
		modelname = 'ied1106_1' => 'IncomeIED11061',
		modelname = 'rvg1106_1' => 'MoneyRVG11061',
		modelname = 'rva1008_1' => 'AutoRVA10081',
		modelname = 'rvt1104_1' => 'TelecomRVT11041',
		modelname = 'rvd1110_1' => 'RetailRVD11101',
		modelname = 'rvr1104_2' => 'RetailRVR11042',
		modelname = 'rvg1201_1' => 'MoneyRVG12011',
		modelname = 'rvr1104_3' => 'RetailRVR11043',
		modelname = 'rvt1204_1' => 'TelecomRVT12041',
		modelname = 'rvt1210_1' => 'TelecomRVT12101',
		modelname = 'rvr1303_1' => 'RetailRVR13031',
		modelname = 'rvc1210_1' => 'PaymentRVC12101',
		modelname = 'rvt1212_1' => 'TelecomRVT12121',
		modelname = 'rvg1302_1' => 'MoneyRVG13021',
		modelname = 'rva1304_1' => 'AutoRVA13041',
		modelname = 'rva1304_2' => 'AutoRVA13042',
		modelname = 'rvg1304_1' => 'MoneyRVG13041',
		modelname = 'rvg1304_2' => 'MoneyRVG13042',
		modelname = 'rva1306_1' => 'AutoRVA13061',
		modelname = 'rva1305_1' => 'AutoRVA13051',
		modelname = 'rva1310_1' => 'AutoRVA13101',
		modelname = 'rva1310_2' => 'AutoRVA13102',
		modelname = 'rva1310_3' => 'AutoRVA13103',
		modelname = 'rvt1307_3' => 'TelecomRVT13073',
		modelname = 'rva1311_1' => 'AutoRVA13111',
		modelname = 'rva1311_2' => 'AutoRVA13112',
		modelname = 'rva1311_3' => 'AutoRVA13113',
		modelname = 'rvg1401_1' => 'MoneyRVG14011',
		modelname = 'rvg1401_2' => 'MoneyRVG14012',	
		modelname = 'rvt1402_1' => 'TelecomRVT14021',	
		modelname = 'rvg1310_1' => 'MoneyRVG13101',	
		modelname = 'rvg1404_1' => 'MoneyRVG14041',
		modelname = 'rvr1311_1' => 'RetailRVR13111',
		modelname = 'rvr1410_1' => 'RetailRVR14101',
		modelname = 'rvb1310_1' => 'BankCardRVB13101',
		modelname = 'rvb1402_1' => 'BankCardRVB14021',
		modelname = 'rvb1104_1' => 'BankCardRVB11041',
		modelname = 'ied1002_0' => 'IncomeIED10020',
		modelname = 'pva1602_0' => 'PowerViewPVA16020',
		modelname = 'fxd1607_0' => 'FICOScoreXDFXD16070',
		modelname = 'rvt1605_1' => 'TelecomRVT16051',
		modelname = 'rvt1605_2' => 'TelecomRVT16052',
		modelname = 'rvt1705_1' => 'TelecomRVT17051',
		''
	);
	
	layout_rvSeq create_output(inData le, Seed_Files.Key_RiskView ri) := TRANSFORM
		reason_codes_temp := dataset([{ri.hri,ri.hri_desc},{ri.hri2,ri.hri2_desc},{ri.hri3,ri.hri3_desc},{ri.hri4,ri.hri4_desc},{ri.hri5,ri.hri5_desc}], Models.Layout_Reason_Codes);
		risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes);

		// generically handle the "Auto_v2 => Auto" cases
		rv_pattern := '^(Auto|BankCard|Money|PreScreen|Retail|Telecom)_v\\d\\s*$';

		// modify the output description
		out_desc := map(
			svcname='models.rvauto_service' and modelname='rva707_0' => 'AutoRVA7070',
			svcname='models.rvretail_service' and modelname='rvr803_1' => 'RetailRVR8031',
			regexfind( rv_pattern, ri.model_name ) => regexfind( rv_pattern, ri.model_name, 1 ),


			ri.model_name
		);
		
		// scores := dataset([{ri.score,out_desc,idx,reason_codes}], Models.Layout_Score);
		modelName := TRIM(ri.model_name);
		scores := DATASET([{ri.score,out_desc,idx,reason_codes}, 
											 {ri.IV01,modelName + '_IV01','-1',[]}, 
											 {ri.IV02,modelName + '_IV02','-1',[]}, 
											 {ri.IV03,modelName + '_IV03','-1',[]}, 
											 {ri.IV04,modelName + '_IV04','-1',[]}, 
											 {ri.IV05,modelName + '_IV05','-1',[]}, 
											 {ri.IV06,modelName + '_IV06','-1',[]}, 
											 {ri.IV07,modelName + '_IV07','-1',[]}, 
											 {ri.IV08,modelName + '_IV08','-1',[]}, 
											 {ri.IV09,modelName + '_IV09','-1',[]}, 
											 {ri.IV10,modelName + '_IV10','-1',[]}, 
											 {ri.IV11,modelName + '_IV11','-1',[]}, 
											 {ri.IV12,modelName + '_IV12','-1',[]}, 
											 {ri.IV13,modelName + '_IV13','-1',[]}, 
											 {ri.IV14,modelName + '_IV14','-1',[]}, 
											 {ri.IV15,modelName + '_IV15','-1',[]}, 
											 {ri.IV16,modelName + '_IV16','-1',[]}, 
											 {ri.IV17,modelName + '_IV17','-1',[]}, 
											 {ri.IV18,modelName + '_IV18','-1',[]}, 
											 {ri.IV19,modelName + '_IV19','-1',[]}, 
											 {ri.IV20,modelName + '_IV20','-1',[]}, 
											 {ri.IV21,modelName + '_IV21','-1',[]}, 
											 {ri.IV22,modelName + '_IV22','-1',[]}, 
											 {ri.IV23,modelName + '_IV23','-1',[]}, 
											 {ri.IV24,modelName + '_IV24','-1',[]}, 
											 {ri.IV25,modelName + '_IV25','-1',[]}, 
											 {ri.IV26,modelName + '_IV26','-1',[]}, 
											 {ri.IV27,modelName + '_IV27','-1',[]}, 
											 {ri.IV28,modelName + '_IV28','-1',[]}, 
											 {ri.IV29,modelName + '_IV29','-1',[]}, 
											 {ri.IV30,modelName + '_IV30','-1',[]}, 
											 {ri.IV31,modelName + '_IV31','-1',[]}, 
											 {ri.IV32,modelName + '_IV32','-1',[]}, 
											 {ri.IV33,modelName + '_IV33','-1',[]}, 
											 {ri.IV34,modelName + '_IV34','-1',[]}, 
											 {ri.IV35,modelName + '_IV35','-1',[]}, 
											 {ri.IV36,modelName + '_IV36','-1',[]}, 
											 {ri.IV37,modelName + '_IV37','-1',[]}, 
											 {ri.IV38,modelName + '_IV38','-1',[]}, 
											 {ri.IV39,modelName + '_IV39','-1',[]}, 
											 {ri.IV40,modelName + '_IV40','-1',[]}, 
											 {ri.IV41,modelName + '_IV41','-1',[]}, 
											 {ri.IV42,modelName + '_IV42','-1',[]}, 
											 {ri.IV43,modelName + '_IV43','-1',[]}] 
											 , Models.Layout_Score);
		
		self.accountnumber := account_value;
		self.description := ri.service_name;
		self.scores := scores (TRIM(i) != '');
		self.seq := le.seq;
		
	END;
	RiskView_rec := join(inData, Seed_Files.Key_RiskView,
		keyed(right.dataset_name=Test_Data_Table_Name) and 
		keyed(right.hashvalue=Seed_Files.Hash_InstantID(
			(string15)left.fname,
			(string20)left.lname,
			(string9)left.ssn,
			risk_indicators.nullstring,
			(string9)(left.z5+left.zip4),
			(string10)left.phone10,
			risk_indicators.nullstring
		))
		and right.model_name = key_modelname,
		create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
	);

	return RiskView_rec;
END;
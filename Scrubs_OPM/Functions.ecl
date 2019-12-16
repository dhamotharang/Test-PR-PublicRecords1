﻿IMPORT scrubs;

EXPORT Functions := MODULE

  //****************************************************************************
  //fn_numeric:  Returns true if only populated with numbers
  //****************************************************************************
  EXPORT fn_numeric(STRING nmbr) := FUNCTION
    
		RETURN IF(Stringlib.StringFilterOut(nmbr, '0123456789') = '',1,0);
							
  END;		

	//****************************************************************************
	//fn_check_past_date:  Returns true if only for past dates 
	//****************************************************************************
	EXPORT fn_check_past_date(string yyyymmdd) := function
	
		isValidDate	:= IF(Scrubs.fn_valid_pastDate(yyyymmdd) > 0, TRUE, FALSE);                   
		RETURN IF(trim(yyyymmdd,all) = '' OR isValidDate, 1, 0);
		
	END;
	
	//****************************************************************************
	//fn_check_occu_Series_cd: validates vendor occupational_series codes
	//****************************************************************************
	
	EXPORT fn_check_occu_Series_cd(STRING c) := FUNCTION 
	
	 c_c							:= trim(c,all);
	 isValidCode			:= if(c_c in[ '0006','0007','0017','0018','0019','0020','0021', '0023','0025','0028','0029','0030',
																	'0050','0060','0062','0072','0080','0081','0082','0083','0084','0085','0086','0089',
																	'0090','0099','0101','0102','0105','0106','0107','0110','0119','0130','0131','0132',
																	'0134','0135','0136','0140','0142','0150','0160','0170','0180','0181','0184','0185',
																	'0186','0187','0188','0189','0190','0193','0199','0201','0203','0241','0244','0260',
																	'0299','0301','0302','0303','0304','0305','0306','0308','0309','0313','0318','0319',
																	'0322','0326','0332','0335','0340','0341','0342','0343','0344','0346','0350','0356',
																	'0360','0361','0382','0390','0391','0392','0394','0399','0401','0403','0404','0405',
																	'0408','0410','0413','0414','0415','0421','0430','0434','0435','0437','0440','0454',
																	'0455','0457','0458','0459','0460','0462','0470','0471','0480','0482','0485','0486',
																	'0487','0499','0501','0503','0505','0510','0511','0512','0525','0526','0530','0540',
																	'0544','0545','0560','0561','0570','0580','0592','0599','0601','0602','0603','0610',
																	'0620','0621','0622','0630','0631','0633','0635','0636','0637','0638','0639','0640',
																	'0642','0644','0645','0646','0647','0648','0649','0651','0660','0661','0662','0665',
																	'0667','0668','0669','0670','0671','0672','0673','0675','0679','0680','0681','0682',
																	'0683','0685','0688','0690','0696','0698','0699','0701','0704','0799','0801','0802',
																	'0803','0804','0806','0807','0808','0809','0810','0817','0819','0828','0830','0840',
																	'0850','0854','0855','0856','0858','0861','0871','0873','0880','0881','0890','0893',
																	'0895','0896','0899','0901','0904','0905','0930','0935','0950','0958','0962','0963',
																	'0965','0967','0986','0987','0991','0993','0996','0998','0999','1001','1008','1010',
																	'1015','1016','1020','1021','1035','1040','1046','1051','1054','1056','1060','1071',
																	'1082','1083','1084','1087','1099','1101','1102','1103','1104','1105','1106','1107',
																	'1109','1130','1140','1144','1145','1146','1147','1150','1152','1160','1163','1165',
																	'1169','1170','1171','1173','1176','1199','1202','1220','1221','1222','1223','1224',
																	'1226','1301','1306','1310','1311','1313','1315','1316','1320','1321','1330','1340',
																	'1341','1350','1360','1361','1370','1371','1372','1373','1374','1380','1382','1384',
																	'1386','1397','1399','1410','1411','1412','1420','1421','1499','1501','1510','1515',
																	'1520','1521','1529','1530','1531','1541','1550','1599','1601','1603','1630','1640',
																	'1654','1658','1667','1670','1699','1701','1702','1710','1712','1715','1720','1725',
																	'1730','1740','1750','1799','1801','1802','1805','1810','1811','1815','1822','1825',
																	'1831','1849','1850','1860','1862','1863','1881','1889','1894','1895','1896','1899',
																	'1910','1980','1981','1999','2001','2003','2005','2010','2030','2032','2091','2099',
																	'2101','2102','2110','2121','2123','2125','2130','2131','2135','2144','2150','2151',
																	'2152','2154','2161','2181','2183','2185','2186','2210','2299','2501','2502','2504',
																	'2601','2602','2604','2606','2608','2610','2801','2805','2810','2854','2892','2199',
																	'3101','3105','3106','3111','3301','3306','3314','3359','3378','3401','3414','3416',
																	'3501','3502','3511','3513','3515','3546','3566','3601','3602','3603','3604','3605',
																	'3606','3610','3701','3703','3705','3707','3711','3712','3725','3727','3769','3801',
																	'3802','3806','3808','3809','3820','3858','3869','3872','3901','3910','3940','4010',
																	'4101','4102','4104','4201','4204','4206','4255','4301','4352','4361','4373','4401',
																	'4402','4403','4406','4414','4416','4417','4441','4449','4454','4601','4602','4604',
																	'4605','4607','4616','4701','4714','4715','4717','4737','4741','4742','4745','4749',
																	'4754','4801','4804','4805','4816','4818','4819','4840','4850','4855','5001','5002',
																	'5003','5026','5031','5042','5048','5201','5205','5210','5220','5221','5301','5306',
																	'5309','5310','5313','5317','5318','5323','5334','5350','5352','5378','5401','5402',
																	'5406','5407','5408','5409','5413','5415','5419','5423','5426','5427','5439','5440',
																	'5701','5703','5704','5705','5716','5725','5729','5736','5737','5738','5767','5782',
																	'5784','5786','5788','5801','5803','5806','5823','5876','6501','6502','6505','6511',
																	'6517','6601','6605','6610','6641','6652','6656','6901','6904','6907','6910','6912',
																	'6913','6914','6941','6968','7001','7002','7006','7009','7301','7304','7305','7401',
																	'7402','7404','7407','7408','7420','7601','7603','8201','8255','8268','8601','8602',
																	'8610','8801','8810','8840','8852','8862','9901','9902','9903','9904','9905','9906',
																	'9907','9908','9914','9915','9916','9917','9918','9919','9920','9921','9923','9924',
																	'9925','9927','9928','9929','9930','9931','9932','9933','9934','9936','9939','9940',
																	'9942','9944','9945','9952','9954','9955','9957','9960','9961','9965','9968','9971',
																	'9972','9973','9975','9976','9982','9985','9988','9991','9993','9994','9995','9996',
																	'9997','9998','9999'] ,true,false);														 
					 RETURN if(isValidCode,1,0);
					 
	END;
	
END; 
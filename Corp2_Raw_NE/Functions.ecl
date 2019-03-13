﻿IMPORT corp2, corp2_mapping;

EXPORT Functions := Module

	EXPORT NameTypeCode(string code) := Function
	 uc := corp2.t2u(code);
	 return map(uc in['7','19','10115','10129','10134','10139','10140','10141','10142','10143','10146',
										'10148','10149','10151','10154','10156','10158','10159','10160','10162','10196',
										'10197','10198','10199','10200','10201','10202','10203','10204','10205','10206',
										'10207','10208','10209','10210','10211','10212','10219','10224','10226','10227']
																																		 =>'01',
							uc =  '10221'     												             =>'03',
							uc =  '10222'     												             =>'04',	
							uc =  '10220'     																		 =>'05',
							uc in['10213','10214','10215','10216','10217','10218'] =>'07',
							uc =  '10171'    																			 =>'09',
						  '**');
	END;
	
	EXPORT Domestic_Type	:= ['7','10115','10134','10139','10140','10141','10142','10143',
														'10146','10154','10156','10158','10159','10160','10197','10199',
														'10200','10205','10206','10207','10211','10219','10226'];
	
	EXPORT Foreign_Type 	:= ['19','10129','10148','10149','10151','10162','10202',
														'10203','10204','10208','10224','10227'];
											
  EXPORT Contact_Types	:= ['TRADEMARK','PROTECTED NAME','REGISTERED NAME','SERVICE MARK','RESERVATION OF CORPORATE NAME']; 
		
	EXPORT Set_Of_Event_Codes :=['38','39','68','79','91','93','101','107','111','113','116','117','118',
															 '119','121','123','124','125','128','132','140','145','146','151','152',
															 '153','155','156','158','159','160','161','167','168','170','173','174',
															 '175','177','178','179','180','186','187','188','189','191','193','200',
															 '203','204','205','209','211','212','214','215','216','217','220','223',
															 '227','228','229','230','231','232','233','237','254','255','256','257',
															 '258','259','260','261','262','263','264','265','266','267','268','269',
															 '270','271','272','273','274','275','276','277','278','279','280','281',
															 '282','283','284','285','286','287','288','289','290','291','292','293',
															 '294','295','296','297','298','299','300','302',''];
															 
	EXPORT Set_Of_AR_Codes :=['105', '130', '144', '197', '198', '210', '222', '224', '225', '234'];
	
	EXPORT Invalid_Titles :=['NONE','REGISTERED AGENT','AGENT','TEST NEW TITLE OFFICER','NEW OFFICER2',
													 'ZTITLE','TEST NEW TITLE OFFICER1','TEST NEW TITLE OFFICER12','TERM',
													 'NEWTITLE','REGISTERED AGENT TEST','TST','S','TEST','TESTING','TESTER'];

END;
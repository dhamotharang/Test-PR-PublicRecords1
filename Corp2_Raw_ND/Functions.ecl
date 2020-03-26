IMPORT corp2_raw_nd, corp2, corp2_mapping;

EXPORT FUNCTIONs := Module
	
	//********************************************************************
	//  For_Profit: Returns "N" or blank
	//********************************************************************	
	EXPORT  For_Profit(STRING filtyp) 
				:= map (corp2.t2u(filtyp) in ['CORPORATION - NONPROFIT - DOMESTIC',
																			'CORPORATION - NONPROFIT - FOREIGN',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - FOREIGN']  => 'N',
								'');
								
	//********************************************************************
	//  For_or_Dom: Returns "F" or "D"
	//********************************************************************	
	EXPORT  For_or_Dom(STRING filtyp) 
				:= map (corp2.t2u(filtyp) in ['COOPERATIVE - ELECTRIC CORPORATION',
																			'COOPERATIVE - GRAZING ASSOCIATION',
																			'COOPERATIVE - MUTUAL AID',
																			'COOPERATIVE ASSOCIATION - DOMESTIC',
																			'CORPORATION - BUSINESS - DOMESTIC',
																			'CORPORATION - FARM/RANCH - IN-STATE',
																			'CORPORATION - NONPROFIT - DOMESTIC',
																			'CORPORATION - PROFESSIONAL - DOMESTIC',
																			'FICTITIOUS PARTNERSHIP NAME',
																			'INSURANCE COMPANY',
																			'LIMITED LIABILITY COMPANY - BUSINESS - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - FARM/RANCH - IN-STATE',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - PROFESSIONAL - DOMESTIC',
																			'LIMITED LIABILITY LIMITED PARTNERSHIP - DOMESTIC',
																			'LIMITED LIABILITY PARTNERSHIP - DOMESTIC',
																			'LIMITED LIABILITY PARTNERSHIP - PROFESSIONAL - DOMESTIC',
																			'LIMITED PARTNERSHIP - DOMESTIC',
																			'REAL ESTATE INVESTMENT TRUST']	            => 'D',
								corp2.t2u(filtyp) in ['COOPERATIVE ASSOCIATION - FOREIGN',
																			'CORPORATION - BUSINESS - FOREIGN',
																			'CORPORATION - FARM/RANCH - OUT-OF-STATE',
																			'CORPORATION - NONPROFIT - FOREIGN',
																			'CORPORATION - PROFESSIONAL - FOREIGN', 
																			'LIMITED LIABILITY COMPANY - BUSINESS - FOREIGN',
																			'LIMITED LIABILITY COMPANY - FARM/RANCH - OUT-OF-STATE',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - FOREIGN',
																			'LIMITED LIABILITY COMPANY - PROFESSIONAL - FOREIGN',
																			'LIMITED LIABILITY LIMITED PARTNERSHIP - FOREIGN',
																			'LIMITED LIABILITY PARTNERSHIP - FOREIGN', 
																			'LIMITED LIABILITY PARTNERSHIP - PROFESSIONAL - FOREIGN',
																			'LIMITED PARTNERSHIP - FOREIGN']	          => 'F',
								'');
								
  //********************************************************************
	//  NameTyp_desc: Returns value for CORP_LN_NAME_TYPE_DESC
	//********************************************************************	
	EXPORT  NameTyp_desc(STRING filtyp) 
				:= map (corp2.t2u(filtyp) in ['COOPERATIVE - ELECTRIC CORPORATION',
																			'COOPERATIVE - GRAZING ASSOCIATION',
																			'COOPERATIVE - MUTUAL AID',
																			'COOPERATIVE ASSOCIATION - DOMESTIC',
																			'COOPERATIVE ASSOCIATION - FOREIGN',
																			'CORPORATION - BUSINESS - DOMESTIC',
																			'CORPORATION - BUSINESS - FOREIGN',
																			'CORPORATION - FARM/RANCH - IN-STATE',
																			'CORPORATION - FARM/RANCH - OUT-OF-STATE',
																			'CORPORATION - NONPROFIT - DOMESTIC',
																			'CORPORATION - NONPROFIT - FOREIGN',
																			'CORPORATION - PROFESSIONAL - DOMESTIC',
																			'CORPORATION - PROFESSIONAL - FOREIGN', 
																			'INSURANCE COMPANY',
																			'LIMITED LIABILITY COMPANY - BUSINESS - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - BUSINESS - FOREIGN',
																			'LIMITED LIABILITY COMPANY - FARM/RANCH - IN-STATE',
																			'LIMITED LIABILITY COMPANY - FARM/RANCH - OUT-OF-STATE',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - NONPROFIT - FOREIGN',
																			'LIMITED LIABILITY COMPANY - PROFESSIONAL - DOMESTIC',
																			'LIMITED LIABILITY COMPANY - PROFESSIONAL - FOREIGN',
																			'LIMITED LIABILITY LIMITED PARTNERSHIP - DOMESTIC',
																			'LIMITED LIABILITY LIMITED PARTNERSHIP - FOREIGN',
																			'LIMITED LIABILITY PARTNERSHIP - DOMESTIC',
																			'LIMITED LIABILITY PARTNERSHIP - FOREIGN', 
																			'LIMITED LIABILITY PARTNERSHIP - PROFESSIONAL - DOMESTIC',
																			'LIMITED LIABILITY PARTNERSHIP - PROFESSIONAL - FOREIGN',
																			'LIMITED PARTNERSHIP - DOMESTIC',
																			'LIMITED PARTNERSHIP - FOREIGN',
																			'REAL ESTATE INVESTMENT TRUST']	      => 'LEGAL',
								corp2.t2u(filtyp) =   'TRADE NAME'  				                => 'TRADENAME',
								corp2.t2u(filtyp) =   'FICTITIOUS PARTNERSHIP NAME'  			  => 'FBN',
								'**|'+ corp2.t2u(filtyp));
								
END;
         
                            


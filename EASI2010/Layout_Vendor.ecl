
// Record layouts from vendor
export Layout_Vendor := MODULE

// layout for 2010 census data
export Layout_Census := RECORD
		Layout_Common.Hdr;

		INTEGER8   		POP10;                                              
		INTEGER8		HH10;
		Layout_common.Demographics;
		Layout_common.RetailTrade;                                 

END;

export Layout_Current_yr := RECORD
		Layout_Common.Hdr;

		INTEGER8   		POP90;                                              
		INTEGER8		POP00;                                              
		INTEGER8		POP10;                                              
		INTEGER8		POP11;                                              
		INTEGER8   		POP16;                                              
		DECIMAL6_2   	POPGROW11;                                          
		DECIMAL6_2		POPFORE16;                                          
		DECIMAL6_2		HHGROW11;                                           
		DECIMAL6_2		HHFORE16;                                           
		INTEGER8		HH90;                                               
		INTEGER8		HH00;                                               
		INTEGER8		HH10;                                               
		INTEGER8		HH11;                                               
		INTEGER8		HH16;
		Layout_common.Demographics;
		Layout_common.RetailTrade;                                 

		Layout_common.QualityOfLife;
		Layout_common.BusinessCounts;
		Layout_common.SocData;
		Layout_common.Expenditures;
		Layout_common.ProfileData;
END;

export Layout_Projection := RECORD
		Layout_Common.Hdr;
		INTEGER8   		POP16;                                              
		INTEGER8		HH16;                                               
		Layout_common.Demographics;
		Layout_common.RetailTrade;
		Layout_common.Expenditures;
END;


END;
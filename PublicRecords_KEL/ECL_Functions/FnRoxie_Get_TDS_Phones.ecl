IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_Get_TDS_Phones(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput) := FUNCTION
																	
	TDS := JOIN(BusinessInput,  Risk_Indicators.Key_Telcordia_TDS,
								(UNSIGNED)LEFT.B_InpClnPhone !=0 AND
								KEYED(LEFT.B_InpClnPhone[1..3]=(RIGHT.npa)) AND 
								KEYED(LEFT.B_InpClnPhone[4..6]=RIGHT.nxx) AND
								LEFT.B_InpClnPhone[7]=	RIGHT.tb,  
						TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII,
									SELF.COCType := RIGHT.coctype;
									SELF.SSC := RIGHT.ssc;
									SELF.WirelessIndicator := RIGHT.wireless_ind;
									SELF := LEFT), 
						LEFT OUTER, KEEP(1),ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_2000));
																								
	RETURN TDS;																
END;	
import strata,ut;

ds := CanadianPhones.file_axciomCanBus.v2;
 
rPopulationStats_file_CanadianPhones_base
 :=
  record
	  string3  grouping                                 := 'ALL';
    CountGroup                                          := count(group);		
    Record_ID_CountNonZero          			        := sum(group,if(ds.Record_ID<>'',1,0));
    Phone_Number_CountNonZero                           := sum(group,if(ds.Phone_Number<>'',1,0));
    Province_CountNonZero                               := sum(group,if(ds.Province<>'',1,0));
    Business_Name_CountNonZero                           := sum(group,if(ds.Business_Name<>'',1,0));
    Street_Number_CountNonZero                          := sum(group,if(ds.Street_Number<>'',1,0));
    Street_Directional_CountNonZero                     := 0;//sum(group,if(ds.Street_Directional<>'',1,0));
    Street_Name_CountNonZero                            := sum(group,if(ds.Street_Name<>'',1,0));
    City_CountNonZero               		            := sum(group,if(ds.City<>'',1,0));
    Postal_Code_CountNonZero                            := sum(group,if(ds.Postal_Code<>'',1,0));
    Pub_Date_CountNonZero                               := sum(group,if(ds.Pub_Date<>'',1,0));
    Filler_CountNonZero                                 := 0;//sum(group,if(ds.Filler<>'',1,0));
    YPHC_1_CountNonZero                                 := sum(group,if(ds.SYPH_1<>'',1,0));
    YPHC_2_CountNonZero                                 := sum(group,if(ds.SYPH_2<>'',1,0));
    YPHC_3_CountNonZero                                 := sum(group,if(ds.SYPH_3<>'',1,0));
    YPHC_4_CountNonZero                                 := sum(group,if(ds.SYPH_4<>'',1,0));
    YPHC_5_CountNonZero                                 := sum(group,if(ds.SYPH_5<>'',1,0));
    YPHC_6_CountNonZero                                 := sum(group,if(ds.SYPH_6<>'',1,0));
    SIC_1_CountNonBlank                                 := sum(group,if(ds.SIC_1<>'',1,0));
    SIC_2_CountNonBlank                                 := sum(group,if(ds.SIC_2<>'',1,0));
    SIC_3_CountNonBlank                                 := sum(group,if(ds.SIC_3<>'',1,0));
    SIC_4_CountNonBlank                                 := sum(group,if(ds.SIC_4<>'',1,0));
    Bus_Govt_Indicator_CountNonBlank                    := sum(group,if(ds.Bus_Govt_Indicator<>'',1,0));
    Latitude_CountNonBlank                              := sum(group,if(ds.Latitude<>'',1,0));
    Longitude_CountNonBlank                             := sum(group,if(ds.Longitude<>'',1,0));
    Lat_Long_Level_Applied_CountNonBlank                := sum(group,if(ds.Lat_Long_Level_Applied<>'',1,0));
    Filler1_CountNonBlank                               := 0;//sum(group,if(ds.Filler1<>'',1,0));
    Record_Use_Indicator_CountNonBlank                  := sum(group,if(ds.Record_Use_Indicator<>'',1,0));
    Filler2_CountNonBlank                               := 0;//sum(group,if(ds. Filler2<>'',1,0));
	

	
  end;

tStats := table(ds,rPopulationStats_file_CanadianPhones_base,few);

strata.createXMLStats(tStats,'CanadianPhonesBus','data',ut.GetDate,'',resultsOut);

export strata_popCanadianPhonesBaseBus:= resultsOut;



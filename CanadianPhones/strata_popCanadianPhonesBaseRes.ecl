
import strata,ut;

ds := CanadianPhones.file_axciomCanRes.v2;

rPopulationStats_file_CanadianPhones_base
 := record
	string3  grouping                                 := 'ALL';
		CountGroup                                     := count(group);
    Record_ID_CountNonBlank                        := sum(group,if(ds.Record_ID<>'',1,0));
    Phone_Number_CountNonBlank                     := sum(group,if(ds.Phone_Number<>'',1,0));
    Province_CountNonBlank                         := sum(group,if(ds.Province<>'',1,0));
    Book_Number_CountNonBlank                      := sum(group,if(ds.Book_Number<>'',1,0));
    Postal_Code_CountNonBlank					   					 := sum(group,if(ds.Postal_Code<>'',1,0));
    Filler1_RESCountNonBlank                          := sum(group,if(ds.Filler1<>'',1,0));
    First_Name_CountNonBlank                       := sum(group,if(ds.First_Name<>'',1,0));
    Middle_Initial_CountNonBlank                   := sum(group,if(ds.Middle_Initial<>'',1,0));
    Last_Name_CountNonBlank                        := sum(group,if(ds.Last_Name<>'',1,0));
    Generational_Suffix_CountNonZero               := sum(group,if(ds.Generational_Suffix<>'',1,0));
    Secondary_Name_CountNonBlank                   := 0;//sum(group,if(ds.Secondary_Name<>'',1,0));
    Filler2_RESCountNonBlank                          := sum(group,if(ds.Filler2<>'',1,0));
    Street_Number_CountNonBlank                    := sum(group,if(ds.Street_Number<>'',1,0));
    Street_Directional_CountNonBlank               := 0;//sum(group,if(ds.Street_Directional<>'',1,0));
    Street_Name_CountNonBlank                      := sum(group,if(ds.Street_Name<>'',1,0));
    Room_Number_CountNonBlank                      := sum(group,if(ds.unit_Number<>'',1,0));
    Room_Code_CountNonBlank                        := sum(group,if(ds.unit_designator<>'',1,0));
    City_CountNonBlank                             := sum(group,if(ds.City<>'',1,0));
    Pub_Date_CountNonBlank                         := sum(group,if(ds.Pub_Date<>'',1,0));
    Filler3_CountNonBlank                          := 0;//sum(group,if(ds.Filler3<>'',1,0));
    Vanity_City_Name_CountNonBlank                 := sum(group,if(ds.Vanity_City_Name<>'',1,0));
    Status_Indicator_CountNonBlank                 := 0;//sum(group,if(ds.Status_code<>'',1,0));
    Latitude_RESCountNonBlank                      := sum(group,if(ds.Latitude<>'',1,0));
    Longitude_RESCountNonBlank                     := sum(group,if(ds.Longitude<>'',1,0));
    Lat_Long_Level_Applied_RESCountNonBlank        := sum(group,if(ds.Lat_Long_Level_Applied<>'',1,0));
    Record_Type_CountNonBlank					   					 := 0;//sum(group,if(ds.Record_Type<>'',1,0));
    Record_Use_IndicatorRES_CountNonBlank          := sum(group,if(ds.Record_Use_Indicator<>'',1,0));
    
	
  end;

tStats := table(ds,rPopulationStats_file_CanadianPhones_base,few);

strata.createXMLStats(tStats,'CanadianPhonesRes','data',ut.GetDate,'',resultsOut);

export strata_popCanadianPhonesBaseRes := resultsOut;


 
 
//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Neighborhood(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Some_Person_;
    KEL.typ.nint Ave_Occupant_Owned_;
    KEL.typ.nint Cnt_Occupant_Owned_;
    KEL.typ.nint Ave_Building_Age_;
    KEL.typ.nint Cnt_Building_Age_;
    KEL.typ.nint Ave_Purchase_Amount_;
    KEL.typ.nint Cnt_Purchase_Amount_;
    KEL.typ.nint Ave_Purchase_Age_;
    KEL.typ.nint Cnt_Purchase_Age_;
    KEL.typ.nint Ave_Mortgage_Amount_;
    KEL.typ.nint Cnt_Mortgage_Amount_;
    KEL.typ.nint Ave_Mortgage_Age_;
    KEL.typ.nint Cnt_Mortgage_Age_;
    KEL.typ.nint Ave_Assessed_Amount_;
    KEL.typ.nint Cnt_Assessed_Amount_;
    KEL.typ.nint Ave_Building_Area_;
    KEL.typ.nint Cnt_Building_Area_;
    KEL.typ.nint Ave_Price_Per_Sf_;
    KEL.typ.nint Cnt_Price_Per_Sf_;
    KEL.typ.nint Ave_No_Of_Buildings_Count_;
    KEL.typ.nint Cnt_No_Of_Buildings_Count_;
    KEL.typ.nint Ave_No_Of_Stories_Count_;
    KEL.typ.nint Cnt_No_Of_Stories_Count_;
    KEL.typ.nint Ave_No_Of_Rooms_Count_;
    KEL.typ.nint Cnt_No_Of_Rooms_Count_;
    KEL.typ.nint Ave_No_Of_Bedrooms_Count_;
    KEL.typ.nint Cnt_No_Of_Bedrooms_Count_;
    KEL.typ.nint Ave_No_Of_Baths_Count_;
    KEL.typ.nint Cnt_No_Of_Baths_Count_;
    KEL.typ.nint Ave_No_Of_Partial_Baths_Count_;
    KEL.typ.nint Cnt_No_Of_Partial_Baths_Count_;
    KEL.typ.nint Ave_Parking_No_Of_Cars_;
    KEL.typ.nint Cnt_Parking_No_Of_Cars_;
    KEL.typ.nint Total_Property_Count_;
    KEL.typ.nint Neighborhood_Vacant_Properties_;
    KEL.typ.nint Neighborhood_Business_Count_;
    KEL.typ.nint Neighborhood_Sfd_Count_;
    KEL.typ.nint Neighborhood_Mfd_Count_;
    KEL.typ.nint Neighborhood_Collegeaddr_Count_;
    KEL.typ.nint Neighborhood_Seasonaladdr_Count_;
    KEL.typ.nint Neighborhood_Property_Count_;
    KEL.typ.nfloat Foreclosure_Geo12_Index_;
    KEL.typ.nfloat Foreclosure_Fips_Index_;
    KEL.typ.nint Foreclosure_Property_Count_;
    KEL.typ.nint Foreclosure_Count_;
    KEL.typ.nint Occupants_;
    KEL.typ.nint Occupants1_Year_;
    KEL.typ.nint Occupants2_Years_;
    KEL.typ.nint Occupants3_Years_;
    KEL.typ.nint Occupants4_Years_;
    KEL.typ.nint Occupants5_Years_;
    KEL.typ.nint Turnover1_Year_In_;
    KEL.typ.nint Turnover1_Year_Out_;
    KEL.typ.nint Turnover2_Years_In_;
    KEL.typ.nint Turnover2_Years_Out_;
    KEL.typ.nint Turnover3_Years_In_;
    KEL.typ.nint Turnover3_Years_Out_;
    KEL.typ.nint Turnover4_Years_In_;
    KEL.typ.nint Turnover4_Years_Out_;
    KEL.typ.nint Turnover5_Years_In_;
    KEL.typ.nint Turnover5_Years_Out_;
    KEL.typ.nint Crimes_;
    KEL.typ.nint Crimes1_Year_;
    KEL.typ.nint Crimes2_Years_;
    KEL.typ.nint Crimes3_Years_;
    KEL.typ.nint Crimes4_Years_;
    KEL.typ.nint Crimes5_Years_;
    KEL.typ.nint Foreclosures_;
    KEL.typ.nint Foreclosures1_Year_;
    KEL.typ.nint Foreclosures2_Years_;
    KEL.typ.nint Foreclosures3_Years_;
    KEL.typ.nint Foreclosures4_Years_;
    KEL.typ.nint Foreclosures5_Years_;
    KEL.typ.nint Sex_Offenders_;
    KEL.typ.nint Sex_Offenders1_Year_;
    KEL.typ.nint Sex_Offenders2_Years_;
    KEL.typ.nint Sex_Offenders3_Years_;
    KEL.typ.nint Sex_Offenders4_Years_;
    KEL.typ.nint Sex_Offenders5_Years_;
    KEL.typ.nkdate History_Date_;
    KEL.typ.nint Median_Valuation_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'fips_geolink(UID),did(Some_Person_:0),aveoccupantowned(Ave_Occupant_Owned_:0),cntoccupantowned(Cnt_Occupant_Owned_:0),avebuildingage(Ave_Building_Age_:0),cntbuildingage(Cnt_Building_Age_:0),avepurchaseamount(Ave_Purchase_Amount_:0),cntpurchaseamount(Cnt_Purchase_Amount_:0),avepurchaseage(Ave_Purchase_Age_:0),cntpurchaseage(Cnt_Purchase_Age_:0),avemortgageamount(Ave_Mortgage_Amount_:0),cntmortgageamount(Cnt_Mortgage_Amount_:0),avemortgageage(Ave_Mortgage_Age_:0),cntmortgageage(Cnt_Mortgage_Age_:0),aveassessedamount(Ave_Assessed_Amount_:0),cntassessedamount(Cnt_Assessed_Amount_:0),avebuildingarea(Ave_Building_Area_:0),cntbuildingarea(Cnt_Building_Area_:0),avepricepersf(Ave_Price_Per_Sf_:0),cntpricepersf(Cnt_Price_Per_Sf_:0),avenoofbuildingscount(Ave_No_Of_Buildings_Count_:0),cntnoofbuildingscount(Cnt_No_Of_Buildings_Count_:0),avenoofstoriescount(Ave_No_Of_Stories_Count_:0),cntnoofstoriescount(Cnt_No_Of_Stories_Count_:0),avenoofroomscount(Ave_No_Of_Rooms_Count_:0),cntnoofroomscount(Cnt_No_Of_Rooms_Count_:0),avenoofbedroomscount(Ave_No_Of_Bedrooms_Count_:0),cntnoofbedroomscount(Cnt_No_Of_Bedrooms_Count_:0),avenoofbathscount(Ave_No_Of_Baths_Count_:0),cntnoofbathscount(Cnt_No_Of_Baths_Count_:0),avenoofpartialbathscount(Ave_No_Of_Partial_Baths_Count_:0),cntnoofpartialbathscount(Cnt_No_Of_Partial_Baths_Count_:0),aveparkingnoofcars(Ave_Parking_No_Of_Cars_:0),cntparkingnoofcars(Cnt_Parking_No_Of_Cars_:0),totalpropertycount(Total_Property_Count_:0),neighborhoodvacantproperties(Neighborhood_Vacant_Properties_:0),neighborhoodbusinesscount(Neighborhood_Business_Count_:0),neighborhoodsfdcount(Neighborhood_Sfd_Count_:0),neighborhoodmfdcount(Neighborhood_Mfd_Count_:0),neighborhoodcollegeaddrcount(Neighborhood_Collegeaddr_Count_:0),neighborhoodseasonaladdrcount(Neighborhood_Seasonaladdr_Count_:0),neighborhoodpropertycount(Neighborhood_Property_Count_:0),foreclosuregeo12index(Foreclosure_Geo12_Index_:0.0),foreclosurefipsindex(Foreclosure_Fips_Index_:0.0),foreclosurepropertycount(Foreclosure_Property_Count_:0),foreclosurecount(Foreclosure_Count_:0),occupants(Occupants_:0),occupants1year(Occupants1_Year_:0),occupants2years(Occupants2_Years_:0),occupants3years(Occupants3_Years_:0),occupants4years(Occupants4_Years_:0),occupants5years(Occupants5_Years_:0),turnover1yearin(Turnover1_Year_In_:0),turnover1yearout(Turnover1_Year_Out_:0),turnover2yearsin(Turnover2_Years_In_:0),turnover2yearsout(Turnover2_Years_Out_:0),turnover3yearsin(Turnover3_Years_In_:0),turnover3yearsout(Turnover3_Years_Out_:0),turnover4yearsin(Turnover4_Years_In_:0),turnover4yearsout(Turnover4_Years_Out_:0),turnover5yearsin(Turnover5_Years_In_:0),turnover5yearsout(Turnover5_Years_Out_:0),crimes(Crimes_:0),crimes1year(Crimes1_Year_:0),crimes2years(Crimes2_Years_:0),crimes3years(Crimes3_Years_:0),crimes4years(Crimes4_Years_:0),crimes5years(Crimes5_Years_:0),foreclosures(Foreclosures_:0),foreclosures1year(Foreclosures1_Year_:0),foreclosures2years(Foreclosures2_Years_:0),foreclosures3years(Foreclosures3_Years_:0),foreclosures4years(Foreclosures4_Years_:0),foreclosures5years(Foreclosures5_Years_:0),sexoffenders(Sex_Offenders_:0),sexoffenders1year(Sex_Offenders1_Year_:0),sexoffenders2years(Sex_Offenders2_Years_:0),sexoffenders3years(Sex_Offenders3_Years_:0),sexoffenders4years(Sex_Offenders4_Years_:0),sexoffenders5years(Sex_Offenders5_Years_:0),historydate(History_Date_:DATE),medianvaluation(Median_Valuation_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __in((KEL.typ.uid)FIPS_geolink = 0);
  SHARED __d0_Prefiltered := __in((KEL.typ.uid)FIPS_geolink <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT History_Layout := RECORD
    KEL.typ.nkdate History_Date_;
    KEL.typ.nint Median_Valuation_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Some_Person_;
    KEL.typ.nint Ave_Occupant_Owned_;
    KEL.typ.nint Cnt_Occupant_Owned_;
    KEL.typ.nint Ave_Building_Age_;
    KEL.typ.nint Cnt_Building_Age_;
    KEL.typ.nint Ave_Purchase_Amount_;
    KEL.typ.nint Cnt_Purchase_Amount_;
    KEL.typ.nint Ave_Purchase_Age_;
    KEL.typ.nint Cnt_Purchase_Age_;
    KEL.typ.nint Ave_Mortgage_Amount_;
    KEL.typ.nint Cnt_Mortgage_Amount_;
    KEL.typ.nint Ave_Mortgage_Age_;
    KEL.typ.nint Cnt_Mortgage_Age_;
    KEL.typ.nint Ave_Assessed_Amount_;
    KEL.typ.nint Cnt_Assessed_Amount_;
    KEL.typ.nint Ave_Building_Area_;
    KEL.typ.nint Cnt_Building_Area_;
    KEL.typ.nint Ave_Price_Per_Sf_;
    KEL.typ.nint Cnt_Price_Per_Sf_;
    KEL.typ.nint Ave_No_Of_Buildings_Count_;
    KEL.typ.nint Cnt_No_Of_Buildings_Count_;
    KEL.typ.nint Ave_No_Of_Stories_Count_;
    KEL.typ.nint Cnt_No_Of_Stories_Count_;
    KEL.typ.nint Ave_No_Of_Rooms_Count_;
    KEL.typ.nint Cnt_No_Of_Rooms_Count_;
    KEL.typ.nint Ave_No_Of_Bedrooms_Count_;
    KEL.typ.nint Cnt_No_Of_Bedrooms_Count_;
    KEL.typ.nint Ave_No_Of_Baths_Count_;
    KEL.typ.nint Cnt_No_Of_Baths_Count_;
    KEL.typ.nint Ave_No_Of_Partial_Baths_Count_;
    KEL.typ.nint Cnt_No_Of_Partial_Baths_Count_;
    KEL.typ.nint Ave_Parking_No_Of_Cars_;
    KEL.typ.nint Cnt_Parking_No_Of_Cars_;
    KEL.typ.nint Total_Property_Count_;
    KEL.typ.nint Neighborhood_Vacant_Properties_;
    KEL.typ.nint Neighborhood_Business_Count_;
    KEL.typ.nint Neighborhood_Sfd_Count_;
    KEL.typ.nint Neighborhood_Mfd_Count_;
    KEL.typ.nint Neighborhood_Collegeaddr_Count_;
    KEL.typ.nint Neighborhood_Seasonaladdr_Count_;
    KEL.typ.nint Neighborhood_Property_Count_;
    KEL.typ.nfloat Foreclosure_Geo12_Index_;
    KEL.typ.nfloat Foreclosure_Fips_Index_;
    KEL.typ.nint Foreclosure_Property_Count_;
    KEL.typ.nint Foreclosure_Count_;
    KEL.typ.nint Occupants_;
    KEL.typ.nint Occupants1_Year_;
    KEL.typ.nint Occupants2_Years_;
    KEL.typ.nint Occupants3_Years_;
    KEL.typ.nint Occupants4_Years_;
    KEL.typ.nint Occupants5_Years_;
    KEL.typ.nint Turnover1_Year_In_;
    KEL.typ.nint Turnover1_Year_Out_;
    KEL.typ.nint Turnover2_Years_In_;
    KEL.typ.nint Turnover2_Years_Out_;
    KEL.typ.nint Turnover3_Years_In_;
    KEL.typ.nint Turnover3_Years_Out_;
    KEL.typ.nint Turnover4_Years_In_;
    KEL.typ.nint Turnover4_Years_Out_;
    KEL.typ.nint Turnover5_Years_In_;
    KEL.typ.nint Turnover5_Years_Out_;
    KEL.typ.nint Crimes_;
    KEL.typ.nint Crimes1_Year_;
    KEL.typ.nint Crimes2_Years_;
    KEL.typ.nint Crimes3_Years_;
    KEL.typ.nint Crimes4_Years_;
    KEL.typ.nint Crimes5_Years_;
    KEL.typ.nint Foreclosures_;
    KEL.typ.nint Foreclosures1_Year_;
    KEL.typ.nint Foreclosures2_Years_;
    KEL.typ.nint Foreclosures3_Years_;
    KEL.typ.nint Foreclosures4_Years_;
    KEL.typ.nint Foreclosures5_Years_;
    KEL.typ.nint Sex_Offenders_;
    KEL.typ.nint Sex_Offenders1_Year_;
    KEL.typ.nint Sex_Offenders2_Years_;
    KEL.typ.nint Sex_Offenders3_Years_;
    KEL.typ.nint Sex_Offenders4_Years_;
    KEL.typ.nint Sex_Offenders5_Years_;
    KEL.typ.ndataset(History_Layout) History_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Neighborhood_Group := __PostFilter;
  Layout Neighborhood__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Some_Person_ := KEL.Intake.SingleValue(__recs,Some_Person_);
    SELF.Ave_Occupant_Owned_ := KEL.Intake.SingleValue(__recs,Ave_Occupant_Owned_);
    SELF.Cnt_Occupant_Owned_ := KEL.Intake.SingleValue(__recs,Cnt_Occupant_Owned_);
    SELF.Ave_Building_Age_ := KEL.Intake.SingleValue(__recs,Ave_Building_Age_);
    SELF.Cnt_Building_Age_ := KEL.Intake.SingleValue(__recs,Cnt_Building_Age_);
    SELF.Ave_Purchase_Amount_ := KEL.Intake.SingleValue(__recs,Ave_Purchase_Amount_);
    SELF.Cnt_Purchase_Amount_ := KEL.Intake.SingleValue(__recs,Cnt_Purchase_Amount_);
    SELF.Ave_Purchase_Age_ := KEL.Intake.SingleValue(__recs,Ave_Purchase_Age_);
    SELF.Cnt_Purchase_Age_ := KEL.Intake.SingleValue(__recs,Cnt_Purchase_Age_);
    SELF.Ave_Mortgage_Amount_ := KEL.Intake.SingleValue(__recs,Ave_Mortgage_Amount_);
    SELF.Cnt_Mortgage_Amount_ := KEL.Intake.SingleValue(__recs,Cnt_Mortgage_Amount_);
    SELF.Ave_Mortgage_Age_ := KEL.Intake.SingleValue(__recs,Ave_Mortgage_Age_);
    SELF.Cnt_Mortgage_Age_ := KEL.Intake.SingleValue(__recs,Cnt_Mortgage_Age_);
    SELF.Ave_Assessed_Amount_ := KEL.Intake.SingleValue(__recs,Ave_Assessed_Amount_);
    SELF.Cnt_Assessed_Amount_ := KEL.Intake.SingleValue(__recs,Cnt_Assessed_Amount_);
    SELF.Ave_Building_Area_ := KEL.Intake.SingleValue(__recs,Ave_Building_Area_);
    SELF.Cnt_Building_Area_ := KEL.Intake.SingleValue(__recs,Cnt_Building_Area_);
    SELF.Ave_Price_Per_Sf_ := KEL.Intake.SingleValue(__recs,Ave_Price_Per_Sf_);
    SELF.Cnt_Price_Per_Sf_ := KEL.Intake.SingleValue(__recs,Cnt_Price_Per_Sf_);
    SELF.Ave_No_Of_Buildings_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Buildings_Count_);
    SELF.Cnt_No_Of_Buildings_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Buildings_Count_);
    SELF.Ave_No_Of_Stories_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Stories_Count_);
    SELF.Cnt_No_Of_Stories_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Stories_Count_);
    SELF.Ave_No_Of_Rooms_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Rooms_Count_);
    SELF.Cnt_No_Of_Rooms_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Rooms_Count_);
    SELF.Ave_No_Of_Bedrooms_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Bedrooms_Count_);
    SELF.Cnt_No_Of_Bedrooms_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Bedrooms_Count_);
    SELF.Ave_No_Of_Baths_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Baths_Count_);
    SELF.Cnt_No_Of_Baths_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Baths_Count_);
    SELF.Ave_No_Of_Partial_Baths_Count_ := KEL.Intake.SingleValue(__recs,Ave_No_Of_Partial_Baths_Count_);
    SELF.Cnt_No_Of_Partial_Baths_Count_ := KEL.Intake.SingleValue(__recs,Cnt_No_Of_Partial_Baths_Count_);
    SELF.Ave_Parking_No_Of_Cars_ := KEL.Intake.SingleValue(__recs,Ave_Parking_No_Of_Cars_);
    SELF.Cnt_Parking_No_Of_Cars_ := KEL.Intake.SingleValue(__recs,Cnt_Parking_No_Of_Cars_);
    SELF.Total_Property_Count_ := KEL.Intake.SingleValue(__recs,Total_Property_Count_);
    SELF.Neighborhood_Vacant_Properties_ := KEL.Intake.SingleValue(__recs,Neighborhood_Vacant_Properties_);
    SELF.Neighborhood_Business_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Business_Count_);
    SELF.Neighborhood_Sfd_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Sfd_Count_);
    SELF.Neighborhood_Mfd_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Mfd_Count_);
    SELF.Neighborhood_Collegeaddr_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Collegeaddr_Count_);
    SELF.Neighborhood_Seasonaladdr_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Seasonaladdr_Count_);
    SELF.Neighborhood_Property_Count_ := KEL.Intake.SingleValue(__recs,Neighborhood_Property_Count_);
    SELF.Foreclosure_Geo12_Index_ := KEL.Intake.SingleValue(__recs,Foreclosure_Geo12_Index_);
    SELF.Foreclosure_Fips_Index_ := KEL.Intake.SingleValue(__recs,Foreclosure_Fips_Index_);
    SELF.Foreclosure_Property_Count_ := KEL.Intake.SingleValue(__recs,Foreclosure_Property_Count_);
    SELF.Foreclosure_Count_ := KEL.Intake.SingleValue(__recs,Foreclosure_Count_);
    SELF.Occupants_ := KEL.Intake.SingleValue(__recs,Occupants_);
    SELF.Occupants1_Year_ := KEL.Intake.SingleValue(__recs,Occupants1_Year_);
    SELF.Occupants2_Years_ := KEL.Intake.SingleValue(__recs,Occupants2_Years_);
    SELF.Occupants3_Years_ := KEL.Intake.SingleValue(__recs,Occupants3_Years_);
    SELF.Occupants4_Years_ := KEL.Intake.SingleValue(__recs,Occupants4_Years_);
    SELF.Occupants5_Years_ := KEL.Intake.SingleValue(__recs,Occupants5_Years_);
    SELF.Turnover1_Year_In_ := KEL.Intake.SingleValue(__recs,Turnover1_Year_In_);
    SELF.Turnover1_Year_Out_ := KEL.Intake.SingleValue(__recs,Turnover1_Year_Out_);
    SELF.Turnover2_Years_In_ := KEL.Intake.SingleValue(__recs,Turnover2_Years_In_);
    SELF.Turnover2_Years_Out_ := KEL.Intake.SingleValue(__recs,Turnover2_Years_Out_);
    SELF.Turnover3_Years_In_ := KEL.Intake.SingleValue(__recs,Turnover3_Years_In_);
    SELF.Turnover3_Years_Out_ := KEL.Intake.SingleValue(__recs,Turnover3_Years_Out_);
    SELF.Turnover4_Years_In_ := KEL.Intake.SingleValue(__recs,Turnover4_Years_In_);
    SELF.Turnover4_Years_Out_ := KEL.Intake.SingleValue(__recs,Turnover4_Years_Out_);
    SELF.Turnover5_Years_In_ := KEL.Intake.SingleValue(__recs,Turnover5_Years_In_);
    SELF.Turnover5_Years_Out_ := KEL.Intake.SingleValue(__recs,Turnover5_Years_Out_);
    SELF.Crimes_ := KEL.Intake.SingleValue(__recs,Crimes_);
    SELF.Crimes1_Year_ := KEL.Intake.SingleValue(__recs,Crimes1_Year_);
    SELF.Crimes2_Years_ := KEL.Intake.SingleValue(__recs,Crimes2_Years_);
    SELF.Crimes3_Years_ := KEL.Intake.SingleValue(__recs,Crimes3_Years_);
    SELF.Crimes4_Years_ := KEL.Intake.SingleValue(__recs,Crimes4_Years_);
    SELF.Crimes5_Years_ := KEL.Intake.SingleValue(__recs,Crimes5_Years_);
    SELF.Foreclosures_ := KEL.Intake.SingleValue(__recs,Foreclosures_);
    SELF.Foreclosures1_Year_ := KEL.Intake.SingleValue(__recs,Foreclosures1_Year_);
    SELF.Foreclosures2_Years_ := KEL.Intake.SingleValue(__recs,Foreclosures2_Years_);
    SELF.Foreclosures3_Years_ := KEL.Intake.SingleValue(__recs,Foreclosures3_Years_);
    SELF.Foreclosures4_Years_ := KEL.Intake.SingleValue(__recs,Foreclosures4_Years_);
    SELF.Foreclosures5_Years_ := KEL.Intake.SingleValue(__recs,Foreclosures5_Years_);
    SELF.Sex_Offenders_ := KEL.Intake.SingleValue(__recs,Sex_Offenders_);
    SELF.Sex_Offenders1_Year_ := KEL.Intake.SingleValue(__recs,Sex_Offenders1_Year_);
    SELF.Sex_Offenders2_Years_ := KEL.Intake.SingleValue(__recs,Sex_Offenders2_Years_);
    SELF.Sex_Offenders3_Years_ := KEL.Intake.SingleValue(__recs,Sex_Offenders3_Years_);
    SELF.Sex_Offenders4_Years_ := KEL.Intake.SingleValue(__recs,Sex_Offenders4_Years_);
    SELF.Sex_Offenders5_Years_ := KEL.Intake.SingleValue(__recs,Sex_Offenders5_Years_);
    SELF.History_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),History_Date_,Median_Valuation_},History_Date_,Median_Valuation_),History_Layout)(__NN(History_Date_) OR __NN(Median_Valuation_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Neighborhood__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.History_ := __CN(PROJECT(DATASET(__r),TRANSFORM(History_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(History_Date_) OR __NN(Median_Valuation_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Neighborhood_Group,COUNT(ROWS(LEFT))=1),GROUP,Neighborhood__Single_Rollup(LEFT)) + ROLLUP(HAVING(Neighborhood_Group,COUNT(ROWS(LEFT))>1),GROUP,Neighborhood__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Neighborhood::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Some_Person__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Some_Person_);
  EXPORT Ave_Occupant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Occupant_Owned_);
  EXPORT Cnt_Occupant_Owned__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Occupant_Owned_);
  EXPORT Ave_Building_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Building_Age_);
  EXPORT Cnt_Building_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Building_Age_);
  EXPORT Ave_Purchase_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Purchase_Amount_);
  EXPORT Cnt_Purchase_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Purchase_Amount_);
  EXPORT Ave_Purchase_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Purchase_Age_);
  EXPORT Cnt_Purchase_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Purchase_Age_);
  EXPORT Ave_Mortgage_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Mortgage_Amount_);
  EXPORT Cnt_Mortgage_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Mortgage_Amount_);
  EXPORT Ave_Mortgage_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Mortgage_Age_);
  EXPORT Cnt_Mortgage_Age__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Mortgage_Age_);
  EXPORT Ave_Assessed_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Assessed_Amount_);
  EXPORT Cnt_Assessed_Amount__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Assessed_Amount_);
  EXPORT Ave_Building_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Building_Area_);
  EXPORT Cnt_Building_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Building_Area_);
  EXPORT Ave_Price_Per_Sf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Price_Per_Sf_);
  EXPORT Cnt_Price_Per_Sf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Price_Per_Sf_);
  EXPORT Ave_No_Of_Buildings_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Buildings_Count_);
  EXPORT Cnt_No_Of_Buildings_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Buildings_Count_);
  EXPORT Ave_No_Of_Stories_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Stories_Count_);
  EXPORT Cnt_No_Of_Stories_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Stories_Count_);
  EXPORT Ave_No_Of_Rooms_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Rooms_Count_);
  EXPORT Cnt_No_Of_Rooms_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Rooms_Count_);
  EXPORT Ave_No_Of_Bedrooms_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Bedrooms_Count_);
  EXPORT Cnt_No_Of_Bedrooms_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Bedrooms_Count_);
  EXPORT Ave_No_Of_Baths_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Baths_Count_);
  EXPORT Cnt_No_Of_Baths_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Baths_Count_);
  EXPORT Ave_No_Of_Partial_Baths_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_No_Of_Partial_Baths_Count_);
  EXPORT Cnt_No_Of_Partial_Baths_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_No_Of_Partial_Baths_Count_);
  EXPORT Ave_Parking_No_Of_Cars__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ave_Parking_No_Of_Cars_);
  EXPORT Cnt_Parking_No_Of_Cars__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Cnt_Parking_No_Of_Cars_);
  EXPORT Total_Property_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Total_Property_Count_);
  EXPORT Neighborhood_Vacant_Properties__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Vacant_Properties_);
  EXPORT Neighborhood_Business_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Business_Count_);
  EXPORT Neighborhood_Sfd_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Sfd_Count_);
  EXPORT Neighborhood_Mfd_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Mfd_Count_);
  EXPORT Neighborhood_Collegeaddr_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Collegeaddr_Count_);
  EXPORT Neighborhood_Seasonaladdr_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Seasonaladdr_Count_);
  EXPORT Neighborhood_Property_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Neighborhood_Property_Count_);
  EXPORT Foreclosure_Geo12_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosure_Geo12_Index_);
  EXPORT Foreclosure_Fips_Index__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosure_Fips_Index_);
  EXPORT Foreclosure_Property_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosure_Property_Count_);
  EXPORT Foreclosure_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosure_Count_);
  EXPORT Occupants__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants_);
  EXPORT Occupants1_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants1_Year_);
  EXPORT Occupants2_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants2_Years_);
  EXPORT Occupants3_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants3_Years_);
  EXPORT Occupants4_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants4_Years_);
  EXPORT Occupants5_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Occupants5_Years_);
  EXPORT Turnover1_Year_In__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover1_Year_In_);
  EXPORT Turnover1_Year_Out__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover1_Year_Out_);
  EXPORT Turnover2_Years_In__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover2_Years_In_);
  EXPORT Turnover2_Years_Out__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover2_Years_Out_);
  EXPORT Turnover3_Years_In__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover3_Years_In_);
  EXPORT Turnover3_Years_Out__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover3_Years_Out_);
  EXPORT Turnover4_Years_In__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover4_Years_In_);
  EXPORT Turnover4_Years_Out__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover4_Years_Out_);
  EXPORT Turnover5_Years_In__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover5_Years_In_);
  EXPORT Turnover5_Years_Out__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Turnover5_Years_Out_);
  EXPORT Crimes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes_);
  EXPORT Crimes1_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes1_Year_);
  EXPORT Crimes2_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes2_Years_);
  EXPORT Crimes3_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes3_Years_);
  EXPORT Crimes4_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes4_Years_);
  EXPORT Crimes5_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Crimes5_Years_);
  EXPORT Foreclosures__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures_);
  EXPORT Foreclosures1_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures1_Year_);
  EXPORT Foreclosures2_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures2_Years_);
  EXPORT Foreclosures3_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures3_Years_);
  EXPORT Foreclosures4_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures4_Years_);
  EXPORT Foreclosures5_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Foreclosures5_Years_);
  EXPORT Sex_Offenders__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders_);
  EXPORT Sex_Offenders1_Year__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders1_Year_);
  EXPORT Sex_Offenders2_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders2_Years_);
  EXPORT Sex_Offenders3_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders3_Years_);
  EXPORT Sex_Offenders4_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders4_Years_);
  EXPORT Sex_Offenders5_Years__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sex_Offenders5_Years_);
  EXPORT Some_Person__Orphan := JOIN(InData(__NN(Some_Person_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Some_Person_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Some_Person__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Some_Person__SingleValue_Invalid),COUNT(Ave_Occupant_Owned__SingleValue_Invalid),COUNT(Cnt_Occupant_Owned__SingleValue_Invalid),COUNT(Ave_Building_Age__SingleValue_Invalid),COUNT(Cnt_Building_Age__SingleValue_Invalid),COUNT(Ave_Purchase_Amount__SingleValue_Invalid),COUNT(Cnt_Purchase_Amount__SingleValue_Invalid),COUNT(Ave_Purchase_Age__SingleValue_Invalid),COUNT(Cnt_Purchase_Age__SingleValue_Invalid),COUNT(Ave_Mortgage_Amount__SingleValue_Invalid),COUNT(Cnt_Mortgage_Amount__SingleValue_Invalid),COUNT(Ave_Mortgage_Age__SingleValue_Invalid),COUNT(Cnt_Mortgage_Age__SingleValue_Invalid),COUNT(Ave_Assessed_Amount__SingleValue_Invalid),COUNT(Cnt_Assessed_Amount__SingleValue_Invalid),COUNT(Ave_Building_Area__SingleValue_Invalid),COUNT(Cnt_Building_Area__SingleValue_Invalid),COUNT(Ave_Price_Per_Sf__SingleValue_Invalid),COUNT(Cnt_Price_Per_Sf__SingleValue_Invalid),COUNT(Ave_No_Of_Buildings_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Buildings_Count__SingleValue_Invalid),COUNT(Ave_No_Of_Stories_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Stories_Count__SingleValue_Invalid),COUNT(Ave_No_Of_Rooms_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Rooms_Count__SingleValue_Invalid),COUNT(Ave_No_Of_Bedrooms_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Bedrooms_Count__SingleValue_Invalid),COUNT(Ave_No_Of_Baths_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Baths_Count__SingleValue_Invalid),COUNT(Ave_No_Of_Partial_Baths_Count__SingleValue_Invalid),COUNT(Cnt_No_Of_Partial_Baths_Count__SingleValue_Invalid),COUNT(Ave_Parking_No_Of_Cars__SingleValue_Invalid),COUNT(Cnt_Parking_No_Of_Cars__SingleValue_Invalid),COUNT(Total_Property_Count__SingleValue_Invalid),COUNT(Neighborhood_Vacant_Properties__SingleValue_Invalid),COUNT(Neighborhood_Business_Count__SingleValue_Invalid),COUNT(Neighborhood_Sfd_Count__SingleValue_Invalid),COUNT(Neighborhood_Mfd_Count__SingleValue_Invalid),COUNT(Neighborhood_Collegeaddr_Count__SingleValue_Invalid),COUNT(Neighborhood_Seasonaladdr_Count__SingleValue_Invalid),COUNT(Neighborhood_Property_Count__SingleValue_Invalid),COUNT(Foreclosure_Geo12_Index__SingleValue_Invalid),COUNT(Foreclosure_Fips_Index__SingleValue_Invalid),COUNT(Foreclosure_Property_Count__SingleValue_Invalid),COUNT(Foreclosure_Count__SingleValue_Invalid),COUNT(Occupants__SingleValue_Invalid),COUNT(Occupants1_Year__SingleValue_Invalid),COUNT(Occupants2_Years__SingleValue_Invalid),COUNT(Occupants3_Years__SingleValue_Invalid),COUNT(Occupants4_Years__SingleValue_Invalid),COUNT(Occupants5_Years__SingleValue_Invalid),COUNT(Turnover1_Year_In__SingleValue_Invalid),COUNT(Turnover1_Year_Out__SingleValue_Invalid),COUNT(Turnover2_Years_In__SingleValue_Invalid),COUNT(Turnover2_Years_Out__SingleValue_Invalid),COUNT(Turnover3_Years_In__SingleValue_Invalid),COUNT(Turnover3_Years_Out__SingleValue_Invalid),COUNT(Turnover4_Years_In__SingleValue_Invalid),COUNT(Turnover4_Years_Out__SingleValue_Invalid),COUNT(Turnover5_Years_In__SingleValue_Invalid),COUNT(Turnover5_Years_Out__SingleValue_Invalid),COUNT(Crimes__SingleValue_Invalid),COUNT(Crimes1_Year__SingleValue_Invalid),COUNT(Crimes2_Years__SingleValue_Invalid),COUNT(Crimes3_Years__SingleValue_Invalid),COUNT(Crimes4_Years__SingleValue_Invalid),COUNT(Crimes5_Years__SingleValue_Invalid),COUNT(Foreclosures__SingleValue_Invalid),COUNT(Foreclosures1_Year__SingleValue_Invalid),COUNT(Foreclosures2_Years__SingleValue_Invalid),COUNT(Foreclosures3_Years__SingleValue_Invalid),COUNT(Foreclosures4_Years__SingleValue_Invalid),COUNT(Foreclosures5_Years__SingleValue_Invalid),COUNT(Sex_Offenders__SingleValue_Invalid),COUNT(Sex_Offenders1_Year__SingleValue_Invalid),COUNT(Sex_Offenders2_Years__SingleValue_Invalid),COUNT(Sex_Offenders3_Years__SingleValue_Invalid),COUNT(Sex_Offenders4_Years__SingleValue_Invalid),COUNT(Sex_Offenders5_Years__SingleValue_Invalid)}],{KEL.typ.int Some_Person__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Some_Person__SingleValue_Invalid,KEL.typ.int Ave_Occupant_Owned__SingleValue_Invalid,KEL.typ.int Cnt_Occupant_Owned__SingleValue_Invalid,KEL.typ.int Ave_Building_Age__SingleValue_Invalid,KEL.typ.int Cnt_Building_Age__SingleValue_Invalid,KEL.typ.int Ave_Purchase_Amount__SingleValue_Invalid,KEL.typ.int Cnt_Purchase_Amount__SingleValue_Invalid,KEL.typ.int Ave_Purchase_Age__SingleValue_Invalid,KEL.typ.int Cnt_Purchase_Age__SingleValue_Invalid,KEL.typ.int Ave_Mortgage_Amount__SingleValue_Invalid,KEL.typ.int Cnt_Mortgage_Amount__SingleValue_Invalid,KEL.typ.int Ave_Mortgage_Age__SingleValue_Invalid,KEL.typ.int Cnt_Mortgage_Age__SingleValue_Invalid,KEL.typ.int Ave_Assessed_Amount__SingleValue_Invalid,KEL.typ.int Cnt_Assessed_Amount__SingleValue_Invalid,KEL.typ.int Ave_Building_Area__SingleValue_Invalid,KEL.typ.int Cnt_Building_Area__SingleValue_Invalid,KEL.typ.int Ave_Price_Per_Sf__SingleValue_Invalid,KEL.typ.int Cnt_Price_Per_Sf__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Buildings_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Buildings_Count__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Stories_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Stories_Count__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Rooms_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Rooms_Count__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Bedrooms_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Bedrooms_Count__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Baths_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Baths_Count__SingleValue_Invalid,KEL.typ.int Ave_No_Of_Partial_Baths_Count__SingleValue_Invalid,KEL.typ.int Cnt_No_Of_Partial_Baths_Count__SingleValue_Invalid,KEL.typ.int Ave_Parking_No_Of_Cars__SingleValue_Invalid,KEL.typ.int Cnt_Parking_No_Of_Cars__SingleValue_Invalid,KEL.typ.int Total_Property_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Vacant_Properties__SingleValue_Invalid,KEL.typ.int Neighborhood_Business_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Sfd_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Mfd_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Collegeaddr_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Seasonaladdr_Count__SingleValue_Invalid,KEL.typ.int Neighborhood_Property_Count__SingleValue_Invalid,KEL.typ.int Foreclosure_Geo12_Index__SingleValue_Invalid,KEL.typ.int Foreclosure_Fips_Index__SingleValue_Invalid,KEL.typ.int Foreclosure_Property_Count__SingleValue_Invalid,KEL.typ.int Foreclosure_Count__SingleValue_Invalid,KEL.typ.int Occupants__SingleValue_Invalid,KEL.typ.int Occupants1_Year__SingleValue_Invalid,KEL.typ.int Occupants2_Years__SingleValue_Invalid,KEL.typ.int Occupants3_Years__SingleValue_Invalid,KEL.typ.int Occupants4_Years__SingleValue_Invalid,KEL.typ.int Occupants5_Years__SingleValue_Invalid,KEL.typ.int Turnover1_Year_In__SingleValue_Invalid,KEL.typ.int Turnover1_Year_Out__SingleValue_Invalid,KEL.typ.int Turnover2_Years_In__SingleValue_Invalid,KEL.typ.int Turnover2_Years_Out__SingleValue_Invalid,KEL.typ.int Turnover3_Years_In__SingleValue_Invalid,KEL.typ.int Turnover3_Years_Out__SingleValue_Invalid,KEL.typ.int Turnover4_Years_In__SingleValue_Invalid,KEL.typ.int Turnover4_Years_Out__SingleValue_Invalid,KEL.typ.int Turnover5_Years_In__SingleValue_Invalid,KEL.typ.int Turnover5_Years_Out__SingleValue_Invalid,KEL.typ.int Crimes__SingleValue_Invalid,KEL.typ.int Crimes1_Year__SingleValue_Invalid,KEL.typ.int Crimes2_Years__SingleValue_Invalid,KEL.typ.int Crimes3_Years__SingleValue_Invalid,KEL.typ.int Crimes4_Years__SingleValue_Invalid,KEL.typ.int Crimes5_Years__SingleValue_Invalid,KEL.typ.int Foreclosures__SingleValue_Invalid,KEL.typ.int Foreclosures1_Year__SingleValue_Invalid,KEL.typ.int Foreclosures2_Years__SingleValue_Invalid,KEL.typ.int Foreclosures3_Years__SingleValue_Invalid,KEL.typ.int Foreclosures4_Years__SingleValue_Invalid,KEL.typ.int Foreclosures5_Years__SingleValue_Invalid,KEL.typ.int Sex_Offenders__SingleValue_Invalid,KEL.typ.int Sex_Offenders1_Year__SingleValue_Invalid,KEL.typ.int Sex_Offenders2_Years__SingleValue_Invalid,KEL.typ.int Sex_Offenders3_Years__SingleValue_Invalid,KEL.typ.int Sex_Offenders4_Years__SingleValue_Invalid,KEL.typ.int Sex_Offenders5_Years__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Some_Person_))),COUNT(__d0(__NN(Some_Person_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveOccupantOwned',COUNT(__d0(__NL(Ave_Occupant_Owned_))),COUNT(__d0(__NN(Ave_Occupant_Owned_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntOccupantOwned',COUNT(__d0(__NL(Cnt_Occupant_Owned_))),COUNT(__d0(__NN(Cnt_Occupant_Owned_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveBuildingAge',COUNT(__d0(__NL(Ave_Building_Age_))),COUNT(__d0(__NN(Ave_Building_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntBuildingAge',COUNT(__d0(__NL(Cnt_Building_Age_))),COUNT(__d0(__NN(Cnt_Building_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AvePurchaseAmount',COUNT(__d0(__NL(Ave_Purchase_Amount_))),COUNT(__d0(__NN(Ave_Purchase_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntPurchaseAmount',COUNT(__d0(__NL(Cnt_Purchase_Amount_))),COUNT(__d0(__NN(Cnt_Purchase_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AvePurchaseAge',COUNT(__d0(__NL(Ave_Purchase_Age_))),COUNT(__d0(__NN(Ave_Purchase_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntPurchaseAge',COUNT(__d0(__NL(Cnt_Purchase_Age_))),COUNT(__d0(__NN(Cnt_Purchase_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveMortgageAmount',COUNT(__d0(__NL(Ave_Mortgage_Amount_))),COUNT(__d0(__NN(Ave_Mortgage_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntMortgageAmount',COUNT(__d0(__NL(Cnt_Mortgage_Amount_))),COUNT(__d0(__NN(Cnt_Mortgage_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveMortgageAge',COUNT(__d0(__NL(Ave_Mortgage_Age_))),COUNT(__d0(__NN(Ave_Mortgage_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntMortgageAge',COUNT(__d0(__NL(Cnt_Mortgage_Age_))),COUNT(__d0(__NN(Cnt_Mortgage_Age_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveAssessedAmount',COUNT(__d0(__NL(Ave_Assessed_Amount_))),COUNT(__d0(__NN(Ave_Assessed_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntAssessedAmount',COUNT(__d0(__NL(Cnt_Assessed_Amount_))),COUNT(__d0(__NN(Cnt_Assessed_Amount_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveBuildingArea',COUNT(__d0(__NL(Ave_Building_Area_))),COUNT(__d0(__NN(Ave_Building_Area_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntBuildingArea',COUNT(__d0(__NL(Cnt_Building_Area_))),COUNT(__d0(__NN(Cnt_Building_Area_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AvePricePerSf',COUNT(__d0(__NL(Ave_Price_Per_Sf_))),COUNT(__d0(__NN(Ave_Price_Per_Sf_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntPricePerSf',COUNT(__d0(__NL(Cnt_Price_Per_Sf_))),COUNT(__d0(__NN(Cnt_Price_Per_Sf_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfBuildingsCount',COUNT(__d0(__NL(Ave_No_Of_Buildings_Count_))),COUNT(__d0(__NN(Ave_No_Of_Buildings_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfBuildingsCount',COUNT(__d0(__NL(Cnt_No_Of_Buildings_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Buildings_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfStoriesCount',COUNT(__d0(__NL(Ave_No_Of_Stories_Count_))),COUNT(__d0(__NN(Ave_No_Of_Stories_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfStoriesCount',COUNT(__d0(__NL(Cnt_No_Of_Stories_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Stories_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfRoomsCount',COUNT(__d0(__NL(Ave_No_Of_Rooms_Count_))),COUNT(__d0(__NN(Ave_No_Of_Rooms_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfRoomsCount',COUNT(__d0(__NL(Cnt_No_Of_Rooms_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Rooms_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfBedroomsCount',COUNT(__d0(__NL(Ave_No_Of_Bedrooms_Count_))),COUNT(__d0(__NN(Ave_No_Of_Bedrooms_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfBedroomsCount',COUNT(__d0(__NL(Cnt_No_Of_Bedrooms_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Bedrooms_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfBathsCount',COUNT(__d0(__NL(Ave_No_Of_Baths_Count_))),COUNT(__d0(__NN(Ave_No_Of_Baths_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfBathsCount',COUNT(__d0(__NL(Cnt_No_Of_Baths_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Baths_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveNoOfPartialBathsCount',COUNT(__d0(__NL(Ave_No_Of_Partial_Baths_Count_))),COUNT(__d0(__NN(Ave_No_Of_Partial_Baths_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntNoOfPartialBathsCount',COUNT(__d0(__NL(Cnt_No_Of_Partial_Baths_Count_))),COUNT(__d0(__NN(Cnt_No_Of_Partial_Baths_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AveParkingNoOfCars',COUNT(__d0(__NL(Ave_Parking_No_Of_Cars_))),COUNT(__d0(__NN(Ave_Parking_No_Of_Cars_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CntParkingNoOfCars',COUNT(__d0(__NL(Cnt_Parking_No_Of_Cars_))),COUNT(__d0(__NN(Cnt_Parking_No_Of_Cars_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalPropertyCount',COUNT(__d0(__NL(Total_Property_Count_))),COUNT(__d0(__NN(Total_Property_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodVacantProperties',COUNT(__d0(__NL(Neighborhood_Vacant_Properties_))),COUNT(__d0(__NN(Neighborhood_Vacant_Properties_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodBusinessCount',COUNT(__d0(__NL(Neighborhood_Business_Count_))),COUNT(__d0(__NN(Neighborhood_Business_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodSfdCount',COUNT(__d0(__NL(Neighborhood_Sfd_Count_))),COUNT(__d0(__NN(Neighborhood_Sfd_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodMfdCount',COUNT(__d0(__NL(Neighborhood_Mfd_Count_))),COUNT(__d0(__NN(Neighborhood_Mfd_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodCollegeaddrCount',COUNT(__d0(__NL(Neighborhood_Collegeaddr_Count_))),COUNT(__d0(__NN(Neighborhood_Collegeaddr_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodSeasonaladdrCount',COUNT(__d0(__NL(Neighborhood_Seasonaladdr_Count_))),COUNT(__d0(__NN(Neighborhood_Seasonaladdr_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NeighborhoodPropertyCount',COUNT(__d0(__NL(Neighborhood_Property_Count_))),COUNT(__d0(__NN(Neighborhood_Property_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ForeclosureGeo12Index',COUNT(__d0(__NL(Foreclosure_Geo12_Index_))),COUNT(__d0(__NN(Foreclosure_Geo12_Index_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ForeclosureFipsIndex',COUNT(__d0(__NL(Foreclosure_Fips_Index_))),COUNT(__d0(__NN(Foreclosure_Fips_Index_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ForeclosurePropertyCount',COUNT(__d0(__NL(Foreclosure_Property_Count_))),COUNT(__d0(__NN(Foreclosure_Property_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ForeclosureCount',COUNT(__d0(__NL(Foreclosure_Count_))),COUNT(__d0(__NN(Foreclosure_Count_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants',COUNT(__d0(__NL(Occupants_))),COUNT(__d0(__NN(Occupants_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants1Year',COUNT(__d0(__NL(Occupants1_Year_))),COUNT(__d0(__NN(Occupants1_Year_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants2Years',COUNT(__d0(__NL(Occupants2_Years_))),COUNT(__d0(__NN(Occupants2_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants3Years',COUNT(__d0(__NL(Occupants3_Years_))),COUNT(__d0(__NN(Occupants3_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants4Years',COUNT(__d0(__NL(Occupants4_Years_))),COUNT(__d0(__NN(Occupants4_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Occupants5Years',COUNT(__d0(__NL(Occupants5_Years_))),COUNT(__d0(__NN(Occupants5_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover1YearIn',COUNT(__d0(__NL(Turnover1_Year_In_))),COUNT(__d0(__NN(Turnover1_Year_In_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover1YearOut',COUNT(__d0(__NL(Turnover1_Year_Out_))),COUNT(__d0(__NN(Turnover1_Year_Out_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover2YearsIn',COUNT(__d0(__NL(Turnover2_Years_In_))),COUNT(__d0(__NN(Turnover2_Years_In_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover2YearsOut',COUNT(__d0(__NL(Turnover2_Years_Out_))),COUNT(__d0(__NN(Turnover2_Years_Out_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover3YearsIn',COUNT(__d0(__NL(Turnover3_Years_In_))),COUNT(__d0(__NN(Turnover3_Years_In_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover3YearsOut',COUNT(__d0(__NL(Turnover3_Years_Out_))),COUNT(__d0(__NN(Turnover3_Years_Out_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover4YearsIn',COUNT(__d0(__NL(Turnover4_Years_In_))),COUNT(__d0(__NN(Turnover4_Years_In_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover4YearsOut',COUNT(__d0(__NL(Turnover4_Years_Out_))),COUNT(__d0(__NN(Turnover4_Years_Out_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover5YearsIn',COUNT(__d0(__NL(Turnover5_Years_In_))),COUNT(__d0(__NN(Turnover5_Years_In_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Turnover5YearsOut',COUNT(__d0(__NL(Turnover5_Years_Out_))),COUNT(__d0(__NN(Turnover5_Years_Out_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes',COUNT(__d0(__NL(Crimes_))),COUNT(__d0(__NN(Crimes_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes1Year',COUNT(__d0(__NL(Crimes1_Year_))),COUNT(__d0(__NN(Crimes1_Year_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes2Years',COUNT(__d0(__NL(Crimes2_Years_))),COUNT(__d0(__NN(Crimes2_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes3Years',COUNT(__d0(__NL(Crimes3_Years_))),COUNT(__d0(__NN(Crimes3_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes4Years',COUNT(__d0(__NL(Crimes4_Years_))),COUNT(__d0(__NN(Crimes4_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Crimes5Years',COUNT(__d0(__NL(Crimes5_Years_))),COUNT(__d0(__NN(Crimes5_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures',COUNT(__d0(__NL(Foreclosures_))),COUNT(__d0(__NN(Foreclosures_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures1Year',COUNT(__d0(__NL(Foreclosures1_Year_))),COUNT(__d0(__NN(Foreclosures1_Year_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures2Years',COUNT(__d0(__NL(Foreclosures2_Years_))),COUNT(__d0(__NN(Foreclosures2_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures3Years',COUNT(__d0(__NL(Foreclosures3_Years_))),COUNT(__d0(__NN(Foreclosures3_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures4Years',COUNT(__d0(__NL(Foreclosures4_Years_))),COUNT(__d0(__NN(Foreclosures4_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Foreclosures5Years',COUNT(__d0(__NL(Foreclosures5_Years_))),COUNT(__d0(__NN(Foreclosures5_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders',COUNT(__d0(__NL(Sex_Offenders_))),COUNT(__d0(__NN(Sex_Offenders_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders1Year',COUNT(__d0(__NL(Sex_Offenders1_Year_))),COUNT(__d0(__NN(Sex_Offenders1_Year_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders2Years',COUNT(__d0(__NL(Sex_Offenders2_Years_))),COUNT(__d0(__NN(Sex_Offenders2_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders3Years',COUNT(__d0(__NL(Sex_Offenders3_Years_))),COUNT(__d0(__NN(Sex_Offenders3_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders4Years',COUNT(__d0(__NL(Sex_Offenders4_Years_))),COUNT(__d0(__NN(Sex_Offenders4_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexOffenders5Years',COUNT(__d0(__NL(Sex_Offenders5_Years_))),COUNT(__d0(__NN(Sex_Offenders5_Years_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistoryDate',COUNT(__d0(__NL(History_Date_))),COUNT(__d0(__NN(History_Date_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MedianValuation',COUNT(__d0(__NL(Median_Valuation_))),COUNT(__d0(__NN(Median_Valuation_)))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Neighborhood','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;

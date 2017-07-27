export Files_DL_Conv_Points_Base := module
  
   export Base_Conviction    := dataset(DriversV2.Constants.Cluster + 'base::DL2::CP_Convictions', DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions, thor);
   
   export Base_Suspension    := dataset(DriversV2.Constants.Cluster + 'base::DL2::CP_Suspensions', DriversV2.Layouts_DL_Conv_Points_Common.Layout_Suspensions, thor);
   
   export Base_DR_Info       := dataset(DriversV2.Constants.Cluster + 'base::DL2::CP_DR_Info', DriversV2.Layouts_DL_Conv_Points_Common.Layout_Driver_Record_Info, thor);
   
   export Base_Accident      := dataset(DriversV2.Constants.Cluster + 'base::DL2::CP_Accidents', DriversV2.Layouts_DL_Conv_Points_Common.Layout_Accident, thor);
   
   export Base_FRA_Insurance := dataset(DriversV2.Constants.Cluster + 'base::DL2::CP_FRA_Insurance', DriversV2.Layouts_DL_Conv_Points_Common.Layout_FRA_Insurance, thor);
   
   
end;
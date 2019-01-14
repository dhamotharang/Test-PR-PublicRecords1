IMPORT KEL05 AS KEL;
IMPORT $.E_PerVeh,$.E_Person,$.E_Vehicle;
IMPORT * FROM KEL05.Null;
EXPORT B_PerVeh := MODULE
  SHARED __EE371 := E_PerVeh.__Result;
  SHARED __IDX_PerVeh_Per_Veh_Filtered := __EE371(__NN(__EE371.Per));
  SHARED IDX_PerVeh_Per_Veh_Layout := RECORD
    E_Person.Typ Per := __T(__IDX_PerVeh_Per_Veh_Filtered.Per);
    __IDX_PerVeh_Per_Veh_Filtered.Veh;
    __IDX_PerVeh_Per_Veh_Filtered.Transaction;
  END;
  SHARED IDX_PerVeh_Per_Veh_Projected := TABLE(__IDX_PerVeh_Per_Veh_Filtered,IDX_PerVeh_Per_Veh_Layout);
  EXPORT IDX_PerVeh_Per_Veh := INDEX(IDX_PerVeh_Per_Veh_Projected,{Per},{IDX_PerVeh_Per_Veh_Projected},'~key::KEL::PerVeh::Per::Veh');
  EXPORT IDX_PerVeh_Per_Veh_Build := BUILD(IDX_PerVeh_Per_Veh,OVERWRITE);
  EXPORT __ST373_Layout := RECORDOF(IDX_PerVeh_Per_Veh);
  EXPORT IDX_PerVeh_Per_Veh_Wrapped := PROJECT(IDX_PerVeh_Per_Veh,TRANSFORM(E_PerVeh.Layout,SELF.Per := __CN(LEFT.Per),SELF:=LEFT));
  SHARED __EE381 := E_PerVeh.__Result;
  SHARED __IDX_PerVeh_Veh_Per_Filtered := __EE381(__NN(__EE381.Veh));
  SHARED IDX_PerVeh_Veh_Per_Layout := RECORD
    E_Vehicle.Typ Veh := __T(__IDX_PerVeh_Veh_Per_Filtered.Veh);
    __IDX_PerVeh_Veh_Per_Filtered.Per;
    __IDX_PerVeh_Veh_Per_Filtered.Transaction;
  END;
  SHARED IDX_PerVeh_Veh_Per_Projected := TABLE(__IDX_PerVeh_Veh_Per_Filtered,IDX_PerVeh_Veh_Per_Layout);
  EXPORT IDX_PerVeh_Veh_Per := INDEX(IDX_PerVeh_Veh_Per_Projected,{Veh},{IDX_PerVeh_Veh_Per_Projected},'~key::KEL::PerVeh::Veh::Per');
  EXPORT IDX_PerVeh_Veh_Per_Build := BUILD(IDX_PerVeh_Veh_Per,OVERWRITE);
  EXPORT __ST383_Layout := RECORDOF(IDX_PerVeh_Veh_Per);
  EXPORT BuildAll := PARALLEL(IDX_PerVeh_Per_Veh_Build,IDX_PerVeh_Veh_Per_Build);
END;

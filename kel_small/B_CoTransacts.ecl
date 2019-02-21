IMPORT KEL05 AS KEL;
IMPORT $.E_CoTransacts,$.E_Person;
IMPORT * FROM KEL05.Null;
EXPORT B_CoTransacts := MODULE
  SHARED __EE355 := E_CoTransacts.__Result;
  SHARED __IDX_CoTransacts_who_whoelse_Filtered := __EE355(__NN(__EE355.who));
  SHARED IDX_CoTransacts_who_whoelse_Layout := RECORD
    E_Person.Typ who := __T(__IDX_CoTransacts_who_whoelse_Filtered.who);
    __IDX_CoTransacts_who_whoelse_Filtered.whoelse;
    __IDX_CoTransacts_who_whoelse_Filtered.__ST22;
  END;
  SHARED IDX_CoTransacts_who_whoelse_Projected := TABLE(__IDX_CoTransacts_who_whoelse_Filtered,IDX_CoTransacts_who_whoelse_Layout);
  EXPORT IDX_CoTransacts_who_whoelse := INDEX(IDX_CoTransacts_who_whoelse_Projected,{who},{IDX_CoTransacts_who_whoelse_Projected},'~key::KEL::CoTransacts::who::whoelse');
  EXPORT IDX_CoTransacts_who_whoelse_Build := BUILD(IDX_CoTransacts_who_whoelse,OVERWRITE);
  EXPORT __ST357_Layout := RECORDOF(IDX_CoTransacts_who_whoelse);
  EXPORT IDX_CoTransacts_who_whoelse_Wrapped := PROJECT(IDX_CoTransacts_who_whoelse,TRANSFORM(E_CoTransacts.Layout,SELF.who := __CN(LEFT.who),SELF:=LEFT));
  SHARED __EE364 := E_CoTransacts.__Result;
  SHARED __IDX_CoTransacts_whoelse_who_Filtered := __EE364(__NN(__EE364.whoelse));
  SHARED IDX_CoTransacts_whoelse_who_Layout := RECORD
    E_Person.Typ whoelse := __T(__IDX_CoTransacts_whoelse_who_Filtered.whoelse);
    __IDX_CoTransacts_whoelse_who_Filtered.who;
    __IDX_CoTransacts_whoelse_who_Filtered.__ST22;
  END;
  SHARED IDX_CoTransacts_whoelse_who_Projected := TABLE(__IDX_CoTransacts_whoelse_who_Filtered,IDX_CoTransacts_whoelse_who_Layout);
  EXPORT IDX_CoTransacts_whoelse_who := INDEX(IDX_CoTransacts_whoelse_who_Projected,{whoelse},{IDX_CoTransacts_whoelse_who_Projected},'~key::KEL::CoTransacts::whoelse::who');
  EXPORT IDX_CoTransacts_whoelse_who_Build := BUILD(IDX_CoTransacts_whoelse_who,OVERWRITE);
  EXPORT __ST366_Layout := RECORDOF(IDX_CoTransacts_whoelse_who);
  EXPORT BuildAll := PARALLEL(IDX_CoTransacts_who_whoelse_Build,IDX_CoTransacts_whoelse_who_Build);
END;

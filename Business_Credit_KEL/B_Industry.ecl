//HPCC Systems KEL Compiler Version v0.6.2beta1
IMPORT KEL06a AS KEL;
IMPORT CFG_graph,E_Industry FROM $;
IMPORT * FROM KEL06a.Null;
EXPORT B_Industry(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED __EE982157 := E_Industry(__in,__cfg).__Result;
  SHARED IDX_Industry_UID_Layout := RECORD
    KEL.typ.uid UID := __T(__EE982157.UID);
    __EE982157._record__type_;
    __EE982157._sbfe__contributor__num_;
    __EE982157._contractacc__num_;
    __EE982157._dt__first__seen_;
    __EE982157._dt__last__seen_;
    __EE982157._classification__code__type_;
    __EE982157._classification__code_;
    __EE982157._primary__industry__code__indicator_;
    __EE982157._privacy__indicator_;
  END;
  SHARED IDX_Industry_UID_Projected := TABLE(__EE982157,IDX_Industry_UID_Layout);
  EXPORT IDX_Industry_UID := INDEX(IDX_Industry_UID_Projected,{UID},{IDX_Industry_UID_Projected},'~key::KEL::Business_Credit_KEL::Industry::UID');
  EXPORT IDX_Industry_UID_Build := BUILD(IDX_Industry_UID,OVERWRITE);
  EXPORT __ST982159_Layout := RECORDOF(IDX_Industry_UID);
  EXPORT IDX_Industry_UID_Wrapped := PROJECT(IDX_Industry_UID,TRANSFORM(E_Industry(__in,__cfg).Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Industry_UID_Build);
END;

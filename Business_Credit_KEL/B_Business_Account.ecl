//HPCC Systems KEL Compiler Version v0.6.4beta2
IMPORT KEL06a AS KEL;
IMPORT CFG_graph,E_Account,E_Business,E_Business_Account FROM $;
IMPORT * FROM KEL06a.Null;
EXPORT B_Business_Account(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED __EE3274335 := E_Business_Account(__in,__cfg).__Result;
  SHARED __IDX_Business_Account__acc___bus__Filtered := __EE3274335(__NN(__EE3274335._acc_));
  SHARED IDX_Business_Account__acc___bus__Layout := RECORD
    E_Account().Typ _acc_ := __T(__IDX_Business_Account__acc___bus__Filtered._acc_);
    __IDX_Business_Account__acc___bus__Filtered._bus_;
  END;
  SHARED IDX_Business_Account__acc___bus__Projected := TABLE(__IDX_Business_Account__acc___bus__Filtered,IDX_Business_Account__acc___bus__Layout);
  EXPORT IDX_Business_Account__acc___bus_ := INDEX(IDX_Business_Account__acc___bus__Projected,{_acc_},{IDX_Business_Account__acc___bus__Projected},'~key::KEL::Business_Credit_KEL::Business_Account::_acc_::_bus_');
  EXPORT IDX_Business_Account__acc___bus__Build := BUILD(IDX_Business_Account__acc___bus_,OVERWRITE);
  EXPORT __ST3274337_Layout := RECORDOF(IDX_Business_Account__acc___bus_);
  SHARED __EE3274327 := E_Business_Account(__in,__cfg).__Result;
  SHARED __IDX_Business_Account__bus___acc__Filtered := __EE3274327(__NN(__EE3274327._bus_));
  SHARED IDX_Business_Account__bus___acc__Layout := RECORD
    E_Business().Typ _bus_ := __T(__IDX_Business_Account__bus___acc__Filtered._bus_);
    __IDX_Business_Account__bus___acc__Filtered._acc_;
  END;
  SHARED IDX_Business_Account__bus___acc__Projected := TABLE(__IDX_Business_Account__bus___acc__Filtered,IDX_Business_Account__bus___acc__Layout);
  EXPORT IDX_Business_Account__bus___acc_ := INDEX(IDX_Business_Account__bus___acc__Projected,{_bus_},{IDX_Business_Account__bus___acc__Projected},'~key::KEL::Business_Credit_KEL::Business_Account::_bus_::_acc_');
  EXPORT IDX_Business_Account__bus___acc__Build := BUILD(IDX_Business_Account__bus___acc_,OVERWRITE);
  EXPORT __ST3274329_Layout := RECORDOF(IDX_Business_Account__bus___acc_);
  EXPORT IDX_Business_Account__bus___acc__Wrapped := PROJECT(IDX_Business_Account__bus___acc_,TRANSFORM(E_Business_Account(__in,__cfg).Layout,SELF._bus_ := __CN(LEFT._bus_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Business_Account__acc___bus__Build,IDX_Business_Account__bus___acc__Build);
END;

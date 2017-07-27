//HPCC Systems KEL Compiler Version v0.6.4beta2
IMPORT KEL06a AS KEL;
IMPORT CFG_graph,E_Account,E_Account_Tradeline,E_Tradeline FROM $;
IMPORT * FROM KEL06a.Null;
EXPORT B_Account_Tradeline(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED __EE3273303 := E_Account_Tradeline(__in,__cfg).__Result;
  SHARED __IDX_Account_Tradeline__acc___trade__Filtered := __EE3273303(__NN(__EE3273303._acc_));
  SHARED IDX_Account_Tradeline__acc___trade__Layout := RECORD
    E_Account().Typ _acc_ := __T(__IDX_Account_Tradeline__acc___trade__Filtered._acc_);
    __IDX_Account_Tradeline__acc___trade__Filtered._trade_;
  END;
  SHARED IDX_Account_Tradeline__acc___trade__Projected := TABLE(__IDX_Account_Tradeline__acc___trade__Filtered,IDX_Account_Tradeline__acc___trade__Layout);
  EXPORT IDX_Account_Tradeline__acc___trade_ := INDEX(IDX_Account_Tradeline__acc___trade__Projected,{_acc_},{IDX_Account_Tradeline__acc___trade__Projected},'~key::KEL::Business_Credit_KEL::Account_Tradeline::_acc_::_trade_');
  EXPORT IDX_Account_Tradeline__acc___trade__Build := BUILD(IDX_Account_Tradeline__acc___trade_,OVERWRITE);
  EXPORT __ST3273305_Layout := RECORDOF(IDX_Account_Tradeline__acc___trade_);
  EXPORT IDX_Account_Tradeline__acc___trade__Wrapped := PROJECT(IDX_Account_Tradeline__acc___trade_,TRANSFORM(E_Account_Tradeline(__in,__cfg).Layout,SELF._acc_ := __CN(LEFT._acc_),SELF:=LEFT));
  SHARED __EE3273311 := E_Account_Tradeline(__in,__cfg).__Result;
  SHARED __IDX_Account_Tradeline__trade___acc__Filtered := __EE3273311(__NN(__EE3273311._trade_));
  SHARED IDX_Account_Tradeline__trade___acc__Layout := RECORD
    E_Tradeline().Typ _trade_ := __T(__IDX_Account_Tradeline__trade___acc__Filtered._trade_);
    __IDX_Account_Tradeline__trade___acc__Filtered._acc_;
  END;
  SHARED IDX_Account_Tradeline__trade___acc__Projected := TABLE(__IDX_Account_Tradeline__trade___acc__Filtered,IDX_Account_Tradeline__trade___acc__Layout);
  EXPORT IDX_Account_Tradeline__trade___acc_ := INDEX(IDX_Account_Tradeline__trade___acc__Projected,{_trade_},{IDX_Account_Tradeline__trade___acc__Projected},'~key::KEL::Business_Credit_KEL::Account_Tradeline::_trade_::_acc_');
  EXPORT IDX_Account_Tradeline__trade___acc__Build := BUILD(IDX_Account_Tradeline__trade___acc_,OVERWRITE);
  EXPORT __ST3273313_Layout := RECORDOF(IDX_Account_Tradeline__trade___acc_);
  EXPORT BuildAll := PARALLEL(IDX_Account_Tradeline__acc___trade__Build,IDX_Account_Tradeline__trade___acc__Build);
END;

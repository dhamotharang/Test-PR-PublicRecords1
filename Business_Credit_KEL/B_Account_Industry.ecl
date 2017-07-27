//HPCC Systems KEL Compiler Version v0.6.2beta1
IMPORT KEL06a AS KEL;
IMPORT CFG_graph,E_Account,E_Account_Industry,E_Industry FROM $;
IMPORT * FROM KEL06a.Null;
EXPORT B_Account_Industry(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED __EE981734 := E_Account_Industry(__in,__cfg).__Result;
  SHARED __IDX_Account_Industry__acc___industry__Filtered := __EE981734(__NN(__EE981734._acc_));
  SHARED IDX_Account_Industry__acc___industry__Layout := RECORD
    E_Account().Typ _acc_ := __T(__IDX_Account_Industry__acc___industry__Filtered._acc_);
    __IDX_Account_Industry__acc___industry__Filtered._industry_;
  END;
  SHARED IDX_Account_Industry__acc___industry__Projected := TABLE(__IDX_Account_Industry__acc___industry__Filtered,IDX_Account_Industry__acc___industry__Layout);
  EXPORT IDX_Account_Industry__acc___industry_ := INDEX(IDX_Account_Industry__acc___industry__Projected,{_acc_},{IDX_Account_Industry__acc___industry__Projected},'~key::KEL::Business_Credit_KEL::Account_Industry::_acc_::_industry_');
  EXPORT IDX_Account_Industry__acc___industry__Build := BUILD(IDX_Account_Industry__acc___industry_,OVERWRITE);
  EXPORT __ST981736_Layout := RECORDOF(IDX_Account_Industry__acc___industry_);
  EXPORT IDX_Account_Industry__acc___industry__Wrapped := PROJECT(IDX_Account_Industry__acc___industry_,TRANSFORM(E_Account_Industry(__in,__cfg).Layout,SELF._acc_ := __CN(LEFT._acc_),SELF:=LEFT));
  SHARED __EE981742 := E_Account_Industry(__in,__cfg).__Result;
  SHARED __IDX_Account_Industry__industry___acc__Filtered := __EE981742(__NN(__EE981742._industry_));
  SHARED IDX_Account_Industry__industry___acc__Layout := RECORD
    E_Industry().Typ _industry_ := __T(__IDX_Account_Industry__industry___acc__Filtered._industry_);
    __IDX_Account_Industry__industry___acc__Filtered._acc_;
  END;
  SHARED IDX_Account_Industry__industry___acc__Projected := TABLE(__IDX_Account_Industry__industry___acc__Filtered,IDX_Account_Industry__industry___acc__Layout);
  EXPORT IDX_Account_Industry__industry___acc_ := INDEX(IDX_Account_Industry__industry___acc__Projected,{_industry_},{IDX_Account_Industry__industry___acc__Projected},'~key::KEL::Business_Credit_KEL::Account_Industry::_industry_::_acc_');
  EXPORT IDX_Account_Industry__industry___acc__Build := BUILD(IDX_Account_Industry__industry___acc_,OVERWRITE);
  EXPORT __ST981744_Layout := RECORDOF(IDX_Account_Industry__industry___acc_);
  EXPORT BuildAll := PARALLEL(IDX_Account_Industry__acc___industry__Build,IDX_Account_Industry__industry___acc__Build);
END;

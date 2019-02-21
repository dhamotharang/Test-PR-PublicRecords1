//HPCC Systems KEL Compiler Version 0.10.0rc2
IMPORT KEL010 AS KEL;
IMPORT E_Co_Transacts,E_Person FROM KEL_Small;
IMPORT * FROM KEL010.Null;
EXPORT B_Co_Transacts := MODULE
  SHARED __EE904 := E_Co_Transacts.__Result;
  SHARED __IDX_Co_Transacts__who__Filtered := __EE904(__NN(__EE904._who_));
  SHARED IDX_Co_Transacts__who__Layout := RECORD
    E_Person.Typ _who_;
    __IDX_Co_Transacts__who__Filtered._whoelse_;
    __IDX_Co_Transacts__who__Filtered._whence_;
    __IDX_Co_Transacts__who__Filtered.__RecordCount;
  END;
  SHARED IDX_Co_Transacts__who__Projected := PROJECT(__IDX_Co_Transacts__who__Filtered,TRANSFORM(IDX_Co_Transacts__who__Layout,SELF._who_:=__T(LEFT._who_),SELF:=LEFT));
  EXPORT IDX_Co_Transacts__who_ := INDEX(IDX_Co_Transacts__who__Projected,{_who_},{IDX_Co_Transacts__who__Projected},'~key::KEL::KEL_Small::Co_Transacts::_who_');
  EXPORT IDX_Co_Transacts__who__Build := BUILD(IDX_Co_Transacts__who_,OVERWRITE);
  EXPORT __ST906_Layout := RECORDOF(IDX_Co_Transacts__who_);
  EXPORT IDX_Co_Transacts__who__Wrapped := PROJECT(IDX_Co_Transacts__who_,TRANSFORM(E_Co_Transacts.Layout,SELF._who_ := __CN(LEFT._who_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Co_Transacts__who__Build);
END;

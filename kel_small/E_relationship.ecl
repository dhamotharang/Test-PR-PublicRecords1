IMPORT $.E_Person,KEL;
IMPORT * FROM KEL.Null;
EXPORT E_relationship := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person.Typ) who;
    KEL.typ.ntyp(E_Person.Typ) whoelse;
  END;
  SHARED __Mapping := 'who:who,whoelse:whoelse';
  SHARED __Mapping0 := 'who:person1,whoelse:person2';
  SHARED __d0_Prefiltered := File_Relat;
  SHARED __d0 := KEL.FromFlat(__d0_Prefiltered,InLayout,__Mapping0);
  SHARED __Mapping1 := 'who:person2,whoelse:person1';
  SHARED __d1_Prefiltered := File_Relat;
  SHARED __d1 := KEL.FromFlat(__d1_Prefiltered,InLayout,__Mapping1);
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) who;
    KEL.typ.ntyp(E_Person.Typ) whoelse;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __Result := PROJECT(TABLE(InData,{who,whoelse,KEL.typ.int __RecordCount := COUNT(GROUP)},who,whoelse,MERGE),Layout) : PERSIST('~temp::KEL::KEL_Small::E_relationship::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
END;

IMPORT $.E_Person,$.E_Vehicle,KEL;
IMPORT * FROM KEL.Null;
EXPORT E_PVRel := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nstr Type;
    KEL.typ.ntyp(E_Person.Typ) Per;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh;
  END;
  SHARED __Mapping := 'Type:Type,Per:Per,Veh:Veh';
  SHARED __d0_Prefiltered := File_PerVeh;
  SHARED __d0 := KEL.FromFlat(__d0_Prefiltered,InLayout,__Mapping);
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nstr Type;
    KEL.typ.ntyp(E_Person.Typ) Per;
    KEL.typ.ntyp(E_Vehicle.Typ) Veh;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __Result := PROJECT(TABLE(InData,{Type,Per,Veh,KEL.typ.int __RecordCount := COUNT(GROUP)},Type,Per,Veh,MERGE),Layout) : PERSIST('~temp::KEL::KEL_Small::E_PVRel::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
END;

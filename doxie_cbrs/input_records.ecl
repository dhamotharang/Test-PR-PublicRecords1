STRING120 icn := '' : STORED('input_CompanyName');
STRING25 ic := '' : STORED('input_City');
STRING2 is := '' : STORED('input_State');
STRING5 iz := '' : STORED('input_Zip');
UNSIGNED2 imr := 0 : STORED('input_MileRadis');

EXPORT input_records :=
  DATASET(
    [{icn,
      ic,
      is,
      iz,
      imr}],
    {STRING120 CompanyName,
     STRING25 City,
     STRING2 State,
     STRING5 Zip,
     UNSIGNED2 Radius});

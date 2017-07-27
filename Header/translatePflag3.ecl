export string50 translatePflag3(string1 f3) := case(f3,
'G' => 'NonGLB rec has GLB SSN',
'U' => 'SSN from Utility File',
'W' => 'Work phone from Utility File',
'X' => 'Work phone and SSN from Utility File',
'');
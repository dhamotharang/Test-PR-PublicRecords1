import lib_fileservices, Boats;

SprayFixedFilesMacro(sourcepath,recordsize,dstname)

 := macro

#uniquename(SprayFiles)

%SprayFiles% := Boats.fsprayfiles(sourcepath, recordsize,dstname);

%SprayFiles%;

endmacro;

SprayFixedFilesMacro('/data_999/boats/ln/MO1.txt',798,'~thor::in::MO1.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2.txt',798,'~thor::in::MO2.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO3.txt',798,'~thor::in::MO3.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO4.txt',798,'~thor::in::MO4.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO5.txt',798,'~thor::in::MO5.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO6.txt',798,'~thor::in::MO6.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO7.txt',798,'~thor::in::MO7.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO8.txt',798,'~thor::in::MO8.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO9.txt',798,'~thor::in::MO9.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO10.txt',798,'~thor::in::MO10.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO11.txt',798,'~thor::in::MO11.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO12.txt',798,'~thor::in::MO12.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO13.txt',798,'~thor::in::MO13.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO14.txt',798,'~thor::in::MO14.fixed.txt')
/*SprayFixedFilesMacro('/data_999/boats/ln/AR15.txt',798,'~thor::in::AR15.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/AR16.txt',798,'~thor::in::AR16.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/AR17.txt',798,'~thor::in::AR17.fixed.txt')*/
SprayFixedFilesMacro('/data_999/boats/ln/MO2002Q4.txt',798,'~thor::in::MO2002Q4.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2003_Q1.txt',798,'~thor::in::MO2003_Q1.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2003_Q2.txt',798,'~thor::in::MO2003_Q2.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2003_Q3.txt',798,'~thor::in::MO2003_Q3.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2003_Q4',798,'~thor::in::MO2003_Q4.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2004_Q1',798,'~thor::in::MO2004_Q1.fixed.txt')
SprayFixedFilesMacro('/data_999/boats/ln/MO2004_Q2.txt',798,'~thor::in::MO2004_Q2.fixed.txt')



 
 

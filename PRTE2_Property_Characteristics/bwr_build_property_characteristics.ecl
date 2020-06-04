IMPORT PRTE2, PRTE2_Common, std, PRTE2_Property_Characteristics;
#WORKUNIT ('name', 'PRCT Property Characteristics Build');

string filedate := (STRING8)Std.Date.Today()+''; 

BuildStep := PRTE2_Property_Characteristics.proc_build_all(filedate);
SEQUENTIAL (BuildStep);

Import Data_Services, doxie;
Export Keys(String Filedate = '') := module
base := BadAddresses.File_BadAddresses_Base(Status = 'C');
BadAddresses.Layouts.Lay_KeyAddress xform(base L) := Transform
 Self.Address := L.Address; 
 Self.City := L.City; 
 Self := L; 
 Self := []; 
 End;
 Key_base := Project(base, xform(Left));

Export Key_Address := Index(Key_base,
												  {Address, City, State}, 
												  {Key_base},
												  Data_Services.Data_location.Prefix('BadAddresses') +
															'thor400_92::key::BadAddresses::'+if(filedate = '', doxie.Version_SuperKey, filedate)+'::address');
End;
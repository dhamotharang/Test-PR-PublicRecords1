EXPORT files := module

EXPORT HMS_IN       := DATASET(constants.In_HMS, Layouts.HMS_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

Export HMS_Base 		:= DATASET(constants.HMS_base,layouts.HMS_Base_Layout,flat);

Export Source_Keys:= Project(HMS_Base,Layouts.HMS_Base_Layout);

Export Lnpid_keys:=project(HMS_Base,
Transform(Layouts.Lnpid_Layout,
Self:=Left;
self := []; 
));

end;
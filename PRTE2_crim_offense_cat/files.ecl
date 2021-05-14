
EXPORT Files := MODULE
		
	EXPORT charge_file := DATASET(constants.Base_name, Layouts.key_layout, FLAT );
		
	Export key_file:=project(charge_file,
  Transform(Layouts.key_layout,
  Self:=Left;
  self := []; 
  ));	
	
	End;
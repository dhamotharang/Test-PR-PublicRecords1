export get_fl_broward_booktype(string pInput) := 
map(
pInput = 'C'	=>  'Condominium Plan	        ' ,    
pInput = 'M'	=>	'Minor Subdivision Survey	' ,    
pInput = 'O'	=>	'Official Records	        ' ,    
pInput = 'P'	=>	'Subdivision Plat	        ' ,    
pInput = 'R'	=>	'Right of Way Monument	  ' ,    
pInput = 'S'	=>	'Survey and Location Map	' ,    
pInput = 'T'	=>	'Right of Way Transfer Map'	,    
pInput = 'V'	=>	'Right of Way Reservation	' ,    
pInput = 'W'	=>	'Maintained Right of Way	' ,    
'');
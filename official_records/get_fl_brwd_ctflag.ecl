export get_fl_brwd_ctflag(string pInput) := 
map(
pInput = 'C'	=>  'Record has been corrected	        ' ,    
pInput = 'R'	=>	'Record has been replaced	' ,    
pInput = 'blank'	=>	'No change to the record	        ' ,    
'');
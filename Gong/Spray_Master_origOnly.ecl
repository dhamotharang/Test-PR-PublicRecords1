import lib_fileservices;


/*
a := FileServices.SprayFixed('10.150.12.242', '/gong/gong/amt/samples/amt.sample_20061212_194958.d00',4213, 'thor_200', 
							  '~thor_200::in::gong::master::orig::amt', , , ,true,true,false); 

FileServices.SprayFixed('10.150.12.242', '/gong/gong/ban/samples/ban.sample_20060525_181915.d00',5262, 'thor_200', 
							  '~thor_200::in::gong::master::orig::ban', , , ,true,true,false);
						  
b := FileServices.SprayFixed('10.150.12.242', '/gong/gong/bs/samples/bs.sample_20061206_190528.d00',1868, 'thor_200', 
							  '~thor_200::in::gong::master::orig::bs', , , ,true,true,false); */	
/*
c := FileServices.SprayFixed('10.150.12.242', '/gong/gong/cin/samples/cin.sample_20061023_180144.d00',3006, 'thor_200', 
							  '~thor_200::in::gong::master::orig::cin', , , ,true,true,false);

FileServices.SprayFixed('10.150.12.242', '/gong/gong/spr/samples/spr.sample_20060525_183231.d00',4213, 'thor_200', 
							  '~thor_200::in::gong::master::orig::spr', , , ,true,true,false);
							  
FileServices.SprayFixed('10.150.12.242', '/gong/gong/gte/samples/gte.sample_20060525_182623.d00',934, 'thor_200', 
							  '~thor_200::in::gong::master::orig::gte', , , ,true,true,false);
*/
d := FileServices.SprayFixed('10.150.12.242', '/gong/gong/lss/samples/lss.sample_20061227_200938.d00',2415, 'thor_200', 
							  '~thor_200::in::gong::master::orig::lss', , , ,true,true,false);
/*							  
FileServices.SprayFixed('10.150.12.242', '/gong/gong/nev/samples/nev.sample_20060525_205542.d00',1202, 'thor_200', 
							  '~thor_200::in::gong::master::orig::nev', , , ,true,true,false);
							  
FileServices.SprayFixed('10.150.12.242', '/gong/gong/pac/samples/pac.sample_20060525_190844.d00',1202, 'thor_200', 
							  '~thor_200::in::gong::master::orig::pac', , , ,true,true,false); 
							  
FileServices.SprayFixed('10.150.12.242', '/gong/gong/pr/samples/pr.sample_20060525_200441.d00',4110, 'thor_200', 
							  '~thor_200::in::gong::master::orig::pr', , , ,true,true,false); 
							  

e := FileServices.SprayFixed('10.150.12.242', '/gong/gong/qst/samples/qst.sample_20061212_195428.d00',3021, 'thor_200', 
							  '~thor_200::in::gong::master::orig::qst', , , ,true,true,false); 


FileServices.SprayFixed('10.150.12.242', '/gong/gong/snt/samples/snt.sample_20060525_195029.d00',1250, 'thor_200', 
							  '~thor_200::in::gong::master::orig::snt', , , ,true,true,false); 

FileServices.SprayFixed('10.150.12.242', '/gong/gong/swb/samples/swb.sample_20060525_210640.d00',2190, 'thor_200', 
							  '~thor_200::in::gong::master::orig::swb', , , ,true,true,false); 						  

FileServices.SprayFixed('10.150.12.242', '/gong/gong/vzs/samples/vzs.sample_20060525_184239.d00',2028, 'thor_200', 
							  '~thor_200::in::gong::master::orig::vzs', , , ,true,true,false); 

							  
*/							  
							  
export Spray_Master_origOnly := parallel(d);
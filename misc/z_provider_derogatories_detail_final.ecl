x:= dedup(sort(distribute(misc._provider_derogatories_detail,hash(id)),except license_number,local),all,local);
xf:= x(
(license_termination_date='' or (license_termination_date<>'' and license_termination_date>='20090930')) and
trim(license_status)  in [
'ACTIVE',                                 
'ACTIVE (EMERITUS)',                            
'ACTIVE - RESTRICTED',                          
'ACTIVE - WITH CONDITIONS',                     
'ACTIVE IN RENEWAL',                   
'ACTIVE LICENSE',                           
'ACTIVE NOT EXPIRED',                           
'ACTIVE PHYSICIAN',                             
'ACTIVE TO INACTIVE',                           
'ACTIVE WITH RESTRICTIONS',                     
'ACTIVE-NON RENEWABLE',                         
'CLEAR ACTIVE',                                 
'CURRENT',                                      
'CURRENT - UNRESTRICTED',                       
'CURRENT ACTIVE',                               
'CURRENT LICENSE',                              
'CURRENT LICENSE - ON PROBATION DUE TO DISCIPL',
'CURRENT LICENSE - STATEMENT OF CHARGES ISSUED',
'CURRENT LICENSE; STATEMENT OF CHARGES ISSUED', 
'CURRENT, UNRESTRICTED LICENSE',                
'VALID UNTIL 01/31/2010',                       
'VALID UNTIL 01/31/2011',                                             
'VALID UNTIL 03/28/2010',                         
'VALID UNTIL 03/31/2010',                       
'VALID UNTIL 04/30/2010',                       
'VALID UNTIL 04/30/2011',                       
'VALID UNTIL 05/31/2010',                                          
'VALID UNTIL 07/31/2010',                                          
'VALID UNTIL 08/31/2010',                       
'VALID UNTIL 10/31/2010',                       
'VALID UNTIL 12/31/2010'		
]);

output(choosen(xf,all));

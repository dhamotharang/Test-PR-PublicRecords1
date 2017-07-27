/*
ORIGINAL_FILING_NUMBER - DEBTORS                        
 ---------------- -------------------------
36390939         MCQUILKIN, ROBERT FRANCIS                              
36390939         ALEXANDER, RICHARD                                  
36390939         ALLEN, CHARLES                                      
36390939         DEHART, JEFFREY                                     
36390939         DONATONI, ROBERT J                                  
36390939         HAWK, KATHLEEN                                      
36390939         JONES, PHILIP W                                     
36390939         KELLY, JAMES MCGIRR                                 
36390939         LEAKEN, THOMAS                                      
36390939         MATEVOUSIN, A                                       
36390939         MCINTYRE, CHARLES                                   
36390939         MCKILLIP, EMILY                                     
36390939         MCQUILKIN ROBERT FRANCIS                            
36390939         MESSAROS, FRANK                                     
36390939         NASH, JOHN                                          
36390939         POLSKY, BARRY W                                     
36390939         RAIKE, JONATHAN W                                   
36390939         REISH, R M                                          
36390939         RUETER, THOMAS J                                    
36390939         STILES, MICHAEL R                                   
36390939         SWEET, DENEEN P                                    
36390939         TONER, MARION                                       
36390939         TURNER, OSCAR                                       
36390939         ZACCARDI, VINCE                                     
*/


export BOOLEAN Check_Fraudulent_Filing(STRING2 file_state, STRING18 filing_num) :=
	MAP(file_state='PA' AND filing_num='36390939' => TRUE,
        FALSE);
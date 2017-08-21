IMPORT nid;

EXPORT LargePropertyOwners := MODULE

Layout_NameValue := RECORD
	string80 	name := '';
	string80 	value := '';
END;	

CommonAbbrv := DATASET([
  {'AMERICAN TEL & TEL CO','AMERICAN TELEPHONE & TELEGRAPH COMPANY'},
	
	{'ARK STATE HWY COMM','ARKANSAS STATE HIGHWAY COMMISSION'},
	{'ARKANSAS STATE HIGHWAY COMM','ARKANSAS STATE HIGHWAY COMMISSION'},
	{'ARKANSAS STATE HWY COMMISSION','ARKANSAS STATE HIGHWAY COMMISSION'},
	
  {'A T & T CO','AMERICAN TELEPHONE & TELEGRAPH COMPANY'},
	{'A T & S F RR CO','ATCHISON TOPEKA & SANTA FE RAILWAY COMPANY'},                                                                 
	{'A T & S F RY CO','ATCHISON TOPEKA & SANTA FE RAILWAY COMPANY'},
	
	{'CAL-WESTERN RECONVEYANCE','CAL-WESTERN RECONVEYANCE'},
	{'CHASE HM FIN LLC','CHASE HOME FINANCE LLC'},

	{'CITY OF PHILA','CITY OF PHILADELPHIA'},
	{'CITY OF PGH','CITY OF PITTSBURG'},
	
  {'DOT/STATE OF FLORIDA','DEPARTMENT OF TRANSPORTATION/STATE OF FLORIDA'},                                                            
  {'DOT/ST OF FLORIDA','DEPARTMENT OF TRANSPORTATION/STATE OF FLORIDA'},                                                            
	
	{'DR HORTON INC','D R HORTON INCORPORATED'},                                                                  
	{'HORTON D R INC','D R HORTON INCORPORATED'},                                                                  

	{'FNMA', 'FNMA'},
	{'FEDERAL NATL MTG ASSN FNMA', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MORTGAGE ASSOC', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MORT ASSOC', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MORTG ASSOC', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MORTGAGE', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MTG', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATL MTG', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MORTGAGE A', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MORTGAGE ASSC', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MORTGAGE ASSO', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MORTGAGE ASSOCIATI', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MORTGAGE ASSOCIATIO', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MTG ASSOC', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATIONAL MTG ASSN', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATL MTG ASSN', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NATL MTG ASSN FNMA', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
 	{'FEDERAL NAT\'L MTG ASSN', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
  {'FEDERAL NATIONAL MTG ASSN', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NAT\'L MTG ASSN FNMA', 'FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FEDERAL NATIONAL MTG ASSN FNMA','FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'THE FEDERAL NATIONAL MORTGAGE ASSOCIATIO,','FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'THE FEDERAL NATIONAL MORTGAGE ASSOCIATIO','FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	{'FANNIE, MAE','FEDERAL NATIONAL MORTGAGE ASSOCIATION'},
	
	{'FED HM LN MTG','FEDERAL HOME LOAN MORTGAGE CORPORATION'},                                                                   
	{'FEDERAL HM LN MTG CORP', 'FEDERAL HOME LOAN MORTGAGE CORPORATION'},
	{'FED HOME LOAN MTG CORP', 'FEDERAL HOME LOAN MORTGAGE CORPORATION'},
	{'THE FEDERAL HOME LOAN MORTGAGE CORPORATI,', 'FEDERAL HOME LOAN MORTGAGE CORPORATION'},
	{'THE FEDERAL HOME LOAN MORTGAGE CORPORATI', 'FEDERAL HOME LOAN MORTGAGE CORPORATION'},
	{'FHLM', 'FHLM'},

 	{'GE CAPITAL', 'GENERAL ELECTRIC CAPITAL'},
                                                                      
//	{'HUD', 'HOUSING AND URBAN DEVELOPMENT'},
	{'H U D', 'HUD'},
	{'HUD-HOUSING OF URBAN DEV', 'HUD'},
	{'HUD-HOUSING OF URBAN DEVELOPMENT', 'HUD'},
	{'HUD-HOUSING OF URBAN DEVELOPME, NT', 'HUD'},
  {'HOUSING & URBAN DEV', 'HUD'},                                                             
  {'HUDHOUSING OF URBAN DEV', 'HUD'},
	{'HUDHOUSINGURBAN DEVELOPMENT', 'HUD'},
	{'HUDHOUSING OF URBAN DEVELOPMENT', 'HUD'},
	{'USA HUD', 'HUD'},
	{'SECRETARY OF HUD', 'HUD'},
	{'THE SECRETARY OF HUD', 'HUD'},
	{'HUD-HOUSING/URBAN DEVELOPMENT', 'HUD'},
	{'HUD-HOUSING & URBAN DEVELOPMENT', 'HUD'},
	{'HUDHOUSING & URBAN DEVELOPMENT', 'HUD'},
	{'H ; U DEVELOPMENT', 'HUD'},
	
	{'SECRETARY OF HOUSING & URBAN DEVELOPMENT', 'HUD'},
	{'THE SECRETARY OF HOUSING & URBAN DEVELOPMENT', 'HUD'},
	{'SECRETARY & HUD', 'HUD'},
	{'SECRETARY/HUD', 'HUD'},
	{'SECRETARY OF H U D', 'SECRETARY OF HUD'},
	{'SECRETARY OF HUD', 'HUD'},
	{'SEC OF H U D', 'HUD'},
	{'SEC OF HUD', 'HUD'},
	{'SECRETARY OF HUD OF WASHINGTON DISTRICT OF COLUMBIA', 'HUD'},
	{'THE SECRETARY OF HUD OF WASHINGTON DISTRICT OF COLUMBIA', 'HUD'},

	{'SECRETARYHUD COMPANY', 'HUD'},
	{'HUD COMPANY', 'HUD'},
	{'HUD CO', 'HUD'},
	{'HUDHOUSINGURBAN DEVELOPMENT COMPANY', 'HUD'},
	{'UNITED STATES DEPARTMENT OF HUD', 'HUD'},

	{'HUD-HOUSING/URBAN DEVELOPM', 'HUD'},
	{'SECRETARY & HUD COMPANY', 'HUD'},
	{'THE SEC OF HUD','HUD'},                                                                 
	{'HUD-HOUSING OF URBAN DEVELOPME', 'HUD'},
	{'HUDHOUSINGURBAN DEVELOPM', 'HUD'},
	{'UNITED STATES DEPARTMENT OF HUD', 'HUD'},
	{'UNITED STATES DEPARTMENT OF HUD', 'HUD'},
	{'DEPARTMENT OF HUD', 'HUD'},
	{'UNITED STATES DEPT OF HUD', 'HUD'},
	{'UNITED STATES OF AMERICA HUD', 'HUD'},                        
	{'SECRETARY OF HUD CO', 'HUD'},                                                             
	{'SECRETARY OF HUD WASHINGTON D C', 'HUD'},                                                
	{'US DEPT HUD', 'HUD'},                                                                     
	{'HUD-HOUSING/URBAN DEVELOP', 'HUD'},                                                       
	{'UNITED STATES HUD', 'HUD'},                                                               

	{'HUD HOUSING & URBAN DEVELOPMENT', 'HUD'},                                                 

	{'THE SECRETARY OF HOUSING & URBAN DEVELOP','HUD'},
	{'SECRETARY OF THE DEPARTMENTS OF HUD','HUD'},
	{'HUD - SECRETARY HOUSING & URBAN DEVELOPMENT','HUD'},                             
	{'SEC OF HUD','HUD'},                                       
	{'SECRETARYHUD','HUD'},                                       
	{'SEC HUD','HUD'},                                       
	{'SECRETARY OF HUD','HUD'}, 
	{'US DEPT OF HUD','HUD'},                                                                  
	{'DEPT OF HUD','HUD'},                                                                     
	{'THE SECRETARY OF HUD OF WASHINGTON DC','HUD'},                                          
	{'HUD SECRETARY OF','HUD'},                                  
	{'UNITED STATES DEPARTMENT OF HUD','HUD'},                                                
	{'SECY OF HUD','HUD'},                                        
	{'US DEPARTMENT OF HUD','HUD'},                                                            
	{'9745 HUD-HOUSING/URBAN DEVELOPMENT','HUD'},                                             
	{'HUD-HOUSING OFE URBAN DEV','HUD'},                                     
	{'HUD-HOUSING & URBAN DEVELOPM','HUD'},                                              
	{'U S DEPT OF HUD','HUD'},                                           
	{'SECRETARY OF HUD OF WASHINGTON D C','HUD'},
	{'DEPT OF HUD 131','HUD'},                                     
	{'SEC OF HUD OF WASHINGTON DC','HUD'},                                                                                                              
	{'SECRETARY OF HUD OF WASHINGTON','HUD'},                                            
	{'HUD 131','HUD'},                                         
	{'SEC OF HUD CO','HUD'},                                                                                                                        
	{'SEC OF HUD','HUD'},                                  
	{'HUD-HOUSING OF URBAN DEVELOPMENT C','HUD'},                                             
	{'SECRETARY HUD OF WASHINGTON DC','HUD'},                                     
	{'HUD HOUSING URBAN DEVELOPMENT','HUD'},                                         
	{'HUD SEC OF','HUD'},                                          
	{'DEPARTMENT OF HUD','HUD'},                                                             
	{'SECRETARY OF HUD WASHINGTON DC','HUD'},                                                 
	{'THE SECRETARY OF HUD OF WASHINGTON D C','HUD'},                                         
	{'9745 HUD','HUD'},                                 
	{'SECRETARY OF HUD OF WASHINGTON DC','HUD'},
	{'HUD SECRETARY OF','HUD'},                                      
	{'U S A HUD','HUD'},                                                       
	{'USA BY HUD','HUD'},                                         
	{'09745 HUD-HOUSING/URBAN DEVELO','HUD'},                                    
	{'THE UNITED STATES DEPARTMENT OF HUD','HUD'},
	{'SECTY OF HUD','HUD'},                         
	{'SECRETARY OF HOUSING & URBAN DEVELOPMENT (HUD)','HUD'},
	{'U S DEPARTMENT OF HUD','HUD'},                                         
	{'SECRETARY OF HUD OF WASHINGTON','HUD'},                                                 
	{'21457 SECRETARY/HUD','HUD'},                                                     
	{'C/O US DEPT OF HUD','HUD'},                                   
	{'HUD SECRETARY OF HOUSING & URBAN DEV','HUD'},                           
	{'SECRETARY OF HOUSING & URBAN DEVELOPMENT HUD','HUD'},
	{'HUD, SECRETARY OF','HUD'},                                                              
		
	{'SEC OF VA', 'SECRETARY OF VETERANS AFFAIRS'},
	{'SEC OF VET AFFAIRS', 'SECRETARY OF VETERANS AFFAIRS'},
	{'SECRETARY OF VET AFFAIRS', 'SECRETARY OF VETERANS AFFAIRS'},

	{'L A CITY', 'LA CITY'},
	{'L A CO FLOOD CONTROL DIST', 'LA COUNTY FLOOD CONTROL DISTRICT'},
	{'L A COMPANY FLOOD CONTROL DIST', 'LA COUNTY FLOOD CONTROL DISTRICT'},
                                                                                                                                                              
	{'MASS COMM OF','COMMONWEALTH OF MASSACHUSETTS'},
	{'MASSACHUSETTS COMM OF','COMMONWEALTH OF MASSACHUSETTS'},
	{'MORTGAGE ELECTRONIC REGISTRATI','MORTGAGE ELECTRONIC REGISTRATION SYSTEMS'},
	
	{'K B HOME NEVADA INC','KB HOME NEVADA INCORPORATED'},

 	{'OHIO STATE OF','STATE OF OHIO'},                                                                    
  {'STATE OF FL DOT','STATE OF FLORIDA DEPARTMENT OF TRANSPORTATION'},
	{'STATE OF N J DEPT CONS & DEV','STATE OF NEW JERSEY DEPARTMENT OF CONSTRUCTION AND DEVELOPMENT'},                                                    
	{'TIITF/ST OF FL','TIITF/STATE OF FLORIDA'},                                                                 
	{'TIITF & ST OF FL','TIITF/STATE OF FLORIDA'},
                    
	{'USA', 'USA'},
	{'U S A', 'USA'},
	{'U S GOVERNMENT', 'US GOVERNMENT'},
	{'US GOVERNMENT', 'US GOVERNMENT'},
	{'U S GOVT', 'UNITED STATES GOVERNMENT'},
	// US BANK
	{'U S BANK NA','US BANK NATIONAL ASSOCIATION'},                                                                    
	{'U S BANK NATIONAL ASSOCIATION','US BANK NATIONAL ASSOCIATION'},                                                  
	// US HOME CORP
	{'U S HOME CORP','US HOME CORPORATION'},                                                                   
	{'U S HOME CORPORATION','US HOME CORPORATION'},                                                           

	
	// VA
	{'VETERANS ADMN', 'VETERANS ADMINISTRATION'},
	//{'VA', 'VETERANS ADMINISTRATION'},
	{'VA', 'VA'},
	{'ADMINISTRATOR OF VA', 'ADMINISTRATOR OF VETERANS ADMINISTRATION'},
	
	{'WEST VA DEPT OF HWYS', 'WEST VIRGINIA DEPARTMENT OF HIGHWAYS'}
	

],
Layout_NameValue);

shared CommonAbbrvTablex := DICTIONARY(CommonAbbrv, {name => value});

EXPORT boolean IsLargePropertyOwner(string name) :=
					name in CommonAbbrvTablex;

EXPORT string LargePropertyOwner(string name) :=
	IF(name in CommonAbbrvTablex,
		CommonAbbrvTablex[name].value,
		name);

END;
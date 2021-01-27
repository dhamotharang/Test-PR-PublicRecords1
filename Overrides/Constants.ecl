IMPORT  STD,FCRA;
EXPORT Constants := MODULE

	EXPORT STRING statsAlert_threshold := '100';
	
	EXPORT BOOLEAN GROWTH_CHECK_CALL               := TRUE;
    EXPORT ADVO                                    := 'ADVO';
    EXPORT AIRCRAFT                            := 'AIRCRAFT';
    EXPORT AIRCRAFT_DETAILS            := 'AIRCRAFT_DETAILS';
    EXPORT AIRCRAFT_ENGINE              := 'AIRCRAFT_ENGINE';
    EXPORT ASSESSMENT                        := 'ASSESSMENT';
    EXPORT ATF                                      := 'ATF'; 
    EXPORT AVM                                      := 'AVM';
    EXPORT AVM_MEDIANS                      := 'AVM_MEDIANS';
    EXPORT BANKRUPTCY_MAIN              := 'BANKRUPTCY_MAIN';
    EXPORT BANKRUPTCY_SEARCH          := 'BANKRUPTCY_SEARCH';
    EXPORT CCW                                      := 'CCW';
    EXPORT COURT_OFFENSES                 := 'COURT_OFFENSE';
    EXPORT DEED                                    := 'DEED';
    EXPORT DID_DEATH                          := 'DID_DEATH';
    EXPORT EMAIL_DATA                        := 'EMAIL_DATA';
    EXPORT GONG                                    := 'GONG';
    EXPORT HDR                                      := 'HDR';
    EXPORT HUNTING_FISHING              := 'HUNTING_FISHING';
    EXPORT INQUIRIES                          := 'INQUIRIES';
    EXPORT IMPULSE                              := 'IMPULSE';
    EXPORT INFUTOR                              := 'INFUTOR';
    EXPORT LIEN_MAIN                          := 'LIEN_MAIN';
    EXPORT LIEN_PARTY                        := 'LIEN_PARTY';
    EXPORT MARI                                    := 'MARI';
    EXPORT MARRIAGE                            := 'MARRIAGE';
    EXPORT MARRIAGE_SEARCH              := 'MARRIAGE_SEARCH';
    EXPORT OFFENDERS                           := 'OFFENDER';
    EXPORT OFFENDERS_PLUS                := 'OFFENDERS_PLUS';
    EXPORT OFFENSES                             := 'OFFENSE';
    EXPORT PAW                                      := 'PAW';
    EXPORT PERSON                                := 'PERSON';
    EXPORT PILOT_CERTIFICATE          := 'PILOT_CERTIFICATE';
    EXPORT PILOT_REGISTRATION        := 'PILOT_REGISTRATION';
    EXPORT PROFLIC                              := 'PROFLIC';
    EXPORT PROPERTY                            := 'PROPERTY';
    EXPORT PROPERTY_SEARCH              := 'PROPERTY_SEARCH';
    EXPORT PUNISHMENT                        := 'PUNISHMENT';
    EXPORT SEARCH                                := 'SEARCH';
    EXPORT SO_MAIN                              := 'SO_MAIN';
    EXPORT SO_OFFENSES                      := 'SO_OFFENSES';
    EXPORT SSN                                      := 'SSN';
    EXPORT STUDENT                              := 'STUDENT';
    EXPORT STUDENT_ALLOY                  := 'STUDENT_ALLOY';
    EXPORT THRIVE                                := 'THRIVE';
    EXPORT UCC                                      := 'UCC';
    EXPORT UCC_PARTY                          := 'UCC_PARTY';
    EXPORT WATERCRAFT                        := 'WATERCRAFT';
    EXPORT WATERCRAFT_COASTGUARD  := 'WATERCRAFT_COASTGUARD';
    EXPORT WATERCRAFT_DETAILS        := 'WATERCRAFT_DETAILS';


	//get datagroup referred in override key builds
	EXPORT GetDsType(STRING datagroup) := FUNCTION
		Dstype := CASE(datagroup, 
			HDR => 'HEADER',
			STUDENT_ALLOY => 'ALLOY',
			STUDENT => 'STUDENT_NEW',
			BANKRUPTCY_MAIN => 'BANKRUPT_FILING',
			BANKRUPTCY_SEARCH => 'BANKRUPT_SEARCH',
			LIEN_MAIN => 'LIENSV2_MAIN',
			LIEN_PARTY => 'LIENSV2_PARTY',
			MARI => 'PROFLIC_MARI', datagroup);
		RETURN Dstype;
	END;

		
	//get datagroup referred in ConsumerDisclosure.FCRADataService
	EXPORT Getdatagroup(STRING datasetname) := FUNCTION

		datagroup := CASE(STD.Str.ToUpperCase(datasetname)
					,'HDR' => HDR
					,'AIRCRAFT'								=> AIRCRAFT             
					,'AIRCRAFT_DETAILS'				=> AIRCRAFT_DETAILS     	
					,'AIRCRAFT_ENGINE'				=> AIRCRAFT_ENGINE      	
					,'ALLOY'									=> STUDENT_ALLOY        
					,'AMERICAN_STUDENT_NEW'	=> STUDENT      
					,'ADVO'									=> ADVO                 
					,'ATF'                   				=> ATF                  
					,'AVM'                   				=> AVM                  
					,'AVM_MEDIANS'           		=> AVM_MEDIANS          
					,'BANKRUPT_MAIN'         		=> BANKRUPTCY_MAIN      
					,'BANKRUPT_SEARCH'				=> BANKRUPTCY_SEARCH    
					,'CONCEALED_WEAPONS'     	=> CCW                  
					,'DID_DEATH'             			=> DID_DEATH            
					,'EMAIL_DATA'            			=> EMAIL_DATA           
					,'GONG'                  				=> GONG                 
					,'HUNTING_FISHING'				=> HUNTING_FISHING      
					,'IMPULSE'               			=> IMPULSE              
					,'INFUTOR'               			=> INFUTOR              
					,'INQUIRIES'             			=> INQUIRIES            
					,'LIENSV2_MAIN'          		=> LIEN_MAIN            
					,'LIENSV2_PARTY'         		=> LIEN_PARTY           
					,'MARRIAGE_MAIN'         		=> MARRIAGE             
					,'MARRIAGE_SEARCH'       		=> MARRIAGE_SEARCH      
					,'PAW'                   				=> PAW                  
					,'PILOT_CERTIFICATE'     		=> PILOT_CERTIFICATE    
					,'PILOT_REGISTRATION'    	=> PILOT_REGISTRATION   
					,'PROFLIC'               				=> PROFLIC              
					,'PROFLIC_MARI'          			=> MARI
					,'ASSESSMENT'            		=> ASSESSMENT           
					,'DEED'                  				=> DEED                 
					,'PROPERTY_SEARCH'				=> PROPERTY_SEARCH      
					,'SO_MAIN'               			=> SO_MAIN              
					,'SO_OFFENSES'           		=> SO_OFFENSES          
					,'SSN_TABLE'             			=> SSN                  
					,'THRIVE'                				=> THRIVE               
					,'UCC_MAIN'              			=> UCC                  
					,'UCC_PARTY'             			=> UCC_PARTY            
					,'WATERCRAFT'            		=> WATERCRAFT           
					,'WATERCRAFT_CGUARD'     	=> WATERCRAFT_COASTGUARD
					,'WATERCRAFT_DETAILS'    	=> WATERCRAFT_DETAILS   
					,'OFFENDERS'             			=> OFFENDERS            
					,'OFFENDERS_PLUS'        		=> OFFENDERS_PLUS       
					,'OFFENSES'              			=> OFFENSES             
					,'COURT_OFFENSES'        		=> COURT_OFFENSES       
					,'PUNISHMENT'            			=> PUNISHMENT           
					,STD.Str.ToUpperCase(datasetname));
		RETURN datagroup;
	END;


	//get datagroup referred in override key builds
	EXPORT GetFileId(STRING datagroup) := FUNCTION
		Dstype := CASE(datagroup 
			,HDR 												=> FCRA.FILE_ID.HDR
			,AIRCRAFT                					=> FCRA.FILE_ID.AIRCRAFT 
			,AIRCRAFT_DETAILS           		=> FCRA.FILE_ID.AIRCRAFT_DETAILS 
			,AIRCRAFT_ENGINE            		=> FCRA.FILE_ID.AIRCRAFT_ENGINE 
			,STUDENT_ALLOY              		=> FCRA.FILE_ID.STUDENT_ALLOY 
			,STUDENT                    			=> FCRA.FILE_ID.STUDENT 
			,ADVO                       				=> FCRA.FILE_ID.ADVO 
			,ATF                        				=> FCRA.FILE_ID.ATF 
			,AVM                        				=> FCRA.FILE_ID.AVM 
			,AVM_MEDIANS                			=> FCRA.FILE_ID.AVM_MEDIANS 
			,BANKRUPTCY_MAIN            		=> FCRA.FILE_ID.BANKRUPTCY 
			,BANKRUPTCY_SEARCH          	=> FCRA.FILE_ID.BANKRUPTCY 
			,CCW                        				=> FCRA.FILE_ID.CCW
			,DID_DEATH                  			=> FCRA.FILE_ID.DID_DEATH 
			,EMAIL_DATA                 			=> FCRA.FILE_ID.Email_Data 
			,GONG                       				=> FCRA.FILE_ID.GONG 
			,HUNTING_FISHING            		=> FCRA.FILE_ID.HUNTING_FISHING 
			,IMPULSE                    				=> FCRA.FILE_ID.IMPULSE 
			,INFUTOR                    				=> FCRA.FILE_ID.INFUTOR 
			,INQUIRIES                  				=> FCRA.FILE_ID.Inquiries 
			,LIEN_MAIN                  				=> FCRA.FILE_ID.LIEN 
			,LIEN_PARTY                 			=> FCRA.FILE_ID.LIEN 
			,MARRIAGE                   			=> FCRA.FILE_ID.MARRIAGE 
			,MARRIAGE_SEARCH            		=> FCRA.FILE_ID.MARRIAGE_SEARCH 
			,PAW                        				=> FCRA.FILE_ID.PAW 
			,PILOT_CERTIFICATE          		=> FCRA.FILE_ID.PILOT_CERTIFICATE 
			,PILOT_REGISTRATION         		=> FCRA.FILE_ID.PILOT_REGISTRATION 
			,PROFLIC                    				=> FCRA.FILE_ID.PROFLIC
			,MARI                       				=> FCRA.FILE_ID.MARI 
			,ASSESSMENT                 			=> FCRA.FILE_ID.ASSESSMENT 
			,DEED                       				=> FCRA.FILE_ID.DEED 
			,PROPERTY_SEARCH            		=> FCRA.FILE_ID.SEARCH 
			,SO_MAIN                    				=> FCRA.FILE_ID.SO_MAIN 
			,SO_OFFENSES                			=> FCRA.FILE_ID.SO_OFFENSES 
			,SSN                        				=> FCRA.FILE_ID.SSN 
			,THRIVE                     				=> FCRA.FILE_ID.THRIVE 
			,UCC                        				=> FCRA.FILE_ID.UCC 
			,UCC_PARTY                  			=> FCRA.FILE_ID.UCC_PARTY 
			,WATERCRAFT                 			=> FCRA.FILE_ID.WATERCRAFT 
			,WATERCRAFT_COASTGUARD  	=> FCRA.FILE_ID.WATERCRAFT_COASTGUARD
			,WATERCRAFT_DETAILS         	=> FCRA.FILE_ID.WATERCRAFT_DETAILS 
			,OFFENDERS                  			=> FCRA.FILE_ID.OFFENDERS 
			,OFFENDERS_PLUS             		=> FCRA.FILE_ID.OFFENDERS_PLUS 
			,OFFENSES                   			=> FCRA.FILE_ID.OFFENSES 
			,COURT_OFFENSES             		=> FCRA.FILE_ID.COURT_OFFENSES 
			,PUNISHMENT                 			=> FCRA.FILE_ID.PUNISHMENT 
			,datagroup);
		RETURN Dstype;
	END;

	EXPORT GetStatsThreshold(STRING datagroup) := FUNCTION
		threshold_limit := CASE(datagroup 
				,GONG 												=> '50'
				,PAW 												=> '10'
				
				,STUDENT										=> '10'          
				,statsAlert_threshold
			);
		RETURN threshold_limit;	
	END;

	EXPORT datagroup_m_set := [BANKRUPTCY_SEARCH];
	EXPORT file_id_m_set := [FCRA.FILE_ID.BANKRUPTCY];		
END;
		
		
		
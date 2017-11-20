IMPORT Business_Risk_BIP, BusinessInstantID20_Services;

EXPORT mod_CalculateBusiness2Exec( Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE ) := 
	MODULE
		
		SHARED getRawScore(
				STRING9 in_bus_fein,                   
				STRING10 in_bus_phone10,
				STRING9 in_rep_ssn,                   
				STRING10 in_rep_phone10,               
				STRING1 e2b_rep_name_on_file,         
				STRING1 e2b_rep_paw_match,            
				STRING1 e2b_rep_idsearch_name,        
				STRING1 e2b_rep_idsearch_addr,        
				STRING1 e2b_rep_idsearch_ssn,         
				STRING1 e2b_rep_match_bus_file_first, 
				STRING1 e2b_rep_match_bus_file_last,  
				STRING1 e2b_rep_match_bus_file_addr,  
				STRING1 e2b_rep_match_bus_file_phn,   
				STRING1 e2b_rep_match_bus_file_fein,  
				STRING1 e2b_rep_match_bus_in_first,   
				STRING1 e2b_rep_match_bus_in_last,    
				STRING1 e2b_rep_match_bus_in_addr,
				STRING1 sbfe_e2b_rep_name_on_file,
				STRING1 sbfe_e2b_rep_addr_on_file,
				STRING1 sbfe_e2b_rep_ssn_on_file    
		) := 
			FUNCTION
				// Calculate Boolean values.
				_e2b_rep_name_on_file_f        := e2b_rep_name_on_file IN ['1','3'];
				_e2b_rep_name_on_file_l        := e2b_rep_name_on_file IN ['2','3'];  
																			
				_e2b_rep_paw_match             := e2b_rep_paw_match = '2';    
																			
				_e2b_rep_idsearch_name_f       := e2b_rep_idsearch_name = '1';
				_e2b_rep_idsearch_name_l       := e2b_rep_idsearch_name = '1';    
				_e2b_rep_idsearch_addr         := e2b_rep_idsearch_addr = '1';  
				_e2b_rep_idsearch_ssn          := e2b_rep_idsearch_ssn = '1';
				
				_e2b_rep_match_bus_file_first  := e2b_rep_match_bus_file_first = '1';
				_e2b_rep_match_bus_file_last   := e2b_rep_match_bus_file_last = '1';    
				_e2b_rep_match_bus_file_addr   := e2b_rep_match_bus_file_addr = '1';  
				_e2b_rep_match_bus_file_phn    := e2b_rep_match_bus_file_phn = '1';
				_e2b_rep_match_bus_file_fein   := e2b_rep_match_bus_file_fein = '1';
				
				_e2b_rep_match_bus_in_first    := e2b_rep_match_bus_in_first = '1';
				_e2b_rep_match_bus_in_last     := e2b_rep_match_bus_in_last = '1';    
				_e2b_rep_match_bus_in_addr     := e2b_rep_match_bus_in_addr = '1';  
				_e2b_rep_match_bus_in_phn      := in_bus_phone10 = in_rep_phone10;
				_e2b_rep_match_bus_in_fein     := TRIM(in_bus_fein) != '' AND TRIM(in_bus_fein) = TRIM(in_rep_ssn); 
				
				_sbfe_e2b_rep_name_on_file_f   := sbfe_e2b_rep_name_on_file IN ['1','3'];
				_sbfe_e2b_rep_name_on_file_l   := sbfe_e2b_rep_name_on_file IN ['2','3'];    
				_sbfe_e2b_rep_addr_on_file     := sbfe_e2b_rep_addr_on_file = '1';  
				_sbfe_e2b_rep_ssn_on_file      := sbfe_e2b_rep_ssn_on_file = '1'; 


				// Calculate initial score.
				bus2exec_desc_rep_key := 
					MAP(
						useSBFE AND
								_sbfe_e2b_rep_name_on_file_f AND _sbfe_e2b_rep_name_on_file_l     =>  '52',
						_e2b_rep_name_on_file_f AND _e2b_rep_name_on_file_l                   =>  '52',
						_e2b_rep_paw_match                                                    =>  '52',
						_e2b_rep_idsearch_name_f AND _e2b_rep_idsearch_name_l                 =>  '52',
						useSBFE AND 
								_sbfe_e2b_rep_ssn_on_file                                         =>  '51',
						_e2b_rep_idsearch_ssn                                                 =>  '51',
																																									
						useSBFE AND 
								_sbfe_e2b_rep_addr_on_file                                        =>  '44',
						_e2b_rep_idsearch_addr                                                =>  '44',                                                                                                              
						_e2b_rep_match_bus_file_fein                                          =>  '43',    
						_e2b_rep_match_bus_file_addr AND 
								( _e2b_rep_match_bus_file_first OR _e2b_rep_match_bus_file_last ) =>  '42',  
						
						_e2b_rep_match_bus_file_addr                                          =>  '33', 
						_e2b_rep_match_bus_file_first OR _e2b_rep_match_bus_file_last         =>  '32',     
						_e2b_rep_match_bus_file_phn                                           =>  '31',
					 
						_e2b_rep_match_bus_in_fein                                            =>  '22',     
						_e2b_rep_match_bus_in_addr AND 
								( _e2b_rep_match_bus_in_first OR _e2b_rep_match_bus_in_last )     =>  '21',

						_e2b_rep_match_bus_in_addr                                            =>  '13',
						_e2b_rep_match_bus_in_first OR _e2b_rep_match_bus_in_last             =>  '12',    
						_e2b_rep_match_bus_in_phn                                             =>  '11',
						/* default........................................................... */   '0'
					);			
				
				RETURN bus2exec_desc_rep_key;
			END;

		SHARED getScoreDesc(STRING score) := 
			CASE( score,
				 '0' => 'The input authorized rep cannot be linked to the business.',
				'11' => 'The input authorized rep\'s phone is the same as the input business phone.',
				'12' => 'The input authorized rep\'s first or last name appears as part of the input business name.',
				'13' => 'The input authorized rep\'s address is the same as the input business address.',
				'21' => 'The input authorized rep\'s address and first or last name is the same as the input business\' address and part of the name.',
				'22' => 'The input authorized rep\'s SSN is the same as the input business FEIN.',
				'31' => 'The input authorized rep\'s phone matches the business phone on record.',
				'32' => 'The input authorized rep\'s first or last name appears as part of the business name on record.',
				'33' => 'The input authorized rep\'s address matches the business address on record.',
				'42' => 'The input authorized rep\'s address and first or last name matches the business\' address and part of the name on record.',
				'43' => 'The input authorized rep\'s SSN matches the business FEIN on record.',
				'44' => 'The input authorized rep\'s address matches the personal address of a business contact on record.',
				'51' => 'The input authorized rep\'s SSN matches the SSN of a business contact on record.',
				'52' => 'The input authorized rep\'s first and last name matches the first and last name of a business contact on record.',
				''
			);

		// Business info
		SHARED in_bus_phone10 := le.Input_Echo.Phone10;
		SHARED in_bus_fein    := le.Input_Echo.FEIN;
		
		// Rep 1 info
		SHARED in_rep1_ssn                   := le.Input_Echo.Rep_SSN;
		SHARED in_rep1_phone10               := le.Input_Echo.rep_phone10;
		SHARED e2b_rep1_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile;
		SHARED e2b_rep1_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWRep1;
		SHARED e2b_rep1_idsearch_name        := le.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID;
		SHARED e2b_rep1_idsearch_addr        := le.Business_To_Executive_Link.AR2BRep1AddrBusHeaderLexID;
		SHARED e2b_rep1_idsearch_ssn         := le.Business_To_Executive_Link.AR2BRep1SSNBusHeaderLexID;
		SHARED e2b_rep1_match_bus_file_first := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirst;
		SHARED e2b_rep1_match_bus_file_last  := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLast;
		SHARED e2b_rep1_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr;
		SHARED e2b_rep1_match_bus_file_phn   := le.Business_To_Executive_Link.BusExecLinkAuthRepPhoneBusPhone;
		SHARED e2b_rep1_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN;
		SHARED e2b_rep1_match_bus_in_first   := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirstInput;
		SHARED e2b_rep1_match_bus_in_last    := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLastInput;
		SHARED e2b_rep1_match_bus_in_addr    := le.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddrInput;

		SHARED sbfe_e2b_rep1_name_on_file    := le.SBFE.SBFEBusExecLinkRep1NameonFile;
		SHARED sbfe_e2b_rep1_addr_on_file    := le.SBFE.SBFEBusExecLinkRep1AddronFile;
		SHARED sbfe_e2b_rep1_ssn_on_file     := le.SBFE.SBFEBusExecLinkRep1SSNonFile;

		// Rep 2 info
		SHARED in_rep2_ssn                   := le.Input_Echo.Rep2_SSN;
		SHARED in_rep2_phone10               := le.Input_Echo.rep2_phone10;
		SHARED e2b_rep2_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthRep2NameOnFile;
		SHARED e2b_rep2_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWrep2;
		SHARED e2b_rep2_idsearch_name        := le.Business_To_Executive_Link.AR2Brep2NameBusHeaderLexID;
		SHARED e2b_rep2_idsearch_addr        := le.Business_To_Executive_Link.AR2Brep2AddrBusHeaderLexID;
		SHARED e2b_rep2_idsearch_ssn         := le.Business_To_Executive_Link.AR2Brep2SSNBusHeaderLexID;
		SHARED e2b_rep2_match_bus_file_first := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2First;
		SHARED e2b_rep2_match_bus_file_last  := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2Last;
		SHARED e2b_rep2_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddr;
		SHARED e2b_rep2_match_bus_file_phn   := le.Business_To_Executive_Link.BusExecLinkAuthRep2PhoneBusPhone;
		SHARED e2b_rep2_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthRep2SSNBusFEIN;
		SHARED e2b_rep2_match_bus_in_first   := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FirstInput;
		SHARED e2b_rep2_match_bus_in_last    := le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2LastInput;
		SHARED e2b_rep2_match_bus_in_addr    := le.Business_To_Executive_Link.BusExecLinkAuthRep2AddrBusAddrInput;

		SHARED sbfe_e2b_rep2_name_on_file    := le.SBFE.SBFEBusExecLinkRep2NameonFile;
		SHARED sbfe_e2b_rep2_addr_on_file    := le.SBFE.SBFEBusExecLinkRep2AddronFile;
		SHARED sbfe_e2b_rep2_ssn_on_file     := le.SBFE.SBFEBusExecLinkRep2SSNonFile;

		// Rep 3 info
		SHARED in_rep3_ssn                   := le.Input_Echo.rep3_SSN;
		SHARED in_rep3_phone10               := le.Input_Echo.rep3_phone10;
		SHARED e2b_rep3_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthrep3NameOnFile;
		SHARED e2b_rep3_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWrep3;
		SHARED e2b_rep3_idsearch_name        := le.Business_To_Executive_Link.AR2Brep3NameBusHeaderLexID;
		SHARED e2b_rep3_idsearch_addr        := le.Business_To_Executive_Link.AR2Brep3AddrBusHeaderLexID;
		SHARED e2b_rep3_idsearch_ssn         := le.Business_To_Executive_Link.AR2Brep3SSNBusHeaderLexID;
		SHARED e2b_rep3_match_bus_file_first := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep3First;
		SHARED e2b_rep3_match_bus_file_last  := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep3Last;
		SHARED e2b_rep3_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthrep3AddrBusAddr;
		SHARED e2b_rep3_match_bus_file_phn   := le.Business_To_Executive_Link.BusExecLinkAuthrep3PhoneBusPhone;
		SHARED e2b_rep3_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthrep3SSNBusFEIN;
		SHARED e2b_rep3_match_bus_in_first   := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep3FirstInput;
		SHARED e2b_rep3_match_bus_in_last    := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep3LastInput;
		SHARED e2b_rep3_match_bus_in_addr    := le.Business_To_Executive_Link.BusExecLinkAuthrep3AddrBusAddrInput;

		SHARED sbfe_e2b_rep3_name_on_file    := le.SBFE.SBFEBusExecLinkRep3NameonFile;
		SHARED sbfe_e2b_rep3_addr_on_file    := le.SBFE.SBFEBusExecLinkRep3AddronFile;
		SHARED sbfe_e2b_rep3_ssn_on_file     := le.SBFE.SBFEBusExecLinkRep3SSNonFile;

		// Rep 4 info
		SHARED in_rep4_ssn                   := le.Input_Echo.rep4_SSN;
		SHARED in_rep4_phone10               := le.Input_Echo.rep4_phone10;
		SHARED e2b_rep4_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthrep4NameOnFile;
		SHARED e2b_rep4_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWrep4;
		SHARED e2b_rep4_idsearch_name        := le.Business_To_Executive_Link.AR2Brep4NameBusHeaderLexID;
		SHARED e2b_rep4_idsearch_addr        := le.Business_To_Executive_Link.AR2Brep4AddrBusHeaderLexID;
		SHARED e2b_rep4_idsearch_ssn         := le.Business_To_Executive_Link.AR2Brep4SSNBusHeaderLexID;
		SHARED e2b_rep4_match_bus_file_first := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep4First;
		SHARED e2b_rep4_match_bus_file_last  := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep4Last;
		SHARED e2b_rep4_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthrep4AddrBusAddr;
		SHARED e2b_rep4_match_bus_file_phn   := le.Business_To_Executive_Link.BusExecLinkAuthrep4PhoneBusPhone;
		SHARED e2b_rep4_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthrep4SSNBusFEIN;
		SHARED e2b_rep4_match_bus_in_first   := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep4FirstInput;
		SHARED e2b_rep4_match_bus_in_last    := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep4LastInput;
		SHARED e2b_rep4_match_bus_in_addr    := le.Business_To_Executive_Link.BusExecLinkAuthrep4AddrBusAddrInput;	

		SHARED sbfe_e2b_rep4_name_on_file    := le.SBFE.SBFEBusExecLinkRep4NameonFile;
		SHARED sbfe_e2b_rep4_addr_on_file    := le.SBFE.SBFEBusExecLinkRep4AddronFile;
		SHARED sbfe_e2b_rep4_ssn_on_file     := le.SBFE.SBFEBusExecLinkRep4SSNonFile;

		// Rep 5 info
		SHARED in_rep5_ssn                   := le.Input_Echo.rep5_SSN;
		SHARED in_rep5_phone10               := le.Input_Echo.rep5_phone10;
		SHARED e2b_rep5_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthrep5NameOnFile;
		SHARED e2b_rep5_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWrep5;
		SHARED e2b_rep5_idsearch_name        := le.Business_To_Executive_Link.AR2Brep5NameBusHeaderLexID;
		SHARED e2b_rep5_idsearch_addr        := le.Business_To_Executive_Link.AR2Brep5AddrBusHeaderLexID;
		SHARED e2b_rep5_idsearch_ssn         := le.Business_To_Executive_Link.AR2Brep5SSNBusHeaderLexID;
		SHARED e2b_rep5_match_bus_file_first := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep5First;
		SHARED e2b_rep5_match_bus_file_last  := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep5Last;
		SHARED e2b_rep5_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthrep5AddrBusAddr;
		SHARED e2b_rep5_match_bus_file_phn   := le.Business_To_Executive_Link.BusExecLinkAuthrep5PhoneBusPhone;
		SHARED e2b_rep5_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthrep5SSNBusFEIN;
		SHARED e2b_rep5_match_bus_in_first   := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep5FirstInput;
		SHARED e2b_rep5_match_bus_in_last    := le.Business_To_Executive_Link.BusExecLinkBusNameAuthrep5LastInput;
		SHARED e2b_rep5_match_bus_in_addr    := le.Business_To_Executive_Link.BusExecLinkAuthrep5AddrBusAddrInput;	

		SHARED sbfe_e2b_rep5_name_on_file    := le.SBFE.SBFEBusExecLinkRep5NameonFile;
		SHARED sbfe_e2b_rep5_addr_on_file    := le.SBFE.SBFEBusExecLinkRep5AddronFile;
		SHARED sbfe_e2b_rep5_ssn_on_file     := le.SBFE.SBFEBusExecLinkRep5SSNonFile;
	
		// Get raw e2b scores.
		SHARED _bus2exec_index_rep1 := getRawScore(
						in_bus_fein,                   
						in_bus_phone10,
						in_rep1_ssn,                   
						in_rep1_phone10,               
						e2b_rep1_name_on_file,         
						e2b_rep1_paw_match,            
						e2b_rep1_idsearch_name,        
						e2b_rep1_idsearch_addr,        
						e2b_rep1_idsearch_ssn,         
						e2b_rep1_match_bus_file_first, 
						e2b_rep1_match_bus_file_last,  
						e2b_rep1_match_bus_file_addr,  
						e2b_rep1_match_bus_file_phn,   
						e2b_rep1_match_bus_file_fein,  
						e2b_rep1_match_bus_in_first,   
						e2b_rep1_match_bus_in_last,    
						e2b_rep1_match_bus_in_addr,
						sbfe_e2b_rep1_name_on_file,
						sbfe_e2b_rep1_addr_on_file,
						sbfe_e2b_rep1_ssn_on_file 
				);
		
		SHARED _bus2exec_desc_rep1 := getScoreDesc( _bus2exec_index_rep1 );
		
		SHARED _bus2exec_index_rep2 := getRawScore(
						in_bus_fein,                   
						in_bus_phone10,
						in_rep2_ssn,                   
						in_rep2_phone10,               
						e2b_rep2_name_on_file,         
						e2b_rep2_paw_match,            
						e2b_rep2_idsearch_name,        
						e2b_rep2_idsearch_addr,        
						e2b_rep2_idsearch_ssn,         
						e2b_rep2_match_bus_file_first, 
						e2b_rep2_match_bus_file_last,  
						e2b_rep2_match_bus_file_addr,  
						e2b_rep2_match_bus_file_phn,   
						e2b_rep2_match_bus_file_fein,  
						e2b_rep2_match_bus_in_first,   
						e2b_rep2_match_bus_in_last,    
						e2b_rep2_match_bus_in_addr,
						sbfe_e2b_rep2_name_on_file,
						sbfe_e2b_rep2_addr_on_file,
						sbfe_e2b_rep2_ssn_on_file    
				);

		SHARED _bus2exec_desc_rep2 := getScoreDesc( _bus2exec_index_rep2 );
		
		SHARED _bus2exec_index_rep3 := getRawScore(
						in_bus_fein,                   
						in_bus_phone10,
						in_rep3_ssn,                   
						in_rep3_phone10,               
						e2b_rep3_name_on_file,         
						e2b_rep3_paw_match,            
						e2b_rep3_idsearch_name,        
						e2b_rep3_idsearch_addr,        
						e2b_rep3_idsearch_ssn,         
						e2b_rep3_match_bus_file_first, 
						e2b_rep3_match_bus_file_last,  
						e2b_rep3_match_bus_file_addr,  
						e2b_rep3_match_bus_file_phn,   
						e2b_rep3_match_bus_file_fein,  
						e2b_rep3_match_bus_in_first,   
						e2b_rep3_match_bus_in_last,    
						e2b_rep3_match_bus_in_addr,
						sbfe_e2b_rep3_name_on_file,
						sbfe_e2b_rep3_addr_on_file,
						sbfe_e2b_rep3_ssn_on_file    
				);

		SHARED _bus2exec_desc_rep3 := getScoreDesc( _bus2exec_index_rep3 );		
		
		SHARED _bus2exec_index_rep4 := getRawScore(
						in_bus_fein,                   
						in_bus_phone10,
						in_rep4_ssn,                   
						in_rep4_phone10,               
						e2b_rep4_name_on_file,         
						e2b_rep4_paw_match,            
						e2b_rep4_idsearch_name,        
						e2b_rep4_idsearch_addr,        
						e2b_rep4_idsearch_ssn,         
						e2b_rep4_match_bus_file_first, 
						e2b_rep4_match_bus_file_last,  
						e2b_rep4_match_bus_file_addr,  
						e2b_rep4_match_bus_file_phn,   
						e2b_rep4_match_bus_file_fein,  
						e2b_rep4_match_bus_in_first,   
						e2b_rep4_match_bus_in_last,    
						e2b_rep4_match_bus_in_addr,
						sbfe_e2b_rep4_name_on_file,
						sbfe_e2b_rep4_addr_on_file,
						sbfe_e2b_rep4_ssn_on_file    
				);

		SHARED _bus2exec_desc_rep4 := getScoreDesc( _bus2exec_index_rep4 );
		
		SHARED _bus2exec_index_rep5 := getRawScore(
						in_bus_fein,                   
						in_bus_phone10,
						in_rep5_ssn,                   
						in_rep5_phone10,               
						e2b_rep5_name_on_file,         
						e2b_rep5_paw_match,            
						e2b_rep5_idsearch_name,        
						e2b_rep5_idsearch_addr,        
						e2b_rep5_idsearch_ssn,         
						e2b_rep5_match_bus_file_first, 
						e2b_rep5_match_bus_file_last,  
						e2b_rep5_match_bus_file_addr,  
						e2b_rep5_match_bus_file_phn,   
						e2b_rep5_match_bus_file_fein,  
						e2b_rep5_match_bus_in_first,   
						e2b_rep5_match_bus_in_last,    
						e2b_rep5_match_bus_in_addr,
						sbfe_e2b_rep5_name_on_file,
						sbfe_e2b_rep5_addr_on_file,
						sbfe_e2b_rep5_ssn_on_file    
				);

		SHARED _bus2exec_desc_rep5 := getScoreDesc( _bus2exec_index_rep5 );		

		// Transform to output layout. Round down each index, e.g. from 52 to 50, from 43 to 40, etc.
		SHARED BusinessInstantID20_Services.Layouts.Business2ExecLayout business_to_exec_indices := 
			TRANSFORM
				_AuthRep1_Exists := le.input_echo.Rep_FullName  != '' OR le.input_echo.Rep_LastName  != '';
				_AuthRep2_Exists := le.input_echo.Rep2_FullName != '' OR le.input_echo.Rep2_LastName != '';
				_AuthRep3_Exists := le.input_echo.Rep3_FullName != '' OR le.input_echo.Rep3_LastName != '';
				_AuthRep4_Exists := le.input_echo.Rep4_FullName != '' OR le.input_echo.Rep4_LastName != '';
				_AuthRep5_Exists := le.input_echo.Rep5_FullName != '' OR le.input_echo.Rep5_LastName != '';
				
    bus2exec_index_rep1_pre  := IF( _AuthRep1_Exists, (STRING2)((INTEGER)_bus2exec_index_rep1 DIV 10 * 10), '' );
    bus2exec_index_rep2_pre  := IF( _AuthRep2_Exists, (STRING2)((INTEGER)_bus2exec_index_rep2 DIV 10 * 10), '' );
    bus2exec_index_rep3_pre  := IF( _AuthRep3_Exists, (STRING2)((INTEGER)_bus2exec_index_rep3 DIV 10 * 10), '' );
    bus2exec_index_rep4_pre  := IF( _AuthRep4_Exists, (STRING2)((INTEGER)_bus2exec_index_rep4 DIV 10 * 10), '' );
    bus2exec_index_rep5_pre  := IF( _AuthRep5_Exists, (STRING2)((INTEGER)_bus2exec_index_rep5 DIV 10 * 10), '' );
    
				SELF.Seq                 := le.Seq;
				SELF.bus2exec_index_rep1 := IF( bus2exec_index_rep1_pre = '0', '00', bus2exec_index_rep1_pre );
				SELF.bus2exec_desc_rep1  := IF( _AuthRep1_Exists, _bus2exec_desc_rep1, '' );
				SELF.bus2exec_index_rep2 := IF( bus2exec_index_rep2_pre = '0', '00', bus2exec_index_rep2_pre );
				SELF.bus2exec_desc_rep2  := IF( _AuthRep2_Exists, _bus2exec_desc_rep2, '' );
				SELF.bus2exec_index_rep3 := IF( bus2exec_index_rep3_pre = '0', '00', bus2exec_index_rep3_pre );
				SELF.bus2exec_desc_rep3  := IF( _AuthRep3_Exists, _bus2exec_desc_rep3, '' );
				SELF.bus2exec_index_rep4 := IF( bus2exec_index_rep4_pre = '0', '00', bus2exec_index_rep4_pre );
				SELF.bus2exec_desc_rep4  := IF( _AuthRep4_Exists, _bus2exec_desc_rep4, '' );
				SELF.bus2exec_index_rep5 := IF( bus2exec_index_rep5_pre = '0', '00', bus2exec_index_rep5_pre );
				SELF.bus2exec_desc_rep5  := IF( _AuthRep5_Exists, _bus2exec_desc_rep5, '' );			
			END;

		SHARED BusinessInstantID20_Services.Layouts.Business2ExecLayout null_business_to_exec := 
			TRANSFORM
				SELF.Seq                 := le.Seq;
				SELF.bus2exec_index_rep1 := '';
				SELF.bus2exec_desc_rep1  := '';
				SELF.bus2exec_index_rep2 := '';
				SELF.bus2exec_desc_rep2  := '';
				SELF.bus2exec_index_rep3 := '';
				SELF.bus2exec_desc_rep3  := '';
				SELF.bus2exec_index_rep4 := '';
				SELF.bus2exec_desc_rep4  := '';
				SELF.bus2exec_index_rep5 := '';
				SELF.bus2exec_desc_rep5  := '';			
			END;
			
		EXPORT rw_null_business_to_exec_indices := ROW( null_business_to_exec );
		
		EXPORT rw_business_to_exec_indices := ROW( business_to_exec_indices );
		
	END;

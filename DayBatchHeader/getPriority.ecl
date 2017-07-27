export getPriority(STRING10 matchCode,STRING20 search) := 
	MAP(//Map priorities for IE01
			search IN ['IE01','IE02','I500'] AND matchCode IN ['FL137ZS'] => 1,
			search IN ['IE01','IE02','I500'] AND matchCode IN ['FL13ZS'] 	=> 2,			
			search IN ['IE01','IE02','I500'] AND matchCode IN ['FLS'] 		=> 3,			
			search IN ['IE01','IE02','I500'] AND matchCode IN ['FL137Z'] 	=> 4,
			search IN ['IE01','IE02','I500'] AND matchCode IN ['FL13Z'] 	=> 5,			
			search IN ['IE01','IE02','I500'] AND matchCode IN ['LS'] 			=> 6,		
			search IN ['IE01','IE02','I500'] AND matchCode IN ['L137ZS'] 	=> 7,
			search IN ['IE01','IE02','I500'] AND matchCode IN ['L13ZS'] 	=> 8,
			search IN ['IE01','IE02','I500'] AND matchCode IN ['L137Z'] 	=> 9,
			search IN ['IE01','IE02','I500'] AND matchCode IN ['L13Z'] 		=> 10,
			search IN ['IE01','IE02','I500']															=> 11,
			// Map priorities for AAPSRCH2_FL13SZ
			search = 'AAPSRCH2_FL13SZ' AND matchCode IN ['FL137ZS'] 	=> 1,
			search = 'AAPSRCH2_FL13SZ' AND matchCode IN ['FL13ZS'] 		=> 2,
			search = 'AAPSRCH2_FL13SZ' 																=> 3,
			// Map priorities for AFNI_SFL137_C
			search = 'AFNI_SFL13Z_C' AND stringLib.StringContains(matchCode,'S',false) => 1, 			
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['FL137Z'] 	=> 2,
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['FL13Z'] 	=> 3,			
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['fL137Z'] 	=> 4,
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['fL13Z'] 	=> 5,			
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['L137Z'] 	=> 6,
			search = 'AFNI_SFL13Z_C' AND matchCode IN ['L13Z'] 		=> 7,
			search = 'AFNI_SFL13Z_C' 															=> 8,			
			// Map priorities for PSRCH2_SSN_C
			search = 'PSRCH2_SSN_C' AND stringLib.StringContains(matchCode,'S',false) => 1, 			
			search = 'PSRCH2_SSN_C'  																									=> 2, 			
			// Map priorities for PSRCH2_FL13Z_C
			search = 'PSRCH2_FL13Z_C' AND matchCode IN ['FL137ZS'] 	=> 1,
			search = 'PSRCH2_FL13Z_C' AND matchCode IN ['FL13ZS'] 	=> 2,						
			search = 'PSRCH2_FL13Z_C' AND matchCode IN ['FL137Z'] 	=> 3,
			search = 'PSRCH2_FL13Z_C' AND matchCode IN ['FL13Z'] 		=> 4,
			search = 'PSRCH2_FL13Z_C'																=> 5,
			// Map all other Priorities 
			matchCode IN ['FL137ZS'] 	=> 1,
			matchCode IN ['FL13ZS'] 	=> 2,			
			matchCode IN ['FLS'] 			=> 3,			
			matchCode IN ['FL137Z'] 	=> 4,
			matchCode IN ['FL13Z'] 		=> 5,			
			matchCode IN ['LS'] 			=> 6,			
			matchCode IN ['L137ZS'] 	=> 7,
			matchCode IN ['L13ZS'] 		=> 8,
			matchCode IN ['L137Z'] 		=> 9,
			matchCode IN ['L13Z'] 		=> 10,
			100
			);
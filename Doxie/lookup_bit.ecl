import ut,corp2_services,vehiclev2_services,doxie,header;
// todo: ALL CAPS
export lookup_bit(string10 b) := CASE(b, 	

//***** 
//***** ORIGINAL USEAGE
//***** 
									'SEX' 									=> 1,
									'CRIM' 									=> 2,
									'CCW' 									=> 3,
									'VEH' 									=> 4,
									'DL' 										=> 5,
									'REL' 									=> 6,
									'FIRE' 									=> 7,
									'FAA' 									=> 8,
									'VESS' 									=> 9,
									'PROF' 									=> 10,
									'BUS' 									=> 11,
									'PROP' 									=> 12,
									'BK'										=> 13,
									'PAW'										=> 14,
									'BC'										=> 15,
									'PROP_ASSES'						=> 16,
									'PROP_DEEDS'						=> 17, 
									'GONG'									=> 18,
									'OFFIC_RECS'						=> 19,
									'PROV'   								=> 20,  
									'SANC'        					=> 21,
									'NXTO'        					=> 22,
									'KROLL'	     						=> 23,
									'HEAD'		 							=> 24,

//***** 									
//***** FOR AUTOKEY RECORD ID GENERATION
//***** 

									'AK'										=> 15,
									
//***** 									
//***** AUTOKEY RECORD TYPE USEAGE
//***** 


	// DISTINGUISH GP PARTY TYPES
									'PARTY_D'								=> 25,
									'PARTY_S' 							=> 26,
									'PARTY_A' 							=> 27,
									'PARTY_C' 							=> 28,
									'PARTY_T'								=> 29,
									
//*****
//***** marriage_divorce_v2
//*****
									'P1'										=> 1,
									'P2'										=> 2,

//*****
//***** Corp_v2
//*****
									corp2_services.lookup_bit.Corp                  => 1,									
									corp2_services.lookup_bit.Accurint              => 2,
									corp2_services.lookup_bit.Not_Ra                => 3,

//****
//**** Vehicles_v2								
//****
									Vehiclev2_services.lookup_bit.no_lessors  =>1,
									Vehiclev2_services.lookup_bit.no_minors  =>2,

//****
//**** LN_PropertyV2
//****
									'A'											=> 1,
									'D'											=> 2,
							//	'PARTY_C'								=> 28, // Care Of
									'PARTY_O'								=> 4,  // Assessee or Buyer (i.e. Owner)
									'PARTY_B'								=> 5,  // Borrower
							//	'PARTY_S'								=> 26, // Seller
							//	NOTE: PARTY_S and PARTY_C were covered above.  It would be nice for this block of
							//	      values to be contiguous, but all that really matters is that they're distinct.
							//        Order is irrelevant but I liked the "COBS" mnemonic to remember party options.

//***
//*** Did segmentation
//***
								header.Constants.DidType.DEAD				=> 22,
								header.Constants.DidType.NOISE	   	=> 23,
								header.Constants.DidType.H_MERGE		=> 24,
								header.Constants.DidType.C_MERGE		=> 25,
								header.Constants.DidType.INACTIVE  	=> 26,
								header.Constants.DidType.AMBIG			=> 27,
								header.Constants.DidType.NO_SSN			=> 28,
								header.Constants.DidType.CORE				=> 29,


//**** Default
									0);

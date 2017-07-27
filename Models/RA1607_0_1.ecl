IMPORT Models, Residency_Services, Header, Risk_Indicators, ut;
//=================================================
//=== Residency Analytics Batch Scoring Model   ===   
//=================================================

EXPORT RA1607_0_1 (DATASET(Residency_Services.Layouts.Model_In_Layout) input_record, 
																						BOOLEAN inDEBUG_MODE = FALSE ) := FUNCTION

//=========================================
//=== Define the "doModel" TRANSFORM    ===   
//=========================================
	Models.Layout_Residency_Batch.Layout_Debug doModel(input_record le, INTEGER generate_seq) := TRANSFORM
	
    default_points                        := -100;  
/* ***********************************************************
	 *              Input Variable Assignments                 *
   *                                                         *
	 *********************************************************** */
	   model_name                           := 'RA1607_0_1';
		 
		 batch_in_prim_name                   := le.batch_in_prim_name;
		 batch_in_prim_range                  := le.batch_in_prim_range;
		 batch_in_sec_range                   := le.batch_in_sec_range;
     batch_in_county_name		              := le.batch_in_county_name;
		 batch_in_st                          := le.batch_in_st;
		 batch_in_z5                          := le.batch_in_z5;
				 
     sysdate                              := common.sas_date((string)ut.getdate);
	   name_first                           := le.name_first;
	   name_middle                          := le.name_middle;
	   county_name                          := le.county_name;  
		 prim_range                           := le.prim_range;
	   predir                               := le.predir;
		 sec_range                            := le.sec_range;
		 prim_name                            := le.prim_name;
		 p_city_name                          := le.p_city_name;
		 st                                   := le.st;
		 z5                                   := le.z5; 
		 
	   proflic_in_cnt                       := le.proflic_in_cnt;
		 proflic_out_cnt                      := le.proflic_out_cnt;
		 
		 huntfish_in_cnt                      := le.huntfish_in_cnt;
		 huntfish_out_cnt                     := le.huntfish_out_cnt;
		 
		 utility_in_cnt                       := le.utility_in_cnt;
		 utility_out_cnt                      := le.utility_out_cnt;
		 
		 property_in_cnt                      := le.property_in_cnt;
		 property_out_cnt                     := le.property_out_cnt;
		 
		 aircraft_in_cnt                      := le.aircraft_in_cnt;
		 aircraft_out_cnt                     := le.aircraft_out_cnt;
		 
		 bankruptcy_in_cnt                    := le.bankruptcy_in_cnt;
		 bankruptcy_out_cnt                   := le.bankruptcy_out_cnt;
		 
		 lienjudg_in_cnt                      := le.lienjudg_in_cnt;
		 lienjudg_out_cnt                     := le.lienjudg_out_cnt;
		 
		 foreclosure_in_cnt                   := le.foreclosure_in_cnt;
		 foreclosure_out_cnt                  := le.foreclosure_out_cnt;
		 
		 paw_in_cnt                           := le.paw_in_cnt;
		 paw_out_cnt                          := le.paw_out_cnt;
		 
		 business_in_cnt                      := le.business_in_cnt;
		 business_out_cnt                     := le.business_out_cnt;
		 
		 phone_in_cnt                         := le.phone_in_cnt;
		 phone_out_cnt                        := le.phone_out_cnt;
		 
		 veh_in_cnt                           := le.veh_in_cnt;
		 veh_out_cnt                          := le.veh_out_cnt;
		 
		 watercraft_in_cnt                    := le.watercraft_in_cnt;
		 watercraft_out_cnt                   := le.watercraft_out_cnt;
		 watercraft_out_expired_flag          := le.watercraft_out_expired_flag;
		 
		 dl_in_cnt                            := le.dl_in_cnt;
		 dl_out_cnt                           := le.dl_out_cnt;
		 dl_out_expired_flag                  := le.dl_out_expired_flag;
		 
		 voter_in_cnt                         := le.voter_in_cnt;
		 voter_out_cnt                        := le.voter_out_cnt;
		 voter_out_expired_flag               := le.voter_out_expired_flag;
		 
		 Homestead_in_cnt                     := le.Homestead_in_cnt;
		 Homestead_out_cnt                    := le.Homestead_out_cnt;
		 
		 isinputaddress                       := le.isinputaddress;
		 isbestaddress                        := le.isbestaddress;
		 Property_homestead                   := le.Property_homestead;
		 AddressReportingSourceIndex          := le.AddressReportingSourceIndex;
		 AddressReportingHistoryIndex         := le.AddressReportingHistoryIndex;
		 AddressSearchHistoryIndex            := le.AddressSearchHistoryIndex;
		 AddressUtilityHistoryIndex           := le.AddressUtilityHistoryIndex;
		 AddressOwnershipHistoryIndex         := le.AddressOwnershipHistoryIndex;
		 AddressOwnerMailingAddressIndex      := le.AddressOwnerMailingAddressIndex; 
		 InferredOwnershipTypeIndex           := le.InferredOwnershipTypeIndex;
		 OtherOwnedPropertyProximity          := le.OtherOwnedPropertyProximity;
		 
		 hrisk_1                              := le.hrisk_1;  
		 hrisk_2                              := le.hrisk_2;
		 
		 ssn                                  := le.ssn; 

/* * ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

NULL := -999999999;


//----------------------------------------------------------------------------
// code for first data step
//----------------------------------------------------------------------------
																																	
																																		
    OthOwnPropPrx_ind := map(
	     OtherOwnedPropertyProximity in [' ', '0', '-1']                => 0,
 									                                                       1);

		 
//-----------------------------------------------------------------------------
// Profile License counts
//-----------------------------------------------------------------------------
     proflic_pts := map(
        proflic_in_cnt = 0  and proflic_out_cnt = 0               => 0,               
        proflic_in_cnt != 0 and proflic_in_cnt < proflic_out_cnt  => -1,
        proflic_in_cnt < proflic_out_cnt                          => -2,
        proflic_out_cnt = 0 and proflic_in_cnt > proflic_out_cnt  => 2,
        proflic_in_cnt != 0 and proflic_in_cnt = proflic_out_cnt  => 0,
        proflic_out_cnt != 0 and proflic_in_cnt > proflic_out_cnt => 1,
                                                                    default_points);
																																		 
//----------------------------------------------------------------------------
//  Hunting and Fishing License counts
//-----------------------------------------------------------------------------
     huntfish_pts := map(
        huntfish_in_cnt = 0 and huntfish_out_cnt = 0                 => 0,            
        huntfish_in_cnt != 0 and huntfish_in_cnt < huntfish_out_cnt  => -1,
        huntfish_in_cnt < huntfish_out_cnt                           => -1,
        huntfish_out_cnt = 0 and huntfish_in_cnt > huntfish_out_cnt  => 2,
        huntfish_in_cnt != 0 and huntfish_in_cnt = huntfish_out_cnt  => 0,
        huntfish_out_cnt != 0 and huntfish_in_cnt > huntfish_out_cnt => 1,
                                                                        default_points);
																																				
//----------------------------------------------------------------------------
//  Utility counts
//-----------------------------------------------------------------------------
     utility_pts := map(
        utility_in_cnt = 0 and utility_out_cnt = 0                      => -1,        
        utility_in_cnt != 0 and utility_in_cnt < utility_out_cnt        => -3,
        utility_in_cnt < utility_out_cnt                                => -5,
        utility_out_cnt = 0 and utility_in_cnt > utility_out_cnt        => 5,
        utility_in_cnt != 0 and utility_in_cnt = utility_out_cnt        => -1,
        utility_out_cnt != 0 and utility_in_cnt > utility_out_cnt       => 3,
                                                                           default_points);
																																					
//----------------------------------------------------------------------------
//  Property counts
//-----------------------------------------------------------------------------
    property_pts := map(
        property_in_cnt = 0 and property_out_cnt = 0                    => 0,         
        property_in_cnt != 0 and property_in_cnt < property_out_cnt     => -1,
        property_in_cnt < property_out_cnt                              => -2,
        property_out_cnt = 0 and property_in_cnt > property_out_cnt     => 3,
        property_in_cnt != 0 and property_in_cnt = property_out_cnt     => 0,
        property_out_cnt != 0 and property_in_cnt > property_out_cnt    => 1,
                                                                           default_points);	
																																					
//----------------------------------------------------------------------------
//  Aircraft counts
//-----------------------------------------------------------------------------
    aircraft_pts := map(
        aircraft_in_cnt = 0 and aircraft_out_cnt = 0                       => 0,       
        aircraft_in_cnt != 0 and aircraft_in_cnt < aircraft_out_cnt        => -2,
        aircraft_in_cnt < aircraft_out_cnt                                 => -3,
        aircraft_out_cnt = 0 and aircraft_in_cnt > aircraft_out_cnt        => 3,
        aircraft_in_cnt != 0 and aircraft_in_cnt = aircraft_out_cnt        => 0,
        aircraft_out_cnt != 0 and aircraft_in_cnt > aircraft_out_cnt       => 2,
                                                                              default_points);
																																							
//-----------------------------------------------------------------------------
//  Bankruptcy counts
//-----------------------------------------------------------------------------
    bankruptcy_pts := map(
        bankruptcy_in_cnt = 0 and bankruptcy_out_cnt = 0                    => 0,
        bankruptcy_in_cnt != 0 and bankruptcy_in_cnt < bankruptcy_out_cnt   => -1,
        bankruptcy_in_cnt < bankruptcy_out_cnt                              => -2,
        bankruptcy_out_cnt = 0 and bankruptcy_in_cnt > bankruptcy_out_cnt   => 2,
        bankruptcy_in_cnt != 0 and bankruptcy_in_cnt = bankruptcy_out_cnt   => 0,
        bankruptcy_out_cnt != 0 and bankruptcy_in_cnt > bankruptcy_out_cnt  => 1,
                                                                               default_points);
																																							
//----------------------------------------------------------------------------
//  Liens and judgment counts
//-----------------------------------------------------------------------------
    lienjudg_pts := map(
        lienjudg_in_cnt = 0 and lienjudg_out_cnt = 0                       => 0,
        lienjudg_in_cnt != 0 and lienjudg_in_cnt < lienjudg_out_cnt        => -1,
        lienjudg_in_cnt < lienjudg_out_cnt                                 => -2,
        lienjudg_out_cnt = 0 and lienjudg_in_cnt > lienjudg_out_cnt        => 2,
        lienjudg_in_cnt != 0 and lienjudg_in_cnt = lienjudg_out_cnt        => 0,
        lienjudg_out_cnt != 0 and lienjudg_in_cnt > lienjudg_out_cnt       => 1,
                                                                              default_points);
																																							
//----------------------------------------------------------------------------
//  foreclosure counts
//-----------------------------------------------------------------------------
    foreclosure_pts := map(
        foreclosure_in_cnt = 0 and foreclosure_out_cnt = 0                          => 0,
        foreclosure_in_cnt != 0 and foreclosure_in_cnt < foreclosure_out_cnt        => -1,
        foreclosure_in_cnt < foreclosure_out_cnt                                    => -2,
        foreclosure_out_cnt = 0 and foreclosure_in_cnt > foreclosure_out_cnt        => 2,
        foreclosure_in_cnt != 0 and foreclosure_in_cnt = foreclosure_out_cnt        => 0,
        foreclosure_out_cnt != 0 and foreclosure_in_cnt > foreclosure_out_cnt       => 1,
                                                                                       default_points);
																																											 
//----------------------------------------------------------------------------
//  paw counts
//-----------------------------------------------------------------------------
		paw_pts := map(
				paw_in_cnt = 0 and paw_out_cnt = 0                  => 0,
				paw_in_cnt != 0 and paw_in_cnt < paw_out_cnt        => -1,
				paw_in_cnt < paw_out_cnt                            => -2,
				paw_out_cnt = 0 and paw_in_cnt > paw_out_cnt        => 2,
				paw_in_cnt != 0 and paw_in_cnt = paw_out_cnt        => 0,
				paw_out_cnt != 0 and paw_in_cnt > paw_out_cnt       => 1,
																												       default_points);
																															 
//----------------------------------------------------------------------------
//  business counts
//-----------------------------------------------------------------------------
		business_pts := map(
				business_in_cnt = 0 and business_out_cnt = 0                       => 0,
				business_in_cnt != 0 and business_in_cnt < business_out_cnt        => -2,
				business_in_cnt < business_out_cnt                                 => -3,
				business_out_cnt = 0 and business_in_cnt > business_out_cnt        => 3,
				business_in_cnt != 0 and business_in_cnt = business_out_cnt        => 0,
				business_out_cnt != 0 and business_in_cnt > business_out_cnt       => 2,
																																			     	  default_points);
																																				
//----------------------------------------------------------------------------
//  phone counts
//----------------------------------------------------------------------------
		phone_pts := map(
				phone_in_cnt = 0 and phone_out_cnt = 0                    => -1,
				phone_in_cnt != 0 and phone_in_cnt < phone_out_cnt        => -2,
				phone_in_cnt < phone_out_cnt                              => -3,
				phone_out_cnt = 0 and phone_in_cnt > phone_out_cnt        => 3,
				phone_in_cnt != 0 and phone_in_cnt = phone_out_cnt        => -1,
				phone_out_cnt != 0 and phone_in_cnt > phone_out_cnt       => 2,
																															       default_points);
 
//----------------------------------------------------------------------------
//  vehicle counts
//----------------------------------------------------------------------------
		veh_pts := map(
				veh_in_cnt = 0 and veh_out_cnt = 0                  => -1,
				veh_in_cnt != 0 and veh_in_cnt < veh_out_cnt        => -3,
				veh_in_cnt < veh_out_cnt                            => -5,
				veh_out_cnt = 0 and veh_in_cnt > veh_out_cnt        => 5,
				veh_in_cnt != 0 and veh_in_cnt = veh_out_cnt        => -1,
				veh_out_cnt != 0 and veh_in_cnt > veh_out_cnt       => 3,
																												       default_points);
																												 
//----------------------------------------------------------------------------
//  watercraft counts
//----------------------------------------------------------------------------
		watercraft_pts := map(
				watercraft_in_cnt = 0 and watercraft_out_cnt = 0                                                           => 0,
				watercraft_in_cnt = watercraft_out_cnt and watercraft_out_cnt != 0 and watercraft_out_expired_flag = 'N'   => -1,             
				watercraft_in_cnt = watercraft_out_cnt and watercraft_out_cnt != 0 and watercraft_out_expired_flag = 'Y'   => -2, 
				watercraft_out_cnt = 0 and watercraft_in_cnt > watercraft_out_cnt                                          => 3,
				watercraft_out_cnt != 0 and watercraft_in_cnt > watercraft_out_cnt                                         => 2,             
				watercraft_in_cnt != 0 and watercraft_in_cnt < watercraft_out_cnt                                          => -1,
				watercraft_in_cnt < watercraft_out_cnt                                                                     => -3,
																																														                          default_points);
																																																											
//----------------------------------------------------------------------------
//  driver's license counts
//----------------------------------------------------------------------------
		dl_pts := map(
				dl_in_cnt = 0 and dl_out_cnt = 0                                             => -1,
				dl_in_cnt = dl_out_cnt and dl_out_cnt != 0 and dl_out_expired_flag = 'N'     => -5,
				dl_in_cnt = dl_out_cnt and dl_out_cnt != 0 and dl_out_expired_flag = 'Y'     => -3,
				dl_out_cnt = 0 and dl_in_cnt > dl_out_cnt                                    => 5,
				dl_out_cnt != 0 and dl_in_cnt > dl_out_cnt                                   => 3,
				dl_in_cnt != 0 and dl_in_cnt < dl_out_cnt                                    => -3,
				dl_in_cnt < dl_out_cnt                                                       => -5,
																																		                    default_points);
																																												
//----------------------------------------------------------------------------
//  voter counts
//----------------------------------------------------------------------------
		voter_pts := map(
				voter_in_cnt = 0 and voter_out_cnt = 0                                                 => -1,
				voter_in_cnt = voter_out_cnt and voter_out_cnt != 0 and voter_out_expired_flag = 'N'   => -5,
				voter_in_cnt = voter_out_cnt and voter_out_cnt != 0 and voter_out_expired_flag = 'Y'   => -3,
				voter_out_cnt = 0 and voter_in_cnt > voter_out_cnt                                     => 5,
				voter_out_cnt != 0 and voter_in_cnt > voter_out_cnt                                    => 3,
				voter_in_cnt != 0 and voter_in_cnt < voter_out_cnt                                     => -3,
				voter_in_cnt < voter_out_cnt                                                           => -5,
										                                                                              default_points);

//----------------------------------------------------------------------------
//  homestead and property counts
//----------------------------------------------------------------------------
		homestead_pts      := map(
		    homestead_in_cnt = homestead_out_cnt and property_homestead in [' ', 'N']     => 0,
				homestead_in_cnt = homestead_out_cnt and property_homestead = 'Y'             => 3,
				homestead_in_cnt > homestead_out_cnt and property_homestead in [' ', 'Y']     => 5, 
				homestead_in_cnt < homestead_out_cnt and property_homestead = 'Y'             => -5,
				homestead_in_cnt < homestead_out_cnt and property_homestead = 'N'             => -3,
				                                                                                 default_points);  
				


		isaddress_pts := map(
		    isinputaddress = 'Y' and isbestaddress='Y'                         => 5,           // best case 
				isinputaddress in [' ', 'N'] and isbestaddress in [' ', 'N']       => -5,          // worst case
				isinputaddress = 'Y' and isbestaddress = 'N'                       => -2,
				isinputaddress = 'N' and isbestaddress = 'Y'                       => 2,
				                                                                      default_points);            
//----------------------------------------
//  Address Reporting Source points                      
//----------------------------------------
    addrrptscridx_pts := map(
		    (INTEGER)AddressReportingSourceIndex = 5              => 2,
				(INTEGER)AddressReportingSourceIndex IN [2,3,4]       => 1,
				(INTEGER)AddressReportingSourceIndex = 1              => -1,
				(INTEGER)AddressReportingSourceIndex IN [NULL, 0, -1] => -2,
				                                                         default_points);                              
//----------------------------------------
//  Address Reporting History points                      
//----------------------------------------																													
		addrrpthstidx_pts  := map(
		    AddressReportingHistoryIndex = ''                               => -2,
		    (INTEGER)AddressReportingHistoryIndex = 6                       => 2,
				(INTEGER)AddressReportingHistoryIndex = 5                       => 1,
				(INTEGER)AddressReportingHistoryIndex = 3                       => -1,
				(INTEGER)AddressReportingHistoryIndex IN [NULL, -1, 1, 2, 4]    => -2,
				                                                         default_points);
		
//----------------------------------------
//  Address Search History points                      
//----------------------------------------
		addrsrchhstidx_pts  := map(
		    AddressSearchHistoryIndex = ''                                                              => -2,
		    (INTEGER)AddressSearchHistoryIndex IN [0, -1]                                               => 0,
		    (INTEGER)AddressSearchHistoryIndex IN [5,6]                                                 => 2,
				0 <= (INTEGER)AddressSearchHistoryIndex AND (INTEGER)AddressSearchHistoryIndex <= 4         => -2,
				                                                                                               default_points);
		

//----------------------------------------
//  Address Utility History points                      
//----------------------------------------
    addrutlhstidx_pts  := map(
		    (INTEGER)AddressUtilityHistoryIndex >= 4                      => 2,
				(INTEGER)AddressUtilityHistoryIndex = 3                       => 1,
				(INTEGER)AddressUtilityHistoryIndex IN [NULL, -1, 0, 1, 2]    => -2,
				                                                                 default_points);
																																 

//----------------------------------------
//  Address Ownership History points                      
//----------------------------------------
		addrownhstidx_pts  := map(
		    AddressOwnershipHistoryIndex = ''                        => -2,
		    (INTEGER)AddressOwnershipHistoryIndex = 5                => 2,
				(INTEGER)AddressOwnershipHistoryIndex = 4                => 1,
				(INTEGER)AddressOwnershipHistoryIndex = 3                => -2,
				(INTEGER)AddressOwnershipHistoryIndex IN [NULL, -1]      => -2,
				(INTEGER)AddressOwnershipHistoryIndex IN [0, 1, 2]       => 0,
				                                                            default_points);
		

//----------------------------------------
//  Address Owner Mailing Address points                      
//----------------------------------------	
		addrownmlidx_pts  := map(
		    (INTEGER)AddressOwnerMailingAddressIndex = 6                          => 2,
				(INTEGER)AddressOwnerMailingAddressIndex = 5                          => 1,
				(INTEGER)AddressOwnerMailingAddressIndex = 4                          => 0,
				(INTEGER)AddressOwnerMailingAddressIndex IN [0, 1, 2, 3, NULL, -1]    => -2,                  
				                                                               default_points);
//----------------------------------------
//  Inferred Ownership Type points                      
//----------------------------------------		
		InfrOwnTypIdx_pts := map(
		    InferredOwnershipTypeIndex = ''                             => -2,
		    (INTEGER)InferredOwnershipTypeIndex = 4                     => 2,
		    (INTEGER)InferredOwnershipTypeIndex = 3                     => 1,
				(INTEGER)InferredOwnershipTypeIndex in [1, 2]               => -1,
				(INTEGER)InferredOwnershipTypeIndex in [0, NULL, -1]        => -2,
				                                                               default_points);                    
																																		
																																		
//-------------------------------------------
//   High Risk Indicator points
//-------------------------------------------
    Highriskind1_pts := map(
		    hrisk_1 in ['04', '07', 'PA', 'MS']                         => -2,
				hrisk_1 in ['25', 'CZ', '29']                               => -1,
				                                                               0);                   
																																			                         
																																														
    Highriskind3_pts := map(
		    hrisk_2 in ['04', '07', 'PA', 'MS']                         => -2,
				hrisk_2 in ['25', 'CZ', '29']                               => -1,
				                                                               0);                   
																																			                       
	  Highriskind_pts := Highriskind1_pts + Highriskind3_pts;  
																																														


//-----------------------------------------------------------------------------
// sum code
//-----------------------------------------------------------------------------
   voo_pts := if(max(AddrRptScrIdx_pts, AddrRptHstIdx_pts, AddrSrchHstIdx_pts, AddrUtlHstIdx_pts, AddrOwnHstIdx_pts, AddrOwnMlIdx_pts, InfrOwnTypIdx_pts) = NULL, NULL, 
	               sum(if(AddrRptScrIdx_pts = NULL, 0, AddrRptScrIdx_pts), 
								     if(AddrRptHstIdx_pts = NULL, 0, AddrRptHstIdx_pts), 
										 if(AddrSrchHstIdx_pts = NULL, 0, AddrSrchHstIdx_pts), 
										 if(AddrUtlHstIdx_pts = NULL, 0, AddrUtlHstIdx_pts), 
										 if(AddrOwnHstIdx_pts = NULL, 0, AddrOwnHstIdx_pts), 
										 if(AddrOwnMlIdx_pts = NULL, 0, AddrOwnMlIdx_pts), 
										 if(InfrOwnTypIdx_pts = NULL, 0, InfrOwnTypIdx_pts)));

   high_pts := if(max(veh_pts, dl_pts, utility_pts, watercraft_pts, aircraft_pts, voter_pts, voo_pts, homestead_pts, isaddress_pts) = NULL, NULL, 
	                sum(if(veh_pts = NULL, 0, veh_pts), 
									    if(dl_pts = NULL, 0, dl_pts), 
									    if(utility_pts = NULL, 0, utility_pts), 
											if(watercraft_pts = NULL, 0, watercraft_pts), 
											if(aircraft_pts = NULL, 0, aircraft_pts), 
											if(voter_pts = NULL, 0, voter_pts), 
											if(voo_pts = NULL, 0, voo_pts), 
											if(homestead_pts = NULL, 0, homestead_pts), 
											if(isaddress_pts = NULL, 0, isaddress_pts)));
												
												
		medium_pts := if(max(property_pts, phone_pts, paw_pts, business_pts, huntfish_pts, Highriskind_pts, proflic_pts) = NULL, NULL, 
		                sum(if(property_pts = NULL, 0, property_pts), 
										    if(phone_pts = NULL, 0, phone_pts), 
												if(paw_pts = NULL, 0, paw_pts), 
												if(business_pts = NULL, 0, business_pts), 
												if(huntfish_pts = NULL, 0, huntfish_pts), 
												if(proflic_pts = NULL, 0, proflic_pts), 
												if(Highriskind_pts = NULL, 0, highriskind_pts))); 										
												
												

   low_pts := if(max(bankruptcy_pts, lienjudg_pts, foreclosure_pts) = NULL, NULL, 
	               sum(if(bankruptcy_pts = NULL, 0, bankruptcy_pts), 
								 if(lienjudg_pts = NULL, 0, lienjudg_pts), 
								 if(foreclosure_pts = NULL, 0, foreclosure_pts)));


  

   total_pts := sum(.55 * high_pts + .30 * medium_pts + .15 * low_pts);
	 
//----------------------------------------------------------------------------
// code for second data step
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// align code
//----------------------------------------------------------------------------
//lower values                      upper values 
  lvalue_A := -35.0000000;          uvalue_A := -1.90000000;
	lvalue_B :=  -1.85000000;         uvalue_B :=  -.600000000;
	lvalue_C :=   -.550000000;        uvalue_C :=  0.950000000;
	lvalue_D :=   1.000000000;        uvalue_D :=  2.450000000;
	lvalue_E :=   2.500000000;        uvalue_E :=  3.900000000;
	lvalue_F :=   3.950000000;        uvalue_F :=  5.650000000;
	lvalue_G :=   5.700000000;        uvalue_G :=  7.450000000;
	lvalue_H :=   7.500000000;        uvalue_H :=  9.250000000;
	lvalue_I :=   9.300000000;        uvalue_I := 12.00000000; 
	lvalue_K :=   12.05000000;        uvalue_K := 35.00000000; 
	
	lnum_A := 63;                     unum_A := 96;
	lnum_B := 58;                     unum_B := 62;
	lnum_C := 55;                     unum_C := 57;
	lnum_D := 53;                     unum_D := 54;
	lnum_E := 50;                     unum_E := 52;
	lnum_F := 47;                     unum_F := 49;
	lnum_G := 45;                     unum_G := 46;
	lnum_H := 42;                     unum_H := 44;
	lnum_I := 37;                     unum_I := 41;
	lnum_K := 6;                      unum_K := 36;  
	
		
  Temp_Score := Map(
	    total_pts <= uvalue_A   => ((lnum_A - unum_A) / (uvalue_A - lvalue_A)) * (total_pts - lvalue_A) + unum_A,
			total_pts <= uvalue_B   => ((lnum_B - unum_B) / (uvalue_B - lvalue_B)) * (total_pts - lvalue_B) + unum_B,
			total_pts <= uvalue_C   => ((lnum_C - unum_C) / (uvalue_C - lvalue_C)) * (total_pts - lvalue_C) + unum_C,
			total_pts <= uvalue_D   => ((lnum_D - unum_D) / (uvalue_D - lvalue_D)) * (total_pts - lvalue_D) + unum_D, 
			total_pts <= uvalue_E   => ((lnum_E - unum_E) / (uvalue_E - lvalue_E)) * (total_pts - lvalue_E) + unum_E,
			total_pts <= uvalue_F   => ((lnum_F - unum_F) / (uvalue_F - lvalue_F)) * (total_pts - lvalue_F) + unum_F,
			total_pts <= uvalue_G   => ((lnum_G - unum_G) / (uvalue_G - lvalue_G)) * (total_pts - lvalue_G) + unum_G,
			total_pts <= uvalue_H   => ((lnum_H - unum_H) / (uvalue_H - lvalue_H)) * (total_pts - lvalue_H) + unum_H,
			total_pts <= uvalue_I   => ((lnum_I - unum_I) / (uvalue_I - lvalue_I)) * (total_pts - lvalue_I) + unum_I,
			total_pts >  uvalue_I   => ((lnum_K - unum_K) / (uvalue_K - lvalue_K)) * (total_pts - lvalue_K) + unum_K,
			                           0);
			
	Round_Score := 101 - round((Temp_Score),0);
	
	
	RB_Score  := Map(
	    Round_Score < 1         => 1,
			Round_Score > 100       => 100,
			                           Round_Score);
					
 
 //---------------------------------------
 //  code for third data step 
 //----------------------------------------
 
 
//=================================================================
//===     THIS PROCESS IS CALLED THE FUZZY MATCH                ===
//=== start by comparing the components of the batch in address ===
//=== to the addresses found by the service                     ===
//=================================================================
 
//============================================================
//=== Are these components of the address populated with data?
//============================================================
  rtns_flag  := batch_in_prim_name != '';
  rtnc_flag  := batch_in_county_name != '';
	
//============================================================
//=== Looking for components of the address that match perfectly
//===    Set to TRUE if any of these components
//===    match PERFECTLY                  
//============================================================	
  num_match       := batch_in_prim_range = prim_range;
  addrstnme_match := batch_in_prim_name = prim_name;
  county_match    := batch_in_county_name = county_name;
  state_match     := batch_in_st = st;                                        
	zip_match       := batch_in_z5 = z5;
	zip_match_int   := (INTEGER)batch_in_z5 = (INTEGER)z5;   

//============================================================================
//===      process for primary range                                       ===
//============================================================================

//============================================================================
//===   convert  to UPPER CASE                                             ===
//============================================================================
  batch_in_prim_range_clean_c8_b1 := StringLib.StringToUpperCase(trim((string)batch_in_prim_range, LEFT, RIGHT));   
  prim_range_clean_c8_b1          := StringLib.StringToUpperCase(trim((string)prim_range, LEFT, RIGHT));            
	

//==============================================================	
//=== Extract the length of the primary range - House number		
//==============================================================																																						 
	length_of_bprange := length(trim((STRING)batch_in_prim_range_clean_c8_b1));
	length_of_prange := length(trim((STRING)prim_range_clean_c8_b1));
	
																																
	min_length_prim_range := max(if(max((STRING)length_of_bprange, (STRING)length_of_prange) = '', NULL, 
	                         min(if((STRING)length_of_bprange                                = '', -NULL, (INTEGER)length_of_bprange), 
												   if((STRING)length_of_prange                                     = '', -NULL, (INTEGER)length_of_prange))), 1);
												
  batch_in_prim_range_trunc_c8_b1 := (batch_in_prim_range_clean_c8_b1)[1..min_length_prim_range];
  prim_range_trunc_c8_b1          := (prim_range_clean_c8_b1)[1..min_length_prim_range];	


//============================================================================================================
//===   The best matches will result in a value of 0
//============================================================================================================       
	num_compare_c9 := map(
      batch_in_prim_range_clean_c8_b1 = prim_range_clean_c8_b1                  => 0,
      batch_in_prim_range_clean_c8_b1 = '' or prim_range_clean_c8_b1 = ''       => 1,                                 
      batch_in_prim_range_trunc_c8_b1 = prim_range_trunc_c8_b1                  => 0,
      (batch_in_prim_range_trunc_c8_b1)[1..1] != (prim_range_trunc_c8_b1)[1..1] => 1,
                                                                                   2);

												
//============================================================================
//===      repeat the process for primary name                             ===
//===     THIS PROCESS IS CALLED THE FUZZY MATCH                           ===
//============================================================================

//============================================================================
//===   convert  to UPPER CASE                                             ===
//============================================================================
  batch_in_prim_name_clean_c8_b1 := StringLib.StringToUpperCase(trim((string)batch_in_prim_name, LEFT, RIGHT));
  prim_name_clean_c8_b1          := StringLib.StringToUpperCase(trim((string)prim_name, LEFT, RIGHT));

  
//==============================================================	
//=== Extract the length of the primary Name - STREET NAME
//==============================================================																																						 
	length_of_bpname := length(trim((STRING)batch_in_prim_name_clean_c8_b1));
	length_of_pname := length(trim((STRING)prim_name_clean_c8_b1));	
	
			
  min_length_prim_name := max(if(max((STRING)length_of_bpname, (STRING)length_of_pname) = '', NULL, 
	                         min(if((STRING)length_of_bpname                              = '', -NULL, (INTEGER)length_of_bpname), 
												   if((STRING)length_of_pname                                   = '', -NULL, (INTEGER)length_of_pname))), 1);	
	
	batch_in_prim_name_trunc_c8_b1 := (batch_in_prim_name_clean_c8_b1)[1..min_length_prim_name];
  prim_name_trunc_c8_b1          := (prim_name_clean_c8_b1)[1..min_length_prim_name];
	
	
//============================================================================================================
//===   The best matches will result in a value of 0
//============================================================================================================ 	
  addrstnme_compare_c10 := map(
      batch_in_prim_name_clean_c8_b1 = prim_name_clean_c8_b1                  => 0,               
      batch_in_prim_name_clean_c8_b1 = '' or prim_name_clean_c8_b1 = ''       => 1,
      batch_in_prim_name_trunc_c8_b1 = prim_name_trunc_c8_b1                  => 0,               
      (batch_in_prim_name_trunc_c8_b1)[1..1] != (prim_name_trunc_c8_b1)[1..1] => 1,
                                                                                 2);
																																								 
																																								 
//============================================================================
//===      repeat the process for county name                              ===
//============================================================================

//============================================================================
//===   convert  to UPPER CASE                                             ===
//============================================================================
  batch_in_county_name_clean_c8_b1 := StringLib.StringToUpperCase(trim((string)batch_in_county_name, LEFT, RIGHT));
  county_name_clean_c8_b1          := StringLib.StringToUpperCase(trim((string)county_name, LEFT, RIGHT));
	
//==============================================================	
//=== Extract the length of the County Name - County NAME
//==============================================================																																						 
	length_of_bcntyname := length(trim((STRING)batch_in_county_name_clean_c8_b1));
	length_of_cntyname  := length(trim((STRING)county_name_clean_c8_b1));	
			
  min_length_cnty_name := max(if(max((STRING)length_of_bcntyname, (STRING)length_of_cntyname) = '', NULL, 
	                         min(if((STRING)length_of_bcntyname                                 = '', -NULL, (INTEGER)length_of_bcntyname), 
												   if((STRING)length_of_cntyname                                      = '', -NULL, (INTEGER)length_of_cntyname))), 1);	

  batch_in_county_name_trunc_c8_b1 := (batch_in_county_name_clean_c8_b1)[1..min_length_cnty_name];
  county_name_trunc_c8_b1          := (county_name_clean_c8_b1)[1..min_length_cnty_name];

  county_compare_c11 := map(
      batch_in_county_name_clean_c8_b1 = county_name_clean_c8_b1                  => 0,
      batch_in_county_name_clean_c8_b1 = '' or county_name_clean_c8_b1 = ''       => 1,
      batch_in_county_name_trunc_c8_b1 = county_name_trunc_c8_b1                  => 0,
      (batch_in_county_name_trunc_c8_b1)[1..1] != (county_name_trunc_c8_b1)[1..1] => 1,
                                                                                     2);																																										 
																																										 
//============================================================================
//===      repeat the process for State                                    ===
//============================================================================

//============================================================================
//===   convert  to UPPER CASE                                             ===
//============================================================================
  batch_in_st_clean_c8_b1 := StringLib.StringToUpperCase(trim((string)batch_in_st, LEFT, RIGHT));
  st_clean_c8_b1          := StringLib.StringToUpperCase(trim((string)st, LEFT, RIGHT));

//==============================================================	
//=== Extract the length of the STATE
//==============================================================																																						 
	length_of_bst := length(trim((STRING)batch_in_st_clean_c8_b1));
	length_of_st  := length(trim((STRING)st_clean_c8_b1));	
		
  min_length_st := max(if(max((STRING)length_of_bst, (STRING)length_of_st) = '', NULL, 
	                         min(if((STRING)length_of_bst                                 = '', -NULL, (INTEGER)length_of_bst), 
												   if((STRING)length_of_st                                      = '', -NULL, (INTEGER)length_of_st))), 1);	

  batch_in_st_trunc_c8_b1 := (batch_in_st_clean_c8_b1)[1..min_length_st];
  st_trunc_c8_b1          := (st_clean_c8_b1)[1..min_length_st];

state_compare_c12 := map(
    batch_in_st_clean_c8_b1 = st_clean_c8_b1                  => 0,
    batch_in_st_clean_c8_b1 = '' or st_clean_c8_b1 = ''       => 1,
    batch_in_st_trunc_c8_b1 = st_trunc_c8_b1                  => 0,
    (batch_in_st_trunc_c8_b1)[1..1] != (st_trunc_c8_b1)[1..1] => 1,
                                                                 2);
																																 
//============================================================================
//===      repeat the process for 5 digit zip code                         ===
//============================================================================

//============================================================================
//===   convert  to UPPER CASE                                             ===
//============================================================================
  batch_in_z5_clean_c8_b1 := StringLib.StringToUpperCase(trim((string)batch_in_z5, LEFT, RIGHT));
	z5_clean_c8_b1          := StringLib.StringToUpperCase(trim((string)z5, LEFT, RIGHT));
	
//==============================================================	
//=== Extract the length of the ZIP CODE
//==============================================================																																						 
	length_of_bzp5 := length(trim((STRING)batch_in_z5_clean_c8_b1));
	length_of_zp5  := length(trim((STRING)z5_clean_c8_b1));	

  min_length_zp5   := max(if(max((STRING)length_of_bzp5, (STRING)length_of_zp5) = '', NULL, 
	                    min(if((STRING)length_of_bzp5                     = '', -NULL, (INTEGER)length_of_bzp5), 
											if((STRING)length_of_zp5                          = '', -NULL, (INTEGER)length_of_zp5))), 1);

  batch_in_z5_trunc_c8_b1 := (batch_in_z5_clean_c8_b1)[1..min_length_zp5];
  z5_trunc_c8_b1          := (z5_clean_c8_b1)[1..min_length_zp5];

  zip_compare_c13 := map(
     batch_in_z5_clean_c8_b1 = z5_clean_c8_b1                  => 0,
		 zip_match_int                                             => 0,                   //This covers the case where the leading zero is truncated
     batch_in_z5_clean_c8_b1 = '' or z5_clean_c8_b1 = ''       => 1,
     batch_in_z5_trunc_c8_b1 = z5_trunc_c8_b1                  => 0,
    (batch_in_z5_trunc_c8_b1)[1..1] != (z5_trunc_c8_b1)[1..1]  => 1,
                                                                  2);
																																 
//=================================================================
//===  IF YOU CAN'T FIND A PERFECT MATCH THEN                   ===
//===   USE THE VALUES SET BY THE FUZZY MATCH LOGIC             ===
//=================================================================
 
  num_compare              := if(NOT(num_match)
                              or NOT(addrstnme_match) 
														  or NOT(county_match)
													  	or NOT(state_match)
												  		or NOT(zip_match), num_compare_c9, NULL);

  addrstnme_compare        := if(NOT(num_match)
                              or NOT(addrstnme_match) 
														  or NOT(county_match)
													  	or NOT(state_match)
												  		or NOT(zip_match), addrstnme_compare_c10, NULL);

  zip_compare              := if(NOT(num_match)
                              or NOT(addrstnme_match) 
														  or NOT(county_match)
													  	or NOT(state_match)
												  		or NOT(zip_match), zip_compare_c13, NULL);
															
	county_compare           := if(NOT(num_match)
                              or NOT(addrstnme_match) 
														  or NOT(county_match)
													  	or NOT(state_match)
												  		or NOT(zip_match),  county_compare_c11, NULL);

  state_compare            := if(NOT(num_match)
                              or NOT(addrstnme_match) 
														  or NOT(county_match)
													  	or NOT(state_match)
												  		or NOT(zip_match),  state_compare_c12, NULL);
													
															
//========================================================================================================================
//=== produce points for the how well the primary name's match between the batch input and the one found by the service
//=======================================================================================================================

  risk_ind_address_score := Risk_Indicators.AddrScore.AddressScore(batch_in_prim_range, 
	                                                               batch_in_prim_name,
																																 batch_in_sec_range, 
																																 prim_range, prim_name, 
																																 sec_range);	
								
								
															
//==============================================================================
//=== Based on the values set by the fuzzy match and address score 
//=== set the values indicating the confidence of the address
//===       'U' - UNKOWN, 
//===       'Y' - YES
//===       'N' - NO
//===       'P' - PROBABLE
//===       'D' - DOUBTFULL
//==============================================================================

  
  addrmatch := map(
    addrstnme_compare = 0 or addrstnme_compare = NULL                             => 'Y',       //this is our best case scenario
    addrstnme_compare = 1 AND risk_ind_address_score BETWEEN 0 AND 40             => 'N',
    addrstnme_compare = 2 AND risk_ind_address_score BETWEEN 30 AND 49            => 'D',               
    addrstnme_compare = 2 AND risk_ind_address_score BETWEEN 50 AND 79            => 'P',                
		addrstnme_compare = 2 AND risk_ind_address_score BETWEEN 80 AND 100           => 'Y',
			                                                                               'U');     

  ctystmatch := map(
      NOT(rtnc_flag)                                                                  => 'U',
      county_match and state_match or county_compare = 0 AND state_compare = 0        => 'Y',
                                                                                         'N');
																																												 
//==============================================================================
//=== Finally set an Index showing the confidence of this address
//=== set the values indicating 
//==============================================================================
																																																
	
  useaddrindex := map(
      (addrmatch in ['Y', 'P']) => 1,
      ctystmatch = 'Y'          => 2,
      homestead_pts = 5         => 3,
      dl_pts = 5                => 4,
      voter_pts = 5             => 5,
                                 0);
																 

//==============================================================================
//=== Finish the TRANSFORM by assigning all of the variables
//=== to the output layout (the debug layout) 
//==============================================================================
	 
														 
	  SELF.obsnum         := generate_seq;
		SELF.model_name     := model_name;
		SELF.sysdate        := sysdate;
    SELF.name_first     := name_first; 
		SELF.name_middle    := name_middle;
		
		/* Model Intermediate Variables */	
		
		self.proflic_pts    := proflic_pts; 
		SELF.huntfish_pts   := huntfish_pts;
		SELF.utility_pts    := utility_pts; 
		
		SELF.property_pts   := property_pts;
		SELF.aircraft_pts   := aircraft_pts;
		SELF.bankruptcy_pts := bankruptcy_pts;
	  SELF.lienjudg_pts   := lienjudg_pts;
		SELF.foreclosure_pts := foreclosure_pts;
		SELF.paw_pts        := paw_pts; 
    SELF.business_pts   := business_pts;                                                                      
		SELF.phone_pts      := phone_pts;                                         
		SELF.veh_pts        := veh_pts; 
		SELF.watercraft_pts := watercraft_pts; 
		SELF.dl_pts         := dl_pts;
		SELF.voter_pts      := voter_pts; 
		SELF.homestead_pts  := homestead_pts;
		
		SELF.isaddress_pts         := isaddress_pts;
		SELF.addrrptscridx_pts     := addrrptscridx_pts;
		SELF.addrrpthstidx_pts     := addrrpthstidx_pts;    
		SELF.addrsrchhstidx_pts    := addrsrchhstidx_pts;  
		SELF.addrutlhstidx_pts     := addrutlhstidx_pts;   
		SELF.addrownhstidx_pts     := addrownhstidx_pts;  
		SELF.addrownmlidx_pts      := addrownmlidx_pts;  
		SELF.InfrOwnTypIdx_pts     := InfrOwnTypIdx_pts;
		
		SELF.highriskind_pts       := highriskind_pts;  
		
		SELF.voo_pts               := voo_pts;
		SELF.high_pts              := high_pts;                                 
		SELF.medium_pts            := medium_pts;
		SELF.low_pts               := low_pts;
		SELF.total_pts             := total_pts;
		
		SELF.risk_ind_address_score := risk_ind_address_score;
		
		SELF.rtns_flag             := rtns_flag;                          
		SELF.rtnc_flag             := rtnc_flag;
		SELF.num_match             := num_match;                           
		SELF.addrstnme_match       := addrstnme_match;
		SELF.county_match          := county_match;
		SELF.state_match           := state_match;
		SELF.zip_match             := zip_match;
		SELF.zip_match_int         := zip_match_int;
		SELF.min_length_prim_range := min_length_prim_range;
		SELF.num_compare_c9        := num_compare_c9;
		SELF.highriskind1_pts      := highriskind1_pts;
		SELF.highriskind3_pts      := highriskind3_pts;
		SELF.num_compare           := num_compare;
		
		SELF.addrstnme_compare     := addrstnme_compare;
		SELF.min_length_prim_name  := min_length_prim_name; 
		
		SELF.county_compare        := county_compare;
		
		SELF.state_compare         := state_compare;
		
		SELF.zip_compare           := zip_compare;
		
		SELF.addrmatch             := addrmatch;
		SELF.ctystmatch            := ctystmatch;
		SELF.useaddrindex          := useaddrindex;
		SELF.RB_score              := RB_score;
		SELF.index_final           := 0;   
		SELF    := le;
	END;

//=================================================
//===  Execute the "doModel" TRANSFORM function ===
//===  and produce the result set               ===
//=================================================
	model_int_results := PROJECT(input_record, doModel(LEFT,COUNTER));
	
	
//=================================================
//===  Reduce all of the addresses down to the  ===
//===  one with the highest number of points    ===
//===  and tie breaker index                    ===
//=================================================
  bestAddressRecs := dedup(sort(model_int_results, acctno, -total_pts, useaddrindex), acctno); 	
	

//=========================================================================
//===  IF we are running in DEBUG MODE                                  ===
//===     all addresses will be returned with their respective scores   ===
//===  ELSE                                                             ===
//===     Just the address with the highest score will be returned      ===
//=========================================================================	
	RETURN(if(inDEBUG_MODE, model_int_results, bestAddressRecs)); 
	 
END;

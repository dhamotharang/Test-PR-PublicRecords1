// This attribute was created to assist in the process of migrating R2 monitoring customers to the new R3 
// Account Monitoring process.  This attribute is obsolete as all customers have been migrated 
// off the R2 monitoring system. 


IMPORT Monitoring, Monitoring_Other, ut, AccountMonitoring;

EXPORT Export_R2_Files(STRING   customer_id_type,  // Valid customer_id types: BWH, NCO, PRA, STD (standard R2 files)
                       STRING   area,
                       STRING   despray_ip_address= '10.173.253.4',
                       STRING   despray_path= '/home/fnisswandt/thorwork',
										   UNSIGNED days_history = 60) :=
   FUNCTION

      // File Prefix Constants passed to the despray function as the Prefix for the output file name
			C_PORTFOLIO           := 'portfolio';
			C_ADDRESS_HISTORY     := 'history_address';
			C_PAW_HISTORY         := 'history_PAW';
			C_PHONE_HISTORY       := 'history_phone';
			C_PROPERTY_HISTORY    := 'history_property';
			
			customer_id_UpperCase := StringLib.StringToUpperCase(customer_id_type);
      Invalid_customer_id   := customer_id_UpperCase NOT IN ['BWH','PRA','NCO','STD'];
			area_UpperCase        := StringLib.StringToUpperCase(area);
			area_LowerCase        := StringLib.StringToLowerCase(area);
			
			// For NCO: phone and address history appear to use NCO_xxxyyy for their "key" 
			// rather than simply "xxxyyy" like the portfolio
      filter_clause := IF( customer_id_UpperCase = 'NCO',
			                     'NCO_' + area_UpperCase,
													 area_UpperCase
												 );

			// The historyDateFilter gets the Epoch date for today (date counter from 1901); subtracts the #
			// of history days requested converts that Epoch date back to the Gregorian date
			// to be used as the filter
			// -Per Franz, return no more than 60 days history 
			// -Per Cheri: no customer will want 0 days history.  All date outside of 1-60 will return 
			// 60 days history.
			VerifedHistWanted  := IF( days_history BETWEEN 1 AND 60,
			                         days_history,
															 60
														 );
														 
			HistoryDateFilter :=  AccountMonitoring.EpochConversionIntToYYYYMMDD( AccountMonitoring.EpochConversionYYYYMMDDToInt( ut.GetDate ) - VerifedHistWanted );
			
			Despray_File( DATASET ds,
	      	          STRING  file_prefix //'portfolio', 'history_address', 'history_PAW', 'history_phone', 'history_property'
	      	        ) := 
			   FUNCTION
	          thor_fn := '~thorwatch::temp::account_monitoring::export::' + 
						            file_prefix + '::' + 
												area_LowerCase + '_' +	
												thorlib.wuid();
	          
						despray_fn := IF( despray_path[LENGTH(despray_path)] != '/',
		                          despray_path + '/',
		                          despray_path
		                        ) + 
													file_prefix + '_' + 
													area_LowerCase + 
													'.csv';

	          output_cmd   := OUTPUT( ds, , thor_fn, CSV(HEADING(1), SEPARATOR('|'), 
                                    TERMINATOR('\n'), QUOTE(',')),OVERWRITE );

	          despray_cmd  := FileServices.DeSpray( thor_fn, despray_ip_address, 
						                                      despray_fn, -1, , , TRUE );

	          delete_cmd   := FileServices.DeleteLogicalFile( thor_fn );
						
						RETURN SEQUENTIAL( output_cmd, despray_cmd, delete_cmd );						
						// RETURN OUTPUT( ds, NAMED('ds'),OVERWRITE);	// for Debug purposes					
         END;  // Despray_File


	    // Portfolio files

      //BWH - Portfolio
      dsBWH_PortfolioRaw     := Monitoring.Files.BWH.Raw();   
      dsBWH_deSprayPortfolio := SORT( dsBWH_PortfolioRaw, customer_id, record_id ); 
 			dspry_BWH_Portfolio    := IF( EXISTS( dsBWH_deSprayPortfolio ),
			                              Despray_File( dsBWH_deSprayPortfolio,
																					        C_PORTFOLIO 
		                                            ) // end BWH Despray_File
																	); // end IF
 
	    // NCO - Portfolio
      dsNCO_PortfolioRaw := Monitoring.Files.NCO.ClientRaw( area_UpperCase );
      
			Layouts_File_Export.Layout_NCOPortfolio xfm_ClientRaw_to_NCO_Portfolio( Monitoring.layouts_NCO.batch_raw l ) := 
			   TRANSFORM
				    SELF.customer_id := l.customer_id[5..10];
						SELF.dob         := l.misc3;
						SELF.case_number := l.misc4;
						SELF.courtid     := l.misc5;
						SELF             := l;
         END;  // transform Layout_NCOportfolio
      
			dsNCO_Portfolio        := PROJECT( dsNCO_PortfolioRaw, xfm_ClientRaw_to_NCO_Portfolio(LEFT) );
			dsNCO_deSprayPortfolio := SORT( dsNCO_Portfolio, customer_id, record_id ); 
			dspry_NCO_Portfolio    := IF( EXISTS( dsNCO_deSprayPortfolio ),
			                              Despray_File( dsNCO_deSprayPortfolio, 
																					        C_PORTFOLIO 
																					    	) // end NCO Despray_File
                                  ); // end IF      

      //PRA - Portfolio
      dsPRA_PortfolioRaw     := Monitoring.Files.PRA.Raw();   
			dsPRA_deSprayPortfolio := SORT( dsPRA_PortfolioRaw, customer_id, record_id ); 
 			dspry_PRA_Portfolio    := IF( EXISTS( dsPRA_deSprayPortfolio ),
			                              Despray_File( dsPRA_deSprayPortfolio,
																			            C_PORTFOLIO 
																						    ) // end Property/PRA Despray_File
                                  );		
			
      //STD - Standard R2 Portfolio 
			dsSTD_deSprayPortfolio := SORT( Monitoring.Files.ClientRaw( area_UpperCase ), 
			                                customer_id, record_id ); 
		  dspry_STD_Portfolio    := IF( EXISTS( dsSTD_deSprayPortfolio ),
			                              Despray_File( dsSTD_deSprayPortfolio, 
																					        C_PORTFOLIO 
																						    ) // end Standard Despray_File
                                  ); // end IF
			
      
			// History Files
			
			// Address history
      dsAddressHistory := monitoring.File_Address_History( customer_id=filter_clause );
      
			Layouts_File_Export.Layout_AddressHistory xfm_to_AddressHistory( Monitoring.Layout_Address_History l ) := 
			   TRANSFORM
				    SELF.customer_id         := IF( customer_id_Uppercase = 'NCO',
						                                l.customer_id[5..10],
																				    l.customer_id );
						SELF.last_reported_date  := l.addr_dt_last_seen;
						SELF.first_reported_date := l.addr_dt_first_seen;
						SELF.source              := l.src;
						SELF.customer_provided   := IF( l.src <> '' AND l.best_address_count > 0, 0, 1 );
						SELF.date_added          := l.addr_version_number;
						SELF                     := l;
         END;  // transform Layout_AddressHistory
			
			ds_AddressHistory      := PROJECT( dsAddressHistory, xfm_to_AddressHistory(LEFT) );

			ds_RequestedAddHistory := ds_AddressHistory( date_added >= HistoryDateFilter); 

			ds_DesprayAddHist      := SORT( ds_RequestedAddHistory,customer_id, 
			                                record_id, -date_added
																	  );  // end SORT Address History
  
			dspry_AddressHistory   := IF( EXISTS( ds_DesprayAddHist ),
			                              Despray_File( ds_DesprayAddHist, 
																					        C_ADDRESS_HISTORY
																					      ) // end Despray Address History
                                  ); // end IF

			// PAW history
      dsPAWHistory := monitoring_other.file_paw_history( customer_id=filter_clause ); 

			Layouts_File_Export.Layout_PAW_History xfm_to_PAWHistory( Monitoring_Other.layout_paw_hist l ) := 
			   TRANSFORM
				    SELF.last_reported_date  := l.pawk_last_seen_1;
						SELF.first_reported_date := l.pawk_first_seen_1;
						SELF.date_added          := l.date_in;
						SELF                     := l;
         END;  // transform Layout_PAWHistory
			
			ds_PAWHistory          := PROJECT( dsPAWHistory, xfm_to_PAWHistory(LEFT) );

			ds_RequestedPAWHistory := ds_PAWHistory( date_added >= HistoryDateFilter );

			ds_DesprayPAWHist      := SORT( ds_RequestedPAWHistory,customer_id, 
			                                record_id, -date_added
																		); // end SORT PAW history

			dspry_PAWHistory       := IF( EXISTS( ds_DesprayPAWHist ),
			                              Despray_File( ds_DesprayPAWHist, 
																			            C_PAW_HISTORY
																						    ) // end Despray PAW History																				 
                                  ); // end IF
																	
			//Phone History
			dsPhoneHistory := monitoring.File_Phone_History(customer_id=filter_clause);
			
			Layouts_File_Export.Layout_PhoneHistory xfm_to_PhoneHistory (Monitoring.Layout_Phone_Update l ) := 
			   TRANSFORM
				    SELF.customer_id       := IF(customer_id_Uppercase = 'NCO',
						                             l.customer_id[5..10],
																				 l.customer_id);
						SELF.customer_provided := IF( l.phone_type <> '' AND l.best_phone_count > 0, 0, 1 ); 
						SELF.date_added        := l.phone_version_number;
						SELF                   := l;
         END;  // transform Layout_NCO_PhoneHistory

      ds_PhoneHistory     := PROJECT( dsPhoneHistory, xfm_to_PhoneHistory(LEFT) );
			ds_RequestedHistory := ds_PhoneHistory( date_added >= HistoryDateFilter ); 

			ds_desprayPhHist := SORT( ds_RequestedHistory,customer_id, record_id, -date_added );
			
			dspry_PhoneHistory  := IF( EXISTS( ds_desprayPhHist ),
			                           Despray_File( ds_desprayPhHist, 
																				       C_PHONE_HISTORY
																				     ) // end Despray Phone History
                                ); // end IF

      // Property history
      dsPropertyHistory := Monitoring_Other.file_prp_history( customer_id=filter_clause );
      
			Layouts_File_Export.Layout_Property_History xfm_to_PropertyHistory( Monitoring_Other.layout_prp_slim l ) := 
			   TRANSFORM
				    SELF.date_added          := l.date_in;
						SELF                     := l;
         END;  // transform to_PropertyHistory
			
			ds_PropertyHistory     := PROJECT( dsPropertyHistory, xfm_to_PropertyHistory(LEFT) );
			ds_RequestedPrpHistory := ds_PropertyHistory( date_added >= HistoryDateFilter );

			ds_DesprayPrpHist      := SORT( ds_RequestedPrpHistory,customer_id, 
			                                record_id, -date_added
																		);  // end SORT Property History
			
			dspry_PropertyHistory  := IF( EXISTS( ds_DesprayPrpHist ),
			                              Despray_File( ds_DesprayPrpHist, 
													              C_PROPERTY_HISTORY
													            ) // end Despray Pproperty History
											    ); // end IF
      
			dspry_Portfolio := CASE( customer_id_UpperCase,
			                         'BWH' => dspry_BWH_Portfolio,		 
			                         'NCO' => dspry_NCO_Portfolio,
											 'PRA' => dspry_PRA_Portfolio, 
											 'STD' => dspry_STD_Portfolio
											); // end CASE
			
      do_real_work := PARALLEL( dspry_Portfolio,
			                       dspry_PhoneHistory,
										  dspry_AddressHistory,
										  dspry_PropertyHistory,
										  dspry_PAWHistory
										 );

			RETURN IF(Invalid_customer_id, FAIL('Must provide valid customer_id: NCO, PRA, STD, or BWH'), do_real_work);
			         
END; // end Export_R2_Files function					

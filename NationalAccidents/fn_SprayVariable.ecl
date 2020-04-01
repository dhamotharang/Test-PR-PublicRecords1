//fn_SprayVariable

IMPORT STD;
EXPORT fn_SprayVariable (STRING ProcessFile, 
                         UNSIGNED3 MaxRecLength, 
												 STRING SprayFile, 
												 STRING FieldSeparator = Constants.FieldSeparator) := 
                                                    STD.File.SprayVariable(
										  				                			Constants.LandingZone,                                   // landing zone 
																					          ProcessFile,                                             // input file
																					          MaxRecLength,                                            // max rec
																					          FieldSeparator,                                          // field sep
																					          ,                                                        // rec sep (use default)
																					          Constants.DefaultQuote,                                  // quote
																					          Constants.THORDest,                                      // destination group
                                                    SprayFile,                                               // destination logical name
																					          -1,                                                      // time
																					          ,                                                        // esp server IP port
																					          ,                                                        // max connections
																					          TRUE,                                                    // overwrite
																					          TRUE,                                                    // replicate
																					          TRUE,                                                    // compression
																									);

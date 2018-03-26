IMPORT ut, RoxieKeyBuild; //CustomerTest
IMPORT PRTE2_Common as Common;

EXPORT FnSpray_And_Build_XRef(STRING CSVName, STRING fileVersion) := FUNCTION

// --------------------------------------------------
sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,											// file LZ
																					Constants.SourcePathForXRefCSV + CSVName, 		// path to file on landing zone
																					8192,																// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,		// line separator(s)
																					Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Cluster(),									// destination THOR cluster
																					Files.FILE_SPRAY_XREF,
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					FALSE												  			// do not compress
																					);																					 


// --------------------------------------------------
// save the sprayed in enhanced data, need to retain SSNs and LexIDs, etc
newXRefEnhanced := Files.SPRAYED_XREF_DS;

// PROJECT down to simple non-enhanced data 
// (we will not use clean addresses to get best address because property data has original address to match against)
newPropertyXRef := PROJECT(newXRefEnhanced, Layouts.Layout_Base_XRef);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyXRef,
																		 Files.BASE_PREFIX_NAME_XRef, 
																		 Files.SUFFIX_NAME_XREF,
																		 fileVersion, buildXRefBase, 3,
																		 false,true);
																			 
// --------------------------------------------------
delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY_XREF);

// --------------------------------------------------

AddrAddr_File_Contents  := PROJECT(Files.XRef_Base_SF_DS, Transforms.ReformatXRef2AddAdd(LEFT,COUNTER) );

RoxieKeyBuild.Mac_SF_BuildProcess_V2(AddrAddr_File_Contents,
																		 Files.BASE_PREFIX_NAME_AAXRef, 
																		 Files.SUFFIX_NAME_XREF,
																		 fileVersion, buildXRefAddrAddr, 3,
																		 false,true);

// --------------------------------------------------

NameAddr_File_Contents  := PROJECT(Files.XRef_Base_SF_DS, Transforms.ReformatXRef2NameAdd(LEFT,COUNTER) );

RoxieKeyBuild.Mac_SF_BuildProcess_V2(NameAddr_File_Contents,
																		 Files.BASE_PREFIX_NAME_NAXRef, 
																		 Files.SUFFIX_NAME_XREF,
																		 fileVersion, buildXRefNameAddr, 3,
																		 false,true);

// --------------------------------------------------

RoxieKeyBuild.Mac_SF_BuildProcess_V2(newXRefEnhanced,
																		 Files.BASE_PREFIX_NAME_ENXRef, 
																		 Files.ENHANCED_NAME_BASE,
																		 fileVersion, buildXRefEnhanced, 3,
																		 false,true);

// --------------------------------------------------
sequentialSteps	:= SEQUENTIAL (
											  sprayFile,
												buildXRefBase,
												buildXRefNameAddr,
												buildXRefAddrAddr,
												buildXRefEnhanced,
												delSprayedFile
												);

RETURN sequentialSteps;

END;
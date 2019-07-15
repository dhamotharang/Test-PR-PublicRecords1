IMPORT ut, _control, Civ_Court, Lib_FileServices, lib_stringlib,Lib_date, tools;
 
EXPORT spray_TX_Harris := MODULE

	EXPORT spray(STRING8 pVersion) := FUNCTION

	  serverIP	:=	IF(	Tools._Constants.IsDataland,
		                    _Control.IPAddress.bctlpedata12,
												_Control.IPAddress.bctlpedata11);
	//	Directory to Spray from
	  Directory	       :=	'/data/stub_cleaning/court/tx/tx_harris/';
																									
		destination      := '~thor_data200::in::civil::';
		dest_file				 := destination + pVersion + '::tx_harris';
		superfile        := '~thor_200::in::civil::tx_harris_new';
		

		spray_file			 := FileServices.Sprayfixed(serverIP, 
		                  Directory + pVersion + '.all.out',
                        901,
												'thor400_66',
											    destination + pVersion + '::tx_harris.raw', 
													     , 
															    ,
																	   ,
																		   , 
																			   true);
																				
		//Create a superfile in specified directory if it does not already exists. Clear it if it already exists.
		
TransformFile := FUNCTION
	dsraw := dataset(destination + pVersion + '::tx_harris.raw',	Civ_Court.Layout_In_TX_Harris.raw,flat);
					
	ds := PROJECT(dsraw,TRANSFORM(Civ_Court.Layout_In_TX_Harris.common; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		

//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile,, dest_file, CSV(SEPARATOR(','),QUOTE('"'),HEADING(1)), OVERWRITE)
	);
	

		add_to_super := SEQUENTIAL(				 
												FileServices.StartSuperFileTransaction();
												FileServices.AddSuperFile(superfile, dest_file);
												FileServices.FinishSuperFileTransaction();
												);
												
 // Remove RAW file
   remove_raw		:=	FileServices.DeleteLogicalFile(destination + pVersion + '::tx_harris.raw');												
												
		RETURN SEQUENTIAL(spray_file, xform_all, add_to_super,remove_raw);

	END;
	
END;
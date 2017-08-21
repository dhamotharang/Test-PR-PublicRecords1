currentdate := Stringlib.GetDateYYYYMMDD();

export DataAppend (string8 idate = currentdate) := FUNCTION

Layout_Input := BuildFax_Services.Layout_BuildFax.input_rec;

// Spray request data to Thor
thorinfilename  := Constants.infilename;
thoroutfilename := Constants.outfilename;
LzInDir         := Constants.LzPathIn;
FileName        := Constants.LZName;
sprayRqsts      := FileServices.SprayVariable(Constants.landingzone,
                                              LzInDir + 
																			        FileName,,
																			        Constants.csvseparator,,,
																			        Constants.dstcluster,
																			        thorinfilename,
                                              -1,,,true,true);

// Soapcall to Service to pull BuildFax data from keys
ds := DATASET(thorinfilename,Layout_Input, CSV(QUOTE('\"')));
Result := ServiceSoapcall_DataAppend(ds);
// Result := ProcessBuildFaxDataAppend(ds);
											
// Output results in CSV file
outputRslts := output(Result,,thoroutfilename,
                      CSV(SEPARATOR(Constants.csvseparator),
													QUOTE(Constants.csvquote)),
											overwrite);

// Despray file to Landing zone out file
LzOutDir     := Constants.LzPathOut;
desprayRslts := FileServices.DeSpray(thoroutfilename,
                                     Constants.landingzone,
						    	    							 LzOutDir + 'buildFax_append_' + workunit + '.csv',,,,true);
																				
append := sequential(sprayRqsts,outputRslts,desprayRslts);

RETURN append;
end;
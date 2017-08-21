export Mac_Combine_Logical_SubFiles(mainbasefile,inlayout,endfile) := 
macro

// *********************************************************************************************

	// Functionality : Macro reduces the count of subfiles in the main base file by combining 
	//				   a group of subfiles
	// Parameters 	 : mainbasefile - Main base file 
	//				   inlayout - Layout of the main base file
	// 				   endfile - file to determine the end of transaction
	
	////// Important - Do not prefix ~ when passing endfile parameter //////////////

// *********************************************************************************************


#uniquename(getcontents)
#uniquename(addsuper)
#uniquename(newdataset)
#uniquename(newfile)
#uniquename(addfullfile)
#uniquename(tempbasefile)
#uniquename(proj_rec)
#uniquename(proj_out)
#uniquename(createtempfile)


%getcontents% := fileservices.superfilecontents(mainbasefile);


%tempbasefile% := mainbasefile+'_tempfile';

%createtempfile% := if(fileservices.SuperFileExists(%tempbasefile%),
						output(%tempbasefile% + ' file exists'),
						fileservices.createsuperfile(%tempbasefile%));

%addsuper% := nothor(
					apply(%getcontents%,
						if(fileservices.getsuperfilesubcount(%tempbasefile%) < 
									fileservices.findsuperfilesubname(mainbasefile,'~'+endfile),
									lib_fileservices.Fileservices.addsuperfile(%tempbasefile%,'~'+name)
									//output('done')
							  )
						  )
				  );



%newdataset% := dataset(%tempbasefile%,inlayout,thor);

%newfile% := output(%newdataset%,,'~'+endfile+'_'+ut.GetDate,overwrite);

#uniquename(gettemp)
#uniquename(removesuper)

%gettemp% := fileservices.superfilecontents(%tempbasefile%);

%removesuper% := nothor(
					apply(%gettemp%,
							if(fileservices.findsuperfilesubname(mainbasefile,'~'+name) > 0 ,
									lib_fileservices.Fileservices.removesuperfile(mainbasefile,'~'+name)
								//	output('done')
							  )
						  )
				  );
				  

%addfullfile% := sequential(
							lib_fileservices.FileServices.startsuperfiletransaction(),
							lib_fileservices.FileServices.addsuperfile(mainbasefile,'~'+endfile+'_'+ut.GetDate,1),
							lib_fileservices.FileServices.clearsuperfile(%tempbasefile%),
							lib_fileservices.FileServices.finishsuperfiletransaction(),
							lib_fileservices.fileservices.deletesuperfile(%tempbasefile%)
						   );

sequential(output('Total subfiles in '+mainbasefile+' '+fileservices.getsuperfilesubcount(mainbasefile)),
						%createtempfile%,%addsuper%,%newfile%,%removesuper%,%addfullfile%,
						output('Total subfiles in '+mainbasefile+' after combining is '+fileservices.getsuperfilesubcount(mainbasefile)));

endmacro;
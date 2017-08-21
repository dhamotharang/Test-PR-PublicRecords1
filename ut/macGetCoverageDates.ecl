///////////////////////////////////////////////////////////////////////////
// -- macGetCoverageDates() -- Returns max and min coverage dates in a dataset based on parameters passed
// --
// -- Example:
// -- 	ut.macGetCoverageDates(ACF.File_ACF_Base	,'ACF'	,dt_first_seen	,dt_last_seen	,ACF_Base	,false	);
// -- 	ut.macGetCoverageDates(DCA.File_DCA_Base	,'DCA'	,Update_Date		,Update_Date	,DCA_Base	,true		);
// --		output(ACF_Base + DCA_Base, all);																																					
// -- 
// --	Here I did coverage datest on the ACF file and the dca file, then concatenated the resulting
// -- dataset together and outputted it.  Having the output in a dataset makes this much more scalable
// -- if you need to get coverage dates for many files, rather than trying to output each by itself to the workunit.
///////////////////////////////////////////////////////////////////////////
export macGetCoverageDates(

	 pFile														// file to do coverage date analysis on
	,pDatasetName											// String describing dataset(useful when concatenating the output of this macro)
	,pDateFirstSeen										// Field to Get earliest date from
	,pDateLastSeen										// field to get latest date from(may be the same as above)
	,pOUtput													// Output var
	,pIsDateString		= true					// Tells macro whether the two date fields passed are strings(true) or integers(false)
	,pMinDate					= '18000000'		// Pass these as integers
	,pMaxDate					= '21000000'		// Pass these as integers
	
) :=
macro
	
	#uniquename(mindtfirstseen)
	#uniquename(maxdtlastseen	)
	#uniquename(myrecord			)
	#uniquename(pfile_first		)
	#uniquename(pfile_last		)


	
	#if(pIsDateString = true)
		%mindtfirstseen%	:= min(pFile((unsigned4)pDateFirstSeen	> pMinDate	and (unsigned4)pDateFirstSeen	< pMaxDate)	, (unsigned4)	pDateFirstSeen	);
		%maxdtlastseen%		:= max(pFile((unsigned4)pDateLastSeen		> pMinDate	and (unsigned4)pDateLastSeen	< pMaxDate)	, (unsigned4)	pDateLastSeen		);
	#else                            
		%mindtfirstseen%	:= min(pFile(pDateFirstSeen > pMinDate	and pDateFirstSeen	< pMaxDate), 							pDateFirstSeen	);
		%maxdtlastseen%		:= max(pFile(pDateLastSeen	> pMinDate	and pDateLastSeen		< pMaxDate),							pDateLastSeen		);
	#end                                                     
	
	%myrecord% := 
	record, maxlength(100)
		
		unsigned4 CoverageBegin := 0;
		unsigned4 CoverageEnd		:= 0;
		string 		DatasetName		:= ''
	
	end;

	export pOutput := dataset([

		{%mindtfirstseen%, %maxdtlastseen%, pDatasetName}

	], %myrecord%);

endmacro;
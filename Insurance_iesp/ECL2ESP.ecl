// This should be shared among all future services (in theory)
IMPORT census_data, DriversV2_Services, iesp, Risk_Indicators, ut, doxie, AutoHeaderI, AutoStandardI;

EXPORT ECL2ESP := MODULE
  // This block of code is modeled after MAC_Marshall_Results, but it uses iesp-style
  // parameters and returns everything in a dataset instead of OUTPUTting the RecordCount
	export Marshall := module
		
		export integer return_count			:= 10	: stored('ReturnCount');		// records per page
		export integer starting_record	:= 1	: stored('StartingRecord');	// which record page starts with
		
		export integer max_return := ut.Min2(
			return_count, iesp.Constants.MAX_COUNT_SEARCH_RESPONSE_RECORDS
		);
	
    export Mac_Set (tag_options) := macro
      unsigned ReturnCount := global(tag_options).ReturnCount;
      #stored ('ReturnCount', ReturnCount);
      unsigned StartingRecord := global(tag_options).StartingRecord;
      #stored ('StartingRecord', StartingRecord);
    endmacro;

		export MAC_Marshall_Results(infile,outfile,l_out,recField='Records',noCount=false,countField='RecordCount') := macro
			outfile := project(
				dataset([0], {unsigned1 a}), 
				transform(
					l_out,                                    																																										
					#if(noCount=false)
						self.countField := count(infile),
						self.recField := choosen(infile, iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
					#else
						self.recField := infile;
					#end
				)
			);
		endmacro;
	end;

END;

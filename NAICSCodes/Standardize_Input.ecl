IMPORT  _Validate,  tools,  ut, MDR, std;

export  Standardize_Input :=  MODULE;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- map fields
	// -- do any conversions/validations
	//////////////////////////////////////////////////////////////////////////////////////
EXPORT fPreProcess(DATASET(Layouts.Sprayed_Input) pRawInput, DATASET(Layouts.Sprayed_Input_DnbDmi) pRawDnbDmiInput,string pversion) := FUNCTION

		Layouts.NAICSLookup NormTrf(Layouts.Sprayed_Input L) := transform			
				SELF			              := L;
				SELF 									  := [];
			end;

		naicsProject := PROJECT(pRawInput, NormTrf(LEFT));
		Gov_NAICS_Lookup_Table := naicsProject
		: persist('~thor_data400::persist::naics::lookup',SINGLE)
		;
					  
		Layouts.NAICSLookup NormDnbDmiTrf(Layouts.Sprayed_Input_DnbDmi L) := transform			
				SELF			              := L;
				SELF 									  := [];
			end;
			
		dnbDmiProject := PROJECT(pRawDnbDmiInput, NormDnbDmiTrf(LEFT));
		DnbDmi_NAICS_Lookup_Table := dnbDmiProject
		: persist('~thor_data400::persist::dnb_dmi::lookup',SINGLE)
		;

    naicsLookupTable := Gov_NAICS_Lookup_Table + DnbDmi_NAICS_Lookup_Table;	
		
		sortNaics := sort(naicsLookupTable, naics_code);
		
		dedupNaics := dedup(sortNaics,naics_code);
			
		RETURN dedupNaics;	

	END;

	EXPORT fAll( DATASET(Layouts.Sprayed_Input) pRawFileInput,
	             DATASET(Layouts.Sprayed_Input_DnbDmi) pRawDnbDmiFileInput,
							 STRING  pversion
	           ) := FUNCTION
						 
		dPreprocess	:= fPreProcess(pRawFileInput, pRawDnbDmiFileInput, pversion); 

		RETURN dPreprocess;
	
	END;

END;

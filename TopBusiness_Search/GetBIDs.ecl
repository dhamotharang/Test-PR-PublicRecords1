import _Control;

export GetBIDs(
	dataset(InputLayout) indata,
	OptionsLayout inoptions) := function
	
#if(not _Control.LibraryUse.ForceOff_TopBusiness_Search__LIB_GetBIDs)
	// Pack arguments
	args := module(LIBIN_GetBIDs)
		export dataset(InputLayout) input := indata;
		export OptionsLayout options := inoptions;
	end;
	
	// Parameters
	parms(LIBIN_GetBIDs inargs) := interface
		export dataset(OutputLayout) result;
	end;
	
	// Call Library
	return library('TopBusiness_Search.LIB_GetBIDs',parms(args)).result;
#else
	return Function_GetBIDs(indata,inoptions);
#end
end;

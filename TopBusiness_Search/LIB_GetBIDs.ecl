/*--LIBRARY--*/
import _Control;

export LIB_GetBIDs(LIBIN_GetBIDs args) := module

	#if(not _Control.LibraryUse.ForceOff_TopBusiness_Search__LIB_GetBIDs)
		,library(LIBOUT_GetBIDs)
	#end

	export result := Function_GetBIDs(args.input,args.options); 

end;
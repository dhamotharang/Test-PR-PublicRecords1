/*--LIBRARY--*/
import _Control,NID;

export lib_PFirst(NID.Interfaces.LIBIN_PFirst args) := 
MODULE
#if(not _Control.LibraryUse.ForceOff_NID__lib_PFirst)
	,LIBRARY(NID.Interfaces.LIBOUT_PFirst)
#end

//versions is where you can pick with which versions of PFirstX you want to be compatible
NID.Interfaces.type_versions versions := [1,2];

export names := NID.PreferredFirstVersioned(args.name, versions); 

END;
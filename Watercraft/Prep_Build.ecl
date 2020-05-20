//
// Watercraft.Prep_Build
//
// import Watercraft, Suppress ;

EXPORT Prep_Build := Module

	EXPORT Search_Base(dsn) := functionmacro			
		import Watercraft;
		return(Watercraft.Regulatory.applyWatercraftSearch(dsn));				
	endmacro;

	EXPORT Main_Base(dsn) := functionmacro			
		import Watercraft;
		return(Watercraft.Regulatory.applyWatercraftMain(dsn));
	endmacro;

end;
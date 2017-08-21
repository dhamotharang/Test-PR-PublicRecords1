//
// Watercraft.Prep_Build
//
import Watercraft, Suppress ;

EXPORT Prep_Build := Module

		EXPORT Search_Base_bip(dsn) := functionmacro			
				//'~thor_data400::base::watercraft_search'
				// Search_Base_ds       :=	dataset(dsn,Watercraft.Layout_Scrubs.Search_Base, thor);	
				return(Suppress.applyRegulatory.applyWatercraftS(dsn));				
		endmacro;

		EXPORT Main_Base(dsn) := functionmacro			
				//'~thor_data400::base::watercraft_main'
				// Main_Base_ds       :=	dataset(dsn,Watercraft.Layout_Scrubs.Main_Base,thor);	
				return(Suppress.applyRegulatory.applyWatercraftMain(dsn));
		endmacro;

end;
IMPORT tools,Bair;

EXPORT Files(boolean pUseProd = false, boolean pUseDelta = false) := MODULE

   /* base File Versions */
	export composite_base := dataset(Filenames(pUseProd,pUseDelta).composite_input, bair.layouts.rCompositeBase, flat);
	 
	 /* building File Versions */

	export composite_mo_building 		:=  dataset(Filenames(pUseProd,pUseDelta).composite_mo_building, Bair.layouts.dbo_event_mo_final_Base, thor, opt);
	export composite_per_building 	:=  dataset(Filenames(pUseProd,pUseDelta).composite_per_building, Bair.layouts.dbo_event_persons_final_Base, thor, opt);
	export composite_veh_building 	:=  dataset(Filenames(pUseProd,pUseDelta).composite_veh_building, Bair.layouts.dbo_event_vehicle_final_Base, thor, opt);
	export composite_building 			:=  dataset(Filenames(pUseProd,pUseDelta).composite_building, 	 bair.layouts.rCompositeBase, thor, opt);

END;
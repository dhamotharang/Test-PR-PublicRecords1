EXPORT Input_Clear := MODULE

	 EXPORT composite_data_building(boolean pUseProd = false) := FUNCTION 
			ret := sequential(	
					Fileservices.StartSuperFileTransaction(),
					Fileservices.RemoveOwnedSubFiles(Filenames(pUseProd,true).composite_mo_building,true),								
					Fileservices.ClearSuperFile(Filenames(pUseProd,true).composite_mo_building),
					Fileservices.RemoveOwnedSubFiles(Filenames(pUseProd,true).composite_per_building,true),								
					Fileservices.ClearSuperFile(Filenames(pUseProd,true).composite_per_building),
					Fileservices.RemoveOwnedSubFiles(Filenames(pUseProd,true).composite_veh_building,true),								
					Fileservices.ClearSuperFile(Filenames(pUseProd,true).composite_veh_building),
					Fileservices.RemoveOwnedSubFiles(Filenames(pUseProd,true).composite_building,true),									
					Fileservices.ClearSuperFile(Filenames(pUseProd,true).composite_building),
					Fileservices.FinishSuperFileTransaction()
			);
			RETURN ret;
		END;
end;
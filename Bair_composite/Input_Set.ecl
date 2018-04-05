EXPORT Input_Set := MODULE

	EXPORT composite_data_building(boolean pUseProd = false) := FUNCTION
		import Bair;

		thor_bair_cluster := '~thor_data400::';
			
		ret:=	sequential(
								Fileservices.StartSuperFileTransaction(),
								Fileservices.addsuperfile(Filenames(pUseProd,true).composite_mo_building	,thor_bair_cluster+'base::bair::dbo::mo::delta::built'		 ,addcontents := true),
								Fileservices.addsuperfile(Filenames(pUseProd,true).composite_per_building	,thor_bair_cluster+'base::bair::dbo::persons::delta::built'		 ,addcontents := true),
								Fileservices.addsuperfile(Filenames(pUseProd,true).composite_veh_building	,thor_bair_cluster+'base::bair::dbo::vehicle::delta::built'		 ,addcontents := true),
								Fileservices.addsuperfile(Filenames(pUseProd,true).composite_building			,'~thor400_data::base::composite_public_safety_data_delta' ,addcontents := true),										
								Fileservices.FinishSuperFileTransaction()
					);
		Return ret;					
	END;
	
END;
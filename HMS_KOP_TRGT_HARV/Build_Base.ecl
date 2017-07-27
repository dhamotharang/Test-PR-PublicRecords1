//Defines full build process
IMPORT _control, versioncontrol, hms_kop_trgt_harv,ut;

EXPORT Build_Base := MODULE

		EXPORT build_base_koptrgtharv(
   					 string				pversion
   					,boolean			pUseProd		= false
   					,dataset(hms_kop_trgt_harv.Layouts.layout_base		)pBaseFile		= hms_kop_trgt_harv.Files().koptrgtharv_Base.qa	) := module
   	
   					SHARED build_base_koptrgtharv := hms_kop_trgt_harv.Update_Base(pversion,pUseProd).KopTrgtHarv_Base;//dataset('~thor400_data::base::kop_trgt_harv::trgt_harv_results::temp::20170104',hms_kop_trgt_harv.Layouts.layout_base,thor);//dataset(hms_kop_trgt_harv.Filenames(,false).trgtharv_lInputTemplate, hms_kop_trgt_harv.layouts.layout_in, csv( separator('\t'),heading(single), terminator(['\n', '\r\n']), quote(['\'','"'])));
   					VersionControl.macBuildNewLogicalFile(
   																					 hms_kop_trgt_harv.Filenames(pversion, pUseProd).koptrgtharv_Base.new
   																				 	,build_base_koptrgtharv
   																					,Build_koptrgtharv_base
																						);
   					SHARED full_build_koptrgtharv	:=  
   						sequential(				
   						 		 Build_koptrgtharv_base
   								,hms_kop_trgt_harv.Promote.promote_koptrgtharv(pversion, pUseProd).buildfiles.New2Built
									);
   	
   					EXPORT koptrgtharv_all	:=
   						if(VersionControl.IsValidVersion(pversion)  //?? version
   								,full_build_koptrgtharv
   								,output('No Valid version parameter passed, skipping KOP TGRT HARV Full build')
   						);
   		END;

	
END;
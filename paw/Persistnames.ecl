import versioncontrol, business_header;
export PersistNames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module
	export Root 	:= business_header._dataset(pUseOtherEnvironment).thor_cluster_persists + 'persist::PAW::'		;

	export f_BusinessContactsStats	:= Root + 'fBusinessContactsStats'	;
	export f_CorpInactives					:= Root + 'fCorpInactives'					;
	
	export dAll_Filenames :=
	dataset([
	
				  {f_BusinessContactsStats		}							
				 ,{f_CorpInactives						}							
          
	], versioncontrol.Layout_Names)
	;
	
end;
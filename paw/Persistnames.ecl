import versioncontrol, business_header;
export PersistNames :=
module
	export Root 	:= business_header._dataset().thor_cluster_persists + 'persist::PAW::'		;

	export f_BusinessContactsStats	:= Root + 'fBusinessContactsStats'	;
	export f_CorpInactives					:= Root + 'fCorpInactives'					;
	
	export dAll_Filenames :=
	dataset([
	
				  {f_BusinessContactsStats		}							
				 ,{f_CorpInactives						}							
          
	], versioncontrol.Layout_Names)
	;
	
end;
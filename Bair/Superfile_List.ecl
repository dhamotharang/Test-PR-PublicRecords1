EXPORT Superfile_List(boolean pDelta = false) := module

	export NewHeader    				:= '~thor_data400::out::Bair_NewHeader_flag';
	export LastBuilt						:= '~thor_data400::out::Bair_LastBuilt_flag';
	export NonBooleanFullBuilt	:= '~thor_data400::out::bair_NonBooleanFullbuilt_flag';
	export BooleanFullBuilt			:= '~thor_data400::out::bair_BooleanFullbuilt_flag';
	export BldStatusFull		  	:= '~thor_data400::out::bair_bldsegment_status_full';
	export BldStatusDelta		  	:= '~thor_data400::out::bair_bldsegment_status_delta';
	export FilesSnap				  	:= '~thor_data400::out::bair_files_snap';
	export FlushBuiltVers	  		:= '~thor_data400::out::bair_flush_vers';	
	export LastFullPkgType			:= '~thor_data400::out::Bair_LastFullPkg_flag';
	export BldChkPt							:= '~thor_data400::out::bair_bldchkpt_' + if(pDelta, 'delta', 'full');
	export BuiltVers	    			:= '~thor_data400::out::bair_'+ if(pDelta, 'delta', 'full') + 'built_vers';	
	
	export BuiltVers_FlushRecs	:= dataset(FlushBuiltVers, bair.layouts.rFlushVers, flat);
	
end;
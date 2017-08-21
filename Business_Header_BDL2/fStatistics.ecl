import Statistics, versioncontrol;

export fStatistics := module

	export BDL(
	
		 dataset(Layout_BH_BDL) pBdl	= File_BDL2_Base
		,string													pversion
	
	) := 
	function

		find_one_record_bdls	:= table(pBdl, {bdl, unsigned8 cnt := count(group)}, bdl)(cnt = 1);
		one_record_bdids			:= join( pBdl										
																	,find_one_record_bdls
																	,left.bdl = right.bdl
																	,transform(recordof(pBdl), self := left)
//																	,local
															);

		Statistics.mac_one_Field_Stats(pBdl, 'BDL2','BDL',pversion,bdid			,'bdid'			,'integer',bdl2_bdid_one_field_stats		);
		Statistics.mac_one_Field_Stats(pBdl, 'BDL2','BDL',pversion,group_id	,'group_id'	,'integer',bdl2_group_id_one_field_stats);
		Statistics.mac_one_Field_Stats(pBdl, 'BDL2','BDL',pversion,bdl	    ,'bdl'	,'integer',bdl2_bdl_one_field_stats);
		
		Statistics.mac_one_Field_Stats(one_record_bdids,'BDL2','BDL2 Orphan BDL',pversion,BDL,'bdl','integer',bdl2_orphan_BDL_one_field_stats);

		Statistics.mac_two_Fields_Stats(pBdl,'BDL2','BDL',pversion,BDL,'bdl','integer',bdid,'bdid','integer',false,false,bdl2_bdl_bdid_two_fields_stats);

		return 
			bdl2_bdid_one_field_stats
		+ bdl2_group_id_one_field_stats
		+ bdl2_bdl_one_field_stats			
		+ bdl2_orphan_bdl_one_field_stats
		+ bdl2_bdl_bdid_two_fields_stats						
		;		
	end;
end;
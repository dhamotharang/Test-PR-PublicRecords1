import  ut,doxie, mdr;

export Key_ccw_rid(boolean  IsFCRA = false) := function
		KeyName  			:= cluster.cluster_out+'key::CCW::';
		KeyName_fcra  := cluster.cluster_out+'key::CCW::fcra::';
		df   					:= CCW_searchfile;
		
		return_file		:= IF (IsFCRA
												,INDEX(df(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),{rid,persistent_record_id},{df},KeyName_fcra +doxie.Version_SuperKey+'::rid')
												,INDEX(df,{rid,persistent_record_id},{df},KeyName +doxie.Version_SuperKey+'::rid')
												);
												
		return(return_file); 
end;
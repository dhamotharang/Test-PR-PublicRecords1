import  doxie, MDR;

export Key_ccw_did(boolean  IsFCRA = false) := function

KeyName_CCW  			:= cluster.cluster_out+'key::CCW::';
KeyName_CCW_fcra  := cluster.cluster_out+'key::CCW::fcra::';
sf := CCW_searchfile;


// Filter to remove empty dids
dbase := sf(did_out!='');
								
return_file		:= IF (IsFCRA
												,INDEX(dbase(Source_Code <> MDR.sourceTools.src_EMerge_CCW_NY),{unsigned6 did_out6 := (unsigned6)dbase.did_out},{rid}, KeyName_CCW_fcra+doxie.Version_SuperKey+'::did')
												,INDEX(dbase,{unsigned6 did_out6 := (unsigned6)dbase.did_out},{rid}, KeyName_CCW+doxie.Version_SuperKey+'::did')
												);
		return(return_file); 
end;																	


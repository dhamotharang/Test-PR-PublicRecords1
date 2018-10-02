Import prte2_common,prte,_control;
EXPORT UpdateDops(STRING current_version, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
 
 is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;

 doDOPS := is_running_in_prod AND NOT skipDOPS;	

 notifyEmail := IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);

 NoUpdate := OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						

 updatedops  := PRTE.UpdateVersion('xxxxxxx',current_version,notifyEmail,'B','F','N');
		
 PerformUpdateOrNot := IF(doDOPS,updatedops,NoUpdate);
 
 		
 RETURN PerformUpdateOrNot;
	
end;
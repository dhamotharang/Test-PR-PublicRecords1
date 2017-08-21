//Return true if layout change is detected
IMPORT _Control;
EXPORT BOOLEAN fnDetectLayoutChange(STRING8 filedate) := FUNCTION

	myEmail								:=	_Control.MyInfo.EmailAddressNotify;	//	Email address to send notifications
	//Get the heading field names from the last processed update
	current_update_superfile := '~thor_data400::in::vintelligence::processed::vin';
	heading_current 			:= dataset(current_update_superfile,{STRING20000 field_name},CSV(SEPARATOR(';'),heading(0)))[1].field_name;
	trim_heading_current 	:= TRIM(heading_current,LEFT,RIGHT);																		 
	current_heading_len 	:= LENGTH(trim_heading_current);
	current_field_cnt			:= StringLib.StringFindCount(trim_heading_current, '|');

	//Get the heading field names from the new update
	new_update_superfile	:= '~thor_data400::in::vintelligence::vin';
	heading_new			 			:= dataset(new_update_superfile,{STRING20000 field_name},CSV(SEPARATOR(';'),heading(0)))[1].field_name;
	trim_heading_new 			:= TRIM(heading_new,LEFT,RIGHT);																		 
	new_heading_len 			:= LENGTH(trim_heading_new);
	new_field_cnt					:= StringLib.StringFindCount(trim_heading_new, '|');

	//Compare the total length of field names and # of fields of 2 updates	
	str_compare_result		:= DataLib.StrCompare(heading_current,heading_new);
	ret_val								:= IF(str_compare_result=100,	false, true);

	emailMsg 							:= IF(ret_val,
															'Layout change - new update field count='+new_field_cnt+'/heading length='+new_heading_len+
															', current update field count='+current_field_cnt+'/heading length='+current_heading_len+'.' + '\n\n\n' +
															'Changes might start from below field -\n\n' + 
															'Current update - ' + FileServices.GetSuperFileSubName(current_update_superfile,1) + '\n' +
															heading_current[DataLib.LeadMatch(heading_current,heading_new)+1..] + '\n\n' +
															'New update - ' + FileServices.GetSuperFileSubName(new_update_superfile,1) + '\n' +
															heading_new[DataLib.LeadMatch(heading_new,heading_current)+1..] + '\n',
															'No layout change detected.');
	emailSubject					:= IF(ret_val,
															'VINtelligence Build '+ filedate + ' - Layout Change Warning',
															'VINtelligence Build '+ filedate + ' - No layout change');
	FileServices.SendEmail(	myEmail																				// to
													,emailSubject																	// subject
													,emailMsg																			// body
													,																							// mailServer
													,																							// port
													,);																						// sender

	RETURN ret_val;
	                 
		
END;
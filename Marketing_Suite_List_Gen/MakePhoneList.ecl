import Marketing_List, ut;

EXPORT MakePhoneList(
											dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
											dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
										 )	:= function;
										 
	// Make the Phone portion of the file from the filters
  string ParmFilterName_PhonePresent   				:= 'PHONEPRESENT';
	string ParmFilterName_PhoneTollFree			  	:= 'TOLLFREE';	
	string ParmFilterName_PhoneAreaCode					:= 'AREACODE';
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | 01 - PHONE              
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  rs_record_phone_present											:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhonePresent and set_filter_values[1] = 'Y');
	string filter_PhonePresent									:=	IF(COUNT(rs_record_phone_present) > 0,'Y','');

  rs_record_phone_tollfree                		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhoneTollFree);
  set of string filter_tollfree        				:= 	IF(COUNT(rs_record_phone_tollfree) > 0, rs_record_phone_tollfree[1].set_filter_values, ['']);
	
  rs_record_phone_areacode                		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_PhoneAreaCode);
  set of string filter_areacode	       				:= 	IF(COUNT(rs_record_phone_areacode) > 0, rs_record_phone_areacode[1].set_filter_values, ['']);
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Phone Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/
	PhonePresent		:=	if (filter_PhonePresent='Y',
													inSlimFile(	trim(phone)<>''));
													
	PhoneTollFree		:=	if (filter_tollfree[1] <> '', 
													inSlimFile(	trim(phone[1..3]) in filter_tollfree));
													
	PhoneAreaCode		:=	if (filter_areacode[1] <> '', 
													inSlimFile(	trim(phone[1..3]) in filter_areacode));
													
	PhoneRecords		:=	dedup(sort(PhonePresent + PhoneTollFree + PhoneAreaCode,record),record);
	
	return PhoneRecords;

end;
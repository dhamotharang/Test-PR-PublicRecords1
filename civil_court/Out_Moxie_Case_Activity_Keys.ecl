lBaseKeyName 	:= 'key::moxie.civil_case_activity.';

rMoxieFileForKeybuildLayout
 :=
  record
	civil_court.Layout_Moxie_Case_Activity;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(civil_court.Name_Moxie_Case_Activity_Dev,rMoxieFileForKeybuildLayout,flat);

rKey_Fields_Layout
 :=
  record
	lMoxieFileForKeybuild.case_key;
	lMoxieFileForKeybuild.event_date;
	lMoxieFileForKeybuild.case_number;
	lMoxieFileForKeybuild.state_origin;
	big_endian unsigned8	filepos	:= (big_endian unsigned8)lMoxieFileForKeybuild.__filepos;
end;

lCase_Activity_Keys_Table    := table(lMoxieFileForKeybuild,rKey_Fields_Layout);

//build case activity keys
kCaseKeyEventDate		:= buildindex(lCase_Activity_Keys_Table(case_key<>''),
							{case_key,event_date,filepos},
							lBaseKeyName + 'case_key.event_date.key',moxie,overwrite);
kCaseNoStateOrigin		:= buildindex(lCase_Activity_Keys_Table(case_number<>''),
							{case_number,state_origin,filepos},
							lBaseKeyName + 'case_number.state_origin.key',moxie,overwrite);
                           
//end case activity keys

export Out_Moxie_Case_Activity_Keys
 :=
  parallel(
			 kCaseKeyEventDate
			,kCaseNoStateOrigin
		   )
 ;
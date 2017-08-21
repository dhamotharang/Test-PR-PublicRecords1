prodVersion := dataset('~thor_data400::base::areacode_change_father',Risk_Indicators.layout_areacode_change,flat);
current := Risk_Indicators.File_AreaCode_Change;



prodVersion trecs(current L, prodVersion R) := transform

self := L;
end;

jrecs:= join(current,prodVersion,
left.old_NPA = right.old_NPA and 
left.old_NXX = right.old_NXX and 
left.old_date_extablished = right.old_date_extablished and 
left.permissive_end = right.permissive_end and 
left.old_name = right.old_name and 
left.new_NPA = right.new_NPA and
left.new_NXX = right.new_NXX and 
left.permissive_start = right.permissive_start and 
left.new_disconnect_date = right.new_disconnect_date and 
left.new_name = right.new_name, trecs(left,right), left only, lookup);


export sample_AreaCode_Change := output(jrecs,named('SampleAreaCodeChanges'));
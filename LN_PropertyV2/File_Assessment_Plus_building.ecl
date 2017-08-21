import ut; 

ut.mac_suppress_by_phonetype(LN_PropertyV2.File_Assessment_Plus,assessee_phone_number,state_code,assesor_phone_suppressed,false);

typeof(assesor_phone_suppressed) reformat(assesor_phone_suppressed l) := transform
	self.condo_project_or_building_name := regexreplace('[;]$',regexreplace('^[;]',trim(l.condo_project_or_building_name,left,right),''),'');
	self								:= l;
end;

p := project(assesor_phone_suppressed,reformat(left));

export File_Assessment_Plus_building := p;
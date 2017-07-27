import vehlic, doxie_build, drivers, ut, Roxiekeybuild,vehicleV2;

#workunit('name','Wildcard Hole Build');
export Proc_Build_wildcard_search(string filedate) := function

veh_norm := vehic_base_normal;

// Add Make 
temp_make :={ veh_norm , BIG_ENDIAN unsigned2 wd_MAKE_CODE , unsigned2 wd_body_code := 0}; 

temp_make lookMake(veh_norm l, vehicleV2.Files.base.make R) := TRANSFORM
   self.wd_MAKE_CODE := r.i;
   self := l;
end;

add_make := join(veh_norm, VehicleV2.Files.base.make,
				  stringlib.StringtoUpperCase(left.make_code)=stringlib.StringtoUpperCase(right.makecode),
				  lookMake(left,right),left outer, lookup);

temp_make getbody(add_make l, vehicleV2.Files.base.BodyStyle R) := TRANSFORM
   self.wd_body_code := r.i;
   self := l;
end;

AddBodyCode := join(add_make, vehicleV2.Files.base.BodyStyle,
				  stringlib.StringtoUpperCase(left.body_code)=stringlib.StringtoUpperCase(trim(right.body_style,left,right)),
				  getbody(left,right),left outer, lookup);
					
Layout_Hole_Veh lookModel(AddBodyCode l, file_Modelindex R) := TRANSFORM

 self.wd_veh_id := l.veh_id;
 self.wd_YEAR_MAKE := (integer)l.YEAR_MAKE;
 self.wd_MAKE_CODE := l.wd_MAKE_CODE;
 self.wd_body_code  := l.wd_body_code;
 self.wd_MAJOR_COLOR_CODE := Color2Code(l.major_color_code);
 self.wd_PLATE_NUMBER := l.PLATE_NUMBER;
 self.wd_VIN := l.VIN;
 self.wd_gender := l.sex;
 self.wd_years_since_1900 := (integer)l.DOB div 10000 - 1900;
 self.wd_zip := (integer)l.zip5;
 self.wd_state := ut.St2Code(l.state);
 self.wd_model_description := r.i;
 self.wd_orig_state := ut.St2Code(l.orig_state);
 self.wd_person_source :=(unsigned1) l.person_source;
 self.vehicle_key := l.vehicle_key;
 self.iteration_key := l.iteration_key;
 self.sequence_key := l.sequence_key;
end;

add_model := join(AddBodyCode, file_Modelindex,
				  stringlib.StringtoUpperCase(left.MODEL_description)=right.str,
				  lookModel(left,right),lookup);

add_Last := add_model; 

// Correct bogus tags (with tags count > 50)
tagRecord :=
RECORD
	add_Last.wd_PLATE_NUMBER;
	cnt := COUNT(GROUP);
END;
tagDist := DISTRIBUTE(add_Last(wd_PLATE_NUMBER != ''), HASH(wd_PLATE_NUMBER));
tagTable := TABLE(tagDist, tagRecord, wd_PLATE_NUMBER, LOCAL);
tagTooTall := tagTable(cnt > 50);

Layout_Hole_Veh remTags(Layout_Hole_Veh L, tagRecord R) :=
TRANSFORM
	SELF.wd_PLATE_NUMBER := IF(R.cnt > 0, '', L.wd_PLATE_NUMBER);
	SELF := L;
END;

blankTags := JOIN(add_Last, tagTooTall, LEFT.wd_PLATE_NUMBER = RIGHT.wd_PLATE_NUMBER, 
											remTags(LEFT, RIGHT), LEFT OUTER, LOOKUP);


Roxiekeybuild.MAC_SF_BuildProcess(blankTags, '~thor_data400::hole::wildcard_' + doxie_build.buildstate,
					'~thor_data400::data::vehicle::'+filedate+'::wildcard_' + doxie_build.buildstate, c1)


build_base_and_keys := sequential(proc_build_strings(filedate),c1);

return build_base_and_keys ;
end;

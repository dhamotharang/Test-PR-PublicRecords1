import vehicle_wildcard;


export boolean Fn_wildcard_badinput(string2 _state, string2 regState,set of unsigned2 make_use,
set of unsigned3 zip_use,set of unsigned2 model_use,set of unsigned1 MajorColor_use,integer ageRangeStart_use,
integer ageRangeEnd_use,integer modelYearStart_use,integer modelYearEnd_use,STRING8 sex_use,
string20 tag_value,string25 vin_value) := FUNCTION

many_rec := {boolean is_many};

make_rec := {unsigned2 make};

many_rec is_make_many(make_rec l) :=transform
self.is_many := l.make in vehicle_wildcard.make_codes_w_many_matches;
end;

zip_rec := {unsigned3 zip};

many_rec is_zip_many(zip_rec l) :=transform
self.is_many :=l.zip in vehicle_wildcard.zips_w_many_matches;
end;


input_rec := record
boolean state_bool;
boolean make_bool;
boolean zip_bool;
boolean model_bool;
boolean color_bool;
boolean ageRangeStart_use_bool;
boolean ageRangeEnd_use_bool;
boolean modelYearStart_use_bool;
boolean modelYearENd_use_bool;
boolean gender_bool ;
boolean plate_bool;
boolean vin_bool;
end;

sum_rec := record
unsigned1 s;
end;

input_rec get_inputs(doxie.layout_references l):=transform
self.state_bool := _state <> '' or regState <>'';
self.make_bool := make_use <> [];
self.zip_bool := zip_use <> [];
self.model_bool := model_use <> [];
self.color_bool := majorColor_use <> [];
self.ageRangeStart_use_bool := ageRangeStart_use <> 0;
self.ageRangeEnd_use_bool := ageRangeEnd_use <> 0;
self.modelYearStart_use_bool := modelYearStart_use <>0;
self.modelYearENd_use_bool := ModelYearEnd_use <> 0;
self.gender_bool := sex_use in ['M','F'];
self.plate_bool := tag_value <> '';
self.vin_bool := vin_value <> '';
end;

inputs := project(dataset([{0}],doxie.layout_references),get_inputs(left));
no_gender_state := project(inputs,transform(input_rec,self.gender_bool :=FALSE, self.state_bool:=FALSE, self:=left));
no_color := project(inputs,transform(input_rec,self.color_bool:=FALSE,self:=left));
no_gender_age := project(inputs,transform(input_rec,self.ageRangeStart_use_bool:=FALSE,self.ageRangeEnd_use_bool:=FALSE, self.gender_bool :=FALSE, self:=left));
no_gender_model_year := project(inputs,transform(input_rec,self.modelYearStart_use_bool:=FALSE,self.modelYearEnd_use_bool:=FALSE,self.gender_bool :=if(modelYearEnd_use >= 1970,FALSE,left.gender_bool), self:=left));
no_make := project(inputs,transform(input_rec,self.make_bool := if(exists(project(dataset(make_use,make_rec),is_make_many(left))(is_many)),false,left.make_bool),self:=left));
no_zip  := project(inputs,transform(input_rec,self.zip_bool := if(exists(project(dataset(zip_use,zip_rec),is_zip_many(left))(is_many)),false,left.zip_bool),self:=left));

sum_rec get_sum(input_rec l):=transform
self.s :=(unsigned1) l.state_bool+ (unsigned) l.make_bool+ (unsigned) l.zip_bool+ (unsigned) l.model_bool+ (unsigned) l.color_bool+ (unsigned) l.ageRangeStart_use_bool+ (unsigned) l.ageRangeEnd_use_bool+ (unsigned) 
l.modelYearStart_use_bool+ (unsigned) l.modelYearENd_use_bool+ (unsigned) l.gender_bool+ (unsigned) l.plate_bool+ (unsigned) l.vin_bool;
end;

just_gender_state := exists(project(no_gender_state,get_sum(left))(s=0));
just_color := exists(project(no_color,get_sum(left))(s=0));
just_gender_age := exists(project(no_gender_age,get_sum(left))(s=0));
just_gender_model_year := exists(project(no_gender_model_year,get_sum(left))(s=0));
just_make := exists(project(no_make,get_sum(left))(s=0));
just_zip := exists(project(no_zip,get_sum(left))(s=0));

unacceptable_inputs := just_gender_state or just_color or just_gender_age or just_gender_model_year or just_make or just_zip;


return unacceptable_inputs;

END;
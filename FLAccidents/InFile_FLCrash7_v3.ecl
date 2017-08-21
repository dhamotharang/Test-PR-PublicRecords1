import ut,Address,lib_StringLib; 
flc7_v2_in0 := dataset(ut.foreign_prod + '~thor_data400::sprayed::flcrash7'
						,FLAccidents.Layout_FLCrash7_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));

flc7_v2_rec := FLAccidents.Layout_FLCrash7_v2;

Address.Mac_Is_Business_Parsed(	flc7_v2_in0,flc7_v2_in,prop_owner_firstname,prop_owner_middleinitial,prop_owner_lastname,'');

flc7_v2_rec flc7_convert_to_old(flc7_v2_in le) := transform

clean_name := if(le.nametype <>'B',Address.CleanPersonFML73(StringLib.StringFindReplace(lib_stringlib.StringLib.StringCleanSpaces(le.prop_owner_firstname +' '+ le.prop_owner_middleinitial +' '+le.prop_owner_lastname),'.',' ')),'');

self.rec_type_7          := '7';
self.prop_owner_name	:=	trim(trim(le.prop_owner_firstname,left,right)+' '+trim(le.prop_owner_middleinitial,left,right)+' '+trim(le.prop_owner_lastname,left,right),left,right);
self.prop_owner_address	:=	trim(le.prop_owner_street,left,right);
self.prop_owner_st_city	:=  trim(le.prop_owner_city,left,right);

self.title			             := if(clean_name <> '',clean_name[1..5],'');
self.fname				           := if(clean_name <> '',clean_name[6..25],'');
self.mname				           := if(clean_name <> '',clean_name[26..45],'');
self.lname				           := if(clean_name <> '',clean_name[46..65],'');
self.suffix	                 := if(clean_name <> '',clean_name[66..70],'');
self.score                   := if(clean_name <> '',clean_name[71..73],'');

self.cname			:=	if(le.nametype ='B',trim(trim(le.prop_owner_firstname,left,right)+' '+trim(le.prop_owner_middleinitial,left,right)+' '+trim(le.prop_owner_lastname,left,right),left,right),'');
self                    :=  le;
self                    := [];

end;

export InFile_FLCrash7_v3 := project(flc7_v2_in,flc7_convert_to_old(left));



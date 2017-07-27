import crim_common, hygenics_crim;

//Base Offender File
ds 	:= dataset(Crim_Common.Name_Moxie_Crim_Offender2_Dev +'_new', hygenics_crim.Layout_Common_Crim_Offender_new, flat)(trim(image_link,left,right) <> '');

	rec := RECORD
		STRING offender_key;
		string state_origin;
		string filename;
	END;
	
	rec slimFile(ds l):= transform
		self.filename 	:= l.image_link;
		self 			:= l;
	end;

export File_IMG_CommonInfo := project(ds, slimFile(left));
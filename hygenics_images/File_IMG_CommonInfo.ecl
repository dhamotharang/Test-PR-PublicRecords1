import corrections, crim_common, hygenics_crim, ut;

//Base Offender File
ds 	:= dataset('~thor_data400::base::corrections_offenders_public', corrections.layout_offender, flat)(trim(image_link,left,right) <> '');

	rec := RECORD
		STRING offender_key;
		string state_origin;
		string filename;
	END;
	
	rec slimFile(ds l):= transform
		self.filename 		:= l.image_link;
		self.state_origin := ut.st2abbrev(stringlib.stringtouppercase(l.orig_state));
		self 			:= l;
	end;

 File_IMG_CommonIn := project(ds, slimFile(left));
export File_IMG_CommonInfo	:= distribute(File_IMG_CommonIn, hash(filename));
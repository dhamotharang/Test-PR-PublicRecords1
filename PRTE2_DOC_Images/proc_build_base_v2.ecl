import std,PromoteSupers,RoxieKeyBuild;

//NOTE: The Image Matrix Base has to build first before processing
//

EXPORT proc_build_base_v2(string filedate) := function

Layouts.Common_v2 	encImg2(files.Images_base_reformat l):= transform
	 self.imglength 	:= length(STD.Str.EncodeBase64(l.photo));
		self.photo 					:= STD.Str.EncodeBase64(l.photo);
		self := l;
	end;

	ds_crim_reform := project(files.Images_base_reformat, encImg2(left));
	

	RoxieKeyBuild.Mac_SF_BuildProcess(ds_crim_reform,Constants.base_prefix_name_v2+'matrix_images',Constants.base_prefix_name_v2+filedate+'::matrix_images_base', do_build, 2);
	return do_build;
	
	end;
	
	
	
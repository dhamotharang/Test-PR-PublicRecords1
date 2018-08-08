import ut, PromoteSupers, images, crim_common, hygenics_crim, corrections,data_services,prte2_doc,std,RoxieKeyBuild;

EXPORT proc_build_base(string filedate):= function

//Format Images File
	ds1 := dataset(Constants.in_prefix_name	+'varying_sources',layouts.raw_image,flat);
		
	images.MAC_ShrinkImage(ds1,filename,imgLength,photo,ds1b);
	

//Format Offender File
	Layouts.IMG_CommonInfo slimFile(files.offender_base l):= transform
		self.filename 				:= trim(l.image_link,all);
		self.state_origin := ut.st2abbrev(STD.Str.ToUpperCase(l.orig_state));
		self 			:= l;
	end;

IMG_CommonInfo := project(Files.offender_base, slimFile(left));

//CREATE IMAGE BASE FILE/////////////////////////
	Layouts.Common getspk(ds1b le, IMG_CommonInfo ri) := TRANSFORM
		SELF.did        := (unsigned)ri.did;
		SELF.state 		  	:= ri.offender_key[1..2];
		SELF.rtype 		  	:= map(ri.data_type ='1' => 'DC',
																									ri. data_type ='5' => 'AL',
																									'');
	
	 SELF.id 		    		:= TRIM(ri.offender_key, ALL);;
		SELF.seq 		    	:= 0;
		SELF.date 		  		:= '';
		SELF.num 		    	:= 1;
		self.image_link := TRIM(ri.filename,ALL);
		SELF.imgLength 	:= le.imgLength;
		SELF.photo 		  	:= le.photo;
	END;

	jMatrixImaages := JOIN(ds1b, IMG_CommonInfo, 
																								trim(STD.Str.ToUpperCase(LEFT.filename))	= trim(RIGHT.filename),
																								getspk(LEFT,RIGHT));

	RoxieKeyBuild.Mac_SF_BuildProcess(jMatrixImaages,Constants.base_prefix_name+'matrix_images',Constants.base_prefix_name+filedate+'::matrix_images_base', do_build, 2);
	
	return do_build;

end;
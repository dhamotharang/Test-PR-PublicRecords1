import hygenics_soff, RoxieKeyBuild,Std;

export proc_build_base(string filedate) := function

_all_images :=  Images.Images_FL_dc + 
			 Images.Images_GA    + 
			 Images.Images_MI_dc +
			 Images.Images_ARdc_In + 
			 Images.Images_IL_dc +   
			 Images.Images_KS_dc +   
			 Images.Images_KY_dc +	  
			 Images.Images_NC_dc + 
			 Images.Images_MNdc_In +
			 Images.Images_NJ_dc +		
			 Images.Images_OKdc_In +	
			 images.File_Sexoffender_Combined;

// Make sure the id's are left justified
Images.Layout_Common trimmer(Images.Layout_Common L) :=
TRANSFORM
	SELF.id := TRIM(L.id, ALL);
	SELF := L;
END;

trimmed := PROJECT(_all_images, trimmer(LEFT));

images.Layout_Common get_dids(trimmed l, images.File_idDID R) := transform
	self.did := R.did;
	self := L;
end;

// switched this proc from an output to a persist...need an action for the sequential
// so outputting the first record to force the persist to build...
prebuild := output(choosen(images.proc_build_idDID,1));

withdid_join := join(trimmed,images.File_idDID, left.state = right.state and
					left.rtype = right.rtype and
					left.id = right.id,get_dids(LEFT,RIGHT),left outer,hash);
					
withdid := withdid_join(image_link<>'' and imglength>0);

//Add Image Date///////////////////////////////////////////////////////////////////////////
	ds_img 	:= sort(distribute(withDid(rtype='SO'), hash(state, image_link)), state, image_link,local);
	ds_soff	:= hygenics_soff.File_In_SO_Defendant(photoname<>'');

	imglnk_layout := record
		ds_soff;
		string imagelink;
		string photodate;
	end;

	//SOff Pull Photo Info
	imglnk_layout pullPhoto(ds_soff l):= transform
		self.photodate := if(regexfind('DATE_OF_PHOTO:', l.defendantadditionalinfo, 0)<>'',
													l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'DATE_OF_PHOTO:', 1)+15..length(l.defendantadditionalinfo)],
												if(regexfind('PHOTO DATE:',  l.defendantadditionalinfo, 0)<>'',
													l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..length(l.defendantadditionalinfo)],
												if(regexfind('PHOTO LAST UPDATED:', l.defendantadditionalinfo, 0)<>'',
													l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO LAST UPDATED:', 1)+20..length(l.defendantadditionalinfo)],
												if(regexfind('PHOTODATE:', l.defendantadditionalinfo, 0)<>'',
													l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTODATE:', 1)+11..length(l.defendantadditionalinfo)],
													''))));
		self.imagelink := '';	
		self := l;
	end;
	
	ds_pull_photo := project(ds_soff, pullPhoto(left));
	
	imglnk_layout addVend(ds_pull_photo l):= transform
	
		fixYYYYMMDD(string ds):= function
			fulldate 	:= if(regexfind('-', ds, 0)<>'',
										regexreplace('-', ds, '/'),
										ds);
										
			fmtsin := [
		          '%m/%d/%Y',
		          '%m/%d/%Y'
	              ];
	    fmtout:='%Y%m%d';		
			
			return Std.date.ConvertDateFormatMultiple(fulldate,fmtsin,fmtout);
	  end;
			
		photo_date				:= if(l.photodate[3] in ['/','-'],
															fixYYYYMMDD(l.photodate[1..10]),
														if(l.photodate[2] in ['/','-'],
															fixYYYYMMDD(l.photodate[1..10]),
														if(l.photodate[1] in ['J','F','M','A','S','O','N','D'] and l.photoname[1..3] != 'NOT',
															hygenics_soff._functions.fn_dateMMMDDYYYY(l.photodate[1..stringlib.stringfind(l.photodate, ';', 1)-1]),
														if(l.photodate[1..2] in ['19','20'],
															l.photodate[1..8],
														''))));	
													
		self.imagelink   	:= if(trim(l.photoname, left, right)<>'',
														StringLib.StringToUpperCase(trim(l.statecode, left, right)+'SOR_'+trim(l.photoname)),
														'');
		self.photodate   	:= photo_date;
		self 							:= l;
	end;

	soff_addDate := sort(distribute(project(ds_pull_photo, addVend(left)), hash(statecode, imagelink)), statecode, imagelink,local): persist('~images::base::sexoffender_test');
	
	withdid addDt(ds_img l, soff_addDate r) := transform
		self.date				:= if(r.photodate[1..2] in ['19','20'] and length(trim(r.photodate, left, right))=8,
													r.photodate,
													'');
		self 						:= l;	
	end;
	
	soff_match 				:= join(ds_img, soff_addDate, 
													trim(left.state,left,right) = trim(right.statecode,left,right) and																										
													trim(left.image_link,left,right) = trim(right.imagelink,left,right), 
													addDt(left,right), 
													left outer, keep(1),local):persist('~thor400_20::persist::soff_image_base');

	ds_complete := withdid(rtype not in ['SO']) + soff_match;

RoxieKeyBuild.Mac_SF_BuildProcess(ds_complete,'~images::base::Matrix_Images',
                '~images::base::sexoffender::'+filedate+'::matrix_images_base',do_build,2);
//ut.MAC_SF_BuildProcess(withdid,'~images::base::Matrix_Images',do1,2)

return sequential(prebuild,do_build);
end;
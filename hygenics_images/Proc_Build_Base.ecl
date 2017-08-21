import ut, hygenics_crim, RoxieKeyBuild, images;

export proc_build_base(string filedate) := function

	_all_images := hygenics_images.File_DOC_Images_Combined.DOC_Concat_All +
					hygenics_images.File_Arrest_Images_Combined.ARR_Concat_All;

	// Make sure the id's are left justified
	Images.Layout_Common trimmer(Images.Layout_Common L) := TRANSFORM
		SELF.id := TRIM(L.id, ALL);
		SELF := L;
	END;

	trimmed := PROJECT(_all_images, trimmer(LEFT));

	images.Layout_Common get_dids(trimmed l, hygenics_images.File_idDID R) := transform
		self.did := R.did;
		self := L;
	end;

	// switched this proc from an output to a persist...need an action for the sequential
	// so outputting the first record to force the persist to build...
	prebuild := output(choosen(hygenics_images.proc_build_idDID,1));

	withdid_join := join(trimmed, hygenics_images.File_idDID, 
						left.state = right.state and
						left.rtype = right.rtype and
						left.id = right.id,
						get_dids(LEFT,RIGHT), left outer, hash);
						
	withdid := withdid_join(image_link<>'' and imglength>0);
	
	//Add Image Date//////////////////////////////////////////////////////////////
	ds_img 	:= sort(withdid(rtype='DC'), hash(state, image_link), state, image_link, -did);
	ds_doc 	:= hygenics_crim.file_in_defendant_doc(photoname<>'');

	imglnk_layout := record
		ds_doc;
		string imagelink;
		string photodate;
	end;

	//DOC
	imglnk_layout addVend(ds_doc l):= transform
		vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
		
		self.photoname 	:= if(trim(l.photoname, left, right)<>'',
																StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
																'');
		self.imagelink	:= '';
				
		self.photodate	:= if(regexfind('PHOTO DATE:', l.defendantadditionalinfo, 0)<>'',
													trim(l.defendantadditionalinfo[stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+12..stringlib.stringfind(l.defendantadditionalinfo, 'PHOTO DATE:', 1)+20]),
													l.institutionreceiptdate);
		self 						:= l;
	end;

	doc_addDate := sort(distribute(project(ds_doc, addVend(left)), hash(statecode, photoname)), statecode, photoname);
	
	withdid addDt(ds_img l, doc_addDate r) := transform
		self.date				:= if(r.photodate[1..2] in ['19','20'],
														r.photodate,
														'');
		self 						:= l;	
	end;
	
	doc_match 				:= join(ds_img, doc_addDate, 
													trim(left.state,left,right) = stringlib.StringToUpperCase(trim(right.statecode,left,right)) and																										
													trim(left.image_link,left,right) = trim(right.photoname,left,right), 
													addDt(left,right), 
													left outer, keep(1)):persist('~thor400_20::persist::doc_image_base');

	//Arrest File//////////////////////////////////////////////////////////////
	ds_img_a 	:= sort(withdid(rtype='AL'), hash(state, image_link), state, image_link, -did);
	ds_arr 		:= hygenics_crim.file_in_defendant_arrests(photoname<>'');
	ds_chg		:= hygenics_crim.file_in_charge_arrests;

	imglnk_layout2 := record
		ds_arr;
		string imagelink;
		string photodate;
	end;

	//Arrest
	imglnk_layout2 addVendr(ds_arr l):= transform
		vVendor 				:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(l.sourcename),l.statecode);
		
		 self.photoname	:=  if(trim(l.photoname, left, right)<>'' and trim(l.sourcename, left, right)<>'FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
													if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)<>'' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname[1..DataLib.StringFind(l.photoname, ',', 1)]),
													if(trim(l.photoname, left, right)<>'' and regexfind(',', l.photoname, 0)='' and trim(l.sourcename, left, right)='FLORIDA_BREVARD_COUNTY_ARRESTS',
														StringLib.StringToUpperCase(vVendor+'_'+l.photoname),
														'')));
		self.photodate	:= '';
		self.imagelink	:= '';
		self 						:= l;
	end;

	arr_addVendor := project(ds_arr, addVendr(left));
	
	addChgLayout := record
		arr_addVendor;
		string20	BookingNumber;
		string8		ArrestDate;
		string8		BookingDate;
	end;

	addChgLayout addField(arr_addVendor l, ds_chg r):= transform
		self 								:= l;
		self.bookingnumber 	:= r.bookingnumber;
		self.arrestdate			:= r.arrestdate;
		self.bookingdate 		:= r.bookingdate;
	end;
	
	slim_AllOff 	:= join(arr_addVendor, ds_chg,
												left.statecode=right.statecode and 
												left.recordid=right.recordid,
												addField(left,right));	
	
	slim_AllOffChg:= sort(distribute(slim_AllOff, hash(statecode, photoname)), statecode, photoname);

	withdid addDt2(ds_img_a l, slim_AllOffChg r) := transform
		self.date				:= if(r.arrestdate[1..2] in ['19','20'],
													r.arrestdate,
												if(r.bookingdate[1..2] in ['19','20'],
													r.bookingdate,
														''));
		self 						:= l;	
	end;
	
	arr_match 				:= join(ds_img_a, slim_AllOffChg, 
													trim(left.state,left,right) = stringlib.StringToUpperCase(trim(right.statecode,left,right)) and																										
													trim(left.image_link,left,right) = trim(right.photoname,left,right), 
													addDt2(left,right), 
													left outer, keep(1)):persist('~thor400_20::persist::arr_image_base');

	ds_complete := withdid(rtype not in ['DC','AL']) + doc_match + arr_match;

RoxieKeyBuild.Mac_SF_BuildProcess(ds_complete,'~criminal_images::base::Matrix_Images',
                '~criminal_images::base::criminal::'+filedate+'::matrix_images_base', do_build, 2);

return sequential(prebuild, do_build);

end;
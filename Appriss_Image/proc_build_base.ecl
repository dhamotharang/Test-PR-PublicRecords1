import ut, RoxieKeyBuild,Appriss_Image;

export proc_build_base(string filedate) := function

BaseFile := File_Appriss_image_base;

d_basefile := distribute(basefile, hash(Booking_sid));

d_basefile applydeletes(d_basefile L , File_Image_link R) := TRANSFORM 
//inherited the modified values for the following bug 72731
  self.agencyKey   := r.agencyKey;
	self.maxQueueSid := r.maxQueueSid;	
  self.did         := r.did;
  self := L;
end;

ResultingBase := join(d_basefile ,File_Image_link, left.booking_sid = right.booking_sid,
                      applydeletes(LEFT,RIGHT),local );

// Combined :=  IF(Appriss_Image.fn_exists_Images(),
                          // File_Appriss_Images(image_link<>'' and imglength>0) + ResultingBase, 
													// ResultingBase);
													
sortedImages := IF (Appriss_Image.fn_exists_Images(),
                    SORT(File_Appriss_Images(image_link<>'' and imglength>0) + ResultingBase,booking_sid,image_link,(integer)maxqueuesid,date,local),
										SORT(ResultingBase,booking_sid,image_link,(integer)maxqueuesid,date,local)
									 );//sort it first
 
dedupedImages:= DEDUP(sortedImages,booking_sid,image_link,right,local);

RoxieKeyBuild.Mac_SF_BuildProcess(dedupedImages,'~Appriss_images::base::Matrix_Images',
                '~Appriss_images::base::Appriss::'+filedate+'::Matrix_images_base',do_build,2);


return sequential(//prebuild,
                  do_build);
end;
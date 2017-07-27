import ut, RoxieKeyBuild,Appriss_Image;

export Prod_build_base_Firsttimeuse(string filedate) := function

//BaseFile := File_Appriss_image_base;

//d_basefile := distribute(basefile, hash(Booking_sid));

// d_basefile applydeletes(d_basefile L , File_Image_link R) := TRANSFORM 
  // self := L;
// end;

// ResultingBase := join(d_basefile ,File_Image_link, left.booking_sid = right.booking_sid,
                      // applydeletes(LEFT,RIGHT),local );

// Combined :=  IF(Appriss_Image.fn_exists_Images(),
                          // File_Appriss_Images(image_link<>'' and imglength>0) + ResultingBase, 
													// ResultingBase);
													
sortedImages := SORT(File_Appriss_Images(image_link<>'' and imglength>0) ,booking_sid,image_link,(integer)maxqueuesid,date,local);
 
dedupedImages:= DEDUP(sortedImages,booking_sid,image_link,right,local);

RoxieKeyBuild.Mac_SF_BuildProcess(dedupedImages,'~Appriss_images::base::Matrix_Images',
                '~Appriss_images::base::Appriss::'+filedate+'::Matrix_images_base',do_build,2);

return sequential(//prebuild,
                  do_build);
end;

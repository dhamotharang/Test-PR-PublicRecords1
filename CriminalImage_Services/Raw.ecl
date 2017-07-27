import hygenics_images_v2,images_v2,doxie;

EXPORT Raw := module;
	export getCrimImagesByDid (dataset(doxie.layout_references) in_dids) := function

		crim_offenderkey := hygenics_images_v2.Key_DID;
		crim_id_recs := join(in_dids, crim_offenderkey,  
										keyed(left.did = right.did) and 
										right.rtype <> Constants.SOImageType,
										limit(0), keep(Constants.maxImageRecords));
										
		crim_id_recs_project := project(crim_id_recs, transform(hygenics_images_v2.Layout_Key_DID, self := left));
		crim_raw_Images := fetch(hygenics_images_v2.File_Images, crim_id_recs_project, RIGHT.__filepos, transform(Images_V2.Layout_Common,
																																													SELF.did := right.did,
																																													SELF.id := right.id,
																																													SELF.imgLength := left.imgLength,
																																													SELF.image_link := left.image_link,
																																													SELF.photo := left.photo,
																																													SELF := right));  
		return crim_raw_Images;
	end;

	export getSOImagesByDid (dataset(doxie.layout_references) in_dids) := function
		so_imagekey := images_v2.Key_DID;
		so_id_recs := join(in_dids, so_imagekey,  
										keyed(left.did = right.did) and 
										right.rtype = Constants.SOImageType,
										limit(0), keep(Constants.maxImageRecords));
										
		so_id_recs_project := project(so_id_recs, transform(Images_V2.Layout_Key_DID, self := left));
		so_raw_Images := fetch(images_v2.File_Images, so_id_recs_project, RIGHT.__filepos, transform(Images_V2.Layout_Common,
																																					SELF.did := right.did,
																																					SELF.id := right.id,
																																					SELF.imgLength := left.imgLength,
																																					SELF.image_link := left.image_link,
																																					SELF.photo := left.photo,
																																					SELF := right)); 
		return so_raw_Images;		
	end;
END;
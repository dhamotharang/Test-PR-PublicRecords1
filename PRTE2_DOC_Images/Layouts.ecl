import images, hygenics_images, prte2_doc;

EXPORT Layouts := module

	export Common 										:= images.Layout_Common;
	export SPKey_ImageLink 	:= hygenics_images.Layout_SPKey_ImageLink;
	export Crim_Pics_Lookup := Hygenics_images.Layout_Crim_Pics_Lookup;
	
	
	export raw_image := RECORD, MAXLENGTH(100000000)
		STRING   filename;
		UNSIGNED4 imgLength;
		JPEG(SELF.imgLength) photo;
	END;
	
		export IMG_CommonInfo := record
			string offender_key;
			string state_origin;
			string filename;
			recordof(prte2_doc.files.file_offenders_base_plus);
		END;
	
		export matrix_images := record, maxlength(hygenics_images.MaxLength_FullImage)
		Common;
		unsigned8 __filepos { virtual (fileposition)};
		end;
		
		export key_did := record
				matrix_images.did;
				matrix_images.state;
				matrix_images.rtype;
				matrix_images.id;
				matrix_images.seq;
				matrix_images.num;
				matrix_images.date;
				matrix_images.imgLength;
	   matrix_images.__filepos;
		end;
	
		export Key_id := record
				matrix_images.state;
				matrix_images.rtype;
				matrix_images.id;
				matrix_images.seq;
				matrix_images.num;
				matrix_images.date;
				matrix_images.imgLength;
	   matrix_images.__filepos;
		end;
		
		
		
	// For DOC IMAGE V2 PROCESSING		
		export matrix_images_reformat := RECORD,maxlength(hygenics_images.MaxLength_FullImage)
			unsigned6 did;
			string2 state;
			string2 rtype;
			string60 id;
			unsigned2 seq;
			string8 date;
			unsigned2 num;
			string image_link;
			unsigned4 imglength;
			JPEG_V2(SELF.imglength) photo;
		END;
		
  export Common_v2 := RECORD, MAXLENGTH(hygenics_images.MaxLength_FullImage)
			unsigned6 did := 0;
			string2 state;
			string2 rtype;
			string60 id;
			unsigned2 seq;
			string8 date;
			unsigned2 num;
			string image_link;
			unsigned4 imgLength;
			string photo;
		end;		
	
		export matrix_images_v2 := RECORD, MAXLENGTH(hygenics_images.MaxLength_FullImage)
				Common_v2;
				unsigned8 __filepos { virtual (fileposition)};
		END;


	export key_did_v2 := record
				matrix_images_v2.did;
				matrix_images_v2.state;
				matrix_images_v2.rtype;
				matrix_images_v2.id;
				matrix_images_v2.seq;
				matrix_images_v2.num;
				matrix_images_v2.date;
				matrix_images_v2.imgLength;
	   matrix_images_v2.__filepos;
		end;
	
		export Key_id_v2 := record
				matrix_images_v2.state;
				matrix_images_v2.rtype;
				matrix_images_v2.id;
				matrix_images_v2.seq;
				matrix_images_v2.num;
				matrix_images_v2.date;
				matrix_images_v2.imgLength;
	   matrix_images_v2.__filepos;
		end;

END;



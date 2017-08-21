import ut, roxiekeybuild,std;

export Proc_Build_IMG_Base(string filedate) := function

/////////////////////////////////////////////////////////
//Sex Offender Image Base File///////////////////////////
/////////////////////////////////////////////////////////

	images__jpeg(integer8 len) := TYPE
	 EXPORT data load(data dd) := dd[1..len];
	 EXPORT integer8 physicallength(data dd) := len;
	 EXPORT data store(data dd) := dd[1..len];
	END;

	soff_layout := RECORD,maxlength(150000)
		unsigned6 did;
		string2 state;
		string2 rtype;
		string60 id;
		unsigned2 seq;
		string8 date;
		unsigned2 num;
		string image_link;
		unsigned4 imglength;
		images__jpeg(SELF.imglength) photo;
	 END;

	//ds_soff := dataset( ut.foreign_prod + 'images::base::matrix_images', soff_layout, flat);
	ds_soff := dataset('~images::base::matrix_images', soff_layout, flat);

	dslayout := RECORD,maxlength(150000)
		unsigned6 did;
		string2 state;
		string2 rtype;
		string60 id;
		unsigned2 seq;
		string8 date;
		unsigned2 num;
		string image_link;
		unsigned4 imglength;
		string photo;
	end;

	dslayout encImg(ds_soff l):= transform
	  self.imglength 	:= length(STD.Str.EncodeBase64(l.photo));
		self.photo 			:= STD.Str.EncodeBase64(l.photo);
		self := l;
	end;

	ds_soff_reform := project(ds_soff, encImg(left));
	
	RoxieKeyBuild.Mac_SF_BuildProcess(ds_soff_reform,'~images_v2::base::Matrix_Images',
                '~images_v2::base::sexoffender::'+filedate+'::matrix_images_base', do_build, 2);

	return do_build;

end;
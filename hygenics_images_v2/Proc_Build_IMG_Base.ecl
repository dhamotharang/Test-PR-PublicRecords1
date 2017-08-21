import ut, roxiekeybuild,std;

export Proc_Build_IMG_Base(string filedate) := function

/////////////////////////////////////////////////////////
//Crim Offender Image Base File//////////////////////////
/////////////////////////////////////////////////////////

	hygenics_images__jpeg(integer8 len) := TYPE
	 EXPORT data load(data dd) := dd[1..len];
	 EXPORT integer8 physicallength(data dd) := len;
	 EXPORT data store(data dd) := dd[1..len];
	END;

	crim_layout := RECORD,maxlength(150000)
		unsigned6 did;
		string2 state;
		string2 rtype;
		string60 id;
		unsigned2 seq;
		string8 date;
		unsigned2 num;
		string image_link;
		unsigned4 imglength;
		hygenics_images__jpeg(SELF.imglength) photo;
	 END;

	ds_crim := dataset('~criminal_images::base::matrix_images', crim_layout, flat);

	dslayout2 := RECORD,maxlength(150000)
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

	dslayout2 encImg2(ds_crim l):= transform
	  self.imglength 	:= length(STD.Str.EncodeBase64(l.photo));
		self.photo 			:= STD.Str.EncodeBase64(l.photo);
		self := l;
	end;

	ds_crim_reform := project(ds_crim, encImg2(left));
	
	RoxieKeyBuild.Mac_SF_BuildProcess(ds_crim_reform,'~criminal_images_v2::base::Matrix_Images',
                '~criminal_images_v2::base::criminal::'+filedate+'::matrix_images_base', do_build, 2);

	return do_build;

end;
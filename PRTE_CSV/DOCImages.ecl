import PRTE_CSV.Constants;

export DOCImages :=
module

	shared	lSubDirName			:=	'';
	shared	lCSVVersion			:=	'20091219';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;	
	
	export integer8 images__maxlength_fullimage := 150000;

	export images__jpeg(integer8 len) := TYPE
		export data load(data dd) := dd[1..len];
		export integer8 physicallength(data dd) := len;
		export data store(data dd) := dd[1..len];
	END;

	export rimages__base__DOC__matrix_images := record
		,maxLength(images__maxlength_fullimage)
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
	end;
	
	export rimages__key__DOC__matrix_images	:=
	record
		string2 state;
		string2 rtype;
		string60 id;
		unsigned2 seq;
		unsigned2 num;
		string8 date;
		unsigned4 imglength;
		unsigned8 __filepos;
	end;

	export rimages__key__DOC__matrix_images_did	:=
	record
		unsigned6 did;
		string2 state;
		string2 rtype;
		string60 id;
		unsigned2 seq;
		unsigned2 num;
		string8 date;
		unsigned4 imglength;
		unsigned8 __filepos;
	end;

	export dimages__base__DOC__matrix_images    := dataset(lCSVFileNamePrefix + 'images__base__doc__' + lCSVVersion + '__matrix_images_base.csv', rimages__base__DOC__matrix_images, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dimages__key__DOC__matrix_images     := dataset(lCSVFileNamePrefix + 'images__key__doc__' + lCSVVersion + '__matrix_images.csv', rimages__key__DOC__matrix_images, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
	export dimages__key__DOC__matrix_images_did := dataset(lCSVFileNamePrefix + 'images__key__doc__' + lCSVVersion + '__matrix_images_did.csv', rimages__key__DOC__matrix_images_did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));

end:DEPRECATED('Use PRET2_DOC_IMAGES MODULE');
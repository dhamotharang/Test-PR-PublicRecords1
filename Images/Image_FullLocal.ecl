import doxie_build, hygenics_images;

string8 imgDate := '' : stored('RecordByDate');
string2 rtype_val := '' : stored('rtype');

unsigned3 imgDateVal := (unsigned3)(imgDate[1..6]);

Layout_FullImageService getdata(File_Images L, Layout_ImageService R) :=
TRANSFORM
	SELF.imgLength := L.imgLength;
	SELF.photo := L.photo;
	SELF := R;
END;

Images.Layout_FullImageService getCrimdata(hygenics_images.File_Images L, Images.Layout_ImageService R) :=
TRANSFORM
	SELF.imgLength := L.imgLength;
	SELF.photo := L.photo;
	SELF := R;
END;

soRecs := Image_Records(rtype='SO');
crimRecs := Image_Records(rtype<>'SO');

so_raw_Images := fetch(File_Images, soRecs, RIGHT.__filepos, getdata(LEFT, RIGHT))
(imgDateVal = 0 OR (unsigned3)(date[1..6]) <= imgDateVal);

crim_raw_Images := fetch(hygenics_images.File_Images, crimRecs, RIGHT.__filepos, getCrimdata(LEFT, RIGHT))
(imgDateVal = 0 OR (unsigned3)(date[1..6]) <= imgDateVal);

soImages := if(exists(soRecs), so_raw_Images);
crimImages := if(exists(crimRecs), crim_raw_Images);

finalImages := soImages + crimImages;

export Image_FullLocal :=
#if(doxie_build.buildstate NOT IN ['FL','PUBLIC'])
dataset([],Layout_FullImageService);
#else
finalImages;
#end
rec  := record
	layout_common;
	unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images_KeyBuilding := dataset('~appriss_images::base::matrix_images_building', rec, flat);
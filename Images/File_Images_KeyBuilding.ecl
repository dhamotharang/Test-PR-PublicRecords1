rec  := record,maxlength(MaxLength_FullImage)
	layout_common;
	unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images_KeyBuilding := dataset('~images::base::Matrix_Images_BUILDING', rec, flat, __OPTION__(LEGACY));
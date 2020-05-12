myrec := record, maxlength(MaxLength_FullImage)
Layout_Common;
unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images := dataset('~images::base::matrix_images_BUILT', myrec, flat, __OPTION__(LEGACY));
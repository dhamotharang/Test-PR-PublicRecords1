import images;

myrec := record, maxlength(MaxLength_FullImage)
Layout_Common;
unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images := dataset('~criminal_images::base::matrix_images_built', myrec, flat, __OPTION__(LEGACY));
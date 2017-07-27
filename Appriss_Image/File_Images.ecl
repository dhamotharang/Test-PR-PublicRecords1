myrec := record
Layout_Common;
unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images := dataset('~Appriss_images::base::matrix_images_BUILT', myrec, flat);
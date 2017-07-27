import images, data_services, ut;

myrec := record, maxlength(MaxLength_FullImage)
Layout_Common;
unsigned8 __filepos { virtual (fileposition)};
end;

export File_Images := dataset(Data_Services.Data_location.Prefix('Images')+'images_v2::base::matrix_images_built', myrec, flat);
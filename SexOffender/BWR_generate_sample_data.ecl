import Images;

// Currently generates approximately 500 records.
main_file     := SexOffender.file_Main;  
offenses_file := SexOffender.File_Offenses;
image_file    := Images.File_Images;

// Create the sample from the main file
mainsample   := sample(main_file,1900,1);  

// Get the list of primary keys and image links
primary_keys := SET(mainsample,seisint_primary_key);
image_links  := SET(mainsample,trim(orig_state_code,left,right)+trim(image_link,left,right));

// Output the data into a new file
output(mainsample
       ,
	   ,'~thor_data400::base::sex_offender_main_Sample'
	   ,overwrite
	   ,csv(SEPARATOR('|'), TERMINATOR('\n')));

inoffensessample := offenses_file.seisint_primary_key IN primary_keys;
offensessample   := offenses_file(inoffensessample);

output(offensessample
       ,
	   ,'~thor_data400::base::sex_offender_Offenses_Sample'
	   ,overwrite
	   ,csv(SEPARATOR('|'), TERMINATOR('\n')));

inimagesample := trim(image_file.image_link,left,right) IN image_links;
imagesample   := image_file(inimagesample);

output(imagesample
       ,
	   ,'~images::base::matrix_images_BUILT_Sample'
	   ,overwrite
	   ,csv(SEPARATOR('|'), TERMINATOR('\n')));

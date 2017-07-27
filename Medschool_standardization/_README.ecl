/*
	Medschool_standardization:
	
		Overview:  Medschool_standardization is module that creates  standaridized file used for medschools.
               Since it is a static file there is no spray involvded.
               There are 2 main static files that are used Medschool_db and Non_Medschool_Db 
               which are located int he update_base attribute. Any new medschool/nonmedschool entries should  be added build_medschools and build_non_medschools_files.    
               Once the enteries are added ,use the buil_all attribute to build the new base files and keys.
               Update_base creates the follwoing 4 base files which are used to create the keys.
               thor_data400::base::mprd::medschools+(version/filedate)
		           thor_data400::base::mprd::medschools_wordlist+(version/filedate)
		           thor_data400::base::mprd::nonmedschools+(version/filedate)
		           thor_data400::base::mprd::nonmedschools_wordlist+(version/filedate)

/*
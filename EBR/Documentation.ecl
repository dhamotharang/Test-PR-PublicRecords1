/*
	Experian Business Reports:
		The current list of file segments and their corresponding descriptions are provided 
		in the Segment_Codes attribute.  
		To spray a segment, use the ebr.MAC_Spray_InputFiles macro, passing it the correct
			parameters.  This will spray the file, and add it to the correct superfiles,
			only if the segment is in the segment_codes table, with it's corresponding 
			record sizes, and the superfiles for it have already been created.
		To run the build which builds the base files, the roxie keys, 
		the as_business_header and runs some stats, execute:
			ebr.BWR_Build_All
		To build just the base files, execute:
			ebr.BWR_Build_Base_Files
		To build just the keys, execute:
			ebr.BWR_Build_Keys
		To create all the superfiles and superkeys used in this process, execute:
			ebr.BWR_Create_All_Superfiles
		If you would like to test out changes to the process without affecting the current
		build/superfiles/etc, you can change the Dataset_Name attribute in your sandbox to your
		test name, and then spray the files, and do the build.  All of the files/keys used in
		build are dependent on that attribute, so they will be named according to your
		Dataset_Name.  Also, you can change the IsTesting attribute to be true, and that will
		change the email notification list so only you get an email.
		
		To add a segment to the process, you will need to create the following attributes:
			BDID_Segment
			file_segment_in
			file_segment_base
			filename_segment_in
			filename_segment_base
			key_segment_bdid
			key_segment_file_number
			keyname_segment_bdid
			keyname_segment_file_number
			layout_segment_in
			layout_segment_base
		And modify the following attributes:
			BWR_Create_All_Superfiles
				add the input file, base file, and keys.
			Proc_Accept_SK_to_Prod
				add the keys you created attributes for
			Proc_Accept_SK_to_QA
				same as above, except for QA
			Proc_Build_Base_Files
				add the BDID_segment attribute here to be built
			Proc_Build_Keys
				add the keys you created attributes here to be built
			Query_BDID_Stats
				Add the segment here to get stats run on it
			Segment_Codes
				Add the segment code, description, and the record sizes for the in file
				and the base file


	Only thing I am not able to make dependent on the segment code, is the persists
	because the process needs to know the name of the persists first.
*/

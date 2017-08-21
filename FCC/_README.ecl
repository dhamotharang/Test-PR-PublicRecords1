/*
	Franchisee - FCC:
	
		Overview: FCC provides information on towers/transmitters, lincensees, and firms. 

		The Build:
			
			Quick Documentation to run the thor build:

				Tapeload02b Dir	: business\fcc_(en)\wa_fcc
				Unix Directory	: edata10:/prod_data_build_13/eval_data/fcc
				Thor Module			: FCC
				Orbit Build			: FCC
				Frequency				: Quarterly
				
				1.	The PEN and WTB files from FCC on tapeload02b are combined on edata10 to create a txt (csv) file in 
            the /prod_data_build_13/eval_data/fcc/data directory named fcc_<date>.txt
				2.	Open FCC.Proc_Build_All('<date>') in a builder window.  Pass the date of the file on edata10.
				3.  Execute it.
				4.	In Orbit, create a build instance of the "FCC" build.  Add the update file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(FCC.Proc_Build_All):
						1. Spray the file & add to sprayed superfile
						2. Build the base file
						3. Build the Roxie keys
						4. Build Strata
						5. Update DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.

    Each build is a full reload.  The build process pulls in the base file only to maintain the sequence_num
    from build to build.

    FCC was updated 12/2015 to removed the ab initio part of the process from the build.  Bug 110156
		
*/
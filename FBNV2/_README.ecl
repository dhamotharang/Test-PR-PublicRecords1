/*

    Current Inputs from Vendors:

			- CA Orange
      - CA San Diego
      - CA Santa Clara
      - CA Ventura
      - FL Events
      - FL Filings
      - TX Harris
      - Experian Base

    Base Inputs

			- BusReg Base
      - FBN Business Base
      - FBN Contact Base

		Inputs no longer received from Vendors:

			- CA San Bernardino
      - InfoUSA
      - NYC
      - TX Dallas

			- CORP2 Cont Base
      - CORP2 Corp Base 
      - CP Hist    
 
	
		Overview: Ficticious Business Names V2

      We receive the following vendors from vendors - 

				Data		       Frequency		Type                                                No Of Records
        ----	         ---------    ----                                                -------------

				CA Orange      Monthy			  Sprayed Variable Txt File Delimited By Quotes       Appx 4000

        CA San Diego   Monthly      Sprayed Variable Txt File Delimited By Commas       Appx 6500
  
        CA Santa Clara Monthly      Sprayed Variable CSV File Delimited By Quotes       Appx 1300

        CA Ventura		 Monthly			Sprayed Variable Txt File Delimited By '~'          Appx 700

        FL Events      Quarterly    Sprayed Fixed Position Txt File 
                                     (These appear to sometimes come in skewed          Appx 1 million
                                     causing bad addressed for AID Cache.)        

        FL Filings     Quarterly    Sprayed Fixed Position Txt File 
                                     (These appear to sometimes come in skewed          Appx 750,000
                                     causing bad addressed for AID Cache.)

        TX Harris      Monthly 			Sprayed Variable Txt File Delimited By '|'          Appx 6000

        Experian       Monthly      Sprayed Fixed Position Txt File                     Appx 24000

        

		The Build:
			
			Quick Documentation to run the thor build:
  
        Run the build whenever data comes in from one of the vendors above.  
        Data comes in on different dates thruout the month/quarter.

				Tapeload Dirs	: business\fbn\ca\orange_(en)
                        business\fbn\ca\san_diego_(en)\<filedate>
                        business\fbn\ca\santa_clara_(en)
                        business\fbn\ca\ventura_(en)\_<filedate>
                        business\fbn\ca\fl_(en)\<filedate>
                        business\fbn\tx_(pn)\harris_county\_<filedate>                        
                        business\fbn\experian_(en)\_<filedate>

				Unix Directories	: /data/data_build_4/fbn/sources/ca/orange/archive
                            /data/data_build_4/fbn/sources/ca/san_diego/<filedate>
                            /data/data_build_4/fbn/sources/ca/santa_clara/archive
                            /data/data_build_4/fbn/sources/ca/ventura/archive/<filedate>
                            /data/data_build_4/fbn/sources/fl/<filedate>
                            /data/data_build_4/fbn/sources/fl/<filedate>
                            /data/data_build_4/fbn/sources/tx/harris/<filedate>
                            /data/data_build_4/fbn/sources/experian/<filedate>

				Thor Module			: FBNV2
				Frequency				: Variable due to when data is received from vendors.
				
				1.	The txt/csv/files on tapeload are to be copied into 
            the data directory under the appropriate fbn unix directory folder. 
				2.	Next, open FBNV2._BWR_Build_All in a builder window.  Change 
            the directory/filename path, filedate, and source to the appropriate values.  
            See examples below.
 
              FBNV2.BWR_Build('/data/data_build_4/fbn/sources/experian/','20161107','Experian',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/san_diego/20180212/RECL.P.OFFS.LEXI4201.VENDOR','20180212','San_Diego',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/santa_clara/archive/20180206_FBN-Listing_20180102-20180131.csv','20180206','Santa_Clara',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/ventura/archive/20180208/Ventura_FBN_R_Jan2018.txt','20180208','Ventura',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/fl/20171018/ficevt.txt','20171018','Event',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/fl/20171018/ficfile.txt','20171018','Filing',sourceip);
							FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/tx/harris/20170302/ASN*.txt','20170302','Harris',sourceip);
 
				3.  Execute it.  The build will spray the input data as well as incorporate the latest 
            base records from BusReg into the base records 
            of the FBN Business and Contact Bases.
				5.	The build will send you an email when it finishes successfully, or a fail email 
            if it fails.
			
				Thor Part(FBNV2._BWR_BuilD):
						1. Validates Source.
            2. Sprays the source to sprayed superfile.
            3. Standardizes the input, clears sources the cleaned superfile, and then adds the 
               standardized clean data to the cleaned superfile.
					  4. Maps the source.
            5. Runs Scrubs on Input Source and Reports Records with questionable fields.  (future)
            6. Maps BusReg, Experian, and CP Hist.
            7. Standardizes Addresses of the source and the Base Files.
						8. Builds Keys
						9. Builds Strata
						10. Runs BIPStats (future)
            11. Create QA Samples
						12. Updates DOPS via email.
						
	Notes:

		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/
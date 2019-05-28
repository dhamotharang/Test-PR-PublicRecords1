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
  
        Run the _BWR_Spray_Input_File whenever data comes in from one of the vendors above.  
        Data comes in on different dates thruout the month/quarter.

        Run the build, _BWR_Build, once a month.

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
				2.	Next open FBNV2._BWR_Spray_Input_File in a builder window.  Change 
            the directory/filename path, filedate, and source to the appropriate values.  
            See examples below.
 
              FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/experian/','20161107','Experian',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/ca/san_diego/20180212/RECL.P.OFFS.LEXI4201.VENDOR','20180212','San_Diego',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/ca/santa_clara/archive/20180206_FBN-Listing_20180102-20180131.csv','20180206','Santa_Clara',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/ca/ventura/archive/20180208/Ventura_FBN_R_Jan2018.txt','20180208','Ventura',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/fl/20171018/ficevt.txt','20171018','Event',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/fl/20171018/ficfile.txt','20171018','Filing',sourceip);
							FBNV2._BWR_Spray_Input_File('/data/data_build_4/fbn/sources/tx/harris/20170302/ASN*.txt','20170302','Harris',sourceip);
 

				3.  Execute it.  It will perform the following steps below - 
						a. Validates the Source.
            b. Sprays the source to sprayed superfile.
            c. Standardizes the input, clears sources the cleaned superfile, and then adds the 
               standardized clean data to the cleaned superfile.
            d. Maps the source.
            e. Runs Scrubs on Input Source and Reports Records with questionable fields.  (future)
        4.  Open FBNV2._BWR_Build in a builder windor.  Change the filedate.
        5.  Execute it.  It performs the following steps below - 
            a. It will incorporate the latest monthly/quarterly vendor data as well as the 
            base records from BusReg and the base records of the FBN Business and Contact Bases.  
			      b. Maps BusReg, Experian, and CP Hist.
            c. Standardizes Addresses of the source and the Base Files.
						d. Builds Keys
						e. Builds Strata
						f. Runs BIPStats (future)
            g. Create QA Samples
						h. Updates DOPS via email.
						
	Notes:

		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
			
*/
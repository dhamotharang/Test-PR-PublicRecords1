"Experian_CRDB" provides the Credit Reporting Data.  

Quick Documentation to run this build on Thor:

Input files are full unload each time and  files are in fixed length format !

I . Record Format		:		fixed file/record length is 4777
			Frequency			:		unload each time.


II.	  EXPERIAN_CRDB  Process

Input file(s) Landing Zone 
On tape load at this location you would find raw vendor files
\\tapeload02b\k\business\tradeline_data\experian\crdb\filedate 

III.
On unix box data resides at below location.
edata12.br.seisint.com/hds_180/experian_CRDB/filedate	


IV	EXPERIAN_CRDB  Build Process

Open this attribute â€œExperian_CRDB._BWR_Build_Allâ€ in a builder window and hit the submit button by passing through two pieces of information: 
1.) Current date.( will be used to populate date first and last seen fields)
2) Raw file folder date.(  will be used to spray raw files from unix box to thor).


V  Output file
a.	After completion of EXPERIAN_CRDB build, it automatically sends email notification to all those people who are listed in this attribute â€œ_control.MyInfo.EmailAddressNotifyâ€.

b.	Example code of BWR code that runs the EXPERIAN_CRDB process 

pversion 	 := '20131115';		// modify to current date
fileDate   	 := '20131017'; 	        //Raw file folder date, this date will be used to spray the raw files on thor
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Modifiy "pversion" & "fileDate" dates accordingly  
// --	2. Make sure the following attribute contains your email address   sandboxed (do not check in!)
// --	_control.MyInfo.EmailAddressNotify
// --	You will receive build emails to this address
// --  3. Check the following attribute to make sure it is correct:
// -- Experian_CRDB._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Experian_CRDB._Dataset().Name + ' Build ' + pversion);
Experian_CRDB.Build_All(fileDate,pversion);
Example work unit --- (W20131115-113544)â€”Data land 


		Notes:
		The thor process uses the following attribute's email addresses to send build info either it fails or completes on thor:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute (_control.MyInfo.EmailAddressNotify)with your email address.  Do not check it in.
    
		This build has only key ( LinkIDs key)and it needs to be deployed to OSS roxie package !

		Rollback:
			If the build is bad, you can rollback the build to the previous one.
			Open 
				Experian_CRDB._BWR_Rollback_Build
			in a builder window.  This provides you with a few options to tailor the rollback 
			to your specific situation.  Such as, if the input files are bad and need to be 
			deleted so they are not used again, set "pDeleteInputFiles" to true.  If the build
			files are bad(the base and key files created by the build), set "pDeleteBuildFiles"
			to true.  Also, set the "pversion" to the version of the build you are rolling back,
			and "pIsTesting" to false to perform the rollback.  
			It will rollback the input files used in the build from the "used" or "using" to the
			"sprayed" superfile (which is where they are at the beginning of the build).  It will
			also rollback the base file and keys from the father to the qa superfiles.  This will 
			ensure that other builds that use these base file(s) will not pull in bad data.  
			Deletion will occur after the rollback.  This should be run on hthor.





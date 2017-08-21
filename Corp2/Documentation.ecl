export Documentation := '';
/*
 To run the full build:

		1.  In dataland, open the following attribute in an editor:
					corp2.Filters
				Make sure that the filters in place are still applicable to this build.  If not, remove them.
				Also, if you need to put any filters into place, put them here.  Most filters will be on the
				existing base files going into the build.  They are in the embedded module 'base'(embedded within corp2.filters).  
				I have removed all of the filters from the last build(as of 20071212), so now there are only standard filters in the 
				filters module which means if you are not adding any new filters to flush anything out, 
				you don't have to change this attribute.  For reference on how to place the filters, you can look
				at any of the numerous filters from the last 6 months in the history of this attribute.
				Basically if I want to filter out something for a particular file, I add it to the lselectfilter.
				Then it gets negated in the full filter.  So, to filter out all PA records 
				and RI records with process_date >= 20071112 from the events base file, I would do the following:

					export Events(dataset(Layout_EventsV2_Base) pInput) :=
					function
						lselectfilter :=		
							///////////////////////////////////////////////////////////////////////////////		
							// -- Bug 23137 -- remove HI temporary records(charter number with a "T" in it)
							///////////////////////////////////////////////////////////////////////////////
							(			pInput.corp_state_origin = 'HI'
							 and (		regexfind('T',pInput.corp_key)
										or	regexfind('T',pInput.corp_sos_charter_nbr)
							))
							
							// -- Above filters added here
							or (								pInput.corp_state_origin	= 'RI'
									and (unsigned4)	pInput.corp_process_date >= 20071112
							)
							or pInput.corp_state_origin  = 'PA'
							// -- end add here
							
							;
						lfullfilter		:= not(lselectfilter);
						lfile					:= pInput(lfullfilter);
						
						return				lfile;
					
					end;

		2.  In dataland, open the following attribute in an editor:
					Corp2.Flags
				Make sure that the flags in place are still applicable to this build.
				These will probably not need to be modified.
				
		3.	Migrate the two attributes you modified to production(only if you modified them):
				Corp2.Filters
				Corp2.Flags
		
		4.	Open the following attribute in a builder window in production:
					Corp2.bwr_BuildAll
				Modify the pversion to today's date, then execute on the 400way.
				
		5.  Once the build is complete, you should receive a roxie email with a list of all the keys.
				When this happens, update the 'Corp2Keys' package on the DOPS page
					http://webdev.br.seisint.com/dops/updateroxie.pl
				with the date of the build.
				
		6.	If, for some reason, the roxie email does not get sent, execute this in a builder window:
					pversion := '20070613'; // this should be the date of the build, same as pversion when you ran the build.
					corp2.Send_Email(pversion).Roxie.QA;
					
				This should send the email to roxiedeployment, and yourself(as long as you have the 
				
					_control.MyInfo.EmailAddressNotify
				
				attribute modified with your email address in your sandbox(don't check in)).
				It checks to see that every key in the package has the same version.  If they do, it will send a standard 
				package email.  If it detects more than one version in the package, it will put alert in the subject line of
				the email and details of the versions in the package.  In that case, the keys will need to be renamed to the 
				same version.  Details on that are in the FAQ below.
				
				
	Other Build Notes:
		In case of an environment failure(or other failure) in the build where you have to resubmit the job,
		you can resubmit the job with no changes, and it will figure out what files/keys are already 
		built, and it will skip those and only do the ones that have not been built yet(assuming the same
		build version).  This means you do not have to comment out any code in your sandbox to prevent it
		from running, it will skip over the code already run.

		The steps of the build:
    1.  Move the sprayed input files from the "sprayed" superfiles to the "using" superfiles. 
		2.  Update all of the base files(in the "QA" superfiles) with the "using" files.
		3.  Move the "using" superfiles to the "used" superfiles.
		4.  Move the New base logical files to the "Built" superfiles
		5.  Build all roxie keys(regular + boolean)
		6.  Move all roxie keys to the "Built" superkeys
		7.  Promote all New Base files and Roxie Keys from the "Built" superfile/key to the "QA" superfile/key
		8.  Run Strata Population Stats
		9.  Send Roxie Email

		FAQ:
				Q:	How do I rollback a successful build?
				A:	Execute the following attribute in a builder window:
							Corp2.bwr_Rollback_Build
						This does three things:
							1.	Rollback the sprayed inputs--Moves them from the "Used" superfiles to the "Sprayed"
									superfiles to prepare them for the next build.
							2.	Rollback the Base files.  This moves the Father Base file to the QA base file.
							3.  Rollback the Roxie keys.  Also moves the Father keys to the QA keys.
				
				Q:	How do rename the base files and the keys?
				A:	Open up this attribute in a builder window
							Corp2.bwr_RenameAll
						Change the date passed to the function to the version you want to change to, and execute it.
						This will only rename the files/keys that have not already been renamed.  So this means if only
						some of the keys/files have been renamed, this will not affect those or fail, it will only 
						modify the ones not already renamed.
				
				Q:	How do I promote a base file(or key) through the versioning system?  Say, if I had to patch
						a base file, promote it to the qa superfiles, then rebuild the roxie keys for it.
				A:	sequential(
							 corp2.Promote(pversion).base.new2built // Move the logical file to the "built" superfile
							,corp2.Promote(pversion).base.built2qa	// Move the "built" superfile to the "qa" superfile
						);
						Then you would build the roxie keys for that base file.

*/
/*
	Build documentation:
		The business header build is a very large build, and takes a long time to run( > 5 days usually).
		Because of it's long run time, it typically fails many times for different reasons.  
		For each build, I create a bug where I document each build workunit, failure, patch, etc.
		Anything related to the build goes into the bug so I can reference it next time to possibly
		prevent the issue.  Example past bugs are 27906, 26771

		vendor_id									= Unique identifier so we can tie this record in business headers
																back to the source record in the source dataset.
		Source group							= link together records that are business associates/relatives.
		vendor linking id(vl_id) 	= The source dataset tells us that records that have this ID 
																value in common are the same business.

		
	Build Steps:
		
			1)	Ensure that the following attribute reflects the current filters that should be applied.  Filters may
					need to be removed or added as needed.
						Business_Header.Filters
			
			2)	Run the following attribute to find out if all of the inputs to the build exist(basically a sanity check to 
					make sure nothing has changed(filenames, etc)).  If this fails, contact Data Development because a file
					has changed and will cause the business header build to fail if not fixed.
						Business_HeaderV2._BWR_List_Build_Inputs	
					The last result in this workunit is the list of inputs for the build.  This will help in populating 
					the Orbit build instance's item list.

			3)	If all datasets have been updated, then the build can be kicked off.  Open the following attribute
					in a builder window.  Note: It takes about 5 minutes to compile.
						Business_Header.BWR_Build_All
					
							Change the pversion local attribute to the current date.
							Execute it.
					If you prefer, open the Business_Header.BWR_Build_All_2 in a builder window and execute it.  This will
					do the same thing as Business_Header.BWR_Build_All, it just puts all of the code in the builder window 
					which makes it easier when you are commenting out code(like during rebuilds) to see in the workunit what
					you changed.
					
			4)	Create a bug for the build with the build workunit inside of it.  Post to this bug the mounts used, 
					the build version, and any workunits used in the build, if workunits fail, the error from the workunit,
					etc.  This is used so that you can track the build and always go back to see what happened in a particular 
					build.
					
			5)	Add build instances to Orbit for the following datasets:

							acainstitutions
							business best
							business headers
							business show sources(which is govdata)
							hri business
							paw
							fcra paw
					
					Be sure to add any bugs fixed in this build to the orbit instances.
					Also, in the build instance notes section, put the build bug for future reference(and so it doesn't get
					confused with the bugs fixed in the build section by QA).
			
	To do when the build completes:
							
			1)	The build automatically updates the roxie page for the following packages:

						acainstitutions
						addresshri
						businessbest		(marketing best)
						businessheader
						govdata
						pawv2
						FCRA_PAWV2Keys
			
			2)	Update the Orbit instances for the following builds to a status of "On Development" for roxie and moxie.

							acainstitutions
							business best
							business headers
							business show sources(which is govdata)
							hri business
							paw
							fcra paw
			
			3)	When the build goes to production, do the following:
					a) Update the above build instances to "Production" status.
					b) In querybuilder, open the following attribute in a builder window:
								Business_Header.BWR_Expose_Slimsorts 
						 Run this on hthor(no need to run on thor) to promote the BDID slimsorts(used in the bdid macros)
						 to the prod superfiles so people can start using them.  It also cleans up the 4th generation
						 files.
			4)	You should be done.
	
	Other Notable Stuff:
		
		How to Rollback a completed build:
			1. Open Business_Header.BWR_Rollback in a builder window.
			2. If the build was put in production and the attribute Business_Header.BWR_Expose_Slimsorts was run, then
					set hasExposeSlimsortsBeenRun to true.  Otherwise, set it to false.
			3. Run it.  This will rollback the files used in the bdid macros(the slimsorts) from father to prod, 
					then from prod to qa.  It will rollback everything else from father to qa since they don't use the prod
					superfiles.
					
		How to rollback a partial build(not completed build):
			1. Since the promotion of all files and keys to the qa supers happens at the end of the build as the last
					step, if the build did not finish, then all of the new files and keys built in the process have not 
					made it to the qa supers(they are in the "built" supers).  So, there is really no rollback needed.
					What you will probably want to do (if some of the files/keys are bad), is what's in the "For Rebuilds"
					section below.
					
		For rebuilds:
			1. If the build failed at a certain point and u want to rerun it from there(without overwriting or
					rebuilding any files that have already been built), then u can just resubmit the job, and it will
					start where it left off, and skip everything it has already built.
			2. If some of the files built in the build are bad and need to be deleted before kicking off the build again,
					then open Business_Header.BWR_Cleanup_Built_Files in a builder window.  Pass in the version of the 
					files that need to be deleted as the first parameter(they will all be the same since they were built
					in the same build).  Then, create a regular expression for the second parameter that will match all 
					of the files that need to be deleted.  Then, set the third parameter to true, for testing.  Run it,
					then check the result dataset in the workunit to make sure the regular expression matched the files/keys
					that you want to delete.  If not, revise the regular expression and rerun it until it does.  Once it does
					match	the files	you want to delete, then change the third parameter to false, run it again, and it will
					delete those files.  Be careful with this.
					
		How to Rename all files/keys or a specific package of keys:
			1. Open Business_Header.BWR_Rename_Roxie_Keys in a builder window.  
					set pversion to the destination version of the files/keys.
					set the PackageName	to the name of the particular package you want to rename.  Use 'all' for
						all packages.
					set IsTesting	to true(the default) the first time you run this.  It will output a dataset of the files/keys
						that will be renamed.  Check the dataset to make sure it represents the keys you want to rename.
						set this to false to actually rename the keys.
					set pJustKeys to true(the default) to rename just keys, no files.  Set this to false to include files
						to rename along with the keys(like base files, etc.  This is not needed for roxie)
			2.  Run this once with IsTesting set to true and verify that the dataset output to the workunit contains
						the keys you want to rename.
					If so, run it again, changing the IsTesting to false, and it will actually rename the keys contained in
						that dataset.

		How to Run Keydiffs:
			1. Open Business_Header.BWR_Run_Keydiffs in a builder window.
					Set pversion_old to the old key version, i.e. 'qa' or '20100420'
					Set pversion_new to the new key version, i.e. 'built' or '20100526'
					Set pIsTesting to false.
			Some notes:
				The key versions you pass to the function can be a super key version such as 'qa','built','father', etc.
					Or they can be a logical key version such as '20100426', '20100630', etc.
				If this is being run outside of a business header build, then the parameters should probably be 'father', 'qa'.
				When it is run inside of the business header build, they should be 'qa','built' because the keys 
				do not get promoted to QA until the end of the build, as the last step.
				When pIsTesting is set to true, the function will not perform the keydiffs, it will just return 
					a dataset result that contains all the information that will be used in running the keydiff, such as:
						old logical version
						new logical version
						old logical keynames
						new logical keynames
						new logical keydiff name
					This is very useful to run first, before running the actual keydiff to check to make sure you are 
					passing in the correct versions, especially when passing in "super" versions.
					

		How to do regression testing after a layout change to a base file(s):
			1. 
*/
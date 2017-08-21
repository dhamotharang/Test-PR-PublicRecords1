/*


	ROXIE KEYS RENAMING DOCUMENTATION

OBJECTIVE: Rename the existing roxiekey names in the current build 

			from - thor_data400::key::keyname + WUID
			to	 - thor_data400::key::<dataset>::<builddate>::<keyname>
			
			ex: oldformat - thor_data400::key::bankrupt_didslim_w20050428-140003
				newformat - thor_data400::key::bankrupt::20050428::didslim

STEPS TO FOLLOW FOR RENAMING ROXIE KEYS

I. The builddate in the above format can be passed either as a parameter to the existing macro,
   attribute or use the version control attribute
   
   ex: '~thor_data400::key::bankrupt::'+filedate+'::bdid' - here filedate is the parameter passed to the
															function or a macro
	   '~thor_data400::key::bankrupt::'+version_development+'::bdid' - here version_development is the 
															version control attribute


II. The ut.MAC_SK_BuildProcess(IF EXISTS) is divided into two macros - replace it with the following macros:

	1. RoxieKeybuild.Mac_SK_BuildProcess_Local - This macro is used for building roxie keys

		Note: An additional parameter should be passed for the renamed macro, which is the logical key name.

		ex: Roxiekeybuild.Mac_SK_BuildProcess_Local(bankrupt.key_bankrupt_bdid,
													'~thor_data400::key::bankrupt::'+filedate+'::bdid',
													'~thor_data400::key::bankrupt_bdid',a,2)
						
			~thor_data400::key::bankrupt::'+filedate+'::bdid - is the additional parameter
			
	2. RoxieKeybuild.Mac_SK_Move_To_Built - This macro doesn't include the key prep parameter and it is
											used to move the subfile from BUILT superfile to QA superfile

		ex: Roxiekeybuild.Mac_SK_BuildProcess_Local('~thor_data400::key::bankrupt::'+filedate+'::bdid',
													'~thor_data400::key::bankrupt_bdid',b,2)

III. The ut.MAC_SK_BuildProcess_v2(IF EXISTS) is divided into two macros - replace it with the following macros

	1. RoxieKeybuild.Mac_SK_BuildProcess_v2_local - This macro is used for building roxie keys

		Note: An additional parameter should be passed for the renamed macro, which is the logical key name.

		ex: Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(bankrupt.key_bankrupt_bdid,
														'~thor_data400::key::bankrupt_bdid',
														'~thor_data400::key::bankrupt::'+filedate+'::bdid',a)
			~thor_data400::key::bankrupt::'+filedate+'::bdid - is the additional parameter
			
	2. Roxiekeybuild.Mac_SK_Move_to_Built_v2 - This macro doesn't include the key prep parameter and it is
											used to move the subfile from BUILT superfile to QA superfile
											
		ex: Roxiekeybuild.Mac_SK_BuildProcess_v2_Local('~thor_data400::key::bankrupt_bdid',
														'~thor_data400::key::bankrupt::'+filedate+'::bdid',a)


IV. Move all the subfiles from Built superfile to QA superfile - No changes in the existing macro

V.  Send an email to roxiedeployment, either by using the Roxiekeybuild.Mac_Daily_Email_Local or using 
	 fileservices.sendemail (sample: doxie_build.Proc_Build_dl_search)





*/
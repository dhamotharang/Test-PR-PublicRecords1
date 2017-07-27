import lib_stringlib, lib_fileservices;

 

fSprayOrig(string pFileNumber, string pState)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/super_credit/vehicles/cleaned/' + trim(pFileNumber,left,right) + '_orig.d00',

                                             2740,

                                             'thor_dell400',

                                             '~thor_data400::in::vehreg_experian_nonupdating_orig_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)) + '_' + lib_stringlib.StringLib.stringtolowercase(trim(pFileNumber)),

                                             ,,,true,true

                                            );

                                             

fSprayName(string pFileNumber, string pState)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/super_credit/vehicles/cleaned/' + trim(pFileNumber,left,right) + '_clean_names.d00',

                                             275,

                                             'thor_dell400',

                                             '~thor_data400::in::vehreg_experian_nonupdating_name_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)) + '_' + lib_stringlib.StringLib.stringtolowercase(trim(pFileNumber)),

                                             ,,,true,true

                                            );

                                             

fSprayAddress(string pFileNumber, string pState)

 := lib_fileservices.FileServices.sprayfixed('10.150.12.240',

                                             '/super_credit/vehicles/cleaned/' + trim(pFileNumber,left,right) + '_clean_addresses.d00',

                                             664,

                                             'thor_dell400',

                                             '~thor_data400::in::vehreg_experian_nonupdating_address_' + lib_stringlib.StringLib.stringtolowercase(trim(pState)) + '_' + lib_stringlib.StringLib.stringtolowercase(trim(pFileNumber)),

                                             ,,,true,true

                                            );

 

fSprayAll(string pFileNumber, string pState)

 := parallel(fSprayOrig(pFileNumber,pState),

              fSprayName(pFileNumber,pState),

              fSprayAddress(pFileNumber,pState)

             );
			 
//fSprayAll('C321R',   'de');
//fSprayAll('C321R2',   'de');
//fSprayAll('C303R',   'al');
//fSprayAll('C304R',   'al');
//fSprayAll('C305R',   'al');-overwrite

//fSprayAll('C563R',   'md');	
//fSprayAll('C564R',   'md');
//fSprayAll('C565R',   'md');






//fSprayAll('C324R',   'or');-could not find

//fSprayAll('C327R',   'or');-could not find
//fSprayAll('C561R',   'or');-could not find
//fSprayAll('C309R',   'sc');
//fSprayAll('C310R',   'sc');

//fSprayAll('C311R2',   'sc');-overwrite




fSprayAll('C535R',   'sc');
fSprayAll('C535R2',   'sc');
fSprayAll('C536R',   'sc');
fSprayAll('C537R',   'sc');

//fSprayAll('C538R',   'sc');

 
/*--finished---
fSprayAll('C300R',   'al');
fSprayAll('C301R',   'al');
fSprayAll('C302R',   'al');

*/


/* not present
fSprayAll('C516R',   'al');
fSprayAll('C517R',   'al');
fSprayAll('C518R',   'al');
fSprayAll('C519R',   'al');
fSprayAll('C520R',   'al');
D856	AL
D857	AL
*/


//export spray := 'todo';
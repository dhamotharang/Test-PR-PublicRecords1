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
//fSprayAll('C592R',   'ct');
fSprayAll('C302R',   'al')


//fSprayAll('C321R',   'de');-finished
//fSprayAll('C321R2',   'de');-finihsed


//fSprayAll('C305R',   'al');-finished
//fSprayAll('C311R2',   'sc');-finished








//fSprayAll('C324R2',   'or');-finished

/*--finished--
fSprayAll('C309R',   'sc');
fSprayAll('C309R2',   'sc');
fSprayAll('C310R',   'sc');
fSprayAll('C310R2',   'sc');
*/



/*-finished

fSprayAll('C535R',   'sc');
fSprayAll('C535R2',   'sc');
fSprayAll('C536R',   'sc');
fSprayAll('C537R',   'sc');
*/


 
/*--finished---
fSprayAll('C300R',   'al');
fSprayAll('C301R',   'al');
fSprayAll('C302R',   'al');

*/






import versioncontrol, _control, ut, tools, Healthcare_Cleaners;
export Build_all(string pversion, boolean pUseProd = false) := function

                
  MedschoolWordList := output(Healthcare_Cleaners.medschool_db.wordlist);
  NonMedschoolWordList := output(Healthcare_Cleaners.NonMedschool_db.wordlist);

                built :=    sequential(                                                                              
                                        fileservices.clearsuperfile('~thor_data400::base::mprd::medschool_wordlist '),
            														fileservices.clearsuperfile('~thor_data400::base::mprd::non_medschool_wordlist'),
																			  fileservices.clearsuperfile('~thor_data400::base::mprd::medschool'),
																			  fileservices.clearsuperfile('~thor_data400::base::mprd::non_medschool'),  
                                        fileservices.clearsuperfile('~thor_data400::key::mprd::medschool::built::msid');																			  
																				fileservices.clearsuperfile('~thor_data400::key::mprd::medschool_wordlist::built::words'); 
																				fileservices.clearsuperfile('~thor_data400::key::mprd::medschool_wordlist::qa::words'),
																			  fileservices.clearsuperfile('~thor_data400::key::mprd::medschool::qa::msid'),
																				fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool::built::msid');
																				fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool_wordlist::built::words'); 
																			  fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool_wordlist::qa::words'),
																			  fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool::qa::msid'),
																			  fileservices.clearsuperfile('~thor_data400::key::mprd::medschool_wordlist::qa::words'),
    											              MedschoolWordList,
                                        NonMedschoolwordlist,
																				FileServices.AddSuperFile('~thor_data400::base::mprd::medschool','~thor_data400::base::mprd::medschools'),
                                        FileServices.AddSuperFile('~thor_data400::base::mprd::non_medschool','~thor_data400::base::mprd::nonmedschools'),
                                        FileServices.AddSuperFile('~thor_data400::base::mprd::medschool_wordlist','~thor_data400::base::mprd::medschools_wordlist'),
                                        FileServices.AddSuperFile('~thor_data400::base::mprd::non_medschool_wordlist','~thor_data400::base::mprd::nonmedschools_wordlist'),
													              parallel
                                              (                                                                                                                 
                                                Healthcare_Cleaners.Build_Medschool_keys.Build_Keys_medschool(pversion,pUseProd).medschool_all,
                                                Healthcare_Cleaners.Build_Medschool_keys.build_keys_medschool_wordlist(pversion,pUseProd).medschool_wordlist_all,
                                                Healthcare_Cleaners.Build_Medschool_keys.build_keys_non_medschool_wordlist(pversion,pUseProd).non_medschool_wordlist_all,
                                                Healthcare_Cleaners.Build_Medschool_keys.Build_Keys_non_medschool(pversion,pUseProd).non_medschool_all
                                              );
                                       parallel
                                              (
                                                Healthcare_Cleaners.Promote.Promote_medschool(pversion,pUseProd).buildfiles.Built2QA,
                                                Healthcare_Cleaners.Promote.Promote_medschool_wordlist(pversion,pUseProd).buildfiles.Built2QA,
                                                Healthcare_Cleaners.Promote.Promote_non_medschool(pversion,pUseProd).buildfiles.Built2QA,
                                                Healthcare_Cleaners.Promote.Promote_non_medschool_wordlist(pversion,pUseProd).buildfiles.Built2QA,
                                               );
																			parallel(                                                                                                                                                                 FileServices.StartSuperFileTransaction(),
                                                // fileservices.clearsuperfile('~thor_data400::base::mprd::medschool_wordlist ');
                                                // fileservices.clearsuperfile('~thor_data400::base::mprd::non_medschool_wordlist ');                         													  
																								// fileservices.clearsuperfile('~thor_data400::base::mprd::medschool');
																								// fileservices.clearsuperfile('~thor_data400::base::mprd::non_medschool');                                                                                                                                                                                      fileservices.clearsuperfile('~thor_data400::key::mprd::medschool_wordlist::qa::words');
																								// fileservices.clearsuperfile('~thor_data400::key::mprd::medschool::qa::msid');
																								// fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool_wordlist::qa::words');
																								// fileservices.clearsuperfile('~thor_data400::key::mprd::non_medschool::qa::msid');                                                                              FileServices.AddSuperFile(Healthcare_Cleaners.Medschool_filenames(pversion,pUseProd).non_medschool_wordlist_lBaseTemplate1,                                                                                                  Healthcare_Cleaners.Medschool_filenames(pversion,pUseProd).non_medschool_wordlist_lBaseTemplate,,true),
																								FileServices.AddSuperFile('~thor_data400::key::mprd::medschool_wordlist::qa::words','~thor_data400::key::mprd::medschool_wordlist::20161901::words');
																								FileServices.AddSuperFile('~thor_data400::key::mprd::medschool::qa::msid','~thor_data400::key::mprd::medschool::20161901::msid');
																								FileServices.AddSuperFile('~thor_data400::key::mprd::non_medschool_wordlist::qa::words','~thor_data400::key::mprd::non_medschool_wordlist::20161901::words');
																								FileServices.AddSuperFile('~thor_data400::key::mprd::non_medschool::qa::msid','~thor_data400::key::mprd::non_medschool::20161901::msid');                                      
                                             );              
                                  ): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure);
   
   return built;
                
end;


import    Medschool_standardization;
export Build_all(string pversion, boolean pUseProd = false) := function

                
  
                built :=    sequential(  
								                         Medschool_standardization.Build_Base.build_base_medschool_db(pversion,pUseProd).medschoool_db_all ,
																				 Medschool_standardization.Build_Base.build_base_non_medschool_db (pversion,pUseProd).non_medschoool_db_all ,
                            parallel  (                                                                                                                 
                                         Medschool_standardization.build_keys.Build_Keys_medschool(pversion,pUseProd).medschool_all,
                                         Medschool_standardization.build_keys.build_keys_medschool_wordlist(pversion,pUseProd).medschool_wordlist_all,
                                         Medschool_standardization.build_keys.Build_Keys_non_medschool(pversion,pUseProd).non_medschool_all,                                                  
																				 Medschool_standardization.build_keys.build_keys_non_medschool_wordlist(pversion,pUseProd).non_medschool_wordlist_all                                                 
                                      );
                            parallel  (
                                         Medschool_standardization.promote.Promote_medschool(pversion,pUseProd).buildfiles.Built2QA,
                                         Medschool_standardization.promote.Promote_medschool_wordlist(pversion,pUseProd).buildfiles.Built2QA,
                                         Medschool_standardization.promote.Promote_non_medschool(pversion,pUseProd).buildfiles.Built2QA,
                                         Medschool_standardization.promote.Promote_non_medschool_wordlist(pversion,pUseProd).buildfiles.Built2QA
                                      );
																			): success(Medschool_standardization.Send_Email(pversion,pUseProd).BuildSuccess), failure(Medschool_standardization.send_email(pversion,pUseProd).BuildFailure);
   
   return built;
                
end;

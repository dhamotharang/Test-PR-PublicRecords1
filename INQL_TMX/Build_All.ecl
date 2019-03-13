import versioncontrol, _control, ut, tools;

export Build_all(string pversion, boolean pUseProd=false, boolean pIsFull = false) := 
function

    spray_ := VersionControl.fSprayInputFiles(fSpray(pversion, pUseProd));

    built := 
        sequential
        (
            // spray_
            Build_Base(pversion, pUseProd, pIsFull).all,
            Build_Keys(pversion, pUseProd, pIsFull).all,
            // Build_Strata(pversion, pUseProd).all,
            
            
            // Archive processed files in history		
            // KJE - What to do? Are these artifacts of old implementations?
            //       Should we just delete these lines and move on?
            
            // FileServices.StartSuperFileTransaction(),
            // FileServices.AddSuperFile(Filenames(pversion, pUseProd).lInputHistTemplate,  
            //                           Filenames(pversion, pUseProd).lInputTemplate,,true),
            // FileServices.ClearSuperFile(Filenames(pversion, pUseProd).lInputTemplate),
            // FileServices.FinishSuperFileTransaction()
            
        ): 
        success(Send_Email(pversion, pUseProd, pIsFull).BuildSuccess), 
        failure(send_email(pversion, pUseProd).BuildFailure);

    return built;

end;
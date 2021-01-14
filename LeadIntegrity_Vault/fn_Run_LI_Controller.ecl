EXPORT fn_Run_LI_Controller(build_period,LIProcToRun = 1) := FUNCTIONMACRO

    Import LeadIntegrity_Vault, Std;

    local LIApd01 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '01');
    local LIApd02 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '02');
    local LIApd03 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '03');
    local LIApd04 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '04');
    local LIApd05 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '05');


    local failuresubject   := 'The LeadIntegrity Build Failed for the Build Period: ' + (string) build_period;

    local failurebody      := 'The LeadIntegrity Build Failed for the Build Period: ' + (string) build_period + '\n' +
                                                          'The Workunit is '+WORKUNIT + '\n' +
                                                          'ErrorMessage is '+FAILMESSAGE + '\n\n';

    local ValDatefailurebody := 'The LeadIntegrity Build did NOT kick off because invalid build date: ' + (string) build_period + '\n' +
                                                                  'The Workunit is '+WORKUNIT + '\n';

    local ValCntfailurebody := 'The LeadIntegrity Build did NOT kick off because of missing Input files exspecting 5 files: ' + (string) build_period + '\n' +
                                                                 'The Workunit is '+WORKUNIT + '\n';


    local   FILE_MASK := LeadIntegrity_Vault.Constants.MMPrefixNM + (string) TRIM(build_period) + '_*_of_05';
    local   ds_files := nothor(STD.File.LogicalFileList(FILE_MASK, true, false, true));
    local   inputFileCount := COUNT(ds_files) :Independent;

    output(build_period,named('Build_Period'));
    output(inputFileCount,named('InputfileCount'));

#IF (LIProcToRun = 1)
         local RunLI := SEQUENTIAL(LIApd01,LIApd02,LIApd03,LIApd04,LIApd05);
#ELSEIF (LIProcToRun = 2)
         local RunLI := SEQUENTIAL(LIApd02,LIApd03,LIApd04,LIApd05);
#ELSEIF (LIProcToRun = 3)
         local RunLI := SEQUENTIAL(LIApd03,LIApd04,LIApd05);
#ELSEIF (LIProcToRun = 4)
         local RunLI := SEQUENTIAL(LIApd04,LIApd05);
#ELSEIF (LIProcToRun = 5)
         local RunLI := SEQUENTIAL(LIApd05);
#ELSE
         local RunLI := output(ERROR('fn_Run_LI_Controller - Invalid Parm for LIProcToRun'));
#END

Final := map(TRIM(build_period)='' => Fileservices.Sendemail(LeadIntegrity_Vault.Constants.TeamEmailList, failuresubject, ValDatefailurebody)
                    ,inputFileCount < 5 => Fileservices.Sendemail(LeadIntegrity_Vault.Constants.TeamEmailList, failuresubject, ValCntfailurebody)
                                      ,RunLI);



Return Final;

ENDMACRO;

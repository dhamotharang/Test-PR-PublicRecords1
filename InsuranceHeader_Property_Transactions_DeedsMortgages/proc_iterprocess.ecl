EXPORT proc_iterprocess(string pversion, string iter) := FUNCTION

doiter    := proc_iterate(pversion,iter).doallagain;

createSF := sequential(if( not NOTHOR(fileservices.superfileexists(files(pversion).salt_output_filename_qa)),
														   NOTHOR(sequential(fileservices.createsuperfile(files(pversion).salt_output_filename_qa),
														          fileservices.createsuperfile(files(pversion).salt_output_filename_father)))));
updateSF := sequential(createSF,
                        FileServices.PromoteSuperFileList([files(pversion).salt_output_filename_qa,files(pversion).salt_output_filename_father], proc_iterate(pversion,iter).OutputFileName));

RETURN sequential(doiter,updateSF);
END;
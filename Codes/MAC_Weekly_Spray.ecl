import RoxieKeyBuild, PRTE,Scrubs_Codes;
export MAC_Weekly_Spray(sourceIP,sourceFile,filedate) := macro   //Removed the recordsize=`436` from export
#workunit('name','CodesV3 spray')
#uniquename(spray_file)
#uniquename(clear_super_csv)
#uniquename(add_super_csv)
#uniquename(clear_super)
#uniquename(add_super)
#uniquename(preprocess)
#uniquename(check_codes)
#uniquename(build_keys)
#uniquename(e_mail_success)
#uniquename(e_mail_fail)
#uniquename(updatedops)
#uniquename(alphacopy)
#uniquename(string_rec)
#uniquename(build_keys_PRTE)
#uniquename(updateidops)
#uniquename(update_orbiti)

%spray_file% := fileservices.sprayvariable(sourceIP,sourcefile,,'\t',,'','thor400_44','~thor_data400::in::codes_v3::csv_'+filedate,-1,,,true,true); //added ::csv to in file

%clear_super_csv% := fileservices.clearsuperfile('~thor_data400::base::codes_v3_csv');
%add_super_csv% := fileservices.addsuperfile('~thor_data400::base::codes_v3_csv','~thor_data400::in::codes_v3::csv_'+filedate); //added ::csv to in file

%preprocess% := codes.Proc_Preprocess(filedate);

%clear_super% := fileservices.clearsuperfile('~thor_data400::base::codes_v3');
%add_super% := fileservices.addsuperfile('~thor_data400::base::codes_v3','~thor_data400::in::codes_v3_'+filedate); 

%check_codes% := IF(EXISTS(codes.Check_Codes),
lib_fileservices.fileservices.sendemail('john.freibaum@lexisnexis.com','Check codes v3 updates', thorlib.WUID()),

output('ECL codes match')); 

%build_keys% := Codes.Proc_build_keys(filedate);
%build_keys_PRTE% := PRTE.Proc_Build_CodesV3_Keys(filedate);
%updatedops% := RoxieKeyBuild.updateversion('CodesV3Keys',filedate,'john.freibaum@lexisnexis.com',,'N|F|B');
%updateidops% 		:= RoxieKeyBuild.updateversion('CodesV3Keys',filedate,'jfreibaum@seisint.com',,'N|T|F',,,'A');  
%update_orbiti% 	:= Codes.Proc_Orbiti_CreateBuild(filedate);


%e_mail_success% := fileservices.sendemail(
                                  'john.freibaum@lexisnexis.com',
                                  'Codes_V3 Roxie Build Succeeded ' + filedate,'keys: 1) thor_data400::key::codes_v3_qa(thor_data400::key::codes::'+filedate+'::codes_v3),\n' + 
                                  ' have been built and ready to be deployed to QA.');
                                                                                                                
%e_mail_fail% := fileservices.sendemail(
                                  'john.freibaum@lexisnexis.com',
                                  'Codes_V3 Roxie Build FAILED', failmessage);

                // To kick off the script in 10.194.72.226 (Ananth)
                %string_rec%    :=
                record
                                string10                processdate;
                end;

// %alphacopy%    :=            sequential(Codes.Proc_Copy_Keys_To_Alpha(filedate),
                                        // output(dataset([{filedate}],%string_rec%),,'~thor_data400::out::codesv3_version',overwrite,csv),
                                        // fileservices.Despray('~thor_data400::out::codesv3_version','10.194.64.250',
																				// '/data/orbitprod/codesv3/process/codesv3flag.txt',,,,TRUE));
  
sequential(%spray_file%,%clear_super_csv%,%add_super_csv%,
output(%preprocess%,,'~thor_data400::in::codes_v3_'+filedate,overwrite), %clear_super%,%add_super%, 
%build_keys%, %build_keys_PRTE%, %updatedops%, /*%alphacopy%,*/%updateidops%, Scrubs_Codes.fn_RunScrubs(filedate,'john.freibaum@lexisnexis.com'),%update_orbiti%) : success(%e_mail_success%), failure(%e_mail_fail%);
endmacro;


  



  

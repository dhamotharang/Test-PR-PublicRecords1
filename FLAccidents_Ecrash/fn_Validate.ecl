import lib_WORKUNITSERVICES;
export fn_Validate := function
supbase := dataset('~thor_data400::base::ecrash_supplemental',FLAccidents_Ecrash.Layouts.ReportVersion,flat);
ebase := dataset('~thor_data400::base::ecrash',FLAccidents_Ecrash.Layout_Basefile,thor);

//father base files
supbase_father := dataset('~thor_data400::base::ecrash_supplemental_father',FLAccidents_Ecrash.Layouts.ReportVersion,flat);
ebase_father := dataset('~thor_data400::base::ecrash_father',FLAccidents_Ecrash.Layout_Basefile,thor);


ecr_threshold := 1000000;
supp_threshold := 500000;

boolean ecrash_check := count(ebase) - count(ebase_father) between 1000 AND  ecr_threshold;
boolean supp_check := count(supbase) - count(supbase_father) between 50 AND supp_threshold;

ds := nothor(lib_WORKUNITSERVICES.WorkunitServices.WorkunitMessages(workunit));


sndchk := if ( count(ds ( message = 'Definition is sandboxed' and regexfind('FLAccidents_Ecrash',location) = true)) > 0 ,FAIL('ECrash code has been sandbox'),  Output('ECrash code has not been commented'))  ;          

countchk := if ( ecrash_check and supp_check  ,Output('ECrash Base Build looks good'),Sequential( FAIL('ECRASH KEY BUILD SHOULD BE ON HOLD'),
 FileServices.SendEmail( 'sudhir.kasavajjala@lexisnexis.com',
													'ECRASH KEY BUILD IS ON HOLD',
													'eCrash Key build is on hold as base files were not updated')
		));


return Sequential( sndchk , countchk );
		
end;
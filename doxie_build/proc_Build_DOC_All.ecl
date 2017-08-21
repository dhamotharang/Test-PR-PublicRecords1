import doxie_build,orbit_report;
export proc_Build_DOC_All (string filedate) := 
function




e_mail_success := fileservices.sendemail(
													'roxiebuilds@seisint.com;vniemela@seisint.com;tkirk@seisint.com;CPettola@seisint.com',
													'CRIM Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_Data400::key::corrections_offenders_' + doxie_build.buildstate + '_qa(thor_Data400::key::corrections_offenders::'+filedate+'::' + doxie_build.buildstate+'),\n' +
'      2) thor_Data400::key::corrections_offenders_docnum_' + doxie_build.buildstate+ '_qa(thor_Data400::key::corrections_offenders::'+filedate+'::docnum_' + doxie_build.buildstate+'),\n' +
'      3) thor_Data400::key::corrections_offenders_OffenderKey_' + doxie_build.buildstate + '_qa(thor_Data400::key::corrections_offenders::'+filedate+'::OffenderKey_' + doxie_build.buildstate+'),\n' +
'      4) thor_data400::key::corrections_'+doxie_build.buildstate+'Address_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::address),\n' +
'      5) thor_data400::key::corrections_'+doxie_build.buildstate+'CityStName_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::citystname),\n' +
'      6) thor_data400::key::corrections_'+doxie_build.buildstate+'Name_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::name),\n' +
'      7) thor_data400::key::corrections_'+doxie_build.buildstate+'Phone_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::phone),\n' +
'      8) thor_data400::key::corrections_'+doxie_build.buildstate+'SSN_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::ssn),\n' +
'      9) thor_data400::key::corrections_'+doxie_build.buildstate+'StName_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::stname),\n' +
'     10) thor_data400::key::corrections_'+doxie_build.buildstate+'Zip_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::zip),\n' +
'     11) thor_data400::key::corrections_fdid_'+ doxie_build.buildstate + '_qa(thor_data400::key::corrections_'+doxie_build.buildstate+'::'+filedate+'::fdid_'+ doxie_build.buildstate+'),\n' +					
'     12) thor_Data400::key::corrections_offenses_' + doxie_build.buildstate + '_qa(thor_Data400::key::corrections_offenses::'+filedate+'::' + doxie_build.buildstate+'),\n' +
'     13) thor_data400::key::corrections_activity_' + doxie_build.buildstate + '_qa(thor_data400::key::corrections_activity::'+filedate+'::' + doxie_build.buildstate+'),\n' +
'     14) thor_data400::key::corrections_court_offenses_' + doxie_build.buildstate + '_qa(thor_data400::key::corrections_court_offenses::'+filedate+'::' + doxie_build.buildstate+'),\n' +
'     15) thor_data400::key::corrections_punishment_' + doxie_build.buildstate + '_qa(thor_data400::key::corrections_punishment::'+filedate+'::' + doxie_build.buildstate+'),\n' +
	             '      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													//'mluber@seisint.com;tkirk@seisint.com;vniemela@seisint.com;CPettola@seisint.com;avenkatachalam@seisint.com',
													'cpettola@seisint.com',
													'CRIM Roxie Build FAILED',
													failmessage);

orbit_report.Crim_Stats(orbitreport);

retval := sequential(proc_build_DOC_bases,proc_build_DOC_keys(filedate),proc_AcceptSK_DOC_To_QA,orbitreport) :
			success(e_mail_success),
			failure(e_mail_fail);
return retval;

end;
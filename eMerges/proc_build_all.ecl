#workunit ('name', 'Emerges Hunt_Fish build ');
import orbit_report;

export proc_build_all(string version_date) := function
  a := emerges.proc_build_base(version_date) : success(output('base files built successfully')), failure(output('build of base files failed'));
  b := emerges.proc_build_key(version_date) : success(output('roxie key build completed')), failure(output('roxie key build failed'));

   	
  //send email to qa with sample records.
  e_mail_qa   := fileservices.sendemail(Email_Notification_Lists.QaSample,
                    'eMerges Sample Records Completed- '+ version_date,	'workunit: ' + workunit);
                    
  sample_records_for_qa	:= emerges.SampleRecs(version_date) : success(e_mail_qa);
	
  send_email := fileservices.sendemail('kgummadi@seisint.com;dknowles@seisint.com','EMERGES BUILD '+version_date+' COMPLETED','EMERGES BASE FILES AND KEYS BUILT SUCCESSFULLY. YOU CAN PROCEED WITH THE DKC PROCESS');
  
	// Generate a csv file for concealed weapon USLM report.
	orbit_report.conwep_stats(getretval);
	
	// Generate a csv file for PRMA report in dayton.
  orbit_report.huntfish_stats(getretval1);

	
	build_all := sequential(a,b,sample_records_for_qa,send_email,getretval,getretval1);
	
	
  return build_all;
end;
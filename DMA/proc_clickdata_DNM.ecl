#workunit('name','DNM Clickdata')

import ut,_control;
export proc_clickdata_DNM(string version_date) := function;
	add_clickID_rec := record
		string60	click_hhid;
		string60	click_id;
		string2		crlf := '\r\n';
	end;
	
	add_clickID_rec populate_clickID(dma.file_suppressionMPS l) := transform
	 self.click_hhid	:= ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.addr_suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,'','','','');
	 self.click_id		:= ut.fn_create_click_id(trim(l.prim_range,left,right)+' '+trim(l.predir,left,right)+' '+trim(l.prim_name,left,right)+' '+trim(l.addr_suffix,left,right)+' '+trim(l.postdir,left,right)+' '+trim(l.unit_desig,left,right)+' '+trim(l.sec_range,left,right),l.zip,trim(l.lname,left,right),'','','');
	 self := l;
	end;
		
	dnm_clickID := project(dma.file_suppressionMPS,
												 populate_clickID(left)
												);

	dnm_clickID_out := output(dnm_clickID,,'~thor_data400::dnm::clickid',__compressed__,overwrite);
	
	destination_ip := _control.IPAddress.edata10;
	despray_dnm_clickID := fileservices.despray('~thor_data400::dnm::clickid',destination_ip,'/ucc_new_build2/dnm_click_data/dnm_clickdata_'+version_date+'.d00',,,,TRUE);
	
	send_succ_mail := fileservices.sendEmail('christopher.brodeur@lexisnexis.com,CDSDataOps@seisint.com,adeshpande@seisint.com,jtrost@seisint.com,mustafa.lakdawala@lexisnexis.com,DataReceiving@lexisnexis.com,randy.reyes@lexisnexis.com','New Do Not Mail Click Data file','New Do Not Mail clickdata file available on edata10 at /ucc_new_build2/dnm_click_data/dnm_clickdata_'+version_date+'.d00');
	send_fail_mail := fileservices.sendEmail('cbrodeur@seisint.com,randy.reyes@lexisnexis.com','Do Not Mail Click Data file failure','New Do Not Mail clickdata file vs'+version_date+' process failed due to the following reason below\n'+failmessage);
	
	bld_clickdata_file := sequential(dnm_clickID_out,despray_dnm_clickID) : success(send_succ_mail), failure(send_fail_mail);
	return bld_clickdata_file;
end;
import ut, _validate;

export Cleaned_DL_TN_Withdrawals(string filedate) := function
  
  wdl_file             := driversv2.file_dl_tn_wdl_raw(filedate);
	layout_all_cln       := driversv2.layouts_dl_tn_in.layout_tn_wdl_all_cleaned;
	
  layout_all_cln mapcleanwdl(wdl_file l) := transform,skip(l.dl_number = '')
  
    self.process_date  := if(_validate.date.fisvalid(l.process_date),l.process_date,'');
	  self.dl_number     := ut.cleanspacesandupper(l.dl_number);
		self.action_code 	 := ut.cleanspacesandupper(l.action_code);	
		self.event_date    := if(_validate.date.fisvalid(l.event_date) and
	                           _validate.date.fisvalid(l.event_date,_validate.date.rules.dateinpast),l.event_date,'');
		self.last_name     := ut.cleanspacesandupper(l.last_name);
		self.birthdate     := if(_validate.date.fisvalid(l.birthdate) and
	                           _validate.date.fisvalid(l.birthdate,_validate.date.rules.dateinpast),l.birthdate,'');
	  self.post_date     := if(_validate.date.fisvalid(l.post_date) and
	                           _validate.date.fisvalid(l.post_date,_validate.date.rules.dateinpast),l.post_date,'');
		self.county_code   := ut.cleanspacesandupper(l.county_code);
		self.action_type 	 := ut.cleanspacesandupper(l.action_type);	
		
  end;

	cleaned_tn_wdl 			 := project(wdl_file, mapcleanwdl(left));			
	cleaned_tn_dl_wdl_all:= sequential(output(cleaned_tn_wdl,,driversv2.constants.cluster+'in::dl2::tn_wdl_cp_clean_update::'+ filedate,overwrite),
																		 fileservices.startsuperfiletransaction(),
																		 fileservices.addsuperfile(driversv2.constants.cluster + 'in::dl2::tn_wdl_cp_clean_updates::superfile', 
																		 driversv2.constants.cluster +'in::dl2::tn_wdl_cp_clean_update::'+filedate), 
																		 fileservices.finishsuperfiletransaction()
																		 );
                  
	return cleaned_tn_dl_wdl_all;
	
end;
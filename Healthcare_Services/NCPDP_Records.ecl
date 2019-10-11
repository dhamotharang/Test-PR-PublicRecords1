import iesp,Healthcare_Header_Services,suppress,Healthcare_Header_Services;
export NCPDP_Records() := module

	Export getRecords(dataset(NCPDP_Layouts.autokeyInput) inputData,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		//Do Search Keys to get data keys
		
   
		outRecs := NCPDP_SearchKeys.getRecords(inputData);
		//Do Penalty logic
		mod_access:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);
		ncpdpsuppressmac:=Suppress.MAC_FlagSuppressedSource(outRecs,mod_access); 
			
		setOptOutncpdp := project(ncpdpsuppressmac, 
		                                  transform(Healthcare_Services.NCPDP_Layouts.LayoutOutput,
		                                   SELF.HASOPTOUT:=LEFT.is_suppressed ;
                                       self.fname:=if(left.is_suppressed=false,left.fname,'');
																			 self.mname:=if(left.is_suppressed=false,left.mname,'');
																			 self.lname:=if(left.is_suppressed=false,left.lname,'');
																			 self.contact_last_name:=if(left.is_suppressed=false,left.contact_last_name,'');
                                       self.contact_first_name :=if(left.is_suppressed=false,left.contact_first_name,'');                        
																			self.contact_middle_initial:=if(left.is_suppressed=false,left.contact_middle_initial,'');                    
																			 self.contact_title:=if(left.is_suppressed=false,left.contact_title,'');                             
																			self.contact_phone:=if(left.is_suppressed=false,left.contact_phone,'');                             
																			 self.contact_phone_ext:=if(left.is_suppressed=false,left.contact_phone_ext,'');                         
																			self.contact_email:=if(left.is_suppressed=false,left.contact_email,'');           
																			self:=left;self:=[];));              			
		
		outRecsPenalty := NCPDP_Functions.doPenalty(setOptOutncpdp, inputData);
		
		return outRecsPenalty;
	end;
	Export getRecordsBatch(dataset(NCPDP_Layouts.autokeyInput) inputData,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		rawRecs := getRecords(inputData,cfg);
		return rawRecs;
	end;

end;

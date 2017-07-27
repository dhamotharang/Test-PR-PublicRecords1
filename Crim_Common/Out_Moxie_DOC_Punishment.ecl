// When called will create the Moxie Punishment file, dated per Version_Development

//Reformat to New DOC Punishment Layout 
Layout_Moxie_DOC_Punishment.new tDOCPunishmentInToOut(File_In_DOC_Punishment pInput)
 :=
  transform
	self.sent_date:='';
	self.release_type:='';	
	self.office_region:='';	
	self.par_status_dt:='';
	self.supv_office:='';	
	self.supv_officer:='';	
	self.office_phone:='';
	self.TDCJID_unit_type:='';
	self.TDCJID_unit_assigned:='';
	self.TDCJID_admit_date:='';
	self.prison_status:='';
	self.recv_dept_code:='';
	self.recv_dept_date:='';
	self.parole_active_flag:='';
	self.casepull_date:='';
	self := pInput;
  end
 ;

dDOCPunishmentOut := project(File_In_DOC_Punishment,tDOCPunishmentInToOut(left));

dTXDOCPunishment := File_In_DOC_Punishment_TX_OAG;

dDOCConcat 	:= dDOCPunishmentOut + dTXDOCPunishment;

//Reformat to Old DOC Punishment Layout 
Layout_Moxie_DOC_Punishment.previous tDOCPunishmentOldLayout(dDOCConcat pInput)
 :=
  transform
	self := pInput;
  end
 ;

dDOCPunishmentOldLayout := project(dDOCConcat,tDOCPunishmentOldLayout(left));

//Output Old/New Punishment Formats
export Out_Moxie_DOC_Punishment
 := sequential(output(dDOCPunishmentOldLayout,,Crim_Common.Name_Moxie_DOC_Punishment_Dev,overwrite); //old layout
			   output(dDOCConcat,,Crim_Common.Name_Moxie_DOC_Punishment_Dev + '_new',overwrite)); //new layout
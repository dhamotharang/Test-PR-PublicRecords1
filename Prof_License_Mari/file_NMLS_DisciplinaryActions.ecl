IMPORT ut,lib_fileservices,_Control,lib_stringlib,AID,address,idl_header,Prof_License_Mari;

EXPORT  file_NMLS_DisciplinaryActions(DATASET(recordof( Prof_License_Mari.layouts_NMLS0900.Individual_Disciplinary_Action)) pDisciplinary, 
																												string process_dte) := FUNCTION
																												
#workunit('name','Prof License MARI- NMLS Discciplinary Action File '+ process_dte);		

src_cd	:= 'S0900'; //Vendor code
src_st	:= 'US';	//License state

//Destination File
MARIDest		:= Prof_License_Mari.thor_Cluster +'out::proflic_mari::nmls::';

//raw to MARIBASE layout - Regulatory
 Prof_License_Mari.layouts.Disciplinary_Action	xformDisciplinaryActions(pDisciplinary pInput) := TRANSFORM
		self.DATE_FIRST_SEEN							:= process_dte;
		self.DATE_LAST_SEEN								:= process_dte;
		self.DATE_VENDOR_FIRST_REPORTED		:= process_dte;
		self.DATE_VENDOR_LAST_REPORTED		:= process_dte;
		self.PROCESS_DATE									:= thorlib.wuid()[2..9];
		self.STD_SOURCE_UPD								:= src_cd;
		self.AUTHORITY_TYPE								:= ut.fnTrim2Upper(pInput.AUTHORITY_TYPE);
		self.AUTHORITY_NAME								:= ut.fnTrim2Upper(pInput.NAME_AUTHORITY);
		self.STATE_ACTION_ID							:= pInput.STATE_ACTION_ID;
		self.INDIVIDUAL_NMLS_ID						:= pInput.INDIVIDUAL_NMLS_ID;
		self.ACTION_TYPE									:= ut.fnTrim2Upper(pInput.ACTION_TYPE);
		self.ACTION_DTE										:= pInput.ACTION_DATE;
		self.CLN_ACTION_DTE								:= Prof_License_Mari.DateCleaner.ToYYYYMMDD(pInput.ACTION_DATE);
		self.ACTION_DETAIL								:= ut.fnTrim2Upper(pInput.ACTION_DETAIL);
		self.URL													:= StringLib.StringFilterOut(pInput.URL,'"');

END;		


ds_disciplinary := sort(project(pDisciplinary, xformDisciplinaryActions(left)),individual_nmls_id,state_action_id,cln_action_dte);

disciplinary_deduped := output(dedup(ds_disciplinary,record,all,local),,'~thor_data400::out::proflic_mari::nmls::' +process_dte+ '::disciplinary_actions',__compressed__,overwrite);
		
return disciplinary_deduped;

end;





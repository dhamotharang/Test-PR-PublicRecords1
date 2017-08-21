import crim_common,ut;

	//Combine LN DOC + Hygenics///////////////////////////////////////
	ln_doc  	:= hygenics_crim.File_In_DOC_Punishment;
	
		hygenics_crim.layout_Common_DOC_Punishment newTran(ln_doc l):= transform
			self.sent_date						:='';
			self.release_type					:='';	
			self.office_region				:='';	
			self.par_status_dt				:='';
			self.supv_office					:='';	
			self.supv_officer					:='';	
			self.office_phone					:='';
			self.TDCJID_unit_type			:='';
			self.TDCJID_unit_assigned	:='';
			self.TDCJID_admit_date		:='';
			self.prison_status				:='';
			self.recv_dept_code				:='';
			self.recv_dept_date				:='';
			self.parole_active_flag		:='';
			self.casepull_date				:='';
			self.pro_st_dt						:='';
			self.pro_end_dt						:='';
			self.pro_status						:='';
			self.punishment_persistent_id := 0;
			self := l;
		end;
	
ln_doc_rec 	:= project(ln_doc, newTran(left))(vendor in ['WA']);	
	
	hyg_doc		:= hygenics_crim.proc_build_DOC_punishments(vendor not in ['EP']);

		hygenics_crim.layout_Common_DOC_Punishment newTran2(hyg_doc l):= transform
			self.punishment_persistent_id := 0;	
			self := l;
		end;
	
hyg_doc_rec 	:= project(hyg_doc, newTran2(left))(vendor not in ['EP']);	
	
doc_concat_pun := ln_doc_rec + hyg_doc_rec;

	///////////////////////////////////////
	
	//Pull Hygenics Only
	//doc_concat_pun := hygenics_crim.proc_build_DOC_punishments;
	
	//Reformat to New DOC Punishment Layout 
	hygenics_crim.layout_Common_DOC_Punishment tDOCPunishmentInToOut(doc_concat_pun pInput) := transform
		self.sent_date						:='';
		self.release_type					:='';	
		self.office_region				:='';	
		self.par_status_dt				:='';
		self.supv_office					:='';	
		self.supv_officer					:='';	
		self.office_phone					:='';
		self.TDCJID_unit_type			:='';
		self.TDCJID_unit_assigned	:='';
		self.TDCJID_admit_date		:='';
		self.prison_status				:='';
		self.recv_dept_code				:='';
		self.recv_dept_date				:='';
		self.parole_active_flag		:='';
		self.casepull_date				:='';
		self.punishment_persistent_id := 0;
		self 											:= pInput;
	end;

dDOCPunishmentOut 	:= project(doc_concat_pun, tDOCPunishmentInToOut(left)):INDEPENDENT;
dDOCConcat 					:= dDOCPunishmentOut;

export Out_Moxie_DOC_Punishment := dDOCConcat;
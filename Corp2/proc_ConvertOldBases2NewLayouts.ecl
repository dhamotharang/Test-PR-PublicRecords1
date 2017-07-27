import corp, versioncontrol;

states_to_exclude := ['CA','FL','HI','NC'];

file_old_corp_base	:= corp.File_Corp_Base(corp_state_origin not in states_to_exclude);
file_old_cont_base	:= corp.File_Corp_Cont_Base(corp_state_origin not in states_to_exclude);
file_old_event_base	:= corp.File_Corp_Event_Base(corp_state_origin not in states_to_exclude);



Layout_Corporate_Direct_Corp_Base tConvertCorp2NewLayout(file_old_corp_base pInput) :=
transform
	self								:= pInput;
	self.corp_ra_dt_first_seen			:= 0;
	self.corp_ra_dt_last_seen			:= 0;
//	self.corp_orig_sos_charter_nbr		:= pInput.corp_orig_sos_charter_nbr;
	self.corp_supp_key                  := '';
	self.corp_vendor_county             := '';
	self.corp_vendor_subcode            := '';
	self.corp_src_type                  := '';
	self.corp_ln_name_type_cd           := '';
	self.corp_ln_name_type_desc         := '';
	self.corp_supp_nbr                  := '';
	self.corp_name_comment              := '';
	self.corp_fax_nbr                   := '';
	self.corp_standing                  := '';
	self.corp_status_comment            := '';
	self.corp_inc_county                := '';
	self.corp_anniversary_month         := '';
	self.corp_public_or_private_ind     := '';
	self.corp_naic_code                 := '';
	self.corp_entity_desc               := '';
	self.corp_certificate_nbr           := '';
	self.corp_internal_nbr              := '';
	self.corp_previous_nbr              := '';
	self.corp_microfilm_nbr             := '';
	self.corp_amendments_filed          := '';
	self.corp_acts                      := '';
	self.corp_partnership_ind           := '';
	self.corp_mfg_ind                   := '';
	self.corp_addl_info                 := '';
	self.corp_taxes                     := '';
	self.corp_franchise_taxes           := '';
	self.corp_tax_program_cd            := '';
	self.corp_tax_program_desc          := '';
	self.corp_ra_resign_date            := '';
	self.corp_ra_no_comp                := '';
	self.corp_ra_no_comp_igs            := '';
	self.corp_ra_addl_info              := '';
	self.corp_ra_fax_nbr                := '';
end;

file_new_corp_base := project(file_old_corp_base, tConvertCorp2NewLayout(left));


Layout_Corporate_Direct_Cont_Base tConvertCont2NewLayout(file_old_cont_base pInput) :=
transform
	self								:= pInput;
	self.corp_supp_key                  := '';
	self.corp_vendor_county             := '';
	self.corp_vendor_subcode            := '';
	self.corp_fax_nbr                   := '';
	self.cont_sos_charter_nbr           := '';
	self.cont_status_cd                 := '';
	self.cont_status_desc               := '';
	self.cont_effective_cd              := '';
	self.cont_effective_desc            := '';
	self.cont_addl_info                 := '';
	self.cont_address_county            := '';
	self.cont_fax_nbr                   := '';
end;

file_new_cont_base := project(file_old_cont_base, tConvertCont2NewLayout(left));

Layout_Corporate_Direct_Event_Base tConvertEvent2NewLayout(file_old_event_base pInput) :=
transform
	self								:= pInput;
	self.corp_supp_key                  := '';
	self.corp_vendor_county             := '';
	self.corp_vendor_subcode            := '';
	self.event_amendment_nbr            := '';
	self.event_date_type_cd             := '';
	self.event_date_type_desc           := '';
	self.event_corp_nbr                 := '';
	self.event_corp_nbr_cd              := '';
	self.event_corp_nbr_desc            := '';
	self.event_roll                     := '';
	self.event_frame                    := '';
	self.event_start                    := '';
	self.event_end                      := '';
	self.event_microfilm_nbr            := '';
end;

file_new_event_base := project(file_old_event_base, tConvertEvent2NewLayout(left));


create_new_corp_base	:= output(file_new_corp_base,,	'~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::main', overwrite);
create_new_cont_base	:= output(file_new_cont_base,,	'~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::cont', overwrite);
create_new_event_base	:= output(file_new_event_base,,'~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::event', overwrite);


export proc_ConvertOldBases2NewLayouts :=
sequential(
	 create_new_corp_base
	,create_new_cont_base
	,create_new_event_base
	,versioncontrol.mUtilities.clear_add(corp2.filenames.base.corp.qa, '~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::main')
	,versioncontrol.mUtilities.clear_add(corp2.filenames.base.cont.qa, '~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::cont')
	,versioncontrol.mUtilities.clear_add(corp2.filenames.base.events.qa, '~thor_data400::base::corp2::' + Corp.Corp_Build_Date + '::event')
	,fileservices.clearsuperfile(corp2.filenames.base.stock.qa)
	,fileservices.clearsuperfile(corp2.filenames.base.ar.qa)
	,rollback.input.Used2Sprayed
);
/*
	self.dt_first_seen					:= (unsigned4)pInput.dt_first_seen;
	self.dt_last_seen					:= (unsigned4)pInput.dt_last_seen;
	self.dt_vendor_first_reported		:= (unsigned4)pInput.dt_vendor_first_reported;
	self.dt_vendor_last_reported		:= (unsigned4)pInput.dt_vendor_last_reported;
*/
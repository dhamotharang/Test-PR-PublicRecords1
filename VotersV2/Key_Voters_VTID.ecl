Import Data_Services, doxie, header_services, ut, Data_Services;

base := PROJECT(VotersV2.File_Voters_Building, VotersV2.Layouts_Voters.Layout_Voters_Base);

base_all := VotersV2.Prep_Build.applyVoters(base(addr_type = '' and name_type = ''));

ut.mac_suppress_by_phonetype(base_all,phone,st,phone_suppression,true,did);	

ut.mac_suppress_by_phonetype(phone_suppression,work_phone,st,work_suppression,true,did);	

ut.mac_suppress_by_phonetype(work_suppression,other_phone,st,allSuppressed,true,did);	

layout_out := VotersV2.Layouts_Voters.Layout_Voters_Base;

//These fields are blanked because they could contain possible SSN's - per Jill Tolbert.
layout_out trfForKeys(allSuppressed l) := transform 
  self.source_voterId := '';
	self.motorVoterId   := '';
	self := l;
end;

voters_vtid_recs := project(allSuppressed, trfForKeys(left));

export Key_Voters_VTID := index(voters_vtid_recs,
															  {vtid},
															  {voters_vtid_recs},
															  Data_Services.Data_location.Prefix('Voter')+'thor_data400::key::voters::'+doxie.Version_SuperKey+'::vtid');
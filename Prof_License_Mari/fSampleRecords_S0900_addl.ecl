EXPORT fSampleRecords_S0900_addl(string version) := function

//Proflic Mari Individual Detail Samples
indv_detail 	:= Prof_License_Mari.files_base.individual_detail;
indv_detail_father := dataset('~thor_data400::base::proflic_mari::individual_detail_father',Prof_License_Mari.layouts.Individual_Reg,flat);
// samplefile1 := topn(indv_detail, 100, -process_date,-date_last_seen);

dist_base_detail := sort(distribute(indv_detail,HASH32(INDIVIDUAL_NMLS_ID,LICENSE_ID)),INDIVIDUAL_NMLS_ID,LICENSE_ID);
dist_detail_father := sort(distribute(indv_detail_father,HASH32(INDIVIDUAL_NMLS_ID,LICENSE_ID)),INDIVIDUAL_NMLS_ID,LICENSE_ID);
Prof_License_Mari.layouts.Individual_Reg join_detail_tr(dist_base_detail l,dist_detail_father r) := transform
self := l;
end;


join_detail := join(dist_base_detail,dist_detail_father,
                        LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID 
                        AND LEFT.LICENSE_ID = RIGHT.LICENSE_ID,
											  join_detail_tr(LEFT,RIGHT),LEFT ONLY,local);

sort_detail := sort(join_detail,individual_nmls_id, license_id);
samplefile1 := choosen(sort_detail,100);

//Proflic Mari Regulatory Actions Samples
regulatory		:= Prof_License_Mari.files_base.regulatory_actions;
proflic_reg_father := dataset('~thor_data400::base::proflic_mari::regulatory_actions_father',Prof_License_Mari.layouts.Regulatory_Action,flat);
// samplefile2 := topn(regulatory, 100, -process_date,-date_last_seen);

dist_base_reg := sort(distribute(regulatory,HASH32(NMLS_ID,REGULATOR)),NMLS_ID, REGULATOR);
dist_reg_father := sort(distribute(proflic_reg_father,HASH32(NMLS_ID,REGULATOR)),NMLS_ID,REGULATOR);
Prof_License_Mari.layouts.Regulatory_Action join_regulatory_tr(dist_base_reg l,dist_reg_father r) := transform
self := l;
end;


join_regulatory := join(dist_base_reg,dist_reg_father,
                        LEFT.NMLS_ID = RIGHT.NMLS_ID 
                        AND LEFT.REGULATOR = RIGHT.REGULATOR,
											  join_regulatory_tr(LEFT,RIGHT),LEFT ONLY,local);

sort_regulatory := sort(join_regulatory,nmls_id, regulator);
samplefile2 := choosen(sort_regulatory,100);

//Proflic Mari Disciplinary Actions Samples
disciplinary	:= Prof_License_Mari.files_base.disciplinary_actions;
proflic_displ_father := dataset('~thor_data400::base::proflic_mari::disciplinary_actions_father',Prof_License_Mari.layouts.Disciplinary_Action,flat);
// samplefile3 := topn(disciplinary, 100, -process_date,-date_last_seen);

dist_base_displ := sort(distribute(disciplinary,HASH32(INDIVIDUAL_NMLS_ID)),INDIVIDUAL_NMLS_ID);
dist_displ_father := sort(distribute(proflic_displ_father,HASH32(INDIVIDUAL_NMLS_ID)),INDIVIDUAL_NMLS_ID);
Prof_License_Mari.layouts.Disciplinary_Action join_disciplinary_tr(dist_base_displ l,dist_displ_father r) := transform
self := l;
end;


join_disciplinary := join(dist_base_displ,dist_displ_father,
                        LEFT.INDIVIDUAL_NMLS_ID = RIGHT.INDIVIDUAL_NMLS_ID, 
                        join_disciplinary_tr(LEFT,RIGHT),LEFT ONLY,local);


sort_disciplinary := sort(join_disciplinary,INDIVIDUAL_NMLS_ID);
samplefile3 := choosen(sort_disciplinary,100);

sampleout:=  sequential(
												output(samplefile1,named('MariSampleIndividualDetailecordsForQA')),
												output(samplefile2,named('MariSampleRegulatoryActionsRecordsForQA')),
												output(samplefile3,named('MariSampleDiscplinaryActionsRecordsForQA'))
                        
                      );

return sampleout;

end;


export File_FDNMasterIDBuild := module

shared	ccid_ds            := Files().Input.MBSFdnCCID.sprayed; //456751
shared	hhid_ds            := Files().Input.MBSFdnHHID.sprayed; //185196
shared	newGCExcl_ds       := Files().Input.MbsNewGcIdExclusion.sprayed;
shared 	MsIndTypIncl_ds    := Files().Input.mbsfdnmasteridindtypeinclusion.sprayed;

				gcid_proj          := project(newGCExcl_ds(exclusion_id_type='GCID'), transform(FraudDefenseNetwork.Layouts.Input.FDNMasterID,
																									self.gc_id               := left.exclusion_id;
																									self.gc_cc_hh_id         := left.exclusion_id;
																									self.id_type             := left.exclusion_id_type;
																									self.FdnmasterId_type    := left.exclusion_id_type;
																									self.FdnmasterId         := hashmd5(left.exclusion_id,trim(left.exclusion_id_type,left,right));
																									self                     := left;
																									self                     := []));

				ccid_proj          := project(ccid_ds(gc_id<>0),transform(FraudDefenseNetwork.Layouts.Input.FDNMasterID, 
				                                          isCCID_defaulted         := left.cc_id=0;
																									gc_cc_hh_id              := if(isCCID_defaulted,left.gc_id,left.cc_id); 
																									self.gc_cc_hh_id         := gc_cc_hh_id; 
																									self.id_type             := 'CCID'; 
																									FdnmasterId_type         := if(isCCID_defaulted,'GCID','CCID');
																									self.FdnmasterId_type    := FdnmasterId_type;
																									self.FdnmasterId         := hashmd5(gc_cc_hh_id,FdnmasterId_type);
																									self                     := left; 
																									self                     := [];));
																									
				hhid_proj          := project(hhid_ds(gc_id<>0),transform(FraudDefenseNetwork.Layouts.Input.FDNMasterID,
				                                          isHHID_defaulted         := left.hh_id=0; 
																									GC_CC_HH_ID              := if(isHHID_defaulted,left.gc_id,left.hh_id); 
																									self.GC_CC_HH_ID         := GC_CC_HH_ID; 
																									self.id_type             := 'HHID'; 
																									FdnmasterId_type         := if(isHHID_defaulted,'GCID','HHID');
																									self.FdnmasterId_type    := FdnmasterId_type;
																									self.FdnmasterId         := hashmd5(gc_cc_hh_id,FdnmasterId_type);
																									self                     := left; 
																									self                     := [];));
																					
       FdnmasterId_Fab     := gcid_proj + ccid_proj + hhid_proj;


export FdnmasterId         			:= dedup(sort(FdnmasterId_fab, gc_id, hh_id, cc_id, gc_cc_hh_id, FdnmasterId),gc_id, hh_id, cc_id, gc_cc_hh_id, FdnmasterId);


shared jn_mastID_Excl      			:= join(FDNMasterID, newGCExcl_ds(status=1), left.gc_cc_hh_id = right.exclusion_id and left.FDNMasterID_Type = right.exclusion_id_type,
																																				 transform(Layouts.Input.MbsFdnMasterIdExcl, 
																																									self.FdnmasterId :=left.FdnmasterId,
																																									self :=right),right outer);
																																									
shared jn_mastIDIndTyp_Incl    	:= join(FDNMasterID, MsIndTypIncl_ds(status=1), left.gc_cc_hh_id = right.inclusion_id and left.FDNMasterID_Type = right.inclusion_type,
																																				transform(Layouts.Input.MbsFdnMasterIDIndTypeIncl, 
																																									self.FdnmasterId :=left.FdnmasterId,
																																									self :=right),right outer);
export FdnmasterIdExcl     			:= dedup(sort(jn_mastID_Excl,record),record);		

export FdnmasterIdIndTypIncl		:= dedup(sort(jn_mastIDIndTyp_Incl,record),record);	

End;
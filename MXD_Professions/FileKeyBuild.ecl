base_recs	:=	MXD_Professions.FilesBase.base;

p_base_recs_seeded := iterate(
															base_recs,
															transform(recordof(base_recs),
																				same_entity 		:= 	left.lastname = right.lastname and
																														left.firstname = right.firstname and
																														left.matronymic = right.matronymic and
																														left.middlename1 = right.middlename1;
																				self.entity_id 	:= IF(LEFT.entity_id = 0,
																																(ThorLib.Node()+1)*0xFFFFFFFF + RANDOM(),
																																if(same_entity, 
																																			left.entity_id, 
																																			(ThorLib.Nodes()*0xFFFFFFFF)+LEFT.entity_id
																																	 )
																															);
																				self := right
																			  ), 
															local
															);		

export FileKeyBuild := p_base_recs_seeded : persist('~thor_data400::persist::mxd_Professions_entityids');
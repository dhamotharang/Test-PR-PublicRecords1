// base_recs := DATASET('~thor_data400::base::mxd_mxdocket_w20111219-085002-4',MXD_MXDocket.Layouts_build.base,THOR);

base_recs		:=	MXD_MXDocket.FilesBase.base;

base_recs1a := 	base_recs(firstname<>'', partytype=1);
base_recs1b := 	sort(distribute(base_recs1a, HASH(TRIM((STRING)lastname,LEFT,RIGHT))), lastname, firstname, matronymic, middlename1, local);
base_recs1c := 	iterate(
												base_recs1b,
												transform(recordof(base_recs1a),
														same_entity 		:=	left.lastname = right.lastname and
																								left.firstname = right.firstname and
																								left.matronymic = right.matronymic and
																								left.middlename1 = right.middlename1;
														self.entity_id 	:= 	IF(LEFT.entity_id = 0,
																										(ThorLib.Node()+1)*0xFFFFFFFF + RANDOM(),
																										if(same_entity, 
																													left.entity_id, 
																													(ThorLib.Nodes()*0xFFFFFFFF)+LEFT.entity_id
																											 )
																									 );
														self := right), local);

export FileKeyBuild := dedup(sort(base_recs1c,record,local),record,local) : persist('~thor_data400::persist::mxd_mxdocket_entityids');
import ut, Death_Master;

export Death_as_Source(dataset(header.Layout_Did_Death_MasterV2) pDeath_Master = dataset([],header.Layout_Did_Death_MasterV2), boolean pForHeaderBuild=false, BOOLEAN buildSSARestricted=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset('~thor_data400::Base::DeathHeader_Building',header.Layout_Did_Death_MasterV2,flat),
					   pDeath_Master
					  )(death_rec_src<>'TEX');

	//Join to states_supplemental file to get state address information
	ExpDeathMaster := header.Layout_DID_Death_MasterV2_expanded;
	st_supplemental := IF(buildSSARestricted,
												Header.file_death_master_supplemental_ssa(state_death_id[1..2] = SOURCE_STATE),
												Header.file_death_master_supplemental(state_death_id[1..2] = SOURCE_STATE));

	ExpDeathMaster AddClnAddress(dSourceData l, st_supplemental r) := TRANSFORM
				self.ssn	:= IF(r.ssn <> '',trim(r.ssn,all), l.ssn);
				self.address := IF(r.address <> '',ut.fn_RemoveSpecialChars(r.address),'');
				self.prim_range := IF(r.prim_range <> '',ut.fn_RemoveSpecialChars(r.prim_range),'');
				self.predir := IF(r.predir <> '',ut.fn_RemoveSpecialChars(r.predir),'');
				self.prim_name := IF(r.prim_name <> '',ut.fn_RemoveSpecialChars(r.prim_name),'');
				self.addr_suffix := IF(r.addr_suffix <> '',ut.fn_RemoveSpecialChars(r.addr_suffix),'');
				self.postdir := IF(r.postdir <> '',ut.fn_RemoveSpecialChars(r.postdir),'');
				self.unit_desig := IF(r.unit_desig <> '',ut.fn_RemoveSpecialChars(r.unit_desig),'');
				self.sec_range := IF(r.sec_range <> '',ut.fn_RemoveSpecialChars(r.sec_range),'');
				self.p_city_name := IF(r.p_city_name <> '',ut.fn_RemoveSpecialChars(r.p_city_name),'');
				self.v_city_name := IF(r.v_city_name <> '',ut.fn_RemoveSpecialChars(r.v_city_name),'');
				self.clnstate := IF(r.state <> '',trim(r.state,all),l.state);
				self.zip5 := IF(r.zip5 <> '',trim(r.zip5,all),'');
				self.zip4 := IF(r.zip4 <> '',trim(r.zip4,all),'');
				self.county := IF(r.fips_county <> '',trim(r.fips_county,left,right),'');
				self.geo_blk := IF(r.geo_blk <> '',trim(r.geo_blk,all),'');
				self := l;
	end;

	dDeathsSrcV2 := join(distribute(dSourceData,    hash(state_death_id))
											,distribute(st_supplemental,hash(state_death_id))
													,left.state_death_id = right.state_death_id
													,AddClnAddress(LEFT,RIGHT)
													,LEFT OUTER
													,local
													);
														
	src_rec := header.layouts_SeqdSrc.DE_src_rec;

    //crlf='SA' flags Direct records where the SSN was overlaid w/ one from the SSA
	header.Mac_Set_Header_Source(dDeathsSrcV2(crlf<>'SA'),ExpDeathMaster,src_rec, Death_src_for_header(l.state_death_id[1..2],l.death_rec_src,l.dod8), with_id)
	
	return with_id;
  end
 ;
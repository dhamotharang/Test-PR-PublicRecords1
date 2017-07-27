IMPORT MPRD;

EXPORT MAC_Derive_Sanctions(pBaseFile, pLayout_base,field_name, Lic_status_field, useFull = 'false') := FUNCTIONMACRO

		field_name := { STRING10 field_name };
		lic_status_field	:= {string1 lic_status_field};
		base_t_plus:=PROJECT(pBaseFile,{
														 pBaseFile
														,STRING8 temp_st_revoke_dt := ''
														,STRING8 temp_fed_revoke_dt	:= ''
														,STRING8 temp_st_rein_dt:=''
														,STRING8 temp_st_ds_dt:=''
														,STRING8 temp_st_as_dt	:= ''
														,STRING8 temp_fed_rein_dt:=''												
														});
	
		st_rein_codes			:= ['113R'];
		st_ds_codes				:= ['112DS','112dS'];
		st_as_codes				:= ['112AS','112aS'];
		st_revoke_codes		:= ['111L','CANDD'];
		fed_rein_codes		:= ['SMR'];
		fed_revoke_codes	:= ['SME'];
		
		base_u2_dst :=DISTRIBUTE(base_t_plus,HASH(group_key,sanc1_state));
		base_u2_srt :=SORT(base_u2_dst,group_key,sanc1_state,LOCAL);
		Gbase_u2    :=GROUP(base_u2_srt,group_key,sanc1_state);
		Gbase_u2_std:=SORT(Gbase_u2
										,-sanc1_date
										,MAP(
 										 field_name IN st_rein_codes		=>2
										,field_name IN st_ds_codes			=>4
										,field_name IN st_as_codes			=>6
										,field_name IN st_revoke_codes	=>8
										,field_name IN fed_rein_codes		=>10
										,field_name IN fed_revoke_codes	=>12
										,99));
	
		Gbase_u2_std tr_iter(Gbase_u2_std l, Gbase_u2_std r) :=TRANSFORM
		SELF.temp_st_rein_dt  	:= IF(r.field_name IN st_rein_codes, 	r.clean_sanc1_date,l.temp_st_rein_dt);
    SELF.temp_st_ds_dt 	    := IF(r.field_name IN st_ds_codes, 	  r.clean_sanc1_date,l.temp_st_ds_dt);
		SELF.temp_st_as_dt 	    := IF(r.field_name IN st_as_codes, 	  r.clean_sanc1_date,l.temp_st_as_dt);
		SELF.temp_st_revoke_dt  := IF(r.field_name IN st_revoke_codes,r.clean_sanc1_date,l.temp_st_revoke_dt);
		SELF.temp_fed_rein_dt   := IF(r.field_name IN fed_rein_codes,	r.clean_sanc1_date,l.temp_fed_rein_dt);
		SELF.temp_fed_revoke_dt := IF(r.field_name IN fed_revoke_codes,r.clean_sanc1_date,l.temp_fed_revoke_dt);
		SELF.LN_derived_rein_date:=MAP(
															 r.field_name IN st_rein_codes  => SELF.temp_st_rein_dt
															,r.field_name IN st_ds_codes
																	AND (UNSIGNED)SELF.temp_st_rein_dt>0
																	AND (UNSIGNED)SELF.temp_st_ds_dt<=(UNSIGNED)SELF.temp_st_rein_dt
																	AND (UNSIGNED)SELF.temp_st_ds_dt>=(UNSIGNED)SELF.temp_st_revoke_dt
																			=> SELF.temp_st_rein_dt
															,r.field_name IN st_revoke_codes  //here comes the "fun!"
																	=>	MAP(
																		// we have no 112dS but have 112aS with active license within the group
																		(((UNSIGNED)SELF.temp_st_ds_dt=0 AND (UNSIGNED)SELF.temp_st_rein_dt=0																				)
																			OR
																		 ((UNSIGNED)SELF.temp_st_ds_dt=0 AND (UNSIGNED)SELF.temp_st_rein_dt>0
																				AND (UNSIGNED)SELF.temp_st_as_dt<=(UNSIGNED)SELF.temp_st_rein_dt)
																			OR
																		 ((UNSIGNED)SELF.temp_st_ds_dt=0 AND (UNSIGNED)SELF.temp_st_rein_dt=0))
																			AND (UNSIGNED)SELF.temp_st_as_dt>0 AND r.lic_status_field = 'A'
																						=> SELF.temp_st_as_dt
																			// we have a 112dS within the group
																			,(((UNSIGNED)SELF.temp_st_ds_dt>0 AND (UNSIGNED)SELF.temp_st_rein_dt=0)
																			OR
																				((UNSIGNED)SELF.temp_st_ds_dt>0
																				AND (UNSIGNED)SELF.temp_st_rein_dt>0
																				AND (UNSIGNED)SELF.temp_st_ds_dt<=(UNSIGNED)SELF.temp_st_rein_dt))
																						=> SELF.temp_st_ds_dt
																			// we do not have a 112dS or 112aS but have a 113R within the group
																			,SELF.temp_st_rein_dt)
																,r.field_name IN fed_rein_codes
																											=> SELF.temp_fed_rein_dt
																,r.field_name IN fed_revoke_codes
																											=> SELF.temp_fed_rein_dt
																,r.LN_derived_rein_date);
			SELF.LN_derived_rein_flag:=IF(r.field_name NOT IN [st_rein_codes,fed_rein_codes]
																		 AND (UNSIGNED)SELF.LN_derived_rein_date>0
																				,true
																				,r.LN_derived_rein_flag);
			SELF:=r;
		END;

		it1:=ITERATE(Gbase_u2_std(record_type = 'C'),tr_iter(LEFT,RIGHT)) + Gbase_u2_std(record_type = 'H');
		final_set1	:= UNGROUP(PROJECT(it1,pLayout_base));

		RETURN final_set1;
	ENDMACRO;				

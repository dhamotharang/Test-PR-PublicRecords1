import	_control, PRTE_CSV;

export Proc_Build_DCA_Keys(string pIndexVersion) := function

	// Get the previous key version that exists on prct roxie
	vPrevIndexVersion	:=	PRTE.GetDemoBuildVersion('DCAKeys','N');

	// Get the key layout definitions
	rDCAKey__key__dca__bdid	:= record
		PRTE_CSV.DCA.rthor_data400__key__dca__bdid; end;
	
	rDCAKey__key__dca__hierarchy_bdid	:= record
		PRTE_CSV.DCA.rthor_data400__key__dca__hierarchy_bdid; end;
	
	rDCAKey__key__dca__hierarchy_root_sub	:= record
		PRTE_CSV.DCA.rthor_data400__key__dca__hierarchy_root_sub; end;
	
	rDCAKey__key__dca__root_sub	:= record
		PRTE_CSV.DCA.rthor_data400__key__dca__root_sub; end;
	
	rDCAKey__key__dca__linkids	:= record
		PRTE_CSV.DCA.rthor_data400__key__dca__linkids; end;
	
	rDCAKey__key__hierarchy_parent_to_child_root_sub	:= record
		PRTE_CSV.DCA.rthor_data400__key__hierarchy_parent_to_child_root_sub; end;
	
	rDCAKey__key__hierarchy_parent_to_child_entnum	:= record
		PRTE_CSV.DCA.rthor_data400__key__hierarchy_parent_to_child_entnum; end;
	
	rDCAKey__key__hierarchy_entnum	:= record
		PRTE_CSV.DCA.rthor_data400__key__hierarchy_entnum; end;
	
	rDCAKey__key__entnum	:= record
		PRTE_CSV.DCA.rthor_data400__key__entnum; end;
		
	rDCAKey__key__entnum_nonfilt	:= record
		PRTE_CSV.DCA.rthor_data400__key__entnum; end;	
	
	rDCAKey__key__autokey__addressb2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__addressb2; end;
	
	rDCAKey__key__autokey__citystnameb2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__citystnameb2; end;
	
	rDCAKey__key__autokey__nameb2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__nameb2; end;
	
	rDCAKey__key__autokey__namewords2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__namewords2; end;
	
	rDCAKey__key__autokey__payload	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__payload; end;
	
	rDCAKey__key__autokey__stnameb2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__stnameb2; end;
	
	rDCAKey__key__autokey__zipb2	:= record
		PRTE_CSV.DCA.rthor_data400__key__autokey__zipb2; end;

// Reformat the csv datasets to the layouts defined above
	ds_key_dca_bdid  												 := project(PRTE_CSV.DCA.dthor_data400__key__dca__bdid, rDCAKey__key__dca__bdid);
	ds_key_dca_hierarchy_bdid								 := project(PRTE_CSV.DCA.dthor_data400__key__dca__hierarchy_bdid, rDCAKey__key__dca__hierarchy_bdid);
	ds_key_dca_hierarchy_root_sub						 := project(PRTE_CSV.DCA.dthor_data400__key__dca__hierarchy_root_sub, rDCAKey__key__dca__hierarchy_root_sub);
	ds_key_dca_root_sub											 := project(PRTE_CSV.DCA.dthor_data400__key__dca__root_sub, rDCAKey__key__dca__root_sub);
	ds_key_dca_linkids											 := project(PRTE_CSV.DCA.dthor_data400__key__dca__linkids, rDCAKey__key__dca__linkids);
	ds_key_hierarchy_parent_to_child_root_sub:= project(PRTE_CSV.DCA.dthor_data400__key__hierarchy_parent_to_child_root_sub, rDCAKey__key__hierarchy_parent_to_child_root_sub);
	ds_key_hierarchy_parent_to_child_entnum	 := project(PRTE_CSV.DCA.dthor_data400__key__hierarchy_parent_to_child_entnum, rDCAKey__key__hierarchy_parent_to_child_entnum);
	ds_key_hierarchy_entnum									 := project(PRTE_CSV.DCA.dthor_data400__key__hierarchy_entnum, rDCAKey__key__hierarchy_entnum);
	ds_key_entnum														 := project(PRTE_CSV.DCA.dthor_data400__key__entnum, rDCAKey__key__entnum);
  ds_key_entnum_nonfilt										 := project(PRTE_CSV.DCA.dthor_data400__key__entnum_nonfilt, rDCAKey__key__entnum_nonfilt);
	ds_key_autokey_addressb2								 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__addressb2, rDCAKey__key__autokey__addressb2);
	ds_key_autokey_citystnameb2							 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__citystnameb2, rDCAKey__key__autokey__citystnameb2);
	ds_key_autokey_nameb2										 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__nameb2, rDCAKey__key__autokey__nameb2);
	ds_key_autokey_namewords2								 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__namewords2,	rDCAKey__key__autokey__namewords2);
  ds_key_autokey_payload									 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__payload, rDCAKey__key__autokey__payload);
  ds_key_autokey_stnameb2									 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__stnameb2, rDCAKey__key__autokey__stnameb2);
	ds_key_autokey_zipb2										 := project(PRTE_CSV.DCA.dthor_data400__key__autokey__zipb2, rDCAKey__key__autokey__zipb2);


// Index definitions for keys
	kKeyDCA__bdid						      :=	index(ds_key_dca_bdid                          ,{bdid}, {ds_key_dca_bdid}, '~prte::key::DCA::' + pIndexVersion + '::bdid');
	kKeyDCA__hierarchy_bdid				:=	index(ds_key_dca_hierarchy_bdid                ,{bdid}, {ds_key_dca_hierarchy_bdid}, '~prte::key::DCA::' + pIndexVersion + '::hierarchy_bdid');
	kKeyDCA__hierarchy_root_sub		:=	index(ds_key_dca_hierarchy_root_sub            ,{root,sub}, {ds_key_dca_hierarchy_root_sub}, '~prte::key::DCA::' + pIndexVersion + '::hierarchy_root_sub');
	kKeyDCA__root_sub		    		  :=	index(ds_key_dca_root_sub           					 ,{root,sub}, {ds_key_dca_root_sub}, '~prte::key::DCA::' + pIndexVersion + '::root_sub');
  kKeyDCA__linkids              :=  index(ds_key_dca_linkids                       ,{ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_key_dca_linkids}, '~prte::key::DCA::' + pIndexVersion + '::linkids');	
	kKeyDCA__hierarchy_p2c      	:=	index(ds_key_hierarchy_parent_to_child_root_sub,{parent_root, parent_sub, child_root, child_sub, child_level}, {ds_key_hierarchy_parent_to_child_root_sub}, '~prte::key::DCA::' + pIndexVersion + '::hierarchy_parent_to_child_root_sub');
	kKeyDCA__hierarchy_p2c_ent  	:=	index(ds_key_hierarchy_parent_to_child_entnum  ,{Parent_Enterprise_number, Enterprise_num, child_level}, {ds_key_hierarchy_parent_to_child_entnum}, '~prte::key::DCA::' + pIndexVersion + '::hierarchy_parent_to_child_entnum');
	kKeyDCA__hierarchy_entnum   	:=	index(ds_key_hierarchy_entnum                  ,{Enterprise_num}, {ds_key_hierarchy_entnum}, '~prte::key::DCA::' + pIndexVersion + '::hierarchy_entnum');
	kKeyDCA__entnum        		  	:=	index(ds_key_entnum        		                 ,{Enterprise_num}, {ds_key_entnum}, '~prte::key::DCA::' + pIndexVersion + '::entnum');
  kKeyDCA__entnum_nonfilt		  	:=	index(ds_key_entnum_nonfilt		                 ,{Enterprise_num}, {ds_key_entnum_nonfilt}, '~prte::key::DCA::' + pIndexVersion + '::entnum_nonfilt');
	kKeyDCA__autokey__addressb2   :=	index(ds_key_autokey_addressb2                 ,{prim_name, prim_range, st, city_code, zip, sec_range, cname_indic, cname_sec, bdid}, {ds_key_autokey_addressb2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::addressb2');
	kKeyDCA__autokey__citystnameb2:=	index(ds_key_autokey_citystnameb2              ,{city_code, st, cname_indic, cname_sec, bdid}, {ds_key_autokey_citystnameb2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyDCA__autokey__nameb2      :=	index(ds_key_autokey_nameb2                    ,{cname_indic, cname_sec, bdid}, {ds_key_autokey_nameb2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::nameb2');
	kKeyDCA__autokey__namewords2  :=	index(ds_key_autokey_namewords2                ,{word, state, seq, bdid}, {ds_key_autokey_namewords2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::namewords2');
	kKeyDCA__autokey__payload     :=	index(ds_key_autokey_payload                   ,{fakeid}, {ds_key_autokey_payload}, '~prte::key::DCA::' + pIndexVersion + '::autokey::payload');
	kKeyDCA__autokey__stnameb2    :=	index(ds_key_autokey_stnameb2                  ,{st, cname_indic, cname_sec, bdid}, {ds_key_autokey_stnameb2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::stnameb2');
	kKeyDCA__autokey__zipb2       :=	index(ds_key_autokey_zipb2                     ,{zip, cname_indic, cname_sec, bdid}, {ds_key_autokey_zipb2}, '~prte::key::DCA::' + pIndexVersion + '::autokey::zipb2');

	return	sequential(
											parallel(																																
																 build(kKeyDCA__bdid				    	   ,update)
																,build(kKeyDCA__hierarchy_bdid	     ,update)
																,build(kKeyDCA__hierarchy_root_sub	 ,update)																																															
																,build(kKeyDCA__root_sub				     ,update)
																,build(kKeyDCA__linkids              ,update)
																,build(kKeyDCA__hierarchy_p2c    	   ,update)
																,build(kKeyDCA__hierarchy_p2c_ent	   ,update)
																,build(kKeyDCA__hierarchy_entnum 	   ,update)
																,build(kKeyDCA__entnum        			 ,update)
																,build(kKeyDCA__entnum_nonfilt 			 ,update)
																,build(kKeyDCA__autokey__addressb2   ,update)
																,build(kKeyDCA__autokey__citystnameb2,update)
																,build(kKeyDCA__autokey__nameb2      ,update)
																,build(kKeyDCA__autokey__namewords2  ,update)
																,build(kKeyDCA__autokey__payload     ,update)
																,build(kKeyDCA__autokey__stnameb2    ,update)
																,build(kKeyDCA__autokey__zipb2       ,update)
																,PRTE.copymissingkeys('DCAKeys',pIndexVersion,vPrevIndexVersion)
															 ),
											PRTE.UpdateVersion('DCAKeys',							        			//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );
end;
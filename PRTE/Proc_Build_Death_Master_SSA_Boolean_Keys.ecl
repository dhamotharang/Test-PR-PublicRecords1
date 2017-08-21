IMPORT Header, _Control, Death_Master;
EXPORT Proc_Build_Death_Master_SSA_Boolean_Keys(STRING pIndexVersion) := FUNCTION

//	LAYOUTS
	rKeyDeath_MasterV2__ssa__death_id	:=	RECORD
		Header.Layout_Did_Death_MasterV3;
		STRING18	county_name;
		UNSIGNED8 __internal_fpos__;
	END;
	
	rKeyDeath_Master__ssa__dictindx3	:=	RECORD
		STRING20	word;
		UNSIGNED4	nominal;
		UNSIGNED4	suffix;
		UNSIGNED8	freq;
		UNSIGNED8	docfreq;
		UNSIGNED1	typ;
		STRING128	fullword;
		UNSIGNED8	fpos;
	END;
	
	rKeyDeath_Master__ssa__docref__state_death_id	:=	RECORD
		UNSIGNED2	src;
		UNSIGNED6	doc;
		STRING16	state_death_id;
		UNSIGNED8	__filepos;
	END;

	rKeyDeath_Master__ssa__dtldictx	:=	RECORD
		STRING20	word;
		UNSIGNED4	nominal;
		UNSIGNED4	suffix;
		UNSIGNED8	freq;
		UNSIGNED8	docfreq;
		UNSIGNED1	typ;
		STRING128	fullword;
		UNSIGNED8	fpos;
	END;
	
	rKeyDeath_Master__ssa__exkeyi	:=	RECORD
		UNSIGNED8	hashkey;
		UNSIGNED2	part;
		UNSIGNED2	src;
		UNSIGNED6	doc;
		STRING		externalkey{MAXLENGTH(255)};
		UNSIGNED8	__internal_fpos__;
	END;

	rKeyDeath_Master__ssa__exkeyo	:=	RECORD
		UNSIGNED2	src;
		UNSIGNED6	doc;
		STRING		externalkey{MAXLENGTH(255)};
		UNSIGNED8	__internal_fpos__;
	END;
	
	rKeyDeath_Master__ssa__nidx3	:=	RECORD
		UNSIGNED1	typ;
		UNSIGNED4	nominal;
		UNSIGNED2	lseg;
		UNSIGNED2	part;
		UNSIGNED2	src;
		UNSIGNED6	doc;
		UNSIGNED2	seg;
		UNSIGNED4	kwp;
		UNSIGNED2	wip;
		UNSIGNED4	suffix;
		UNSIGNED2	sect;
		UNSIGNED8	fpos;
	END;
	
	rKeyDeath_Master__ssa__xdstat2	:=	RECORD
		INTEGER1	f;
		UNSIGNED8	maxdocfreq;
		UNSIGNED8	maxfreq;
		INTEGER8	meandocsize;
		INTEGER8	uniquenominals;
		INTEGER8	doccount;
		UNSIGNED8	fpos;
	END;
	
	rKeyDeath_Master__ssa__xseglist	:=	RECORD
		INTEGER1					f;
		STRING						segname{MAXLENGTH(128)};
		UNSIGNED1					segtype;
		SET OF UNSIGNED2	seglist{MAXCOUNT(64)};
		UNSIGNED8					fpos;
	END;
	
	rKeyDeath__supplemental__ssa__death_id	:=	RECORD
		header.layout_death_master_slim_supplemental;
		UNSIGNED8	__internal_fpos__;
	END;

// thor_data400::key::death_masterv2_ssa::20140510c::did
	rKeyDeath_MasterV2__ssa__did	:=	RECORD
		Header.Layout_Did_Death_MasterV3;
		STRING18	county_name;
		UNSIGNED8	__internal_fpos__;
	END;

// DATASETS
	dV2_SSA_death_id						:= DATASET([], rKeyDeath_MasterV2__ssa__death_id);
	dSSA_Dictindx3							:= DATASET([], rKeyDeath_Master__ssa__dictindx3);
	dSSA_State_death_id					:= DATASET([], rKeyDeath_Master__ssa__docref__state_death_id);
	dSSA_dtldictx								:= DATASET([], rKeyDeath_Master__ssa__dtldictx);
	dSSA_exkeyi									:= DATASET([], rKeyDeath_Master__ssa__exkeyi);
	dSSA_exkeyo									:= DATASET([], rKeyDeath_Master__ssa__exkeyo);
	dSSA_nidx3									:= DATASET([], rKeyDeath_Master__ssa__nidx3);
	dSSA_xdstat2								:= DATASET([], rKeyDeath_Master__ssa__xdstat2);
	dSSA_xseglist								:= DATASET([], rKeyDeath_Master__ssa__xseglist);
	dSupplemental_SSA_death_id	:= DATASET([], rKeyDeath__supplemental__ssa__death_id);
	dV2_SSA_did									:= DATASET([], rKeyDeath_MasterV2__ssa__did);


// INDICES
	V2_SSA_death_id_in						:= INDEX(dV2_SSA_death_id,{state_death_id},{dV2_SSA_death_id},'~prte::key::death_masterv2_ssa::' + pIndexVersion + '::death_id');
	SSA_Dictindx3_in							:= INDEX(dSSA_Dictindx3,{word,nominal,suffix,freq,docfreq},{dSSA_Dictindx3},'~prte::key::death_master_ssa::' + pIndexVersion + '::dictindx3');
	SSA_State_death_id_in					:= INDEX(dSSA_State_death_id,{src,doc,state_death_id},{dSSA_State_death_id},'~prte::key::death_master_ssa::' + pIndexVersion + '::docref.state_death_id');
	SSA_dtldictx_in								:= INDEX(dSSA_dtldictx,{word,nominal,suffix,freq,docfreq},{dSSA_dtldictx},'~prte::key::death_master_ssa::' + pIndexVersion + '::dtldictx');
	SSA_exkeyi_in									:= INDEX(dSSA_exkeyi,{hashkey,part,src,doc},{dSSA_exkeyi},'~prte::key::death_master_ssa::' + pIndexVersion + '::exkeyi');
	SSA_exkeyo_in									:= INDEX(dSSA_exkeyo,{src,doc},{dSSA_exkeyo},'~prte::key::death_master_ssa::' + pIndexVersion + '::exkeyo');
	SSA_nidx3_in									:= INDEX(dSSA_nidx3,{typ,nominal,lseg,part,src,doc,seg,kwp,wip,suffix},{dSSA_nidx3},'~prte::key::death_master_ssa::' + pIndexVersion + '::nidx3');
	SSA_xdstat2_in								:= INDEX(dSSA_xdstat2,{f},{dSSA_xdstat2},'~prte::key::death_master_ssa::' + pIndexVersion + '::xdstat2');
	SSA_xseglist_in								:= INDEX(dSSA_xseglist,{f},{dSSA_xseglist},'~prte::key::death_master_ssa::' + pIndexVersion + '::xseglist');
	Supplemental_SSA_death_id_in	:= INDEX(dSupplemental_SSA_death_id,{state_death_id},{dSupplemental_SSA_death_id},'~prte::key::death_supplemental_ssa::' + pIndexVersion + '::docref.state_death_id');
	V2_SSA_did_in									:= INDEX(dV2_SSA_did,{UNSIGNED6 l_did := (INTEGER)did},{dV2_SSA_did},'~prte::key::death_masterv2_ssa::' + pIndexVersion + '::did');


	RETURN SEQUENTIAL(PARALLEL(BUILD(V2_SSA_death_id_in, update),
														 BUILD(SSA_Dictindx3_in, update),
														 BUILD(SSA_State_death_id_in, update),
														 BUILD(SSA_dtldictx_in, update),
														 BUILD(SSA_exkeyi_in, update),
														 BUILD(SSA_exkeyo_in, update),
														 BUILD(SSA_nidx3_in, update),
														 BUILD(SSA_xdstat2_in, update),
														 BUILD(SSA_xseglist_in, update),
														 BUILD(Supplemental_SSA_death_id_in, update),
														 BUILD(V2_SSA_did_in, update)),
									  PRTE.UpdateVersion('DeathMasterSsaKeys',								//	Package name
																	     pIndexVersion,												//	Package version
																	     _Control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																	     'B',																	//	B = Boca, A = Alpharetta
																	     'N',																	//	N = Non-FCRA, F = FCRA
																	     'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );

END;
EXPORT PrepSources := 
MODULE

import BIPV2_Files, dcav2, Frandx, mdr;

export LNCA(
	dataset(BIPV2_Files.layout_proxid) 							head 
	,dataset(DCAV2.layouts.Base.companies) 					lncad
):=
FUNCTION

	lncar := BIPv2_HRCHY.Layouts.lncar;
	
	// ACTIVE
	active_lnca := lncad(record_type in [dcav2.Utilities.RecordType.Updated,dcav2.Utilities.RecordType.New]);

	// SLIM
	lnca := project(active_lnca, transform(lncar, self := left.rawfields, self.date_last_seen := left.date_last_seen)) : persist('~thor_data400::BIPv2_HRCHY::mod_Build.lnca');
	
	// JOIN TO HEADER
	lj := 
	join(
		lnca((unsigned6)enterprise_num > 0),
		head(active_enterprise_number <> ''),
		left.enterprise_num = right.active_enterprise_number,
		transform(
			BIPv2_HRCHY.Layouts.prep_r2,

			self.proxid := right.proxid,
			self.isLegalNameInHeader := stringlib.stringtouppercase(trim(right.company_name_type_derived)) = 'LEGAL';
			self.id := (unsigned6)left.enterprise_num,
			self.parent_id := (unsigned6)left.parent_enterprise_number,
			self.ultimate_id := (unsigned6)left.ultimate_enterprise_number,
			self.hq_id := 0,
			self.name := left.name,
			self.dt_last_seen := left.date_last_seen,
			self.biz_type := constants.lnca.ctype_code( left.company_type),
			self.is_SELE_level := constants.lnca.ctype_code_is_SELE_level(self.biz_type),
			self.src := 'L',
			
			self.derived_ultid := 0,
			self.derived_orgid := 0,
			self.derived_SELEid := 0,
			self.derived_levels_above := 0,
			self.derived_levels_below := 0,
			self.derived_levels_from_top := 0,
			self.hrchy_type := ''
		),
		left outer,
		hash
	);

	return lj;

END;//LNCA


export DUNS(
	dataset(BIPV2_Files.layout_proxid) 								head 
	,dataset(recordof(BIPV2_Files.files_hrchy.duns)) 	dunsd 					
):=
FUNCTION

	
	// ACTIVE
	active_duns := dunsd(active_duns_number = 'Y') ;
	
	// SLIM
	duns := 
	dedup(
		project(
			active_duns, 
			transform(
				BIPv2_HRCHY.Layouts.dunsr, 
				self := left.rawfields, 
				self.date_last_seen := left.date_last_seen, 
				self:= left.clean_address
			))
		, all) : persist('~thor_data400::BIPv2_HRCHY::mod_Build.duns');//lots of dups here
		
	// JOIN TO HEADER
	BIPv2_HRCHY.Layouts.prep_r2 dunxf(duns le, head ri) := transform
			self.proxid := ri.proxid,
			self.isLegalNameInHeader := stringlib.stringtouppercase(trim(ri.company_name_type_derived)) = 'LEGAL';		
			self.id := (unsigned6)le.duns_number,
			self.parent_id := (unsigned6)le.parent_duns_number,
			self.ultimate_id := (unsigned6)le.ultimate_duns_number,
			self.hq_id := (unsigned6)le.headquarters_duns_number,
			self.name := le.business_name,
			self.dt_last_seen := le.date_last_seen,		
			self.biz_type := le.type_of_establishment,
			self.is_SELE_level := constants.duns.ctype_code_is_SELE_level(self.biz_type),
			self.src := 'D',
			
			self.derived_ultid := 0,
			self.derived_orgid := 0,
			self.derived_SELEid := 0,
			self.derived_levels_above := 0,
			self.derived_levels_below := 0,
			self.derived_levels_from_top := 0,
			self.hrchy_type := ''
	end;

	dj := 
	join(
		duns((unsigned6)duns_number > 0),
		head(active_duns_number <> ''),
		left.duns_number = right.active_duns_number and
		left.prim_range = right.prim_range,							//currently, too many dups
		dunxf(left, right),
		left outer,
		hash
	) ; 

	//where we have a duns and proxid tied together, eliminate those duns numbers from consideration
	djfil := dedup(dj(proxid > 0), id, all);
	dunsleftover :=
	join(
		duns((unsigned6)duns_number > 0),
		djfil,
		(integer)left.duns_number = right.id,
		left only,
		hash
	);


	//then try to get a proxid for the remaining active duns numbers with a join on name, address, contact_name, src = D
	dj2 :=
	join(
		project(dunsleftover, recordof(duns)),
		head(source = 'D'),
		left.prim_range = right.prim_range AND					
		left.prim_name = right.prim_name AND			
		left.sec_range = right.sec_range AND				
		left.zip = right.zip AND
		stringlib.stringtouppercase(left.business_name[1..50]) = right.company_name[1..50],
		dunxf(left, right),
		hash
	) ;

	return dj+dj2;

END;//DUNS


export FRAN(
	dataset(BIPV2_Files.layout_proxid) 								head 
	,dataset(Frandx.layouts.Base)											frand 					
):=
FUNCTION

	
	// ACTIVE
	active_fran := frand;//per Ellison: There's nothing in the record layout to indicate whether a franchise is active or inactive.

	// SLIM
	fran := project(active_fran, BIPv2_HRCHY.Layouts.franr);
	
	// JOIN TO HEADER
	fj0 :=
	join(
		fran((unsigned6)franchisee_id > 0, BIPv2_HRCHY.Constants.FRAN.ctype_decode(unit_flag) <> ''),
		dedup(head(source = mdr.sourceTools.src_Frandx and vl_id <> ''), vl_id, proxid, company_name, company_name_type_derived, all),
		left.franchisee_id = right.vl_id[1..6],
		transform(
			BIPv2_HRCHY.Layouts.prep_r2;
			
			isHQ := left.unit_flag = 'H' and left.company_name = right.company_name;

			self.proxid := right.proxid;
			self.isLegalNameInHeader := stringlib.stringtouppercase(trim(right.company_name_type_derived)) = 'LEGAL';
			
			//the HQ and the branch have the same franchisee ID.  use that ID as the parent ID.  store a 900 version of it elsewhere for reference
			self.id := 					if(isHQ ,			(unsigned6)left.franchisee_id, 90000000000 + (unsigned6)left.franchisee_id);
			self.parent_id := 	if(not isHQ ,	(unsigned6)left.franchisee_id, 0);
			self.ultimate_id := self.parent_id;
			self.hq_id := 0;
			self.name := if(isHQ , left.company_name, left.brand_name);
			self.dt_last_seen := left.dt_last_seen;
			self.biz_type := constants.fran.get_itype(left.unit_flag);
			self.is_SELE_level := isHQ;
			self.src := 'F';
			
			self.derived_ultid := 0;
			self.derived_orgid := 0;
			self.derived_SELEid := 0;
			self.derived_levels_above := 0;
			self.derived_levels_below := 0;
			self.derived_levels_from_top := 0;
			self.hrchy_type := '';
		),
		//left outer,
		hash
	);

	fj0d := dedup(fj0, all);

	//only keep the frandata if it has a parent or a child.  otherwise, it isnt buying us anything
	fj :=
	join(//those with parents
		fj0d(parent_id > 0),
		dedup(fj0d, id, all),
		left.parent_id = right.id,
		transform(left),
		hash
	)+
	join(//those with children
		fj0d(id > 0),
		dedup(fj0d, parent_id, all),
		left.id = right.parent_id,
		transform(left),
		hash
	);
	return fj;

END;//FRAN


export Patch(
	dataset(BIPv2_HRCHY.Layouts.prep_r2) aj
) :=
FUNCTION

	/*
	GLOBAL TYPES
	1) if all you have is self_id, then you are atop the hrchy, regardless of whether anyone sits below you
	2) have self, ult, and parent

	DUNS TYPES
	1) hq_ult_type2_No_parent - self is type 2.  there is no parent.  ult and hq are populated.	
		OLD - They are branches, and their HQs are located via the ultimate_duns_number.  The ultimate_duns_number may also be used as the parent_duns_number.
		NEW - use hq as parent
	2) parent_ult_type3_No_hq - type = 3.  duns = ultimate.  parent is different.	parent is overseas.  Ultimate here is domestic ultimate.  We only have domestic dmi data.  (later: But two domestic hierarchies with same overseas parent are related.)
	2) ult_type1_No_hq_no_parent - type = 3.  duns = ultimate.  parent is empty.	this is the hq.

	*/

	tj :=
	project(
		aj,
		transform(
			BIPv2_HRCHY.Layouts.prep_r2,
			self.hrchy_type := 
			map(
				left.id > 0 
				and left.parent_id = 0 
				and left.ultimate_id = 0
					=> 'G1',

				left.src = 'D' 
				and (unsigned1)left.biz_type = 3 
				and left.id = left.ultimate_id 
				and left.id <> left.parent_id 
				and left.parent_id > 0 
					=> 'D2',

				left.id > 0 
				and left.parent_id > 0 
				and left.ultimate_id > 0
					=> 'G2',	
					
				left.src = 'D' 
				and (unsigned1)left.biz_type = 2 
				and left.id > 0 
				and left.parent_id = 0 
				and left.ultimate_id > 0 
				and left.hq_id > 0
					=> 'D1',		
	
				left.src = 'D' 
				and (unsigned1)left.biz_type = 1 
				and left.id = left.ultimate_id 
				and left.parent_id = 0 
					=> 'D3',					
					''
			),
			self := left
		)
	);

	// output(tj(id in mybothi or parent_id in mybothi or ultimate_id in mybothi), all, named('tj'));

	r3 := record
		tj.src;
		tj.hrchy_type;
		cnt := count(group);
	end;

	// t3 := table(sort(tj, src, hrchy_type), r3, src, hrchy_type, few);
	t3 := table(tj, r3, src, hrchy_type, few);
	// output(sort(t3, -cnt), named('t3'));

	// m(ms, ht, name) := macro
	// output(tj(src = ms and hrchy_type = ht), named(name));
	// endmacro;

	// m('D','G1','preDG1');
	// m('D','G2','preDG2');
	// m('D','D1','preDD1');
	// m('D','D2','preDD2');
	// m('D','D3','preDD3');
	// m('D','','preDblank');

	// m('L','G1','preLG1');
	// m('L','G2','preLG2');
	// m('L','','preLblank');

	/*
	 src hrchy type cnt 
	1 D G1 440541256 
	2 D D1 63595995 
	3 D  34803860 
	4 D G2 16613471 
	5 L G2 200208 
	6 L G1 91193 
	7 L  30 
	*/
	//why no d2?

	//now do some handling of these types before you go into hrchy function




	//***** NOW FIX THEM

	f := 
	project(
		tj(hrchy_type <> ''),
		transform(
			BIPv2_HRCHY.Layouts.prep_r2,	
			self.parent_id :=
			case(
				left.hrchy_type,
				// 'D1' => left.ultimate_id, //OLD
				'D1' => left.hq_id,					//NEW
				'D2' => 0,
				// 'D3' => keep it blank
				left.parent_id
			);
			self.ultimate_id :=
			case(
				left.hrchy_type,
				'G1' => left.id,
				left.ultimate_id
			);
			self := left
		)
	);

	return f;
END;//Patch

export HandleDups(
	dataset(BIPv2_HRCHY.Layouts.prep_r2) d2
) :=
FUNCTION

	// only keep most recent that has a proxid
	recent := dedup(sort(distribute(d2, hash32(id, src)), id, src, if(proxid != 0, 0, 1), -dt_last_seen, local),
	                left.id = right.id
	                  and left.src = right.src
	                  and left.dt_last_seen != right.dt_last_seen,
	                local);

	// only keep ones with ultimate or parent
	potentials := dedup(sort(recent, id, src, if(ultimate_id != 0, 0, 1), if(parent_id != 0, 0, 1)),
	                    left.id = right.id
	                      and left.src = right.src
	                      and ((left.ultimate_id != 0 and right.ultimate_id = 0)
	                          or (left.parent_id != 0 and right.parent_id = 0)));

	// Prefer higher ids for parent/ultimate. Prefer sele level.
	d3v1 := dedup(sort(potentials, id, src, -parent_id, -ultimate_id, if(is_sele_level, 0, 1), if(isLegalNameInHeader, 0, 1),
	                   proxid),
	              id, src);


	//***** FIND DUPS THAT ARE OK BECAUSE THEY ARE NOT A PARENT TO ANYONE (duplicate nodes ok at bottom of hrchy but not in the middle)  tested in W20140404-134522
	// If we already have the proxid, then we don't need it again.
	noDupProx
		:= join(d2(proxid != 0, parent_id != 0), d3v1(proxid != 0),
		        left.src = right.src
		          and left.proxid = right.proxid,
		        transform(left),
		        left only, hash);

	deduped_out :=
	join(
		dedup(sort(noDupProx, proxid, id, parent_id, ultimate_id, src, -dt_last_seen, if(is_sele_level, 0, 1),
		           if(isLegalNameInHeader, 0, 1)),
		      proxid, id, parent_id, ultimate_id, src),
		d3v1,
		left.id = right.id and
		left.src = right.src and
		left.proxid = right.proxid,
		left only,
		hash
	);

	deduped_out_but_ok :=
	join( //one join to clear it at the parent level
		join( //one join to clear it at the ult level
			deduped_out(
				proxid > 0 //no reason to keep a 0 prox when it has a dup id already in there
				,(parent_id > 0 and parent_id <> id) or (ultimate_id > 0 and ultimate_id <> id) //needs a parent for the dups to work
				), 
			dedup(d2, ultimate_id, src, all),
			left.id = right.ultimate_id and
			left.src = right.src,
			left only,
			hash
		),
		dedup(d2, parent_id, src, all),
		left.id = right.parent_id and
		left.src = right.src,
		left only,
		hash
	);

	return d3v1 + deduped_out_but_ok;

END;//HandleDups

END;//PrepSources
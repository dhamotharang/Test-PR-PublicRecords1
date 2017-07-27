import Census_Data, doxie_cbrs, business_header, ut, STD;

export fn_best_information(
  dataset(doxie_cbrs.layout_references) in_group_ids,
	boolean in_use_supergroup
) :=
function
  temp_filter_on_ids := join (in_group_ids, Business_Header.Key_BH_SuperGroup_BDID,
                              left.bdid=right.bdid,
                              transform (right),
                              keep (1), limit (0));
	best_rec := RECORD
		string	bdid; // i know, not a string.
		boolean fromdca := false;
		string8 	dt_last_seen := '';
		qstring120 	company_name := '';
		qstring10 	prim_range := '';
		string2   	predir := '';
		qstring28 	prim_name := '';
		qstring4  	addr_suffix := '';
		string2   	postdir := '';
		qstring5  	unit_desig := '';
		qstring8  	sec_range := '';
		qstring25 	city := '';
		string2   	state := '';
		string5	 	zip := '';
		string4		zip4 := '';
		string15	phone := '';  // International numbers
		string10	fein := '';        
		unsigned1 	best_flags := 0;   // also ok not a string
		boolean 	isCurrent := false;
		boolean 	hasBBB := false;
		unsigned1 	level := 0;
		string60 	msaDesc := '';
		string18 	county_name := '';
		string4  	msa := '';
	END;
	
	best_dca := doxie_cbrs.fn_DCA_records_dayton(in_group_ids,in_use_supergroup);
	
	best_dca_tbl := table(sort(best_dca,root),{root,cnt := count(group)},root);
	
	{best_dca, unsigned cnt} xf_add_cnt(best_dca l, best_dca_tbl r) := transform
	  self.cnt := r.cnt;
		self := l;
	end;
	
	best_dca_cnt := join(best_dca,best_dca_tbl,left.root = right.root,xf_add_cnt(left,right));
	
	best_dca_rec := dedup(group(sort(best_dca_cnt,group_id,-cnt,level,sub),group_id),group_id,left);
	
	best_rec add_msa_county(best_dca_rec L, Census_Data.Key_Fips2County R) := TRANSFORM
		SELF.level := (unsigned1)L.level;
		SELF.company_name := L.name;
		SELF.msaDesc := if(L.msa <> '' and L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
		SELF.county_name := if (L.county <> '', R.county_name, '');
		SELF.msa := if(L.msa <> '0000', L.msa, '');	
		SELF.prim_name := if(L.prim_range = '' and L.predir = '' and 
							 L.prim_name = '' and L.addr_suffix = '' and 
							 L.postdir = '' and L.sec_range = '' and L.unit_desig = '',
							 L.street, L.prim_name);	
		SELF.bdid := (string)l.group_id;
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
		SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, ''); 
		SELF.fromdca := true;
		SELF := L;
	END;
	
	best_dca_rec_trans := JOIN(best_dca_rec,Census_Data.Key_Fips2County,
														KEYED(LEFT.state = RIGHT.state_code and
														LEFT.county[3..5] = RIGHT.county_fips),
														add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1));
														
  temp_filter_on_ids keepl(temp_filter_on_ids l) := transform
	  self := l;
	end;
	
	temp_filter_on_ids_not_in_dca := join(temp_filter_on_ids,best_dca_rec_trans,(string)left.group_id=right.bdid,keepl(left),left only);
	ut.mac_slim_back(temp_filter_on_ids_not_in_dca,doxie_cbrs.layout_references,group_ids_not_in_dca);

	besr :=
		dedup(
			group(
				sort(
					doxie_cbrs.fn_best_records_prs(
						project(
							group_ids_not_in_dca,
							transform(
								doxie_cbrs.layout_supergroup,
								self.level := 0,
								self.group_id := 0,
								self := left)),
						in_use_supergroup)(
						prim_name <> '' and
						zip <> ''),
					group_id,
					-best_flags,
					-dt_last_seen,
					level,
					bdid,
					company_name,
					fein,
					phone,
					prim_name,
					zip),
				group_id),
			group_id,
			left);
	
	best_rec trans_best(besr L) := TRANSFORM
		//SELF.blue_check := false;
		SELF.best_flags := 0;
		SELF.dt_last_seen := (string)L.dt_last_seen;
		SELF.bdid := (string)l.group_id;	
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
		SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, ''); 		
		SELF := L;
	END;
	
	besr_msa := project(besr,trans_best(LEFT));
					
	temp_filter_on_ids_not_in_dca_or_best_rec := join(temp_filter_on_ids_not_in_dca,besr_msa,(string)left.group_id=right.bdid,keepl(left),left only);
	ut.mac_slim_back(temp_filter_on_ids_not_in_dca_or_best_rec,doxie_cbrs.layout_references,group_ids_not_in_dca_or_best_rec);
	
	thebest := doxie_cbrs.fn_getBaseRecs(group_ids_not_in_dca_or_best_rec,in_use_supergroup);  // filters empty addresses
	allr := dedup(group(sort(thebest,group_id,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),group_id),group_id,left);
	best_allr := allr;//choosen(sort(allr,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),1);  //resort just in case
	
	best_rec trim_best(best_allr L) := TRANSFORM
		//SELF.blue_check := false;
		SELF.best_flags := 0;
		SELF.dt_last_seen := (string)L.dt_last_seen;
		SELF.bdid := (string)l.group_id;
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
		SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, ''); 		
		SELF := L;
	END;
	
	best_rec_trimmed := project(best_allr,trim_best(LEFT));
	
	return best_dca_rec_trans +
	       besr_msa +
	       best_rec_trimmed;
	
end;
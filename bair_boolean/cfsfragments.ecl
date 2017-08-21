IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT cfsfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_cfs	:= bair_boolean.constants('').persistfile('cfs');

  bair_data := Bair.files(pUseDelta:=pDelta).cfs_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
	// bair_data := enth(Bair.files(,true,false).cfs_Base.built,10000)(eid not in set(bair_boolean.temp,ExternalKey));
	bair_data1 := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));
	
	cfs_data := Group(sort(bair_data1,eid,-primary_officer),eid);
	cfs_data1 := project(cfs_data,transform(bair_boolean.Layout_Bair_Conv.dbo_cfs_base,
		self.primaryrec 					:= '',						
		SELF.class_code						:= Bair.MapClassCodeNum(2,(string)left.initial_ucr_group),
		SELF.wc_location_type			:= left.location_type,
		SELF.wc_district					:= left.district,
		SELF.wc_beat							:= left.beat,
		SELF.wc_rd								:= left.rd,
		SELF.wc_how_received			:= left.how_received,
		SELF.wc_initial_type			:= left.initial_type,
		SELF.wc_final_type				:= left.final_type,
		SELF.wc_incident_progress	:= left.incident_progress,
		SELF.wc_unit							:= left.unit,
		SELF.agency								:= left.data_provider_name,
	  self := left));
	
	bair_boolean.Layout_Bair_Conv.dbo_cfs_base cfsdata (bair_boolean.Layout_Bair_Conv.dbo_cfs_base l , bair_boolean.Layout_Bair_Conv.dbo_cfs_base r ):= transform
	self.primaryrec :=  IF((l.primary_officer)='', 'PTRU','PFAL');
	self := r; 
	end;
	
	cfs_Base_data := Iterate(cfs_data1,cfsdata(LEFT,RIGHT));
	shared cfs_base := ungroup(cfs_base_data);
	
	// cfs Business
	Layout_cfs_base xd(bair_boolean.Layout_Bair_Conv.dbo_cfs_Base l) := TRANSFORM
		SELF.Geocoded 						:= IF(l.Geocoded ='1','True','False');
		SELF.primary_officer			:= IF(l.primary_officer ='1','True','False');
		SELF.gh12									:= l.gh12;
	  SELF.gh4 									:= l.gh12[1..4];
		SELF.gh5 									:= l.gh12[1..5];
		SELF.gh6 									:= l.gh12[1..6];
		SELF := l;
	END;
	
	SHARED cfs_File := SORT(PROJECT(cfs_Base, xd(LEFT)),eid,-primaryrec,local);
	SHARED cfs_mod := cfs_baseBooleanSearch(cfs_File);
  //
	Layout_AnswerListData xans(Layout_cfs_base l) := TRANSFORM
		SELF.source_doc_type := 'cfs';
		SELF.record_id := l.eid;
		SELF.gh12 := l.gh12;
		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
		SELF.address := l.address;
		//SELF.name := l;
		SELF := l;
	END;
	SHARED cfs_ans_recs := PROJECT(cfs_file, xans(LEFT));
	
	
	// Combine cfs sources
	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_cfs);
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
							:= cfs_mod.SegmentDefinitions;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
							:= cfs_mod.Postings_Doc;
	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= cfs_ans_recs;
END;
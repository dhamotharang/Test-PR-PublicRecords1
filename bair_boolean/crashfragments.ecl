IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT crashfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_crash	:= bair_boolean.constants('').persistfile('crash');

 	bair_data := Bair.files(pUseDelta:=pDelta).crash_Base.built;
 	// bair_data := Bair.files(pUseDelta:=pDelta).crash_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
	// bair_data := enth(Bair.files(,true,false).crash_Base.built,10000)(eid not in set(bair_boolean.temp,ExternalKey));
	
	bair_data1 := DISTRIBUTE(bair_data(eid <> ''),HASH64(eid));

//Crash Persons data for primaryrec field	
	data_persons := group(sort(bair_data1(Per_id<>0),eid,per_id),eid);
	Crash_persons := project(data_persons ,transform(Layout_crash_base, 
																										self.primaryrec := '',	
																										self.age := (STRING) left.age,
																										self.gh12	:= left.gh12,
																										self.gh4 	:= left.gh12[1..4],
																										self.gh5 	:= left.gh12[1..5],
																										self.gh6 	:= left.gh12[1..6],
																										self.class_code	:= Bair.MapClassCodeNum(3,left.crashType), 
																										self.wc_crashtype := left.crashtype, 
																										self.wc_locationtype := left.locationtype, 
																										self.wc_plate := left.plate,
																										self.intersectionRelated := IF(left.intersectionRelated = '1','T','F'),
																										self.hitAndRun := IF(left.hitAndRun ='1','T','F'),
																										self.trafficControlPresent := IF(left.trafficControlPresent ='1','T','F'),
																										self.agency	:= left.data_provider_name,
																										self := left));
	
	Layout_crash_base crashpersons (Layout_crash_base l , Layout_crash_base r ):= transform
	self.primaryrec :=  IF(((string)L.per_id)='0', 'PTRU','PFAL');
	// self.primaryrec :=  IF(((string)L.per_id)='0' AND R.vehicleid != 0, 'PTRU','PFAL');  // Logic to exclude person from primary if not attached to vehicle
	self := r; 
	end;
	
	crashpersons_data := Iterate(Crash_persons,crashpersons(LEFT,RIGHT));
	
//Crash vehicle data for primaryrec field	
	data_vehicle := group(sort(bair_data1(Veh_id<>0),eid,Veh_id),eid);
	Crash_vehicle := project(data_vehicle ,transform(Layout_crash_base, 
																									self.primaryrec := '',
																									self.age := '',
																									self.gh12	:= left.gh12,
																									self.gh4 	:= left.gh12[1..4],
																									self.gh5 	:= left.gh12[1..5],
																									self.gh6 	:= left.gh12[1..6],
																									self.class_code	:= Bair.MapClassCodeNum(3,left.crashType), 
																									self.wc_crashtype := left.crashtype, 
																									self.wc_locationtype := left.locationtype, 
																									self.wc_plate := left.plate,
																									self.towed := IF(left.towed ='1','T','F'),
																									self.intersectionRelated := IF(left.intersectionRelated = '1','T','F'),
																									self.hitAndRun := IF(left.hitAndRun ='1','T','F'),
																									self.trafficControlPresent := IF(left.trafficControlPresent ='1','T','F'),
																									self.agency	:= left.data_provider_name,
																									self := left));
	
  Layout_crash_base crashvehicle (Layout_crash_base l , Layout_crash_base r ):= transform
  self.primaryrec :=  IF(((string)L.veh_id)='0', 'PTRU','PFAL');
  self := r; 
  end;
  
	crashvehicle_data := Iterate(Crash_vehicle,crashvehicle(LEFT,RIGHT));
	
	Crashdata := crashpersons_data + crashvehicle_data;
	
	EXPORT crash_Base := sort(Ungroup(Crashdata),eid,-primaryrec);
	
 	// crash Business
   	SHARED crash_mod := crash_baseBooleanSearch(crash_Base);
     //
   	Layout_AnswerListData xans(Layout_crash_base l) := TRANSFORM
   		SELF.source_doc_type := 'crash';
   		SELF.record_id := l.eid;
   		SELF.gh12 := l.gh12;
   		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
   		SELF.address := l.address;
   		//SELF.name := l;
   		SELF := l;
   	END;
   	SHARED crash_ans_recs := PROJECT(crash_Base, xans(LEFT));
   	
   	
   	// Combine crash sources
   	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_crash);
   	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
   							:= crash_mod.SegmentDefinitions;
   	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
   							:= crash_mod.Postings_Doc;
   	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
							:= crash_ans_recs;   
   END;

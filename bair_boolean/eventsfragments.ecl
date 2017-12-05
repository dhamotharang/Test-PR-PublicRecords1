IMPORT Text_Search, Codes, Header, MDR, bair;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT eventsfragments(Types.StateList st_list=ALL, Boolean pDelta=true) := MODULE
	//SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_events	:= bair_boolean.constants('').persistfile('events');

			mo_file := Bair.files(pUseDelta:=pDelta).mo_Base.built;
			// mo_file := Bair.files(pUseDelta:=pDelta).mo_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
		  mo_base := DISTRIBUTE(mo_file(eid <> '',ir_number<>''),HASH64(eid));
			
			mo		:=	project(mo_base,transform(bair_boolean.layout_events_base, 
								SELF.Property_Value := IF((REAL)left.Property_Value = 0,'0.0',left.Property_Value),   // Convert .0000's to 0.0  
								SELF.companions     := (STRING) left.companions,
								SELF.first_time			:= (STRING) left.first_time,
								SELF.last_time			:= (STRING) left.last_time,
								SELF.sequence				:= (STRING) left.sequence,
								SELF.interval				:= (STRING) left.interval,
								SELF.commonalities	:= (STRING) left.commonalities,
								SELF.age_1					:= '',
								SELF.age_2					:= '',
								SELF.weight_1				:= '',
								SELF.weight_2				:= '',
								SELF.height_1				:= '',
								SELF.height_2				:= '',
								SELF.Geocoded				:= IF(left.Geocoded ='1','True','False'),
								SELF.Raids					:= IF(left.Raids ='1','True','False'),
								SELF.Quarantined		:= IF(left.Quarantined ='1','True','False'),
								SELF.gh12						:= left.gh12,
								self.gh4 						:= left.gh12[1..4],
								self.gh5 						:= left.gh12[1..5],
								self.gh6 						:= left.gh12[1..6],
								self:=left,self:=[]));
			
			mo_udf_file := Bair.files(pUseDelta:=pDelta).mo_udf_Base.built;
			
			mo_udf_base := DISTRIBUTE(mo_udf_file(eid <> ''),HASH64(eid));				
			mo_udf := Sort(mo_udf_base,recordid_raids,ori,fieldid,local);
							
			bair_boolean.layout_events_base Denorm_MO(mo L, mo_udf R, Integer C) := TRANSFORM
				Self.moudf1	:= IF(C=1,R.string_val,L.moudf1);
				Self.moudf2	:= IF(C=2,R.string_val,L.moudf2);
				Self.moudf3	:= IF(C=3,R.string_val,L.moudf3);
				Self.moudf4	:= IF(C=4,R.string_val,L.moudf4);
				Self.moudf5	:= IF(C=5,R.string_val,L.moudf5);
				Self.moudf6	:= IF(C=6,R.string_val,L.moudf6);
				Self.moudf7	:= IF(C=7,R.string_val,L.moudf7);
				Self.moudf8	:= IF(C=8,R.string_val,L.moudf8);
				Self := L;
			END;
			
			persons_file	:= Bair.files(pUseDelta:=pDelta).persons_Base.built;
			// persons_file	:= Bair.files(pUseDelta:=pDelta).persons_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
			persons_base	:= DISTRIBUTE(persons_file(eid <> '',ir_number<>''),HASH64(eid));		
			
			persons			:=	project(persons_base,
															transform(bair_boolean.layout_events_base,
																		SELF.gh12 					:= left.gh12,
																		self.gh4						:= left.gh12[1..4],
																		self.gh5						:= left.gh12[1..5],
																		self.gh6						:= left.gh12[1..6],
																		SELF.age_1 					:= (STRING) left.age_1,
																		SELF.age_2 					:= (STRING) left.age_2,
																		SELF.weight_1 			:= (STRING) left.weight_1,
																		SELF.weight_2 			:= (STRING) left.weight_2,
																		SELF.height_1 			:= (STRING) left.height_1,
																		SELF.height_2 			:= (STRING) left.height_2,
																		SELF.Property_value := '',
																		SELF.companions     := '',
																		SELF.first_time			:= '',
																		SELF.last_time			:= '',
																		SELF.sequence				:= '',
																		SELF.interval				:= '',
																		SELF.commonalities	:= '',
																		self:=left,self:=[]));
									
			persons_udf_file := Bair.files(pUseDelta:=pDelta).persons_udf_Base.built;
			
			persons_udf_base := DISTRIBUTE(persons_udf_file(eid <> ''),HASH64(eid));				
			persons_udf := sort(persons_udf_base,recordid_raids,ori,fieldid,local);	
			
			bair_boolean.layout_events_base Denorm_PER(persons L, persons_udf R, Integer C) := TRANSFORM		
					self.personudf1	:= IF(C=1,R.string_val,L.personudf1);
					self.personudf2	:= IF(C=2,R.string_val,L.personudf2);
					self.personudf3	:= IF(C=3,R.string_val,L.personudf3);
					self.personudf4	:= IF(C=4,R.string_val,L.personudf4);
					self :=L;
			END;
			
			veh_file := Bair.files(pUseDelta:=pDelta).vehicle_Base.built;
			// veh_file := Bair.files(pUseDelta:=pDelta).vehicle_Base.built(eid not in set(bair_boolean.temp,ExternalKey));
				
			veh_data := PROJECT(veh_file,
														TRANSFORM(bair_boolean.layout_events_base,
																		SELF.gh12 					:= left.gh12,
																		self.gh4						:= left.gh12[1..4],
																		self.gh5						:= left.gh12[1..5],
																		self.gh6						:= left.gh12[1..6],
																		SELF.age_1 					:= '',
																		SELF.age_2 					:= '',
																		SELF.weight_1 			:= '',
																		SELF.weight_2 			:= '',
																		SELF.height_1 			:= '',
																		SELF.height_2 			:= '',
																		SELF.Property_value := '',
																		SELF.companions     := '',
																		SELF.first_time			:= '',
																		SELF.last_time			:= '',
																		SELF.sequence				:= '',
																		SELF.interval				:= '',
																		SELF.commonalities	:= '',
																		self:=left,self:=[]));
		
			bair_data := Denormalize(mo,mo_udf,
											left.recordid_raids=right.recordid_raids and
											left.ori = right.ori,
											Denorm_MO(left,right,counter),local)
								+ Denormalize(persons,persons_udf,
											left.recordid_raids=right.recordid_raids and
											left.ori = right.ori,
											Denorm_PER(left,right,counter),local)
								+ veh_data;
																		
      bair_data1 := project(bair_data,transform(bair_boolean.layout_events_base,
																					self.primaryrec						:= IF(left.mostamp=0 and left.personstamp=0 and left.vehiclestamp=0 ,'PTRU','PFAL'),
																					self.class_code 					:= Bair.MapClassCodeNum(1, (string)left.ucr_group),
																					self.wc_crime							:= left.crime,
																					self.wc_location_type			:= left.location_type,
																					self.wc_property_taken_1	:= left.property_taken_1,
																					self.wc_property_taken_2	:= left.property_taken_2,
																					self.wc_property_taken_3	:= left.property_taken_3,
																					self.wc_address_of_crime	:= left.address_of_crime,
																					self.wc_address_name			:= left.address_name,
																					self.wc_beat							:= left.beat,
																					self.wc_rd								:= left.rd,
																					self.wc_plate							:= left.plate,
                                          self.synopsis_of_crime    := Text_Search.rtf2text(left.synopsis_of_crime),
																					Self:=left,self:=[]));
																					
			SHARED events_base := SORT(DISTRIBUTE(bair_data1(eid <> '',ir_number<>''),HASH64(eid)),eid,-primaryrec,LOCAL);
					
			SHARED events_mod := events_baseBooleanSearch(events_Base);

      Layout_AnswerListData xans(Layout_events_base l) := TRANSFORM
         		SELF.source_doc_type := 'events';
         		SELF.record_id := l.eid;
         		SELF.gh12 := l.gh12;
         		SELF.dt_last_seen := (STRING) l.dt_vendor_last_reported;
         		SELF.address := l.address;
         		//SELF.name := l;
         		SELF := l;
         	END;
         	SHARED events_ans_recs := PROJECT(events_Base, xans(LEFT));
         	
         	
         	// Combine mo sources
         	EXPORT DeletePersist := FileServices.DeleteLogicalFile(Persist_events);
         	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions
         							:= events_mod.SegmentDefinitions;
         	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings
         							:= events_mod.Postings_Doc;
         	EXPORT DATASET(bair_boolean.Layout_AnswerListData) answerRecs
         							:= events_ans_recs;


   END;

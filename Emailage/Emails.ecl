import Email_Data, mdr;

fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;

boolean IsFlatRate(unsigned src_set) := 
/*Flat rate*/		fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_IBehavior)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_LT)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_PD)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_AlloyMedia_Consumer))	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_InfutorNare)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_impulse)) 		
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_email));

excludeSet:=['ET'];

uniq_email := DEDUP(SORT(DISTRIBUTE(Email_Data.File_Email_Base(
							did<>0
							,current_rec=true
							,Clean_Email<>''
							,IsFlatRate(email_src_all))
						,hash(did)),
					did, -date_last_seen, clean_email, local),
				did, clean_email, local)(email_src NOT in excludeSet);

demailGrouped := GROUP(uniq_email,did,LOCAL);
demails := PROJECT(demailGrouped
					,TRANSFORM({$.layouts.rEmail, integer counter_ := 0}
						,SELF.LexId := LEFT.did
						,SELF.Email := LEFT.Clean_Email
						,SELF.counter_ := COUNTER + 1
						,SELF:=LEFT;)
						);
demailUngroup := UNGROUP(demails);

EXPORT Emails := JOIN(distribute(demailUngroup(counter_ <= $.Constants.threshold_email_cnt + 1), hash(LexId)), $.AllowedLexids, left.lexid = right.LexId, transform($.layouts.rEmail, self := left), LOCAL);

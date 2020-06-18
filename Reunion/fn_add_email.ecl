import Email_Data, mdr, D2C, D2C_Customers;

fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;

boolean IsFlatRate(unsigned src_set) := 
/*Flat rate*/		fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_IBehavior)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_LT)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_Thrive_PD)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_AlloyMedia_Consumer))	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_InfutorNare)) 	
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_impulse)) 		
/*Flat rate*/		OR			fFlagIsOn(src_set,Email_Data.Translation_Codes.source_bitmap_code(mdr.sourceTools.src_wired_assets_email));

EXPORT fn_add_email(DATASET(reunion.layouts.lMain) src) := FUNCTION

	email := DEDUP(SORT(DISTRIBUTE(Email_Data.File_Email_Base(
							did<>0
							,current_rec=true
							,Clean_Email<>''
							,IsFlatRate(email_src_all)
							,email_src not in D2C.Constants.EmailRestrictedSources //added for D2C
						   	,D2C_Customers.SRC_Allowed.Check(9, email_src)) //added for D2C
						,did),
					did, clean_email, -date_last_seen, local),
				did, clean_email, local);
	main := DISTRIBUTE(src((unsigned6)adl<>0), (unsigned6)adl);

	j := JOIN(main, SORT(email,did,-date_last_seen,local), (unsigned6)left.adl = right.did, 
							TRANSFORM(Reunion.layouts.lEmail,
								self.record_type := 'E';
								self.Email1 := right.Clean_Email;
								self := left;), LEFT OUTER, NOSORT(RIGHT), KEEP(3), LOCAL);
	j2 := GROUP(j, adl, local);

	Reunion.layouts.lEmail xCombine(Reunion.layouts.lEmail L, DATASET(Reunion.layouts.lEmail) allRows) := TRANSFORM
				self.Email1 := allRows[1].Email1;
				self.Email2 := allRows[2].Email1;
				self.Email3 := allRows[3].Email1;
				self := L;
	END;
	j3 := ROLLUP(J2, GROUP, xCombine(LEFT, ROWS(LEFT)));
	
	return j3(email1<>'');

END;

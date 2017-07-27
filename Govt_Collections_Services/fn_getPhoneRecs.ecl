
IMPORT addrbest, progressive_phone, AutoStandardI;

EXPORT fn_getPhoneRecs(dataset(Layouts.batch_working) ds_batch_in,
                       IParams.BatchParams in_mod ) := 
	FUNCTION
		
		// Fulfills _documentation, Req. 4.1.16
		
		// 1. Transform input to progressive_phone.layout_progressive_batch_in.
		data_in := PROJECT( ds_batch_in, Transforms.xfm_to_phones_batchIn(LEFT) );

		// 2. Configure temp mod. For reference, see ERO_Services.fn_addPhone( ).
		tmpMod :=
			MODULE(PROJECT(AutoStandardI.GlobalModule(),progressive_phone.iParam.Batch,OPT))
				EXPORT BOOLEAN ExcludeDeadContacts := FALSE;
				EXPORT BOOLEAN DedupOutputPhones   := TRUE; 
				EXPORT INTEGER MaxPhoneCount       := in_mod.MaxPhoneCount; 
				EXPORT INTEGER CountPP             := in_mod.MaxPhoneCount; // maps to STORED('CountType6_PP_PHONESPLUSSEARCH');
				//EXPORT INTEGER OrderPP             := 1; // maps to STORED('OrderType6_PP_PHONESPLUSSEARCH');
			END;
		
		// 3. Get Phone records.
		ds_phone_recs_pre := addrbest.Progressive_phone_common(data_in,tmpMod);

		// 4. Do a group-denormalize to add phone numbers to the result set, the most recent 
		// phone number first. Return.
		ds_phone_recs_grpd :=
			GROUP( SORT( ds_phone_recs_pre, acctno, -(UNSIGNED)subj_phone_date_last ), acctno );

		Layouts.batch_working 
				xfm_denorm(Layouts.batch_working le, 
				           DATASET(Progressive_Phone.layout_progressive_phone_common) allRows) :=
					TRANSFORM
						SELF.phone_number_1 := allRows[1].subj_phone10,
						SELF.phone_number_2 := allRows[2].subj_phone10,
						SELF.phone_number_3 := allRows[3].subj_phone10,
						SELF := le			
					END;

		ds_phone_recs :=
			DENORMALIZE(
				ds_batch_in, ds_phone_recs_grpd,
				LEFT.acctno = RIGHT.acctno,
				GROUP,
				xfm_denorm(LEFT,ROWS(RIGHT))
			);
			
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_phone_recs_pre, NAMED('ds_phone_intm_recs') ) );
		
		RETURN ds_phone_recs;
		
	END;
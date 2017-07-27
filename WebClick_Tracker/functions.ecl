export functions := MODULE
		export norm_evtlist(set of string45 evtlist = []) := FUNCTION
				rec1 := rECORD
					String45 event;
				END;
						
				OutRec := RECORD
					STRING45 event;
					integer orig_order;
				END;

				OutRec NormIt(set of string45 L, INTEGER C) := TRANSFORM
						SELF.orig_order := C;
						SELF.event := StringLib.StringToUpperCase(L[c]);
				END;
				freq_key := WebClick_Tracker.build_freq;				
				Norm :=NORMALIZE(dataset([{'a'}],rec1),COUNT(evtlist),NormIt(evtlist,COUNTER));
				norm_s := SORT(Norm,event);	
        norm_rec := RECORD
							STRING45 event;
							integer orig_order;
							integer cnt ;
				END;


				norm_rec xfm_norm(norm_s L, recordof(freq_key) R) := TRANSFORM
					SELF.cnt := R.cnt;
					SELF := L;
    		END;
	
				norm_j := JOIN(norm_s,freq_key
												,LEFT.event = RIGHT.evt
												,xfm_norm(LEFT,RIGHT)
												);
												
        norm_f := SORT(norm_j,cnt);	
				OUTPUT(norm_f);
				set of integer i := set(norm_f,orig_order);
				OUTPUT(i);
				RETURN i;													 
		END;
		
		
		export Test_203(inital_values) := MACRO
		
			 IDS_exists := exists(inital_values.company_ID) OR exists(inital_values.App_ID) 
			               OR exists(inital_values.User_ID) OR exists(inital_values.sessionID) 
										 ;
			 
			 yyyy_s := (unsigned6)(inital_values.date_s/10000);
			 yyyy_e := (unsigned6)(inital_values.date_e/10000);
			 mm_s := (unsigned6)(inital_values.date_s/100)%100;
			 mm_e := (unsigned6)(inital_values.date_e/100)%100;
			 
			 date_valid := (exists(inital_values.date_s) AND exists(inital_values.date_e)
			                AND (mm_e-mm_s >0 and mm_e-mm_s <=2) AND (yyyy_s=yyyy_e));
			 freq_rec := RECORD
					string45 evt;
					integer cnt ;
			 END;
			 freq_rec NormIt(set of string45 L,integer6 c) := TRANSFORM
					SELF.evt := TRIM(StringLib.StringToUpperCase(L[c]));
					SELF := [];
			 END;
						
				//Normalised input 
				Norm_evt := NORMALIZE(dataset([{'a',1}],freq_rec),COUNT(inital_values.evtlist),NormIt(inital_values.evtlist,counter));
				ds_freq:=if(inital_values.datasource<>'',
								WebClick_Tracker.build_freq(source=StringLib.StringToUpperCase(inital_values.datasource)),
								WebClick_Tracker.build_freq);
				Evt_freq := JOIN(Norm_evt,ds_freq
									 ,StringLib.StringToUpperCase(LEFT.evt) = StringLib.StringToUpperCase(RIGHT.evt)
									 ,TRANSFORM(freq_rec,SELf := RIGHT));
				min_freq := MIN(Evt_freq,cnt);										 
				
				IF(min_freq >20000000 and NOT IDS_exists and NOT date_valid,FAIL('Search too Broad'));
		ENDMACRO;
				
		


END;


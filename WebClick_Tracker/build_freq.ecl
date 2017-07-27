	
   //read in put key file	
		evt_key := WEbclick_tRAcker.DSIndex.Key_EventID_dis;

    //input intermediate data rec
		in_rec := RECORD
			string1 source;
			string45 evt ;
			integer ord ;
			integer cnt ;
		END;
		
		// group by event and order to avoid dataset too large on thor
		Eds_g_byOrder := GROUP(evt_key,source,event,order);
		//count events of same order
		in_rec xfm_in_rec( recordof(evt_key)  L, DATASET( recordof(evt_key)) R) := TRANSFORM
			self.source := l.source;
			SELF.evt := l.event;
			SELF.ord := L.order;
			SELF.cnt := COUNT(r);
		END;
		Eds_gO_Cnt := TABLE(Eds_g_byOrder,TRANSFORM(in_rec,SELF.evt := event,SELF.ord := order,self.source := source,SELF.cnt := count(group)));

    //int data rec 
		local_rec := RECORD
			string1 source;
			string45 evt;
			integer cnt1 ;
		END;
		
		//group and count events locally
		Eds_g_byEvt := GROUP(Eds_gO_Cnt,source,evt);
		Eds_gE_Local_Cnt := TABLE(Eds_g_byEvt,TRANSFORM(local_rec,SELF.evt := evt,self.source := source,SELF.cnt1 := sum(group,cnt)));
		
		//final data rec
		final_rec := RECORD
			string1 source;
			string45 evt;
			integer cnt ;
		END;
		
		//group and count events locally
		freq_ds_gE := GROUP(SORT(ungroup(Eds_gE_Local_Cnt),source,evt),source,evt);
		freq_out := TABLE(freq_ds_gE,TRANSFORM(final_rec,SELF.evt := evt,self.source := source,SELF.cnt := sum(group,cnt1)));
		
		//Event Frequency Key 
    dist_freq :=distribute(freq_out,hash32(evt));
		map_freq := sort(dist_freq,source,Evt,local);					
		export build_freq := index(map_freq,{source,evt ,cnt},'~thor_data400::key::WebClick::qa::freq_nl');

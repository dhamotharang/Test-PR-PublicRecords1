	evt_key := WEbclick_tRAcker.DSIndex.Key_EventID_dis;

  //input intermediate data rec
	sub_rec := RECORD
		string1 source;
		string45 evt ;
		integer ord ;
	
	END;
		
	// group by event and order to avoid dataset too large on thor
	Eds_g_byOrder := GROUP(evt_key,source,event,order);
	
	in_rec := RECORD
			string1 source;
			string45 evt ;
			//integer ord ;
			//integer cnt ;
		END;
	
	in_rec proj_recs(Eds_g_byOrder l) := transform
		self.source := l.source;
		self.evt := l.event;
		//self.ord := l.order;
	//	self.cnt := 0;
	end;
	Eds_gO_Cnt := project(Eds_g_byOrder,proj_recs(left));
	
		in_rec1 := record
			Eds_gO_Cnt;
			integer cnt := count(group);
		end;
	
	tab_out := table(Eds_gO_Cnt,in_rec1,source,evt,few);
	dist_freq :=distribute(tab_out,hash32(evt));
		map_freq := sort(dist_freq,source,Evt,local);					
		
		export build_freq := index(map_freq,{source,evt ,cnt},'~thor_data400::key::WebClick::qa::freq_nl');

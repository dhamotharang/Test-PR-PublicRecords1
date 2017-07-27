import WebClick_tracker;

export Transforms := MODULE 

	export Layouts.rec_rp xfm_rp(Layouts.rec_freq L, Layouts.rec_freq R) := TRANSFORM
				SELF.event := if(L.event<>'',L.event,R.event);
				SELF.frequency_percent_1 := if(L.event<>'',L.frequency_percent,0);
				SELF.frequency_count_1 := if(L.event<>'',L.frequency_count,0);
				SELF.frequency_percent_2 := if(R.event<>'',R.frequency_percent,0);
				SELF.frequency_count_2 := if(R.event<>'',R.frequency_count,0);
	END;
	export Layouts.SD_Rec xfm_SID(Layouts.SD_Rec L,DSIndex.Key_SessionID_dis R):=transform
			self := r;
			self := l;
	end;

END;	
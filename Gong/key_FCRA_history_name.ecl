import gong, doxie, NID, _Control;

hist_in := Gong.File_History_Full_Prepped_for_FCRA_Keys(trim(name_last)<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

Export key_FCRA_history_name := 
       index(hist_out,
             {string6 dph_name_last := metaphonelib.DMetaPhone1(name_last),
							name_last,
							st,
              string20 p_name_first := NID.PreferredFirstVersionedStr(name_first, NID.version),
							name_first},
             {hist_out},
			if(_Control.ThisEnvironment.Name='Dataland',
		    '~thor40_241::key::gong_history::fcra::qa::name',
		    '~thor_data400::key::gong_history::fcra::qa::name')
		);
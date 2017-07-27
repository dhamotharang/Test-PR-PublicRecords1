import doxie, ut, _Control;

hist_in := File_History_Full_Prepped_for_FCRA_Keys(bdid != 0);
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_FCRA_History_BDID := index(hist_out,{bdid},{hist_out},
			if(_Control.ThisEnvironment.Name='Dataland',
			'~thor40_241::key::gong_history::fcra::qa::bdid',
            ut.foreign_prod + 'thor_data400::key::gong_hist_bdid_' + doxie.Version_SuperKey
			));

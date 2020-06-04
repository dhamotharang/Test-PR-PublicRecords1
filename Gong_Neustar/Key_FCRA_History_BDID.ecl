//######################################################
//## This Key is no longer in FCRA_GongKeys 2/26/2020 ##
//######################################################
Import Data_Services, doxie, ut, _Control, gong;

hist_in := File_History_Full_Prepped_for_FCRA_Keys(bdid != 0);
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export Key_FCRA_History_BDID := index(hist_out,{bdid},{hist_out},
			Data_Services.Data_location.Prefix('Gong_History')+'thor_data400::key::gong_history::fcra::qa::bdid'
			);

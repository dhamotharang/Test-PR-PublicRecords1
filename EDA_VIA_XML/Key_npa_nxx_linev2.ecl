import gong, gong_v2, doxie;

f_gong_in := project(Gong_v2.proc_roxie_keybuild_prep_current(TRIM(phone10)<>''),
                     transform(gong_v2.Layout_bscurrent_raw, self:=left, self := []));

export Key_npa_nxx_linev2 :=  
       index(f_gong_in,
             {string3 npa := phone10[1..3],
		    string3 nxx := phone10[4..6],
		    string4 line := phone10[7..10]},
             {f_gong_in},
		   Gong_v2.thor_cluster + 'key::gongv2_eda_npa_nxx_line_' + doxie.Version_SuperKey);

import ut, cellphone, phonesplus_v2;
				   

export spray_NeustarInputFile(string filedate) := 
function
												
a := fileservices.SprayVariable(_control.IPAddress.bctlpedata10,
                        '/data/hds_2/phonesplus/sources/neustar/data_files/neustar/'+ filedate +'/WIRELINE-TO-WIRELESS-NORANGE.TXT',
                        ,                   // max rec size
                        ',',               // separator
						'\r\n',           // end of rec terminator
                        ,              	 // quotations included
                        'thor400_44', // cluster
                        '~thor400_44::in::cellphones::NeuStar::' + filedate + '::WIRELINE-TO-WIRELESS-NORANGE.TXT',// filename on Thor
                        ,
                        ,
                        ,
                        true,         // overwrite
                        true,        // replicate
                        false       // compress
                   );     


b := fileservices.ClearSuperFile('~thor_data400::base::neustarupdate',false);
	
c := fileservices.AddSuperFile('~thor_data400::base::neustarupdate','~thor400_44::in::cellphones::neustar::'
	+filedate+
	'::wireline-to-wireless-norange.txt',,false,false);
	
d := fileservices.SprayVariable(_control.IPAddress.bctlpedata10,
                        '/data/hds_2/phonesplus/sources/neustar/data_files/neustar/'+ filedate +'/WIRELESS-TO-WIRELINE-NORANGE.TXT',
                        ,                   // max rec size
                        ',',               // separator
						'\r\n',           // end of rec terminator
                        ,              	 // quotations included
                        'thor400_44', // cluster
                        '~thor400_44::in::cellphones::NeuStar::' + filedate + '::WIRELESS-TO-WIRELINE-NORANGE.TXT',// filename on Thor
                        ,
                        ,
                        ,
                        true,         // overwrite
                        true,        // replicate
                        false       // compress
                   );     
		
//----Create Neustar History File		
neustar_in1 := dataset('~thor400_44::in::cellphones::neustar::' + filedate + '::wireline-to-wireless-norange.txt', CellPhone.layoutNeuStar, thor);
neustar_in2 := dataset('~thor400_44::in::cellphones::neustar::' + filedate + '::wireless-to-wireline-norange.txt', CellPhone.layoutNeuStar, thor);
base_f := Phonesplus_v2.File_Neustar_History;

Phonesplus_v2.Layout_Neustar_History t_reformat_history (neustar_in1 le, string file_type) := transform
	self.phone := le.cellphone;
	self.is_land_to_cell := if(file_type = 'LC', true, false);
	self.dt_first_seen := (unsigned)filedate;
	self.dt_last_seen := (unsigned)filedate;
	self.is_current := true;
	end;
	
update_lc := project(neustar_in1, t_reformat_history(left,'LC'));
update_cl := project(neustar_in2, t_reformat_history(left,'CL'));
update_all:= update_lc + update_cl;

Phonesplus_v2.Layout_Neustar_History t_apply_update (update_all le, base_f ri) := transform
	self.dt_first_seen := ut.min2(le.dt_first_seen, ri.dt_first_seen);
	self.dt_last_seen := ut.max2(le.dt_last_seen, ri.dt_last_seen);
	self := le;
end;

apply_update1 := join(distribute(update_all, hash(phone)),
											distribute(base_f(is_current), hash(phone)),
											left.phone = right.phone and 
											left.is_land_to_cell = right.is_land_to_cell,
											t_apply_update(left, right),
											left outer,
											local);



Phonesplus_v2.Layout_Neustar_History t_apply_remove (base_f le, update_all ri) := transform
	self.is_current  := false;
	self := le;
end;

apply_removed := join(distribute(base_f(is_current), hash(phone)),
											distribute(update_all, hash(phone)),
											left.phone = right.phone and 
											left.is_land_to_cell = right.is_land_to_cell,
											t_apply_remove(left, right),
											left only,
											local);

new_base := apply_update1 + apply_removed + base_f(~is_current);

ut.MAC_SF_BuildProcess(new_base,'~thor_data400::base::neustar_history' ,e,3,,true);


return sequential(a,b,c,d, e);
end;

 
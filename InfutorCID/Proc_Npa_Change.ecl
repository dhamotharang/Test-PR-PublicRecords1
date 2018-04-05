import ut;
export Proc_Npa_Change (string date) := function
infcid_input  := infutorcid.File_InfutorCID;
npa_change 		:= infcid_input(orig_telephoneconfidencescore = '7');
infcid_other	:= infcid_input(orig_telephoneconfidencescore <> '7');

Layout_InfutorCID_Npa_Change t_find_npa_change(npa_change le, infcid_other ri) := transform
	self.orig_phone := if(ri.orig_Phone <> '', ri.orig_Phone, '');
	self.old_phone := le.orig_Phone;
	self.dt_first_changed := (unsigned) date;
	self.dt_last_changed := (unsigned) date;
	self := if(ri.orig_Phone <> '', ri, le);
end;


npa_change_f := join(distribute(npa_change, hash(orig_Phone[4..])),
                     distribute(infcid_other, hash(orig_Phone[4..])),
					 left.orig_Phone[4..] = right.orig_Phone[4..] and
					 left.orig_Phone[..3] <> right.orig_Phone[..3] and
					 left.orig_businessname = right.orig_businessname and
					 left.orig_firstname = right.orig_firstname and
					 left.orig_lastname = right.orig_lastname and
					 left.orig_primarystreetname = right.orig_primarystreetname,
    				 t_find_npa_change(left, right),
					 left outer,
					 local);
			 
all_changes := if(nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::infutorcid_npa_changed')) = 0, npa_change_f, InfutorCID.File_npa_change + npa_change_f);

Layout_InfutorCID_Npa_Change t_rollup (all_changes le, all_changes ri) := transform
	self.dt_last_changed := MAX(le.dt_last_changed, ri.dt_last_changed);
	self.dt_first_changed := ut.Min2(le.dt_first_changed, ri.dt_first_changed);
	self := ri;
end;

all_changes_r := rollup(sort(all_changes,record),
					  t_rollup(left, right), record,
					  except dt_last_changed, dt_first_changed);
		 

npa_change_w := output(all_changes_r,,'~thor_data400::base::infutorcid_npa_changed' + date, overwrite,__compressed__);

npa_change_add :=  sequential(npa_change_w,
														 FileServices.StartSuperFileTransaction(),
														 FileServices.ClearSuperFile('~thor_data400::base::infutorcid_npa_changed');
														 FileServices.AddSuperFile('~thor_data400::base::infutorcid_npa_changed','~thor_data400::base::infutorcid_npa_changed' + date ),
														 FileServices.FinishSuperFileTransaction());
					
return npa_change_add ;
end;
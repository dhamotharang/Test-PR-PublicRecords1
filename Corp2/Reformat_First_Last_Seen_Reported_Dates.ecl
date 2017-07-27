corp_fl_20060425  := dataset('thor_data400::in::corporate_direct::20060425::fl::corp_v2',corp2.Layout_Corporate_Direct_Corp_In,flat);
corp_hi_20060428  := dataset('thor_data400::in::corporate_direct::20060428::hi::corp_v2',corp2.Layout_Corporate_Direct_Corp_In,flat);
corp_nc_20060425  := dataset('thor_data400::in::corporate_direct::20060425::nc::corp_v2',corp2.Layout_Corporate_Direct_Corp_In,flat);

cont_fl_20060425  := dataset('thor_data400::in::corporate_direct::20060425::fl::cont_v2',corp2.Layout_Corporate_Direct_Cont_In,flat);
cont_hi_20060428  := dataset('thor_data400::in::corporate_direct::20060428::hi::cont_v2',corp2.Layout_Corporate_Direct_Cont_In,flat);
cont_nc_20060425  := dataset('thor_data400::in::corporate_direct::20060425::nc::cont_v2',corp2.Layout_Corporate_Direct_Cont_In,flat);

dCorp := corp_fl_20060425
       + corp_hi_20060428
	   + corp_nc_20060425
	   ;

dCont := cont_fl_20060425
       + cont_hi_20060428
	   + cont_nc_20060425
	   ;
	   
corp2.Layout_Corp_Base Corp_ReformatDate(dCorp l) := transform
 self.dt_first_seen            := (unsigned4)CheckDate(l.dt_first_seen);
 self.dt_last_seen             := (unsigned4)CheckDate(l.dt_last_seen);
 self.dt_vendor_first_reported := (unsigned4)CheckDate(l.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := (unsigned4)CheckDate(l.dt_vendor_last_reported);
 self.corp_ra_dt_first_seen    := (unsigned4)CheckDate(l.corp_ra_dt_first_seen);
 self.corp_ra_dt_last_seen     := (unsigned4)CheckDate(l.corp_ra_dt_last_seen);
 self := l;
 self := [];
end;

corp2.Layout_Corp_Cont_Base Corp_Cont_ReformatDate(dCont l) := transform
 self.dt_first_seen            := (unsigned4)CheckDate(l.dt_first_seen);
 self.dt_last_seen             := (unsigned4)CheckDate(l.dt_last_seen);
 self := l;
 self := [];
end;

dCorpOut     := project(dCorp,Corp_ReformatDate(left));
dCorpContOut := project(dCont,Corp_Cont_ReformatDate(left));

output(dCorpOut,,'thor_data400::in::corporate_direct::corp2_fl_hi_nc',__compressed__);
output(dCorpContOut,,'thor_data400::in::corporate_direct::cont2_fl_hi_nc',__compressed__);
ds := lssi.File_LSSI_Base;

r1 := record
  ds;
  integer l_recid;
  integer l_xcode;
  integer l_lsttyp;
  integer l_npa;
  integer l_telno;
  integer l_lststy;
  integer l_indent;
  integer l_split;
  integer l_fsn;
  integer l_ftd;
  integer l_lstnm;
  integer l_lstgn;
  integer l_hseno;
  integer l_hsesx;
  integer l_strt;
  integer l_locnm;
  integer l_state;
  integer l_dirtx;
  integer l_zip;
  integer l_spltx;
  integer l_nstel;
  integer l_county;
  integer l_geo_lat;
  integer l_geo_long;
  integer l_geo_acc;
  integer l_siccode;
  integer l_mailable;
end;

r1 t1(ds le) := transform
  self.l_recid    := length(trim(le.recid));
  self.l_xcode    := length(trim(le.xcode));
  self.l_lsttyp   := length(trim(le.lsttyp));
  self.l_npa      := length(trim(le.npa));
  self.l_telno    := length(trim(le.telno));
  self.l_lststy   := length(trim(le.lststy));
  self.l_indent   := length(trim(le.indent));
  self.l_split    := length(trim(le.split));
  self.l_fsn      := length(trim(le.fsn));
  self.l_ftd      := length(trim(le.ftd));
  self.l_lstnm    := length(trim(le.lstnm));
  self.l_lstgn    := length(trim(le.lstgn));
  self.l_hseno    := length(trim(le.hseno));
  self.l_hsesx    := length(trim(le.hsesx));
  self.l_strt     := length(trim(le.strt));
  self.l_locnm    := length(trim(le.locnm));
  self.l_state    := length(trim(le.state));
  self.l_dirtx    := length(trim(le.dirtx));
  self.l_zip      := length(trim(le.zip));
  self.l_spltx    := length(trim(le.spltx));
  self.l_nstel    := length(trim(le.nstel));
  self.l_county   := length(trim(le.county));
  self.l_geo_lat  := length(trim(le.geo_lat));
  self.l_geo_long := length(trim(le.geo_long));
  self.l_geo_acc  := length(trim(le.geo_acc));
  self.l_siccode  := length(trim(le.siccode));
  self.l_mailable := length(trim(le.mailable));
  self            := le;
end;

p1 := project(ds,t1(left));

output(max(p1,l_recid),named('recid'));
output(max(p1,l_xcode),named('xcode'));
output(max(p1,l_lsttyp),named('lsttyp'));
output(max(p1,l_npa),named('npa'));
output(max(p1,l_telno),named('telno'));
output(max(p1,l_lststy),named('lststy'));
output(max(p1,l_indent),named('indent'));
output(max(p1,l_split),named('split'));
output(max(p1,l_fsn),named('fsn'));
output(max(p1,l_ftd),named('ftd'));
output(max(p1,l_lstnm),named('lstnm'));
output(max(p1,l_lstgn),named('lstgn'));
output(max(p1,l_hseno),named('hseno'));
output(max(p1,l_hsesx),named('hsesx'));
output(max(p1,l_strt),named('strt'));
output(max(p1,l_locnm),named('locnm'));
output(max(p1,l_state),named('state'));
output(max(p1,l_dirtx),named('dirtx'));
output(max(p1,l_zip),named('zip'));
output(max(p1,l_splitx),named('splitx'));
output(max(p1,l_nstel),named('nstel'));
output(max(p1,l_county),named('county'));
output(max(p1,l_geo_lat),named('geo_lat'));
output(max(p1,l_geo_long),named('geo_long'));
output(max(p1,l_geo_acc),named('geo_acc'));
output(max(p1,l_siccode),named('siccode'));
output(max(p1,l_mailable),named('mailable'));

r1 := record
 string user_num;
 string first_name;
 string last_name;
 string maiden_name;
 string dob;
 string gender;
 string zip;
end;

ds := dataset('~thor::in::mylife::customer_database',r1,csv(/*heading(1),*/terminator(['\r\n','\n']),separator('\t')));

r2 := record
 ds;
 integer l_user_num;
 integer l_first_name;
 integer l_last_name;
 integer l_maiden_name;
 integer l_dob;
 integer l_gender;
 integer l_zip;
end;

r2 t1(ds le) := transform
 self.l_user_num    := length(trim(le.user_num));
 self.l_first_name  := length(trim(le.first_name));
 self.l_last_name   := length(trim(le.last_name));
 self.l_maiden_name := length(trim(le.maiden_name));
 self.l_dob         := length(trim(le.dob));
 self.l_gender      := length(trim(le.gender));
 self.l_zip         := length(trim(le.zip));
 self               := le;
end;

p1 := project(ds,t1(left));

output(max(p1,l_user_num),named('l_user_num'));
output(max(p1,l_first_name),named('l_first_name'));
output(max(p1,l_last_name),named('l_last_name'));
output(max(p1,l_maiden_name),named('l_maiden_name'));
output(max(p1,l_dob),named('l_dob'));
output(max(p1,l_gender),named('l_gender'));
output(max(p1,l_zip),named('l_zip'));

//export field_lengths := 'todo';
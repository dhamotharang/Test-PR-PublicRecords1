reunion.layouts.l_lssi t1(reunion.reunion_clean le) := transform
 self.orig_recid   := le.orig_vendor_id;
 self.main_adl     := if(le.did<>0,intformat(le.did,12,1),'');
 self.orig_lstnm   := le.orig_last_name;
 self.orig_lstgn   := le.orig_first_name;
 self              := le;
end;

//add back records that were filtered
reunion.layouts.l_lssi t2(reunion.files.file_in_reunion_lssi le) := transform
 self.main_adl      := '';
 self.orig_recid    := stringlib.stringtouppercase(le.rec_id);
 self.orig_xcode    := stringlib.stringtouppercase(le.xcode);
 self.orig_lsttyp   := stringlib.stringtouppercase(le.lsttyp);
 self.orig_npa      := stringlib.stringtouppercase(le.npa);
 self.orig_telno    := stringlib.stringtouppercase(le.telno);
 self.orig_lststy   := stringlib.stringtouppercase(le.lststy);
 self.orig_indent   := stringlib.stringtouppercase(le.indent);
 self.orig_split    := stringlib.stringtouppercase(le.split);
 self.orig_fsn      := stringlib.stringtouppercase(le.fsn);
 self.orig_ftd      := stringlib.stringtouppercase(le.ftd);
 self.orig_lstnm    := stringlib.stringtouppercase(le.lstnm);
 self.orig_lstgn    := stringlib.stringtouppercase(le.lstgn);
 self.orig_hseno    := stringlib.stringtouppercase(le.hseno);
 self.orig_hsesx    := stringlib.stringtouppercase(le.hsesx);
 self.orig_strt     := stringlib.stringtouppercase(le.strt);
 self.orig_locnm    := stringlib.stringtouppercase(le.locnm);
 self.orig_state    := stringlib.stringtouppercase(le.state);
 self.orig_dirtx    := stringlib.stringtouppercase(le.dirtx);
 self.orig_zip      := stringlib.stringtouppercase(le.zip);
 self.orig_spltx    := stringlib.stringtouppercase(le.spltx);
 self.orig_nstel    := stringlib.stringtouppercase(le.nstel);
 self.orig_county   := stringlib.stringtouppercase(le.county);
 self.orig_geolat   := stringlib.stringtouppercase(le.geolat);
 self.orig_geolong  := stringlib.stringtouppercase(le.geolong);
 self.orig_geoacc   := stringlib.stringtouppercase(le.geoacc);
 self.orig_mailable := stringlib.stringtouppercase(le.mailable);
end;

r2 := record
 string rec_id;
 string xcode;
 string lsttyp;
 string npa;
 string telno;
 string lststy;
 string indent;
 string split;
 string fsn;
 string ftd;
 string lstnm;
 string lstgn;
 string hseno;
 string hsesx;
 string strt;
 string locnm;
 string state;
 string dirtx;
 string zip;
 string spltx;
 string nstel;
 string county;
 string geolat;
 string geolong;
 string geoacc;
 string mailable;
end;

raw_file_in_reunion_lssi := dataset('~thor_data400::in::reunion::lssi',r2,csv(quote('"'),/*heading(1),*/terminator(['\r\n','\n'])/*,separator('\t')*/));
 
p1 := project(reunion.reunion_clean(vendor='2'),t1(left));
p2 := project(raw_file_in_reunion_lssi(trim(fsn)='' and trim(lstnm)='' and trim(lstgn)=''),t2(left));

export mapping_reunion_lssi := dedup(p1+p2,all);
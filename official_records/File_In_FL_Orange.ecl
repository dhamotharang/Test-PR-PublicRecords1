import lib_stringlib;

Layouts_Orange.rmblank append2norm(Files_raw.Orange.File_in_raw l) := transform
	self.grantor := trim(l.blank) + ' ' + trim(l.grantor);
	self.grantee := trim(l.grantee) + ' '+ trim(l.blank2);
	self         := l;
end;

dappend := project(Files_raw.Orange.File_in_raw,append2norm(LEFT));

Layout_temp := record
	string cn1;
	string cn2;
	string inter1;
	string inter2;
	Layouts_Orange.rmblank;
	unsigned integer cnt;
	unsigned integer cnt1;
	unsigned integer maxcnt;

end;

Layout_temp tr_temp(dappend l) := transform
	ct1 := length(lib_stringlib.StringLib.StringFilter(l.grantor,',')) + 1;
	ct2 := length(lib_stringlib.StringLib.StringFilter(l.grantee,',')) + 1;

	self.cn1     := '';
	self.cn2     := '';
	self.inter1  := l.grantor;
	self.inter2  := l.grantee;
	self.cnt     := ct1;
  self.cnt1    := ct2;
	self.maxcnt  := if(ct1 > ct2 ,ct1,ct2);
  self         := l;
end;

prenorm := project(dappend,tr_temp(LEFT));

Layout_temp tr_normalize(prenorm l,Integer C) := transform
self.cn1 := map(l.cnt = 1 => l.inter1,
                C = 1 and C < l.cnt  => l.inter1[1..(lib_stringlib.StringLib.StringFind(l.inter1,',',1)-1)],
				 C <> 1 and C <  l.cnt => l.inter1[(lib_stringlib.StringLib.StringFind(l.inter1,',',(C-1))+1)..(lib_stringlib.StringLib.StringFind(l.inter1,',',C)-1)], 
				 C = l.cnt => l.inter1[(lib_stringlib.StringLib.StringFind(l.inter1,',',(C-1))+1)..length(l.inter1)],'');
				
				
self.cn2 := map(l.cnt1 = 1 => l.inter2,
                C = 1 and C < l.cnt1  => l.inter2[1..(lib_stringlib.StringLib.StringFind(l.inter2,',',1)-1)],
				 C <> 1 and C <  l.cnt1 => l.inter2[(lib_stringlib.StringLib.StringFind(l.inter2,',',(C-1))+1)..(lib_stringlib.StringLib.StringFind(l.inter2,',',C)-1)], 
				 C = l.cnt1 => l.inter2[(lib_stringlib.StringLib.StringFind(l.inter2,',',(C-1))+1)..length(l.inter2)],'');
				

self := l;
end;

dnormalize := normalize(prenorm,LEFT.maxcnt,tr_normalize(LEFT,COUNTER));

Layouts_Orange.rmblank Convert2norm(dnormalize l) := transform
self.grantor := trim(l.cn1);
self.grantee := trim(l.cn2);
self := l;
end;

postnorm := project(dnormalize,Convert2norm(LEFT));


Layouts_Orange.Layout_common Convert2direct(postnorm l) := transform
	self.process_date      := '';
  self.book              := lib_stringlib.StringLib.StringFilterOut(l.bookpage[1..lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)-1],'B:');
  self.page              := lib_stringlib.StringLib.StringFilterout(trim(l.bookpage)[lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)..lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)+7],'P:');
  self.recording_date    := trim(l.recording_date);
  self.document_type     := trim(l.document_type);
  self.legal_1           := trim(l.legal_1);
  self.consideration     := trim(l.consideration);
  self.lf                := '';
  self.court_case_number := l.case_number;
  self.party_name        := trim(l.grantor);
  self.party_code        := 'D';
  self.instrument_or_clerk_file_no := trim(l.document_number);
  self := l;
  end;
  
 dwith_direct := project(postnorm,Convert2direct(LEFT));

Layouts_Orange.Layout_common Convert2rev(postnorm l) := transform
 self.process_date                   := '';
  self.book                         := lib_stringlib.StringLib.StringFilterout(trim(l.bookpage)[1..(lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)-1)],'B:');
  self.page                         := lib_stringlib.StringLib.StringFilterout(trim(l.bookpage)[lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)..lib_stringlib.StringLib.StringFind(l.bookpage,'P',1)+7],'P:');
  self.recording_date               := trim(l.recording_date);
  self.document_type                := trim(l.document_type);
  self.legal_1                      := trim(l.legal_1);
  self.consideration                := trim(l.consideration);
  self.lf                           := '';
  self.court_case_number            := l.case_number;
  self.party_name                   := trim(l.grantee);
  self.party_code                   := 'R';
  self.instrument_or_clerk_file_no := trim(l.document_number);
  self := l;
  end;
  
  dwith_reverse := project(postnorm,Convert2rev(LEFT));
  
  combined := dwith_direct + dwith_reverse;
  
export File_In_FL_Orange := sort(combined,instrument_or_clerk_file_no) ( instrument_or_clerk_file_no <> '');


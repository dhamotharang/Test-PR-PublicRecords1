import ut;
export Proc_Oig_KeyBase (string pVersion):= function

in_file:=OIG.oig_did;

OIG.Layouts.KeyBuild Trans_dates(OIG.Layouts.KeyBuild l):=transform
			self.dt_vendor_first_reported	:= pVersion[1..8];
			self.dt_vendor_last_reported	:= pVersion[1..8];
			self.dt_first_seen						:= pVersion[1..8];
			self.dt_last_seen							:= pVersion[1..8];
			self         	  							:= l;
end;

oig_ds:= project(in_file,trans_dates(left));

TrimUpper(string s):= function
	return trim(stringlib.StringToUppercase(s),left,right);
end;

SANCT_dESC:=RECORD
	STRING SANCTYPE;
	STRING250 DESC;
END;

SancTable:=dataset(OIG.Cluster+'lookup::oig::sanctype',SANCT_dESC,CSV(SEPARATOR(['|']), quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

OIG.Layouts.KeyBuild findSanc_desc( OIG.Layouts.KeyBuild l, SANCT_dESC r) := transform
  self. SANCDESC     := r.DESC;
	self         	   	 := l;
end;

joinSanc_desc := join(oig_ds,SancTable,
      								trimUpper(left.SANCTYPE) = trim(right.SANCTYPE,left,right),
      								findSanc_desc(left,right),
      								left outer,lookup):persist(OIG.Cluster+'OIG::Key_base');
return joinSanc_desc;
  
end;
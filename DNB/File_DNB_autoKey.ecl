IMPORT dnb,STANDARD;

Layout_DNB_autokey := record
		unsigned6 bdid := 0;
		string9   duns_number :='';
		string90  business_name :='';
		string10  telephone_number :='';
		standard.Addr_Slim;
	end;

layout_autokey := record
  Layout_DNB_autokey;
  unsigned1 zero := 0;
  string1 blank := '';

  // RR-15382 CCPA Fields added 	
  unsigned4 global_sid:= 0;
  unsigned8 record_sid:= 0;

end;

f1 := DNB.File_DNB_Base;

layout_autokey SetAutoFields (f1 L) := transform
       self.suffix := l.addr_suffix;
       self.z5 := l.zip;
	  self.z4 := l.zip4 ; 
  self := L;
end;

File_DNB_autoKey_1 := PROJECT (f1, SetAutoFields (Left));

layout_autokey SetAutoFields_dba (f1 L) := transform

		self.business_name := l.trade_style;
		self.suffix := l.addr_suffix;
		self.z5 := l.zip;
		self.z4 := l.zip4 ; 
		self :=l;
end;

File_DNB_autoKey_2 := dedup(sort(PROJECT (f1(trade_style<>''), SetAutoFields_dba (Left)),record),record);

layout_autokey SetAutoFields_mail (f1 L) := transform

		self.prim_range :=l.mail_prim_range;
		self.predir :=l.mail_predir;
		self.prim_name :=l.mail_prim_name;
		self.suffix:=l.mail_addr_suffix;
		self.postdir:=l.mail_postdir;
		self.unit_desig:=l.mail_unit_desig;
		self.sec_range:=l.mail_sec_range;
		self.p_city_name:=l.mail_p_city_name;
		self.st:=l.mail_st;
		self.z5:=l.mail_zip;
		self.z4:=l.mail_zip4;
		self :=l;
end;

File_DNB_autoKey_3 := dedup(sort(PROJECT (f1(mail_address<>''), SetAutoFields_mail (Left)),record),record);

layout_autokey SetAutoFields_mail_trade (f1 L) := transform

		self.business_name := l.trade_style;
		self.prim_range :=l.mail_prim_range;
		self.predir :=l.mail_predir;
		self.prim_name :=l.mail_prim_name;
		self.suffix:=l.mail_addr_suffix;
		self.postdir:=l.mail_postdir;
		self.unit_desig:=l.mail_unit_desig;
		self.sec_range:=l.mail_sec_range;
		self.p_city_name:=l.mail_p_city_name;
		self.st:=l.mail_st;
		self.z5:=l.mail_zip;
		self.z4:=l.mail_zip4;
		self :=l;
end;

File_DNB_autoKey_4 := dedup(sort(PROJECT (f1(mail_address<>'' and trade_style<>''), SetAutoFields_mail_trade (Left)),record),record);

EXPORT File_DNB_autoKey :=dedup(sort(File_DNB_autoKey_1 +File_DNB_autoKey_2+File_DNB_autoKey_3+File_DNB_autoKey_4,record),record);

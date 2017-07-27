import dnb,Lib_KeyLib;
#workunit ('name', 'Build DNB Contacts Keys ' + dnb.version);

h := dnb.FILE_DNB_Contacts_keybuild;

MyFields := record
    h.bdid;            // Seisint Business Identifier
	h.did;
	h.duns_number;
	h.fname;
	h.mname;
	h.lname;
    string30 nameasis := KeyLib.CompNameNoSyn(h.company_name);
	string80 cn_all := keyLib.GongDacName(h.company_name);
	string40 pcn_all := keyLib.GongDaphcName(h.company_name);
	string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);	
	string6  dph_lname := metaphonelib.DMetaPhone1(h.lname);

	h.__filepos;
end;
  
t := table(h, MyFields);

BUILDINDEX( t(lfmname <> ''), {lfmname,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'lfmname.key', moxie,overwrite);
BUILDINDEX( t, {dph_lname,fname,mname,lname,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'dph_lname.fname.mname.lname.key', moxie,overwrite);
BUILDINDEX( t(nameasis <> ''), {nameasis,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'nameasis.key', moxie,overwrite);
BUILDINDEX( t, {did,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'did.key', moxie,overwrite);
BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'bdid.key', moxie,overwrite);
BUILDINDEX( t, {duns_number,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'duns_number.key', moxie,overwrite);


// ------------------
// -- KEY #0
// ------------------
cn_rec := record
	string10 cn;
	t.__filepos;
end;

cn_rec Norm_cn(MyFields l, integer C) := transform
	self.cn := choose(C, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],
						l.cn_all[31..40],l.cn_all[41..50],l.cn_all[51..60],
						l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t, 8,Norm_cn(LEFT, COUNTER));

BUILDINDEX(cn_records(cn <> ''), {cn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'cn.key', moxie,overwrite);

// ------------------
// -- KEY #1
// ------------------
pcn_rec := record
	string5 pcn;
	t.__filepos;
end;

pcn_rec Norm_pcn(MyFields l, integer C) := transform
	self.pcn := choose(C, l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],
				l.pcn_all[16..20],l.pcn_all[21..25],l.pcn_all[26..30],
				l.pcn_all[31..35],l.pcn_all[36..40]);
	self := l;
end;

pcn_records := NORMALIZE(t, 8,Norm_pcn(LEFT, COUNTER));

BUILDINDEX(pcn_records(pcn <> ''), {pcn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Contacts + 'pcn.key', moxie,overwrite);
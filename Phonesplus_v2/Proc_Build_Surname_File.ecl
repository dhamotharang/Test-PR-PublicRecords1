import Nid, Address, Gong, ut, Gong_Neustar;

export Proc_build_Surname_file (string pversion):= function
boolean isGoodName(string lname) := LENGTH(TRIM(lname)) > 0 AND TRIM(stringlib.stringfilter(lname,'@.0123456789()"')) = '';
f := Phonesplus_v2.File_Phonesplus_Base(current_rec and in_flag and glb_dppa_flag = '' and glb_dppa_all = '' and isGoodName(lname));

Nid.Mac_CleanFullNames(f, f_clean, OrigName);

overrides := Gong_Neustar.Surname_overrides;
//Map to Gong.File_History_Full_Prepped_for_Keys layout
Gong.layout_historyaid map_common_layout(f_clean l) := transform
	self.filedate	:= (string)l.last_build_date;
	self.listing_type_bus := IF(stringlib.StringFind(l.listingtype, 'B', 1) > 0 ,l.listingtype,'');
	self.listing_type_res := IF(stringlib.StringFind(l.listingtype, 'R', 1) > 0 ,l.listingtype,'');
	self.listing_type_gov	:= IF(stringlib.StringFind(l.listingtype, 'G', 1) > 0 ,l.listingtype,'');
	self.phone10	:= l.cellphone; 
	self.name_prefix	:= l.cln_title;
	self.name_first	:= l.cln_fname;
	self.name_middle	:= l.cln_mname;
	self.name_last	:= l.cln_lname;
	self.name_suffix	:= l.cln_suffix;
	self.listed_name	:= l.OrigName;
	self.did := l.did;
	self.hhid	:= l.hhid;
	self.bdid := l.bdid;
	self.st		:= l.state;
	self.z5		:= l.zip5;
	self.z4		:= l.zip4;
	self.dt_first_seen	:= (string)l.datefirstseen;
	self.dt_last_seen	:= (string)l.datelastseen;
	self.pdid := '';
	self := l;
	self := [];
  end;
	

f_Surname := project(f_clean(nametype='P',OrigName not in overrides,NOT REGEXFIND('\\b(FOR|UNLISTED|UNPUBLISHED|BLOCKED)\\b',OrigName)),map_common_layout(left));
f_Surname_d := dedup(sort(f_Surname, record), all);

ut.MAC_SF_BuildProcess(f_Surname_d,'~thor_data400::base::phonesplusv2_surname',surname_base,2,,true, pversion);



return sequential(surname_base);

end;




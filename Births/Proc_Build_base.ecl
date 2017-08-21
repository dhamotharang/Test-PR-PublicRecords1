import ut, did_add, header_slimsort, address;

EXPORT Proc_Build_base	(
						string pVersion =  Births.Version_Development
						) := 
MODULE

CA_births	:=	Births.File_CA_births;
baseRec		:=	Births.Layout_Births_Base;

didRec		:=	record
				Births.Layout_Births_Base,
	string10	prim_range:='',
	string28	prim_name:='',
	string8		sec_range:='',
	string5		zip:='',
end;

// last_basefile:=dataset('~thor_data400::base::births_father',{Births.Layout_Births_Base,unsigned8 __filepos { virtual(fileposition)}},flat);
// didRec tr_baseRec_to_didRec(last_basefile l) := transform
	// self := l;
// end;
// ds_last_base := project(last_basefile, tr_baseRec_to_didRec(left));

didRec t_clean(CA_births l) := transform
 
 string73 v_pname := address.cleanpersonlfm73(stringlib.stringcleanspaces(l.orig_name_last+', '+l.orig_name_first+' '+l.orig_name_middle));

 self.clean_dob   := l.orig_dob[7..10]+l.orig_dob[1..2]+l.orig_dob[4..6];
 self.title       := v_pname[ 1.. 5];
 self.fname       := v_pname[ 6..25];
 self.mname       := v_pname[26..45];
 self.lname       := v_pname[46..65];
 self.name_suffix := v_pname[66..70];
 self.name_score  := v_pname[71..73];
 self.st          := 'CA';
 self             := l;
end;

p_clean := dedup(project(CA_births, t_clean(left))(fname<>'',lname<>''),all);

matchset := ['A','D','Q','G'];

// did_add.MAC_Match_Flex(	p_clean + ds_last_base
did_add.MAC_Match_Flex(	p_clean
						,matchset					
						,ssn_field
						,clean_dob
						,fname
						,mname
						,lname
						,name_suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,phone
						,DID
						,didRec
						,true
						,DID_Score
						,75
						,DIDfile
						)

baseRec tr_didRec_to_baseRec(DIDfile l) := transform
	self := l;
end;

basefile := project(DIDfile, tr_didRec_to_baseRec(left));

ut.mac_sf_buildprocess(basefile, '~thor_data400::base::births', baseOUT, 2);

export All := baseOUT;

END;
import header;
// sample call
// sel:=[
// '0146CD9999C78E031B'
// ,'0149FEA6C0A9BE4AC5'
// ,'404240000394188' 
// ,'410570000684493'  
// ,'JJLLS0885619428' 
// ];
// EQ_Hist.fn_lookup_vendor_id(sel);

EXPORT fn_lookup_vendor_id(set of string18 pvid=[]) := function

raw_rf:=record
	string15 first_name;
	string15 middle_initial;
	string25 last_name;
	string2  suffix;
	string15 former_first_name;
	string15 former_middle_initial;
	string25 former_last_name;
	string2  former_suffix;
	string15 former_first_name2:='';
	string15 former_middle_initial2:='';
	string25 former_last_name2:='';
	string2  former_suffix2:='';
	string15 aka_first_name;
	string15 aka_middle_initial;
	string25 aka_last_name;
	string2  aka_suffix;
	string57 current_address;
	string20 current_city;
	string2  current_state;
	string5  current_zip;
	string6  current_address_date_reported;
	string57 former1_address;
	string20 former1_city;
	string2  former1_state;
	string5  former1_zip;
	string6  former1_address_date_reported;
	string57 former2_address;
	string20 former2_city;
	string2  former2_state;
	string5  former2_zip;
	string6  former2_address_date_reported;
	string9  ssn;
	string18  cid;
	string1  ssn_confirmed:='';
	string8  birthdate:='';
	string10 phone:='';
	string35 current_occupation_employer:='';
	string35 former_occupation_employer:='';
	string35 former2_occupation_employer:='';
	string35 other_occupation_employer:='';
	string35 other_former_occupation_employer:='';
end;

r:=record
	string18 cid;
	string75 fn { virtual(logicalfilename)};
	raw_rf;
end;

EqFiles0
	:=
	  DATASET('~thor_data400::in::quickhdr_raw',             {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	+ DATASET('~thor_data400::in::quickhdr_raw_father',      {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	+ DATASET('~thor_data400::in::quickhdr_raw_history',     {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	;
EqFiles1
	:=
	DATASET('~thor_data400::in::quickhdr_raw_history_608', {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.old_raw},     THOR)
	;

EqFiles:=project(EqFiles0
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		))
		+
		project(EqFiles1
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		));

return EqFiles(cid in pvid);

end;
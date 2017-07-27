import doxie;

/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
flc8 := FLAccidents.basefile_flcrash8;
//using flcrash input file where washington suppression are being removed.  National input file does not have driver phones.
xpnd_layout := record
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string1 rec_type_8;
	string10 accident_nbr;
	string2 section_no;
	string2 filler;
	string40 carrier_name;
	string40 carrier_address;
	string20 carrier_city;
	string2 carrier_state;
	string9 carrier_zip;
	string8 us_dot_or_icc_id_nums;
	string1 source_or_carrier_info;
	string266 filler3;
  end;
xpnd_layout xpndrecs(flc8 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self 								:= L;
end;

pflc8:= project(flc8,xpndrecs(left));
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.


export key_Ntlcrash8 := index(pflc8
                            ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							,{pflc8}
							,'~thor_data400::key::ntlcrash8_' + doxie.Version_SuperKey);
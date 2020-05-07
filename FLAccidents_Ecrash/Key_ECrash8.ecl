Import Data_Services, doxie,FLAccidents, STD;

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
	string40 accident_nbr;
	string2 section_no;
	string2 filler;
	string40 carrier_name;
	string40 carrier_address;
	string20 carrier_city;
	string2 carrier_state;
	string9 carrier_zip;
	string8 us_dot_or_icc_id_nums;
	string1 source_or_carrier_info;
	string40 orig_accnbr, 
	string266 filler3;
  end;
xpnd_layout xpndrecs(flc8 L) := transform
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.accident_nbr := STD.Str.Filter(l.accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.orig_accnbr := l.accident_nbr; 
self 								:= L;
end;

pflc8:= project(flc8,xpndrecs(left));
//ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;
//National file does not have information pertinent to this layout.  Therefore only passing FL records.

ecrashFile  := FLAccidents_Ecrash.BaseFile;

xpnd_layout xpndecrash(ecrashFile L) := transform

self.rec_type_8						:= '8';
t_accident_nbr 			:= if(l.source_id in ['TF','TM'],L.state_report_number, L.case_identifier);
t_scrub := STD.Str.Filter(t_accident_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);
self.orig_accnbr := t_accident_nbr;
self.carrier_name     := L.Insurance_Company;

self := l; 
self := [];
end; 

pecrash := project(ecrashFile, xpndecrash(left)); 
/*
iyetekFile := FLAccidents_Ecrash.BaseFile_Iyetek ;

xpnd_layout xpndiyetek(iyetekFile L) := transform

self.rec_type_8						:= '8';
t_scrub := STD.Str.Filter(L.state_report_number,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
self.accident_nbr := if(t_scrub in ['UNK', 'UNKNOWN'], 'UNK'+l.incident_id,t_scrub);  
self.orig_accnbr := L.state_report_number; 
self.carrier_name     := L.Insurance_Company;
self := l; 
self := [];
end; 
piyetek := project(iyetekFile, xpndiyetek(left)); 
*/
ptotal :=dedup(pflc8+pecrash,all); 
export key_Ecrash8 := index(ptotal
                            ,{string40 l_acc_nbr := accident_nbr}
							,{ptotal}
							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrash8_' + doxie.Version_SuperKey);
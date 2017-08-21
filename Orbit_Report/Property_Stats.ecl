export Property_stats(getretval) := macro

import ut,LN_PropertyV2,ln_property,Codes,lib_stringlib;

#uniquename(ds_assr0)
#uniquename(ds_deed0)
%ds_assr0% := ln_propertyV2.File_Assessment(state_code in ln_property.valid_states or fips_code in ln_property.valid_fips);
%ds_deed0% := ln_propertyV2.File_Deed(state in ln_property.valid_states or fips_code in ln_property.valid_fips);

#uniquename(ds_assr)
#uniquename(ds_deed)
ln_property.mac_patch_county(%ds_assr0%,state_code,%ds_assr%);
ln_property.mac_patch_county(%ds_deed0%,state,%ds_deed%);

#uniquename(r1)
%r1% := record
 string5  fips;
 string2  st;
 string40 county;
 string4  type_;
 string15 coverage_type;
 string8  date;
end;

#uniquename(t_assr)
%r1% %t_assr%(%ds_assr% le) := transform
 self.fips          := le.fips_code;
 self.st            := le.state_code;
 self.county        := le.county_name;
 self.type_         := 'ASSR';
 self.coverage_type := 'ASSESSED YEAR';
 self.date          := if(le.vendor_source_flag[1]='F',le.tax_year,le.assessed_value_year);
 //self.date          := if(le.tax_year between '1970' and ut.GetDate[1..4],le.tax_year,'');// was already commented
end;

#uniquename(t_deed)
%r1% %t_deed%(%ds_deed% le) := transform

 string8 v_rec_dt := le.recording_date;
 
 self.fips          := le.fips_code;
 self.st            := le.state;
 self.county        := le.county_name;
 self.type_         := if(le.from_file='D','DEED',if(le.from_file='M','MORT','DorM'));
 // self.type_         := if(le.from_file in ['D','M'],le.from_file,'DorM'); // was already commented
 self.coverage_type := 'RECORDING DATE';
 self.date          := if(v_rec_dt between '19700000' and ut.GetDate,v_rec_dt,'');
end;

#uniquename(assr_slim)
#uniquename(deed_slim)
%assr_slim% := project(%ds_assr%,%t_assr%(left));
%deed_slim% := project(%ds_deed%,%t_deed%(left));

#uniquename(concat)
%concat% := %assr_slim%+%deed_slim%;

#uniquename(fips_rec)
%fips_rec% := record
string2  state_alpha;
string2  state_code;
string3  county_code;
string40 county_alpha;
string2  class;
string1  crlf;
end;

#uniquename(fips_lookup)
%fips_lookup% := dedup(dataset('~thor_data400::in::fips_code_lookup',%fips_rec%,flat),state_code,county_code,record);

#uniquename(t_translate)
%r1% %t_translate%(%r1% le, %fips_lookup% ri) := transform
 self.st     := if(trim(le.st)='',ri.state_alpha,le.st);
 self.county := if(trim(le.county)='',ri.county_alpha,le.county);
 self        := le;
end;

#uniquename(j1)
%j1% := join(%concat%,%fips_lookup%,
           left.fips[1..2]=right.state_code and left.fips[3..5]=right.county_code,
		   %t_translate%(left,right),lookup,
	       left outer
		  );

#uniquename(j1_filt)
%j1_filt% := %j1%(date<>'' and st <>'');

#uniquename(combo_rec)
%combo_rec% := record
	string st_county_type := '';
	string mydate := '';
end;

#uniquename(join_recs)
		%combo_rec% %join_recs%(%j1_filt% l,Codes.File_Codes_V3_In r) := transform
			self.st_county_type := trim(r.long_desc)+','+
										stringlib.stringtouppercase(trim(l.county)[1..1])+
										stringlib.stringtolowercase(trim(l.county)[2..])+','
										+map(trim(l.type_) = 'ASSR' => 'Assessor ',
											trim(l.type_) = 'DEED' => 'Deed ',
											trim(l.type_) = 'MORT' => 'Mortgage ',
											'DorM');
										
			self.mydate := trim(l.date);
		end;
		
		#uniquename(join_out)
		%join_out% := join(%j1_filt%(trim(date) <> '' 
							and trim(st) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.st = right.code,
							%join_recs%(left,right),
							left outer,
							lookup);
// getretval := %join_out%;

Orbit_Report.Run_Stats('property',%join_out%,st_county_type,mydate,'emailme','nst',getretval);


endmacro;
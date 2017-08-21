import Liensv2;
import liensv2,codes,ut,lib_fileservices,_Control;
export Liens_stats(getretval) := macro

#uniquename(myds)
%myds% := Liensv2.file_liens_main;

#uniquename(combo_rec)
%combo_rec% := record
	string instate := '';
	string countyname := '';
	string filing_date := '';
end;

#uniquename(proj_combo)
%combo_rec% %proj_combo%(%myds% l) := transform
	self.instate := if(l.filing_state = 'IL','IL',if(l.filing_jurisdiction <> '',l.filing_jurisdiction,l.agency_state));
	self.countyname := l.agency_county;
	self.filing_date := if(l.filing_date <> '',l.filing_date,l.orig_filing_date);
end;

#uniquename(proj_out)
%proj_out% := project(%myds%,%proj_combo%(left));

#uniquename(string_rec)
%string_rec% := record
	string instate := '';
	string filing_date := '';
end;


#uniquename(join_recs)
%string_rec% %join_recs%(%proj_out% l,Codes.File_Codes_V3_In r) := transform
	self.instate := trim(r.long_desc)+if(l.countyname <> '',','+stringlib.stringtouppercase(trim(l.countyname)[1..1])+
										stringlib.stringtolowercase(trim(l.countyname)[2..]),',na');
	self.filing_date := trim(l.filing_date);
end;
		
#uniquename(join_out)
%join_out% := join(%proj_out%(trim(filing_date) <> '' 
							and trim(instate) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.instate = right.code,
							%join_recs%(left,right),
							left outer,
							lookup);



Orbit_Report.Run_Stats('liens',%join_out%,instate,filing_date,'emailme','nst',getretval);


endmacro;
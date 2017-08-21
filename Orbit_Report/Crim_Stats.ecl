
export Crim_Stats(getretval) := macro

import crim_common,census_data,codes,ut,lib_fileservices,_Control;

#uniquename(coffender2)
#uniquename(ctoffenses)
#uniquename(coffenses)
#uniquename(cpoffenses)


%coffender2% := Hygenics_crim.File_Moxie_Crim_Offender2_Dev;
%ctoffenses% := Hygenics_crim.File_Moxie_Court_Offenses_Dev;
%coffenses% := Hygenics_crim.File_Moxie_DOC_Offenses_Dev;
%cpoffenses% := Hygenics_crim.File_Moxie_DOC_Punishment_Dev ;

#uniquename(ct_off_rec)
%ct_off_rec% := record
	%ctoffenses%;
	string county_name := '';
end;

#uniquename(proj_recs)
%ct_off_rec% %proj_recs%(%ctoffenses% l) := transform
	self.county_name := l.court_county;
	self := l;
end;

#uniquename(get_ct_off_cty)
%get_ct_off_cty% := project(%ctoffenses%,%proj_recs%(left));

Orbit_report.Get_Crim_Data(%coffender2%,case_date,orig_state,'case_filing_dt',cfdt,'county_name',false);
Orbit_report.Get_Crim_Data(%ctoffenses%,arr_date,state_origin,'arr_date',arrdt);
Orbit_report.Get_Crim_Data(%get_ct_off_cty%,arr_date,state_origin,'arr_date',arrdt1,'county_name');
Orbit_report.Get_Crim_Data(%ctoffenses%,arr_disp_date,state_origin,'arr_disp_date',arrddt);
Orbit_report.Get_Crim_Data(%ctoffenses%,court_disp_date,state_origin,'court_disp_date',cddt);
Orbit_report.Get_Crim_Data(%ctoffenses%,sent_date,state_origin,'sent_date',sdt);
Orbit_report.Get_Crim_Data(%cpoffenses%,event_dt,vendor,'event_dt',edt);
Orbit_report.Get_Crim_Data(%coffenses%,stc_dt,vendor,'stc_date',stdt);
Orbit_report.Get_Crim_Data(%coffenses%,inc_adm_dt,vendor,'inc_adm_dt',incdt);
Orbit_report.Get_Crim_Data(%cpoffenses%,latest_adm_dt,vendor,'latest_adm_dt',ldt);

#uniquename(myds)

%myds% := cfdt + arrdt + arrdt1 + arrddt + cddt + sdt + edt + stdt + incdt + ldt; 

#uniquename(string_rec)
%string_rec% := record
	string instate := '';
	string filing_date := '';
end;


#uniquename(join_recs)
%string_rec% %join_recs%(%myds% l,Codes.File_Codes_V3_In r) := transform
	self.instate := trim(r.long_desc)+  if(l.county_name <> '',','+stringlib.stringtouppercase(trim(l.county_name)[1..1])+stringlib.stringtolowercase(trim(l.county_name)[2..]),',None')+',' + trim(l.date_type);
	self.filing_date := trim(l.filing_date);
end;
		
#uniquename(join_out)
%join_out% := join(%myds%(trim(filing_date) <> '' 
							and trim(instate) <> ''),
							Codes.File_Codes_V3_In(file_name = 'GENERAL' and field_name = 'STATE_LONG'),
							left.instate = right.code,
							%join_recs%(left,right),
							left outer,
							lookup);

#uniquename(statsretval)
Orbit_Report.Run_Stats('crim',%join_out%,instate,filing_date,'emailme','nst',getretval);

// getretval := %join_out%

// getretval := if ( fileservices.fileexists('~thor_data400::base::crim_offender2_did_' + Crim_Common.Version_Production) and
					// fileservices.fileexists('~thor_data400::base::court_offenses_' + Crim_Common.Version_Production) and
					// fileservices.fileexists('~thor_data400::in::crim_offenses_' + Crim_Common.Version_In_DOC_Offenses) and
					// fileservices.fileexists('~thor_data400::in::crim_punishment_' + Crim_Common.Version_In_DOC_Punishment),
					// %statsretval%,
					// output('One of the crim files dont exist')
					// );

endmacro;
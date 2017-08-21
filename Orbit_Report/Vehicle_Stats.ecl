export Vehicle_stats(getretval) := macro
import vehiclev2,codes,ut,lib_fileservices,_Control;
#uniquename(myds)
%myds% := Vehiclev2.file_vehicleV2_party;

#uniquename(effretval)
#uniquename(ttlretval)

Orbit_report.Get_Crim_Data(%myds%,Reg_Latest_Effective_Date,state_origin,'REG_LATEST_EFFECTIVE_DATE',redt);
Orbit_report.Get_Crim_Data(%myds%,Ttl_Latest_Issue_Date,state_origin,'TITLE_LATEST_ISSUE_DATE',tedt);

#uniquename(myds)

%myds% := redt + tedt; 

#uniquename(string_rec)
%string_rec% := record
	string instate := '';
	string filing_date := '';
end;


#uniquename(join_recs)
%string_rec% %join_recs%(%myds% l,Codes.File_Codes_V3_In r) := transform
	self.instate := regexreplace('None',trim(r.long_desc)+  if(l.county_name <> '',','+stringlib.stringtouppercase(trim(l.county_name)[1..1])+stringlib.stringtolowercase(trim(l.county_name)[2..]),',None')+',' + trim(l.date_type),'Statewide');
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

// Orbit_Report.Run_Stats('vehicle',%myds%,state_origin,Reg_Latest_Effective_Date,'emailme','st',effretval,,'vehicleeff');
// Orbit_Report.Run_Stats('vehicle',%myds%,state_origin,Ttl_Latest_Issue_Date,'emailme','st',ttlretval,,'vehiclettl');

#uniquename(statsretval)
Orbit_Report.Run_Stats('vehicle',%join_out%,instate,filing_date,'emailme','nst',getretval);


//getretval := parallel(effretval,ttlretval);

endmacro;
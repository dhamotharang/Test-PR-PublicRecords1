export Corp_stats(getretval) := macro

import corp2,codes,lib_fileservices,_control,ut;

#uniquename(myds)

%myds% := corp2.Files().Base.Corp.built;

#uniquename(string_rec)
%string_rec% := record
	string instate := '';
	string filing_date := '';
end;

#uniquename(proj_rec)
%string_rec% %proj_rec%(%myds% l) := transform
	self.instate := l.corp_state_origin;//if(l.corp_state_origin <> '',l.corp_state_origin,l.corp_inc_state);
	self.filing_date := l.corp_inc_date;
end;

#uniquename(proj_out)

%proj_out% := project(%myds%,%proj_rec%(left));


Orbit_Report.Run_Stats('corp',%proj_out%,instate,filing_date,'emailme','st',getretval);


endmacro;
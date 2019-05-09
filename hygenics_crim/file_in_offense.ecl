import data_services;

case_types_filter := ['SC - SMALL CLAIMS','FUGITIVE WARRANT','SEALED AT INDICTMENT'];
OR_case_type_keep := ['OF','OFFENSE EXTRADITION','OFFENSE FELONY','OFFENSE INFRACTION',
                      'OFFENSE MISDEMEANOR','OFFENSE OTHER','OFFENSE VIOLATION'];

in_ds :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_offense',
								layout_in_offense,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(casetype, left, right)<>'CIVIL' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);

file_in_Offense_CW  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_offense_cw', hygenics_crim.layout_in_offense,
											 CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
											 (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID') ;

proj_off_cw         := Project(file_in_Offense_CW,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

file_in_Offense_IE  :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_offense_IE', hygenics_crim.layout_in_offense,
												CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
												(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID') ;

proj_off_IE         := Project(file_in_Offense_IE,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));


	in_ds addCtCd(in_ds l):= transform
		self.courtname := l.courtname;
		self := l;
	end;
	
	ds := project(in_ds, addCtCd(left));
	
	ds_filt 	  := ds(statecode in ['FL','MN'] and CaseType not in case_types_filter); 
	ds_remain 	:= ds(statecode in ['OR'] and CaseType in OR_case_type_keep) + ds(statecode not in ['FL','MN','OR'] and CaseType not in case_types_filter);
	
	sort_filt	:= sort(distribute(ds_filt, hash(recordid)), recordid, statecode,   
						-casecomments, -docketnumber, -casenumber,
						-offensedesc, -offensedate, -offensetype,
						-finalrulingdate,local);

	ds rollupDs(sort_filt l, sort_filt r) := transform
		self.initialplea		:= if(l.initialplea = '', r.initialplea, l.initialplea);
		self.finalruling		:= if(l.finalruling = '', r.finalruling, l.finalruling);
		self.finalrulingdate	:= if(l.finalrulingdate < r.finalrulingdate, r.finalrulingdate, l.finalrulingdate);
		self.offensedegree		:= if(l.offensedegree = '', r.offensedegree, l.offensedegree);
		self.fileddate			:= if(l.fileddate = '', r.fileddate, l.fileddate);
		self 					:= l;
	end;
				
	rollupDsOut := ROLLUP(sort_filt,
                        left.recordid = right.recordid and 
						trim(left.statecode) = trim(right.statecode) and 
						trim(left.casecomments) = trim(right.casecomments) and 
						trim(left.docketnumber) = trim(right.docketnumber) and 
						trim(left.casenumber) = trim(right.casenumber) and
						trim(left.offensedesc) = trim(right.offensedesc) and 
						trim(left.offensedate) = trim(right.offensedate) and 
						trim(left.offensetype) = trim(right.offensetype),
						rollupDs(LEFT,right),local);
						
	ds_all := ds_remain() + rollupDSOut()+proj_off_cw+proj_off_IE :INDEPENDENT;
	
export file_in_offense := ds_all;
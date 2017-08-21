import std;

EXPORT Mod_BadDate_Reports(string version = '', boolean nightly = false) := Module
	
	pPrepped := not nightly;
	
	rBadDate := record
		string5 	rectype;
		unsigned4 ori;
		string  	date;		
		unsigned1 len;
		unsigned2 cnt;
	end;
	
	DevList			:=  'debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;';
	ProductList	:= DevList;
	footer			:='</table>';
	
	fnTextOut(pHeader,pBody,pFooter) := FUNCTIONMACRO
		OutText:=
				pHeader
				+trim(rollup(pBody,true
				,transform({pBody}
					,self.x:=trim(left.x)+trim(right.x)
					,self:=left
					))[1].x)
				+pFooter
				;

		RETURN OutText;
	ENDMACRO;
	
	header:=
		'<table border="1">\n'
		+'<caption>'
		+'BAD DATES Report - ' + if(pPrepped, 'IMPORTER - ', 'NIGHTLY - ') + version
		+'</caption>\n'
		+'<tr><td>'
		+'rectype'
		+'</td><td>'
		+'ori'
		+'</td><td>'
		+'date'
		+'</td><td>'
		+'len'
		+'</td><td>'
		+'cnt'
		+'</td></tr>\n'
		;
	mo 	:= bair.Files(,,,pPrepped).event_dbo_mo_input(ir_number	<> '' and quarantined = '0');
	per := bair.Files(,,,pPrepped).event_dbo_persons_input(ir_number	<> '' and quarantined = '0');
	veh := bair.Files(,,,pPrepped).event_dbo_vehicle_input(ir_number	<> '' and quarantined = '0');
	cfs := bair.Files(,,,pPrepped).cfs_dbo_cfs_2_input(event_number	<> '' and quarantined = '0');
	cra	:= bair.Files(,,,pPrepped).crash_dbo_crash_input(case_number	<> '' and quarantined = '0');
	off := bair.Files(,,,pPrepped).offenders_dbo_offender_classification_input(agency_offender_id	<> '');
	
	tmo1:=table(mo(length(trim(first_date_time,left,right)) not in [23,0]),{string5 rectype:='mo',string date:='first_date_time',unsigned4 ori:=ori,unsigned1 len:=length(trim(first_date_time,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(first_date_time,left,right)),few,merge);
	tmo2:=table(mo(length(trim(last_date_time,left,right)) not in [23,0]),{string5 rectype:='mo',string date:='last_date_time',unsigned4 ori:=ori,unsigned1 len:=length(trim(last_date_time,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(last_date_time,left,right)),few,merge);

	tper1:=table(per(length(trim(edit_date,left,right)) not in [23,0]),{string5 rectype:='per',string date:='edit_date',unsigned4 ori:=ori,unsigned1 len:=length(trim(edit_date,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(edit_date,left,right)),few,merge);
	tper2:=table(per(length(trim(raids_activitydate,left,right)) not in [23,0]),{string5 rectype:='per',string date:='raids_activitydate',unsigned4 ori:=ori,unsigned1 len:=length(trim(raids_activitydate,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(raids_activitydate,left,right)),few,merge);

	tveh1:=table(veh(length(trim(edit_date,left,right)) not in [23,0]),{string5 rectype:='veh',string date:='edit_date',unsigned4 ori:=ori,unsigned1 len:=length(trim(edit_date,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(edit_date,left,right)),few,merge);
	tveh2:=table(veh(length(trim(raids_activitydate,left,right)) not in [23,0]),{string5 rectype:='veh',string date:='raids_activitydate',unsigned4 ori:=ori,unsigned1 len:=length(trim(raids_activitydate,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(raids_activitydate,left,right)),few,merge);

	tcfs1:=table(cfs(length(trim(edit_date,left,right)) not in [23,0]),{string5 rectype:='cfs',string date:='edit_date',unsigned4 ori:=ori,unsigned1 len:=length(trim(edit_date,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(edit_date,left,right)),few,merge);
	tcfs2:=table(cfs(length(trim(date_occurred,left,right)) not in [23,0]),{string5 rectype:='cfs',string date:='date_occurred',unsigned4 ori:=ori,unsigned1 len:=length(trim(date_occurred,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(date_occurred,left,right)),few,merge);
	tcfs3:=table(cfs(length(trim(date_time_received,left,right)) not in [23,0]),{string5 rectype:='cfs',string date:='date_time_received',unsigned4 ori:=ori,unsigned1 len:=length(trim(date_time_received,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(date_time_received,left,right)),few,merge);

	tcra:=table(cra(length(trim(report_date,left,right)) not in [23,0]),{string5 rectype:='cra',string date:='report_date',unsigned4 ori:=ori,unsigned1 len:=length(trim(report_date,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(report_date,left,right)),few,merge);

	toff:=table(off(length(trim(classification_date,left,right)) not in [23,0]),{string5 rectype:='off',string date:='classification_date',unsigned4 ori:=ori,unsigned1 len:=length(trim(classification_date,left,right)),unsigned2 cnt:=count(group)},ori,length(trim(classification_date,left,right)),few,merge);

	t := tmo1+tmo2+tper1+tper2+tveh1+tveh2+tcfs1+tcfs2+tcfs3+tcra+toff;
	
	body:=
		table(t,{string x:=
		'<tr><td>'
		+rectype
		+'</td><td>'
		+ori
		+'</td><td>'
		+date
		+'</td><td>'
		+len
		+'</td><td>'
		+cnt
		+'</td></tr>\n'
		});
	
	dummy:='';
	noGo:=sequential(dummy);
	
	EXPORT send :=
		if(count(t) = 0
		,noGo
		,STD.System.Email.SendEmailAttachText(
						ProductList
						,'BAD DATES Report -' + if(pPrepped, 'IMPORTER - ', 'NIGHTLY - ') + version
						,'Attached is a BAD DATES report'
						,fnTextOut(header,body,footer)
						,'text/plain; charset=ISO-8859-3'
						,'BADDATES_Report.html'
						)
		);
End;
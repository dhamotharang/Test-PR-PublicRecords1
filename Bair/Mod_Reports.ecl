EXPORT Mod_Reports := Module

IMPORT _Control,Std,ut;
SHARED DevList:=Bair.email_notification_lists.Coverage_Report_DevList;
SHARED ProductList:=Bair.email_notification_lists.Coverage_Report_ProductList;

SHARED Today:=(STRING8)Std.Date.Today():independent;
SHARED DataProvider:=bair.files(,true,true).DataProvider_base.qa(agencyTypeID in [1,2]);
SHARED footer:='</table>';
SHARED fnLastUpdate(string pFromDate,string pToDate) := function
	FromDate:=STD.Str.FilterOut(pFromDate,'-');
	ToDate:=STD.Str.FilterOut(pToDate,'-');
	RETURN (string5)((integer)ut.DaysApart(FromDate,ToDate));
END;
SHARED fnTextOut(pHeader,pBody,pFooter) := FUNCTIONMACRO
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

SHARED sel:=[
					'10000433'
					,'505'
					,'AKAST0100'
					,'AR0660100'
					,'AZ00700PB'
					,'AZ0072900'
					,'BAIRAdmin'
					,'BAIRHPCC'
					,'CA01900PB'
					,'CA0340000'
					,'CODPD00'
					,'CODPD0000'
					,'FL0100000'
					,'FL05017'
					,'IADPS1300'
					,'KS0460500'
					,'MN06906'
					,'NC03201'
					,'NC0920100'
					,'NJ0061400'
					,'NY04350'
					,'OH0310400'
					,'OH07701'
					,'TN0010300'
					,'TX05701'
					,'TX0570400'
					,'TX22101'
					,'VA1190000'
					,'WATCHSYS'
					,'WI0411600'
					,'10000183'
					,'10000193'
					,'10000433'
					,'AR0660100'
					,'BAIRAdmin'
					,'BAIRHPCC'
					,'FL05017'
					,'MN06906'
					,'OH0310400'
					,'OH07701'
					,'TX05701'
					,'VA04701'
					,'VA0980000'
					,'VA11600'
					]
				;

STRING36  oLogin				:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP			:= Bair._Constant.bair_batchlz;

fCandidates := Bair.Orbit_SOAPCalls.GetCandidates('allagencies_input_prep', 'candidates', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs
(~regexfind('xml',filename));

sptrn:='('
			+'^event'
			+'|^event_mo'
			+'|^event_persons'
			+'|^event_vehicle'
			+'|cfs'
			+'|cfs_officers'
			+'|crash'
			+'|crash_person'
			+'|crash_vehicle'
			+'|offender'
			+'|offender_classification'
			+'|offender_picture'
			+'|lpr'
			+')(_[0-9].*)';

ORBIT_received0:=table(fCandidates,{
				ReceiveDate_:=ReceiveDate[1..10]
				,SourceName
				,Mode:=stringlib.StringToUpperCase(regexreplace('_',regexfind(sptrn,Filename,1,nocase),' '))
				,xml_cnt:=sum(group,if(regexfind('xml',filename),1,0))
				,csv_cnt:=sum(group,if(regexfind('utf8',filename),1,0))
				,total:=count(group)
				,LastReceived:=fnLastUpdate(ReceiveDate[1..10],Today)
				},ReceiveDate[1..10],SourceName,few,merge);

ORBIT_received:=join(ORBIT_received0,DataProvider,left.SourceName=right.data_provider_name,lookup);

header:=
	'<table border="1">\n'

	+'<caption>'
	+'Last Agency Receipt Report'
	+'<p>  ***  See at the top ATACRaids(ACA) agencies that STOPPED sending file to HPCC  ***'
	+'</caption>\n'

	+'<tr><td>'
	+'Line Number'
	+'</td><td>'
	+'ORI'
	+'</td><td>'
	+'Product'
	+'</td><td>'
	+'Receive Date'
	+'</td><td>'
	+'Source Name'
	+'</td><td>'
	+'Mode'
	+'</td><td>'
	+'XML count'
	+'</td><td>'
	+'CSV count'
	+'</td><td>'
	+'Last Received'
	+'</td></tr>\n'
	;

d0:=sort(ORBIT_received,SourceName,Mode,-ReceiveDate_);
d1:=dedup(d0,SourceName,Mode);
d:=sort(d1,AgencyTypeId,-(unsigned)LastReceived,SourceName,Mode);
p:=project(d,transform({integer lnum,d},self.lnum:=counter,self:=left));
body:=
	table(p,{string x:=
	'<tr><td>'
	+lnum
	+'</td><td>'
	+data_provider_ori
	+'</td><td>'
	+case(AgencyTypeId,1 => 'ATACRaids(ACA)',2 =>'RaidsOnline(CCM)',3 =>'WorkstationOnly',4 =>'RocRaids',99 =>'TEST','ERROR')
	+'</td><td>'
	+trim(ReceiveDate_)
	+'</td><td'
	+if(data_provider_ori in sel,' bgcolor="yellow"','')
	+'>'
	+trim(SourceName)
	+'</td><td>'
	+trim(Mode)
	+'</td><td>'
	+trim((string)xml_cnt)
	+'</td><td>'
	+trim((string)csv_cnt)
	+'</td><td>'
	+trim((string)LastReceived)
	+'</td></tr>\n'
	});

EXPORT send_Last_Received :=
	STD.System.Email.SendEmailAttachText(
					DevList
					,'Last Agency Receipt Report'
					,'Attached is a list of the most recently landed agency contributions'
					+'\n\n  ***  See at the top ATACRaids(ACA) agencies that STOPPED sending file to HPCC  ***'
					,fnTextOut(header,body,footer)
					,'text/plain; charset=ISO-8859-3'
					,'Last_Agency_Receipt_Report.html'
					);


f0:=bair.files(,true).mo_base.qa;
d0:=bair.files(,true,true).mo_base.qa;

f := distributed(f0, hash(eid));
d := distributed(d0, hash(eid));

linkflags := 'left.eid = right.eid,left only, local';
bair.MAC_Join(dOut,f,d,linkflags);

t00:=table(dOut,{
				ori
				,data_provider_name
				,earliest_update_:=min(group,dt_vendor_first_reported)
				,last_update_:=max(group,dt_vendor_last_reported)
				,earliest_date_:=min(group,clean_FIRST_DATE)
				,last_date_:=max(group,clean_LAST_DATE)
				,earliest_date_time_:=min(group,clean_FIRST_DATE_time)
				,last_date_time_:=max(group,clean_LAST_DATE_time)
				},eid,data_provider_name,merge,few);

t0:=join(t00,DataProvider,left.data_provider_name=right.data_provider_name,lookup);

t1:=table(t0,{t0
				,earliest_update:=min(group,earliest_update_)
				,last_update:=max(group,last_update_)
				,string8 earliest_date:=min(group,if(earliest_date_=0,99999999,earliest_date_))
				,last__date:=max(group,last_date_)
				,string8 earliest_date_time:=min(group,if(earliest_date_time_=0,99999999,earliest_date_time_))
				,last_date_time:=max(group,last_date_time_)
				,cnt:=count(group)
				},data_provider_name,merge,few):independent;

SHARED summarized_dates:=table(t1,{t1
				,earliestupdate:=fnLastUpdate((string)earliest_update,Today)
				,lastupdate:=fnLastUpdate((string)last_update,Today)
				})
				// ((unsigned)lastupdate<200)
				;

header:=
	'<table border="1">\n'

	+'<caption>'
	+'Detail Coverage Report'
	+'<p>  ***  See at the top ATACRaids(ACA) agencies that STARTED updating most recently ***'
	+'</caption>\n'

	+'<tr><td>'
	+'Line Number'
	+'</td><td>'
	+'Product'
	+'</td><td>'
	+'ORI'
	+'</td><td>'
	+'Source Name'
	+'</td><td>'
	+'Earliest Update'
	+'</td><td>'
	+'Latest Update'
	+'</td><td>'
	+'Event count'
	+'</td><td>'
	+'Days Since Earliest Update'
	+'</td><td>'
	+'Days Since Latest Update'
	+'</td></tr>\n'
	;

s:=sort(summarized_dates((unsigned)lastupdate<200),AgencyTypeId,-earliest_update,-(unsigned)lastupdate,-cnt);
p:=project(s,transform({integer lnum,s},self.lnum:=counter,self:=left));
body:=
	table(p,{string x:=
	'<tr><td>'
	+lnum
	+'</td><td>'
	+case(AgencyTypeId,1 => 'ATACRaids(ACA)',2 =>'RaidsOnline(CCM)',3 =>'WorkstationOnly',4 =>'RocRaids',99 =>'TEST','ERROR')
	+'</td><td>'
	+ori
	+'</td><td'
	+if(data_provider_ori in sel,' bgcolor="yellow"','')
	+'>'
	+trim(data_provider_name)
	+'</td><td>'
	+trim((string)earliest_update)
	+'</td><td>'
	+trim((string)last_update)
	+'</td><td>'
	+trim((string)cnt)
	+'</td><td>'
	+trim((string)earliestupdate)
	+'</td><td>'
	+trim((string)lastupdate)
	+'</td></tr>\n'
	});

EXPORT send_Detail_Coverage :=
	STD.System.Email.SendEmailAttachText(
					DevList
					,'Detail Coverage Report'
					,'Attached is a Detail Coverage Report'
					+'\n\n  ***  See at the top ATACRaids(ACA) agencies that STARTED updating most recently ***'
					,fnTextOut(header,body,footer)
					,'text/plain; charset=ISO-8859-3'
					,'Detail_Coverage_Report.html'
					);

header:=
	'<table border="1">\n'

	+'<caption>'
	+'Coverage Report - Days Since Earliest Update'
	+'<p>  ***  See at the top ATACRaids(ACA) agencies that STARTED updating most recently ***'
	+'</caption>\n'

	+'<tr><td>'
	+'Line Number'
	+'</td><td>'
	+'Product'
	+'</td><td>'
	+'ORI'
	+'</td><td>'
	+'Source Name'
	+'</td><td>'
	+'Event count'
	+'</td><td>'
	+'Days Since Earliest Update'
	+'</td></tr>\n'
	;

s:=sort(summarized_dates((unsigned)lastupdate<200),AgencyTypeId,-earliest_update,data_provider_name);
p:=project(s,transform({integer lnum,s},self.lnum:=counter,self:=left));
body:=
	table(p,{string x:=
	'<tr><td>'
	+lnum
	+'</td><td>'
	+case(AgencyTypeId,1 => 'ATACRaids(ACA)',2 =>'RaidsOnline(CCM)',3 =>'WorkstationOnly',4 =>'RocRaids',99 =>'TEST','ERROR')
	+'</td><td>'
	+ori
	+'</td><td'
	+if(data_provider_ori in sel,' bgcolor="yellow"','')
	+'>'
	+trim(data_provider_name)
	+'</td><td>'
	+trim((string)cnt)
	+'</td><td>'
	+trim((string)earliestupdate)
	+'</td></tr>\n'
	});

EXPORT send_Days_Since_Earliest :=
	STD.System.Email.SendEmailAttachText(
					ProductList
					,'Coverage Report - Days Since Earliest Update'
					,'Attached is a Coverage report - Days Since Earliest Update.'
					+'\n\n  ***  See at the top ATACRaids(ACA) agencies that STARTED updating most recently ***'
					,fnTextOut(header,body,footer)
					,'text/plain; charset=ISO-8859-3'
					,'Coverage_Report_Days_Since_Earliest_Update.html'
					);

header:=
	'<table border="1">\n'

	+'<caption>'
	+'Coverage Report - Days Since Last Update'
	+'<p>  ***  See at the top ATACRaids(ACA) agencies that STOPPED updating  ***'
	+'</caption>\n'

	+'<tr><td>'
	+'Line Number'
	+'</td><td>'
	+'Product'
	+'</td><td>'
	+'ORI'
	+'</td><td>'
	+'Source Name'
	+'</td><td>'
	+'Event count'
	+'</td><td>'
	+'Days Since Last Update'
	+'</td></tr>\n'
	;

s:=sort(summarized_dates((unsigned)lastupdate<200),AgencyTypeId,last_update,data_provider_name);
p:=project(s,transform({integer lnum,s},self.lnum:=counter,self:=left));
body:=
	table(p,{string x:=
	'<tr><td>'
	+lnum
	+'</td><td>'
	+case(AgencyTypeId,1 => 'ATACRaids(ACA)',2 =>'RaidsOnline(CCM)',3 =>'WorkstationOnly',4 =>'RocRaids',99 =>'TEST','ERROR')
	+'</td><td>'
	+ori
	+'</td><td'
	+if(data_provider_ori in sel,' bgcolor="yellow"','')
	+'>'
	+trim(data_provider_name)
	+'</td><td>'
	+trim((string)cnt)
	+'</td><td>'
	+trim((string)lastupdate)
	+'</td></tr>\n'
	});

EXPORT send_Days_Since_Last :=
	STD.System.Email.SendEmailAttachText(
					ProductList
					,'Coverage Report - Days Since Last Update'
					,'Attached is a Coverage report - Days Since Last Update'
					+'\n\n  ***  See at the top ATACRaids(ACA) agencies that STOPPED updating  ***'
					,fnTextOut(header,body,footer)
					,'text/plain; charset=ISO-8859-3'
					,'Coverage_Report_Days_Since_Last_Update.html'
					);

header:=
	'<table border="1">\n'

	+'<caption>'
	+'Incident Coverage Report'
	+'<p>  ***  See at the top ATACRaids(ACA) agencies with OLDEST incident coverage ***'
	+'</caption>\n'

	+'<tr><td>'
	+'Line Number'
	+'</td><td>'
	+'Product'
	+'</td><td>'
	+'ORI'
	+'</td><td>'
	+'Source Name'
	+'</td><td>'
	+'Earliest Incident'
	+'</td><td>'
	+'Latest Incident'
	+'</td></tr>\n'
	;

s:=sort(summarized_dates,AgencyTypeId, earliest_date_time, last_date_time,data_provider_name);
p:=project(s,transform({integer lnum,s},self.lnum:=counter,self:=left))
			(
			(unsigned)earliest_date_time>19000101,(unsigned)last_date_time between 19000101 and Std.Date.Today()
			)	;
body:=
	table(p,{string x:=
	'<tr><td>'
	+lnum
	+'</td><td>'
	+case(AgencyTypeId,1 => 'ATACRaids(ACA)',2 =>'RaidsOnline(CCM)',3 =>'WorkstationOnly',4 =>'RocRaids',99 =>'TEST','ERROR')
	+'</td><td>'
	+ori
	+'</td><td>'
	+trim(data_provider_name)
	+'</td><td>'
	+earliest_date_time[..4]+'-'+earliest_date_time[5..6]+'-'+earliest_date_time[7..]
	+'</td><td>'
	+last_date_time[..4]+'-'+last_date_time[5..6]+'-'+last_date_time[7..]
	+'</td></tr>\n'
	});

EXPORT send_Incident_Coverage :=
	STD.System.Email.SendEmailAttachText(
					DevList
					,'Incident Coverage Report'
					,'Attached is an Incident Coverage Report'
					+'\n\n  ***  See at the top ATACRaids(ACA) agencies with OLDEST incident coverage ***'
					,fnTextOut(header,body,footer)
					,'text/plain; charset=ISO-8859-3'
					,'Detail_Coverage_Report.html'
					);

END;
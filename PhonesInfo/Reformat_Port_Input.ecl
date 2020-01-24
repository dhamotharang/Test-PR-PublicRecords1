#OPTION('multiplePersistInstances',FALSE);

IMPORT Std;
	
	tempLayout := record
		PhonesInfo.Layout_iConectiv.Intermediate;
		integer uniqueid;
		string ocn;
	end;

////////////////////////////////////////////////////////////////////////////////////////////	
//Reformat iConectiv Input File/////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
	
	//Pull Existing iConectiv History w/ Newly Concatenated Daily - LEGACY PORT RECORDS
	dailyICInput 		:= PhonesInfo.File_iConectiv.In_Port_Daily_History(action_code in ['A','U','D'] and porting_dt<>'');

	//Reformat Dates & Add Counter
	tempLayout fixICFile(dailyICInput l, unsigned c):= transform
			init_dt 							:= l.filename[std.str.Find(l.filename, '_init_', 1)+6..std.str.Find(l.filename, '_init_', 1)+20];
			incr_dt 							:= l.filename[std.str.Find(l.filename, 'mid_102_', 1)+8..std.str.Find(l.filename, 'mid_102_', 1)+22];
						
			f_dt_time							:=  stringlib.stringfilter(if(std.str.Find(l.filename, '_init_', 1 ) > 0,
																			PhonesInfo._Functions.fn_FixTimeStamp(init_dt),
																			incr_dt), '0123456789');
					
			f_port_dt							:= stringlib.stringfilter(l.porting_dt, '0123456789');	
				
		self.filename									:= l.filename[stringlib.stringfind(l.filename, 'mid', 1)..stringlib.stringfind(l.filename, '.csv', 1)-1];					
		self.file_dt_time							:= std.str.FindReplace(f_dt_time,'_', '');	
		self.porting_dt								:= f_port_dt;
		self.vendor_first_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');
		self.vendor_last_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');	
		self.port_start_dt						:= f_port_dt;
		self.port_end_dt							:= f_port_dt;
		self.remove_port_dt						:= if(l.action_code = 'D', f_port_dt, '');
		self.groupid 									:= c;
		self.is_ported          			:= if(l.action_code in ['A','U'], true, false);	
		self.ocn											:= '';
		self.uniqueid									:= 0;
		self 													:= l;
	end;

	iConectivInput 	:= project(dailyICInput, fixICFile(left, counter));
	
////////////////////////////////////////////////////////////////////////////////////////////	
//Reformat Telo Input File//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

	//Pull Existing TeloHistory w/ Newly Concatenated Daily - REPLACEMENT PORT RECORDS
	dailyTelo 				:= PhonesInfo.File_Port.In_Port_Daily_History(length((string)tn)=10 and lrn<>0);
	
	dailyTeloAdd			:= dailyTelo(operation<>'D');
	dailyTeloDelAud		:= dailyTelo(operation='D' and trim(DownloadReason) = 'audit-discrepancy');	
	dailyTeloDelOth		:= dedup(sort(distribute(dailyTelo(operation='D' and trim(DownloadReason) <> 'audit-discrepancy'), hash(tn)), tn, lrn, spid, uniqueid, ((string)activationtimestamp)[1..8], -operationtimestamp[1..8], local), tn, local); //Keep Latest Delete		
	
	concatDailyTelo		:= dailyTeloAdd + dailyTeloDelAud + dailyTeloDelOth;	
	
	tempLayout fixTeloFile(concatDailyTelo l, unsigned c):= transform
	
			fn_timeConvert(integer timestamp) := function
														
				reformTimestamp := (string)Std.Date.SecondsToParts(timestamp).year 
																+ intformat(Std.Date.SecondsToParts(timestamp).month, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).day, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).hour, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).minute, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).second, 2, 1);
					
				return reformTimestamp;
				
			end;
			
			f_port_dt		:= stringlib.stringfilter((string)l.activationtimestamp, '0123456789');	
						
		self.filename									:= l.filename[stringlib.stringfind(l.filename, 'npac', 1)..stringlib.stringfind(l.filename, '.csv', 1)-1];					
		self.action_code							:= if(l.operation='M', 
																				if(trim(l.downloadreason)='audit-discrepancy', 'U', 'A'), 
																				l.operation);
		self.country_code							:= ''; 
		self.phone										:= (string)l.tn;		
		self.dial_type								:= '';		
		self.spid											:= '';					
		self.service_type							:= '';	
		self.routing_code							:= (string)l.lrn;	
		self.porting_dt								:= f_port_dt;	
		self.country_abbr							:= '';
		self.file_dt_time							:= stringlib.stringfilter(if(length((string)l.updated)<14,
																														fn_timeConvert(l.updated),
																														(string)l.updated), '0123456789');
		self.vendor_first_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');
		self.vendor_last_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');	
		self.port_start_dt						:= f_port_dt;
		self.port_end_dt							:= f_port_dt;
		self.remove_port_dt						:= if(l.operation='D', f_port_dt, '');
		self.groupid 									:= c;
		self.ocn 											:= l.spid;
		self.uniqueid									:= l.uniqueid;
	end;

	inputTelo 			:= project(concatDailyTelo, fixTeloFile(left, counter));
	
	//Append Spid
	srtCRef 				:= sort(distribute(PhonesInfo.File_Source_Reference.Main, hash(ocn)), ocn, local);
	srtTInput				:= sort(distribute(inputTelo, hash(ocn)), ocn, local);
	
	tempLayout addSpidTr(srtTInput l, srtCRef r):= transform
		self.spid 										:= r.spid;	
		self 													:= l;
	end;
	
	addTSPID 				:= join(srtTInput, srtCRef,
													left.ocn = right.ocn,
													addSpidTr(left, right), left outer, local, keep(1));
	
	teloInput				:= dedup(sort(distribute(addTSPID, hash(phone)), record, local), record, local);
	
////////////////////////////////////////////////////////////////////////////////////////////	
//Concat Input Files////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

	concatRec				:= iConectivInput + teloInput : persist('~thor_data400::persist::port::inputFile'); 

EXPORT Reformat_Port_Input := concatRec : independent;
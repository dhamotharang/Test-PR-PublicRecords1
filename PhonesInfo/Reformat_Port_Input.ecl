#OPTION('multiplePersistInstances',FALSE);
IMPORT Data_services, Std;

//DF-28036: Convert 6-Digit Spids to 4-Character Spids
	
	tempLayout := record
		PhonesInfo.Layout_iConectiv.Intermediate;
		integer uniqueid;
		string ocn;
	end;

////////////////////////////////////////////////////////////////////////////////////////////	
//Reformat iConectiv Input File/////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
	
	//Pull Existing iConectiv History - LEGACY PORT RECORDS
	iConectivInput  := PhonesInfo.File_iConectiv.In_Port_Daily_History_Translated; //DF-28036: One-Time Spid-to-OCN Conversion
	
////////////////////////////////////////////////////////////////////////////////////////////	
//Reformat Telo Input File//////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

	//Pull Existing TeloHistory w/ Newly Concatenated Daily - REPLACEMENT PORT RECORDS
	dailyTelo 				:= PhonesInfo.File_Port.In_Port_Daily_History(length((string)tn)=10 and lrn<>0);
	
	dailyTeloAdd			:= dailyTelo(operation<>'D');
	dailyTeloDelAud		:= dailyTelo(operation='D' and trim(DownloadReason) = 'audit-discrepancy');	
	dailyTeloDelOth		:= dedup(sort(distribute(dailyTelo(operation='D' and trim(DownloadReason) <> 'audit-discrepancy'), hash(tn)), tn, lrn, spid, uniqueid, ((string)activationtimestamp)[1..8], -operationtimestamp[1..8], local), tn, local); //Keep Latest Delete		
	
	concatDailyTelo		:= dailyTeloAdd + dailyTeloDelAud + dailyTeloDelOth;	
	
	tempLayout fixTeloFile(concatDailyTelo l):= transform
	
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
		self.groupid 									:= 0;
		self.ocn 											:= l.spid;
		self.spid											:= l.spid;
		self.uniqueid									:= l.uniqueid;
	end;

	teloInput 			:= project(concatDailyTelo, fixTeloFile(left));
	
////////////////////////////////////////////////////////////////////////////////////////////	
//Concat Input Files////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

	ccRec						:= iConectivInput + teloInput;

	//Add Counter to Concatenated Files
	tempLayout addCtr(ccRec l, unsigned c):= transform
		self.groupid 	:= c;
		self 					:= l;
	end;

	concatRec 			:= project(ccRec, addCtr(left, counter)) : persist('~thor_data400::persist::port::inputFile2'); 

EXPORT Reformat_Port_Input := concatRec : independent;
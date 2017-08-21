// FUNCTION: get start and end time of bankruptcy along with bk main daily count
// 					 despray the file to edata12, automated process on e12 will look for the
//					 desprayed file and push the file to batchtransfer.seisint.com
// PARAMETERS: filetype = used when despraying the file
//						 pstart = true will set the start time
//						 pend = true will set the end time
//						 despray = true will despray the file

import ut,_Control;
EXPORT daily_count_stats_for_banko(string filetype,boolean pstart = false,boolean despray = false, boolean pend = false, string suffix = '') := function
	string_rec := record
		string starttime := '';
		string productname := 'bankruptcy';
		string processname := 'build';
		string records := (string)count(bankruptcyv2.file_bankruptcy_main_v3_daily);
		string filesize := '';
		string endtime := '';
	end;
	
	string datetime := ut.GetDate + ut.getTime();
	
	ds := dataset('~thor::stats::bankruptcy::dailycount::tobanko'+filetype,string_rec,csv,opt);
	
	tabds := table(dataset([{'','','','','',''}],string_rec),string_rec,few);
	
	finalds := if (count(ds) > 0, ds, tabds);
	
	string_rec proj_recs(finalds l) := transform
		self.starttime := if(pstart,datetime[1..4]+'-'+datetime[5..6]+'-'+datetime[7..8]+' '+datetime[9..10]+':'+datetime[11..12]+':'+datetime[13..14],l.starttime);
		//self.records := count(bankruptcyv2.file_bankruptcy_main_v3_daily);
		self.endtime := if (pend, datetime[1..4]+'-'+datetime[5..6]+'-'+datetime[7..8]+' '+datetime[9..10]+':'+datetime[11..12]+':'+datetime[13..14],l.endtime);
		self := l;
	end;
	
	proj_out := project(finalds,proj_recs(left));
	
	createfile :=  sequential(if(~fileservices.fileexists('~thor::stats::bankruptcy::dailycount::tobanko'+filetype),
												fileservices.createsuperfile('~thor::stats::bankruptcy::dailycount::tobanko'+filetype)),
												output(proj_out,,'~thor::stats::bankruptcy::dailycount::tobanko'+filetype+suffix+WORKUNIT,csv,overwrite),
												fileservices.clearsuperfile('~thor::stats::bankruptcy::dailycount::tobanko'+filetype,true),
												fileservices.addsuperfile('~thor::stats::bankruptcy::dailycount::tobanko'+filetype,'~thor::stats::bankruptcy::dailycount::tobanko'+filetype+suffix+WORKUNIT),
												if (despray,
													fileservices.Despray('~thor::stats::bankruptcy::dailycount::tobanko'+filetype,_Control.IPAddress.bctlpedata10,
																'/data/hds_180/bkv3/countstobanko/process/bk_build_'+datetime[5..6]+datetime[7..8]+datetime[1..4]+filetype+'.txt',,,,TRUE))
												);
	return if (_Control.ThisEnvironment.Name = 'Prod_Thor',createfile,output('No Counts'));
end;
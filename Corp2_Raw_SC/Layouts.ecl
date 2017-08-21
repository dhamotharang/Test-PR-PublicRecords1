EXPORT Layouts := module

	export CorpFileLayoutIn 								:= Record
		string 		corpid;
		string 		corpname;
		string 		agentname;
		string 		agentaddress1;
		string 		agentaddress2;
		string		agentcity;
		string 		agentstate;
		string 		agentzip;
		string 		agentzipplus4;
		string 		originalfilingdate;
		string 		effectivefilingdate;
		string 		expirationdate;
		string 		dissolveddate;
		string 		corporationstatus;
		string 		domforcode;
		string 		corptypecode;
		string 		incstate;
		string 		oldcorpid;
		string 		lf;
	end;
	
	export CorpFileLayoutBase 							:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CorpFileLayoutIn;
	end;

	export CorpNameLayoutIn 								:= Record
		string 		corpdbid;
		string 		associatedname;
		string 		associatedtype;
		string 		expirationdt;
		string 		fixedname;
		string 		oldcorpdbid;
		string 		lf;
	end;
	
	export CorpNameLayoutBase 							:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CorpNameLayoutIn;
	end;

	export CorpTXNLayoutIn 									:= Record
		string 		corpdbid;
		string 		fileddate;
		string 		tranid;
		string 		trncomment;
		string 		oldcorpdbid;
		string 		lf;
			
	end;
	
	export CorpTXNLayoutBase 								:= Record
		string1		action_flag;
		unsigned4	dt_first_received;
		unsigned4	dt_last_received;
		CorpTxnLayoutIn;
	end;
	
	export ForgnStateDescLookUpLayoutIn			:= Record,	Maxlength(100)
		string 		code;
		string 		statecode;
		string 		statedesc;
  end;

	export TempCorpFileCorpNameLayoutIn 		:= Record
		CorpFileLayoutIn;
		CorpNameLayoutIn;
	end;
	
	export TempCorpTXNLayout 									:= Record
		CorpTXNLayoutIn;
		string 		corptypecode;
	end;
	
end;	
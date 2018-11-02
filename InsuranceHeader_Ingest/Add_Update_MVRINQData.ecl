IMPORT idl_header, MVR_HistoricalDownloads, ut , InsuranceHeader_PreProcess;

EXPORT Add_Update_MVRINQData(dataset(idl_header.Layout_Header_Link) insHeader) := MODULE

	base_mvrinq_pre 		:= MVR_HistoricalDownloads.Access_Insurance_Header_File.Insurance_Header_Data_All;
	base_mvrinq			    := DEDUP(SORT(DISTRIBUTE(base_mvrinq_pre,HASH(date)),date,first_name,last_name,middle_name,suffix,dln,dob,order_state,rid,LOCAL),date,first_name,last_name,middle_name,suffix,dln,dob,order_state,LOCAL);
	MVRINQ              := IDL_Header.SourceTools.src_ins_mvrinq;
	header_layout 	    := idl_header.Layout_Header_Link;
	
	header_layout xformToIdlLayout(base_mvrinq l) := TRANSFORM		
	
	  zeroDLN := if(ut.isNumeric(l.dln), (integer)l.dln, 1); 

		integer ins_date := (integer)l.date;		
		SELF.dt_first_seen := ins_date;
		SELF.dt_last_seen := ins_date;
		SELF.source_rid := l.rid;
		SELF.fname := l.first_name;
		SELF.lname := l.last_name;
		SELF.mname := l.middle_name;
		SELF.sname := if(regexfind('^[A-Za-z0-9]+$', trim(l.suffix)), l.suffix, '');
		SELF.dl_nbr := if(zeroDLN = 0 or l.dln in set(InsuranceHeader_PreProcess.bad_dln_list, dln), skip, l.dln);//l.dln;
		SELF.dob := (integer)l.dob;
		SELF.dl_state := l.order_state;
		SELF.src := MVRINQ;
		SELF := [];
	END;
	
	base_mvrinq_header     := PROJECT(base_mvrinq, xformToIdlLayout(left))(fname != '' and dob > 0 and dl_nbr != '');

	EXPORT getRecords   := base_mvrinq_header ; 
	
END; 



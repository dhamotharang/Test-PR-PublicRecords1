//Creates file for PRTE keys - Bug#174616

IMPORT ut, PRTE_CSV;
#option('multiplePersistInstances',FALSE);

//string8 version_date	:= '20150410';	//change date to reflect current key build version date

//New Records
ds_status		:= PRTE_CSV.Bankruptcy_Files.status;
ds_comments	:= PRTE_CSV.Bankruptcy_Files.comments;
ds_main			:= PRTE_CSV.Bankruptcy_Files.main;

///////////////////////////////////////////////////////////////////////////////////////////
//Join all files   /////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
	l_status := record, maxLength(10000) 
		string8 status_date;
		string30 status_type;
	end;

	l_comments := record, maxLength(10000) 
		string8 filing_date;
		string30 description;
	end;

//join status to Main
	Layout_Join_Main := record
		PRTE_CSV.BK_Key_Layouts.mainV3;
		dataset(l_status) status;
	end;

	Layout_Join_Main join_Main(ds_main l, ds_status r) := TRANSFORM
	   self.status 			:= row(R,l_status);
	   self            	:= l;
	end;

	jn_Main := JOIN(ds_main
								 ,ds_status
								 ,left.tmsid = right.tmsid
								 ,join_Main(left,right)
								 ,left outer);
				 
	j_Main	:= sort(distribute(jn_Main, hash(tmsid)), tmsid, local);
	
//Join comments
	Layout_Join_AllV2	:= record
		Layout_Join_Main;
		dataset(l_comments) comments;
	end;
								 
	Layout_Join_AllV2 jComment(j_Main L, ds_comments R) := TRANSFORM
		self.comments := row(R,l_comments);
		self := L;
END;

j_AllV3 := join(j_Main, ds_comments,
							left.tmsid = right.tmsid,
							jComment(left,right),left outer);
							
output(count(j_AllV3),named('Join_BK3_Count'));

EXPORT Bankruptcy_main_join := j_AllV3 : persist('~persist::Bankruptcy_main_join');
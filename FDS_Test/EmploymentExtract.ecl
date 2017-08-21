/*			Limit multiple responses to a maximum of five with the best match returned first.  Each multiple should be listed separately but with the same record ID
			Statistics should accompany each file reporting:
			Match rate at each level of match
			Fill rate for each field
			Each record should have a unique record ID
			Names should be parsed out – first|middle|last|company name. 
			Addresses should be parsed out separating street address|secondary address|city|state|ZIP™.
			Dates should be in the format of mmddyyyy

		--Extract is from specific zip codes specified.  It will be in the response layout
*/
import business_header,address,ut,versioncontrol,paw;

export EmploymentExtract(
	 string															pversion
	,dataset(paw.layout.Employment_Out)	pPaw						= paw.file_base
	,set of string											pZipCodes				= ZipcodeSet		
	,boolean														pOverwrite			= true
	,boolean														pCsvout					= true
	,string															pSeparator			= '|'	

) :=
function

	dbh_filter := pPaw(zip in pZipCodes, bdid != 0, did != 0);
	
	lay_temp := record
	Layout_consumer.Response.Employment_Extract;
	unsigned8 bdid;
	unsigned8 did;
	end;
	
	lay_temp tConvert2Response(paw.layout.Employment_Out l,unsigned8 cnt) :=
	transform
	
		self.Record_ID				 := (string)cnt;
			 self.first_Name	 	:= l.fname;
			 self.middle_Name	 	:= l.mname;
			 self.last_Name			:= l.lname;
		self.company_Name		 	 := l.company_name;
		self.tax_ID 					 := l.company_fein;
		self.Title	 	 				 := l.company_title;
		self.Street_Address		 := trim(Address.Addr1FromComponents(
																 l.prim_range
																,l.predir
																,l.prim_name
																,l.addr_suffix
																,l.postdir
																,'',''
															),left,right);
		self.Secondary_Address := trim(Address.Addr1FromComponents(
																 l.unit_desig
																,l.sec_range
																,''
																,''
																,''
																,''
																,''
															),left,right);
		self.City							 := l.city;
		self.State						 := l.state;
		self.Zip_Code					 := l.zip;
		self.phone						 := l.phone;
		self.email							:= l.email_address;
		self.ssn								:= l.ssn;
		self.date_last_reported := if((unsigned)l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen),8,1),'');
		self.date_added				  := if((unsigned)l.dt_first_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_first_seen),8,1),'');
		self.confidence_level	  := if((unsigned)l.score>6, true,false);
		self.did := l.did;
		self.bdid := l.bdid;
		
	end;

	dresponse := project(dbh_filter	,tConvert2Response(left,counter));
	
	dresponse_deduped := dedup(sort(dresponse,(unsigned8)Zip_Code,did,-(unsigned8)(date_last_reported[5..8]+date_last_reported[1..4]))
		, (unsigned8)Zip_Code,did);
	dresponse_ref := project(dresponse_deduped,transform(Layout_consumer.Response.Employment_Extract,self := left));

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Employment_Extract.new										,dresponse_ref	,BuildResponseFile					 ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Employment_Extract.new	 + 'PipeDelimited',dresponse_ref	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	dresponse_forstats := project(dresponse_ref	,transform({Layout_consumer.Response.Employment_Extract,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		Record_ID_CountNonBlank   				:= sum(group,if(dresponse_forstats.Record_ID					<>'',1,0));
		first_Name_CountNonBlank   				:= sum(group,if(dresponse_forstats.first_Name					<>'',1,0));
		middle_Name_CountNonBlank   			:= sum(group,if(dresponse_forstats.middle_Name				<>'',1,0));
		last_Name_CountNonBlank   				:= sum(group,if(dresponse_forstats.last_Name					<>'',1,0));
		Company_Name_CountNonBlank   			:= sum(group,if(dresponse_forstats.Company_Name				<>'',1,0));
		tax_ID_CountNonBlank   						:= sum(group,if(dresponse_forstats.tax_ID 						<>'',1,0));
		title_CountNonBlank   						:= sum(group,if(dresponse_forstats.title 							<>'',1,0));
		Street_Address_CountNonBlank   		:= sum(group,if(dresponse_forstats.Street_Address			<>'',1,0));
		Secondary_Address_CountNonBlank   := sum(group,if(dresponse_forstats.Secondary_Address	<>'',1,0));
		City_CountNonBlank   							:= sum(group,if(dresponse_forstats.City								<>'',1,0));
		State_CountNonBlank   						:= sum(group,if(dresponse_forstats.State							<>'',1,0));
		Zip_Code_CountNonBlank   					:= sum(group,if(dresponse_forstats.Zip_Code						<>'',1,0));
		phone_CountNonBlank   						:= sum(group,if(dresponse_forstats.phone							<>'',1,0));
		email_CountNonBlank   						:= sum(group,if(dresponse_forstats.email							<>'',1,0));
		ssn_CountNonBlank   							:= sum(group,if(dresponse_forstats.ssn								<>'',1,0));
		date_last_reported_CountNonBlank  := sum(group,if(dresponse_forstats.date_last_reported	<>'',1,0));
		date_added_CountNonBlank   				:= sum(group,if(dresponse_forstats.date_added					<>'',1,0));
		confidence_level_CountNonBlank   	:= sum(group,if(dresponse_forstats.confidence_level		=true,1,0));
                                                                       
	end;
	
	dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	return parallel(
		 output('FDS Extract Results Follow'	,named('__'							))
		,BuildResponseFile
		,BuildResponseFilePipe
		,output(dresponse_stats								,named('Employment_Extract_Fill_Rates'))
	);

end;
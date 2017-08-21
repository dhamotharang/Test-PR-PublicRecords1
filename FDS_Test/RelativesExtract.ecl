//Use header.file_relatives (same_lname=true is a relative, false is an associate).  
//Based on documentation what you’re saying makes sense.  Also note that for the extract 
//you’re just returning a count, no data.
// for this extract, looks like I can just filter the relatives file on the zips(since it has zip)
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

export RelativesExtract(
	 string																						pversion
	,dataset(Layout_consumer.Temporary.filerelatives)	prelass					= File_Relatives()
	,set of string																		pZipCodes				= ZipcodeSet		
	,boolean																					pOverwrite			= true
	,boolean																					pCsvout					= true
	,string																						pSeparator			= '|'	

) :=
function

	dbh_filter := prelass(clean_address.zip in pZipCodes);
	
	lay_temp := record
	Layout_consumer.Response.Relatives_Extract;
	unsigned8 did;
	end;
	
	lay_temp tConvert2Response(Layout_consumer.Temporary.filerelatives l,unsigned8 cnt) :=
	transform
	
		self.Record_ID				:= (string)cnt;
		self 									:= l.appended_data;
		self 									:= l;
	end;

	dresponse_deduped := dedup(sort(dbh_filter,(unsigned8)appended_data.Zip_Code,did,did2,-(unsigned8)(appended_data.date_last_reported[5..8]+appended_data.date_last_reported[1..4]))
		, (unsigned8)appended_data.Zip_Code,did,did2);

	dresponse := project(dresponse_deduped	,tConvert2Response(left,counter));
	
	dresponse_ref := project(dresponse,transform(Layout_consumer.Response.Relatives_Extract,self := left));

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Relatives_Extract.new										,dresponse_ref	,BuildResponseFile					 ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.Relatives_Extract.new	 + 'PipeDelimited',dresponse_ref	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	dresponse_forstats := project(dresponse_ref	,transform({Layout_consumer.Response.Relatives_Extract,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		Record_ID_CountNonBlank   											:= sum(group,if(dresponse_forstats.Record_ID																		<>'',1,0));
		first_Name_CountNonBlank   											:= sum(group,if(dresponse_forstats.first_Name																		<>'',1,0));
		middle_Name_CountNonBlank   										:= sum(group,if(dresponse_forstats.middle_Name																	<>'',1,0));
		last_Name_CountNonBlank   											:= sum(group,if(dresponse_forstats.last_Name																		<>'',1,0));
		Alias_fName_CountNonBlank   										:= sum(group,if(dresponse_forstats.Alias_fName																	<>'',1,0));
		Alias_mName_CountNonBlank   										:= sum(group,if(dresponse_forstats.Alias_mName																	<>'',1,0));
		Alias_lName_CountNonBlank   										:= sum(group,if(dresponse_forstats.Alias_lName																	<>'',1,0));
		Street_Address_CountNonBlank   									:= sum(group,if(dresponse_forstats.Street_Address																<>'',1,0));
		Secondary_Address_CountNonBlank 								:= sum(group,if(dresponse_forstats.Secondary_Address														<>'',1,0));
		City_CountNonBlank   														:= sum(group,if(dresponse_forstats.City																					<>'',1,0));
		State_CountNonBlank   													:= sum(group,if(dresponse_forstats.State																				<>'',1,0));
		Zip_Code_CountNonBlank   												:= sum(group,if(dresponse_forstats.Zip_Code																			<>'',1,0));
		phone_CountNonBlank   													:= sum(group,if(dresponse_forstats.phone																				<>'',1,0));
		date_added_CountNonBlank   											:= sum(group,if(dresponse_forstats.date_added																		<>'',1,0));
		date_last_reported_CountNonBlank   							:= sum(group,if(dresponse_forstats.date_last_reported														<>'',1,0));
		date_of_birth_CountNonBlank   									:= sum(group,if(dresponse_forstats.date_of_birth																<>'',1,0));
		deceased_indicator_CountNonBlank   							:= sum(group,if(dresponse_forstats.deceased_indicator							 							= true,1,0));
		count_of_all_relatives_available_CountNonBlank  := sum(group,if((unsigned8)dresponse_forstats.count_of_all_relatives_available	<>0,1,0));
		rel_first_Name_CountNonBlank   									:= sum(group,if(dresponse_forstats.rel_first_Name																<>'',1,0));
		rel_middle_Name_CountNonBlank   								:= sum(group,if(dresponse_forstats.rel_middle_Name															<>'',1,0));
		rel_last_Name_CountNonBlank   									:= sum(group,if(dresponse_forstats.rel_last_Name																<>'',1,0));
		rel_Street_Address_CountNonBlank   							:= sum(group,if(dresponse_forstats.rel_Street_Address														<>'',1,0));
		rel_Secondary_Address_CountNonBlank   					:= sum(group,if(dresponse_forstats.rel_Secondary_Address												<>'',1,0));
		rel_City_CountNonBlank   												:= sum(group,if(dresponse_forstats.rel_City																			<>'',1,0));
		rel_State_CountNonBlank   											:= sum(group,if(dresponse_forstats.rel_State																		<>'',1,0));
		rel_Zip_Code_CountNonBlank   										:= sum(group,if(dresponse_forstats.rel_Zip_Code																	<>'',1,0));
		rel_phone_CountNonBlank   											:= sum(group,if(dresponse_forstats.rel_phone																		<>'',1,0));
                                                                       
	end;
	
	dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	return parallel(
		 output('FDS Relatives Extract Results Follow'	,named('_'							))
		,BuildResponseFile
		,BuildResponseFilePipe
		,output(dresponse_stats								,named('Relatives_Extract_Fill_Rates'))
	);

end;
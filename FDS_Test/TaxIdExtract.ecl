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
import business_header,address,ut,versioncontrol;

laybh := business_header.Layout_BH_Best;

export TaxIdExtract(
	 string					pversion
	,dataset(laybh)	pBusinessHeader = business_header.files().base.business_header_best.qa
	,set of string	pZipCodes				= ZipcodeSet		
	,boolean				pOverwrite			= false
	,boolean				pCsvout					= true
	,string					pSeparator			= '|'	

) :=
function

	dbh_filter := pBusinessHeader(fein != 0, intformat(zip,5,1) in pZipCodes);
	
	Layouts.Response.TaxId_Extract tConvert2Response(laybh l,unsigned8 cnt) :=
	transform
	
		self.Record_ID				 := (string)cnt;
		self.Business_Name		 := l.company_name;
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
		self.Zip_Code					 := if(l.zip != 0,intformat(l.zip,5,1),'');
		self.phone						 := if(l.phone != 0,(string)l.phone,'');
		self.tax_ID 					 := intformat(l.fein,9,1);
		self.last_report_date	 := if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen),8,1),'');
	
	end;

	dresponse := project(dbh_filter	,tConvert2Response(left,counter));
	
	dresponse_deduped := sort(dedup(sort(dresponse,tax_ID), tax_ID,keep 5),(unsigned8)Zip_Code);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.TaxID_Extract.new	,dresponse_deduped			,BuildResponseFile,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.TaxID_Extract.new	 + 'PipeDelimited',dresponse_deduped	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	dresponse_forstats := project(dresponse_deduped	,transform({Layouts.Response.TaxId_Extract,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
		Record_ID_CountNonBlank          := sum(group,if(dresponse_forstats.Record_ID					<>'',1,0));
		Business_Name_CountNonBlank      := sum(group,if(dresponse_forstats.Business_Name			<>'',1,0));
		Street_Address_CountNonBlank     := sum(group,if(dresponse_forstats.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank  := sum(group,if(dresponse_forstats.Secondary_Address	<>'',1,0));
		City_CountNonBlank               := sum(group,if(dresponse_forstats.City							<>'',1,0));
		State_CountNonBlank              := sum(group,if(dresponse_forstats.State							<>'',1,0));
		Zip_Code_CountNonBlank           := sum(group,if(dresponse_forstats.Zip_Code					<>'',1,0));
		phone_CountNonBlank              := sum(group,if(dresponse_forstats.phone							<>'',1,0));
		tax_ID_CountNonBlank             := sum(group,if(dresponse_forstats.tax_ID 						<>'',1,0));
		last_report_date_CountNonBlank   := sum(group,if(dresponse_forstats.last_report_date	<>'',1,0));
                                                                       
	end;
	
	dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	return parallel(
		 output('FDS Extract Results Follow'	,named('__'							))
		,BuildResponseFile
		,BuildResponseFilePipe
		,output(dresponse_stats								,named('Tax_Id_Extract_Fill_Rates'))
	);

end;
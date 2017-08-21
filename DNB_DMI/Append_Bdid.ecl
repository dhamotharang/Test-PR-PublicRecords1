//Assigns DIDs and BDIDs on the passed records
import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2,mdr;
//////////////////////////////////////////////////////////////////////////////////////
// -- function: fAppendBdid
// -- Appends Bdids
//////////////////////////////////////////////////////////////////////////////////////
export Append_Bdid(dataset(Layouts.Base.CompaniesForBIP2) pCompany, dataset(Layouts.Base.contacts) pContact) :=
function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Bdiding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.SlimWithContacts  tSlimForBdiding(Layouts.Base.CompaniesForBIP2 l) :=
	transform

		self.company_name	:= if(l.rawfields.trade_style = '' or (l.rawfields.trade_style <> '' and l.rawfields.parent_duns_number = '' and l.rawfields.ultimate_duns_number = ''),
															Stringlib.StringToUpperCase(l.rawfields.business_name),
															Stringlib.StringToUpperCase(l.rawfields.trade_style));
		self.prim_range		:= l.Clean_address.prim_range		;
		self.prim_name		:= l.Clean_address.prim_name		;
		self.zip5					:= l.Clean_address.zip					;
		self.sec_range		:= l.Clean_address.sec_range		;
		self.state				:= l.Clean_address.st						;
		self.phone				:= l.rawfields.telephone_number									;
		self.bdid					:= 0																		;
		self.bdid_score		:= 0																		;
		self.source_group := IF(l.active_duns_number = 'Y', l.rawfields.duns_number, 'D' + l.rawfields.duns_number + '-' + stringlib.stringtouppercase(l.rawfields.business_name));
		self.fein					:= '';
		self.source				:= MDR.sourceTools.src_Dunn_Bradstreet;
		self 							:= l;
		self							:= [];		
	end;   

	dSlimForBdiding :=  project(pCompany,tSlimForBdiding(left));

	BDID_Matchset := ['A','P'];

	Business_Header.MAC_Source_Match(
		 dSlimForBdiding											// infile
		,dSourceMatchOut											// outfile
		,FALSE																// bool_bdid_field_is_string12
		,bdid																	// bdid_field
		,FALSE																// bool_infile_has_source_field
		,MDR.sourceTools.src_Dunn_Bradstreet	// source_type_or_field
		,TRUE																	// bool_infile_has_source_group
		,source_group													// source_group_field
		,company_name													// company_name_field
		,prim_range														// prim_range_field
		,prim_name														// prim_name_field
		,sec_range														// sec_range_field
		,zip5																	// zip_field
		,TRUE																	// bool_infile_has_phone
		,phone																// phone_field
		,FALSE																// bool_infile_has_fein
		,fein_field														// fein_field
		,TRUE																	// bool_infile_has_vendor_id	= 'false'
		,source_group													// vendor_id_field						= 'vendor_id'
		// ,
		// ,
		// ,BIPV2.xlink_version_set
		// ,rid;
	);
	
	// BIPV2.IDmacros.mac_SelectRecordForXLink(dSourceMatchOut, outfileTryXlink, outfileSkipXlink);
	
	pOutFileTry_dist	:=	distribute(dSourceMatchOut,rid);
						 
	pContactsDeduped	:=	dedup(sort(distribute(pcontact, rid),rid,clean_name.lname,clean_name.fname,clean_name.mname,local),rid,clean_name.lname,clean_name.fname,clean_name.mname,local);
																								 
	dnb_dmi.Layouts.Temporary.SlimWithContacts joinForContacts(	pOutFileTry_dist l, pContactsDeduped r) := transform
		self.lname	:=	r.clean_name.lname;
		self.mname	:=	r.clean_name.mname;
		self.fname	:=	r.clean_name.fname;
		self				:=	l;		
	end;	
	
	joinedWithContacts	:=	join(	pOutFileTry_dist,
																pContactsDeduped,																
																left.rid=right.rid,
																joinForContacts(left,right),
																left outer,
																local
															 );																									 

	Business_Header_SS.MAC_Add_BDID_FLEX(
		 joinedWithContacts										// Input Dataset						
		,BDID_Matchset                        // BDID Matchset what fields to match on           
		,company_name	                        // company_name	              
		,prim_range		                        // prim_range		              
		,prim_name		                        // prim_name		              
		,zip5					                        // zip5					              
		,sec_range		                        // sec_range		              
		,state				                        // state				              
		,phone				                        // phone				              
		,fein_not_used                        // fein              
		,bdid													        // bdid												
		,Layouts.Temporary.SlimWithContacts   // Output Layout 
		,true                                 // output layout has bdid score field?                       
		,bdid_score                           // bdid_score                 
		,dBdidFlexOut                         // Output Dataset 
		,
		,																			// default to use prod version of superfiles
		,																			// default is to hit prod from dataland, and on prod hit prod.
		,BIPV2.xlink_version_set
		,
		,
		,
		,fname
		,mname
		,lname
		,
		,source
		,rid
	  ,true
	);   		
 
	// dBDidOut := outfileSkipXlink + dBdidFlexOut;
	dBDidOut := dBdidFlexOut;
	
	dBDidOut_dist			:= distribute	(dBDidOut(bdid != 0 or DotID != 0 or EmpID != 0 or POWID != 0 or ProxID !=0 or SELEID != 0 or OrgID != 0 or UltID != 0)	,rid);

	pDataset_dist 		:= distribute	(pCompany							,rid													);
 
	dnb_dmi.Layouts.Base.CompaniesForBIP2 tAssignBdids(dnb_dmi.layouts.Base.CompaniesForBIP2 l, dnb_dmi.Layouts.Temporary.SlimWithContacts r) :=
	transform

		self.bdid					:= if(r.bdid 				<> 0, r.bdid				, 0);
		self.bdid_score		:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
		self.Ultid				:= if(r.Ultid 			<> 0, r.Ultid				, 0);
		self.Ultscore			:= if(r.Ultscore		<> 0, r.Ultscore		, 0);
		self.UltWeight		:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
		self.OrgID				:= if(r.OrgID 			<> 0, r.OrgID				, 0);
		self.Orgscore			:= if(r.Orgscore		<> 0, r.Orgscore		, 0);
		self.OrgWeight		:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
		self.ProxID				:= if(r.ProxID 			<> 0, r.ProxID			, 0);
		self.Proxscore		:= if(r.Proxscore		<> 0, r.Proxscore		, 0);
		self.ProxWeight		:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
		self.SELEID				:= if(r.SELEID			<> 0, r.SELEID			,	0);
		self.SELEScore		:= if(r.SELEScore		<> 0, r.SELEScore		,	0);
		self.SELEWeight		:= if(r.SELEWeight	<> 0, r.SELEWeight	,	0);
		self.POWID				:= if(r.POWID 			<> 0, r.POWID				, 0);
		self.POWscore			:= if(r.POWscore		<> 0, r.POWscore		, 0);
		self.POWWeight		:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
		self.EmpID				:= if(r.EmpID 			<> 0, r.EmpID				, 0);
		self.Empscore			:= if(r.Empscore		<> 0, r.Empscore		, 0);
		self.EmpWeight		:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
		self.DotID				:= if(r.DotID 			<> 0, r.DotID				, 0);
		self.Dotscore			:= if(r.Dotscore		<> 0, r.Dotscore		, 0);
		self.DotWeight		:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
		self 							:= l;
		//self							:= r;
	end;

	dAssignBdids := join(
										 pDataset_dist
										,dBDidOut_dist
										,left.rid = right.rid
										,tAssignBdids(left, right)
										,left outer
										,local
										);
	
	return dAssignBdids;

end; 

import corp2, Corp2_Raw_DC, Corp2_Mapping;

#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 thor patches ');
#workunit('priority','high');
#workunit('priority',12);
#option('activitiesPerCpp', 50);

pversion		 :=	'20160715z'; //new version of data
filterSet		 := ['DC'];  

state_origin := 'DC';
state_fips	 := '11';	
state_desc	 := 'DISTRICT OF COLUMBIA';

domestic_list		:= ['ACT OF CONGRESS CORPORATION DOMESTIC','FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT','FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL','GENERAL PARTNERSHIP DOMESTIC','LIMITED COOPERATIVE ASSOCIATION DOMESTIC',
										'LIMITED LIABILITY COMPANY DOMESTIC','LIMITED LIABILITY PARTNERSHIP DOMESTIC','LIMITED PARTNERSHIP DOMESTIC','NON-PROFIT CORPORATION DOMESTIC',
										'PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC PROFESSIONAL','STATUTORY TRUST DOMESTIC','TRADE NAME DOMESTIC'];
																			
foreign_list		:= ['ACT OF CONGRESS CORPORATION FOREIGN','FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT','FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL','LIMITED LIABILITY COMPANY FOREIGN',
										'LIMITED LIABILITY PARTNERSHIP FOREIGN','LIMITED PARTNERSHIP FOREIGN','NON-PROFIT CORPORATION FOREIGN','STATUTORY TRUST FOREIGN',
										'GENERAL COOPERATIVE FOREIGN NON-PROFIT','GENERAL COOPERATIVE ASSOCIATION FOREIGN','NON-PROFIT CORPORATION FOREIGN NON-PROFIT','FOR-PROFIT CORPORATION FOREIGN' ];
																									
profit_list 		:= ['FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT', 'FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL','FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT','FOR-PROFIT CORPORATION FOREIGN',
										'FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL'];
										
Nonprofit_list	:= ['NON-PROFIT CORPORATION DOMESTIC', 'NON-PROFIT CORPORATION FOREIGN','NON-PROFIT CORPORATION FOREIGN NON-PROFIT'];				
		

dsCurrentCorp			:=	corp2.files().Base_xtnd.corp.qa: independent; // Current QA superfile for corp file
//dsCurrentCorp			:=	dataset('~thor_data400::base::corp2::20160319::corp_xtnd',Corp2.layout_corporate_direct_corp_base_expanded,thor);

output(dsCurrentCorp,,named('dsCurrentCorp'));
output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));	// sanity check count

//--------------------------------------------
DC_Recs	   	:= dsCurrentCorp(corp2.t2u(corp_state_origin) in filterSet);
DC_RecsDist	:= sort(distribute(DC_Recs,hash(corp_key)),record,local);
BadRecsFilt	:= stringlib.stringfilterout(corp2.t2u(DC_RecsDist.corp_key),'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')<>'' or 									//eliminate bad corp keys
							 stringlib.stringfilterout(corp2.t2u(DC_RecsDist.corp_orig_sos_charter_nbr),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')<>'' or 	//eliminate bad charter numbers
corp2.t2u(DC_RecsDist.corp_legal_name) = 'DC';							 
BadRecs			:= DC_RecsDist(BadRecsFilt);
output(BadRecs,,named('BadRecs'));
output(count(BadRecs),named('cnt_BadRecs'));	// These records will be removed from the output

ToFix				:= DC_RecsDist(not(BadRecsFilt));
TheRest			:= dsCurrentCorp(corp2.t2u(corp_state_origin) not in filterSet);

output(ToFix,,named('ToFix'));
output(count(ToFix),named('cnt_ToFix'));			// sanity check count

output(TheRest,,named('TheRest'));
output(count(TheRest),named('cnt_TheRest'));	// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded trfCleanFields(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded Input)	:=	transform
		
		self.corp_orig_org_structure_desc := if(input.corp_orig_org_structure_desc = 'TRADE NAME DOMESTIC','',input.corp_orig_org_structure_desc);//new change in re corp 
		self.corp_ln_name_type_cd					:= if(input.corp_orig_org_structure_desc = 'TRADE NAME DOMESTIC', '04', input.corp_ln_name_type_cd);			//TRADE NAME records are new change 										   
		self.corp_ln_name_type_desc		    := if(input.corp_orig_org_structure_desc = 'TRADE NAME DOMESTIC', 'TRADE NAME',input.corp_ln_name_type_desc);		
		self.Corp_foreign_domestic_ind    := map(input.corp_orig_org_structure_desc in domestic_list 	=>'D',
																						 input.corp_orig_org_structure_desc in foreign_list 	=>'F','');	 // "Corp_foreign_domestic_ind"  New in re corp 
		self.Corp_for_profit_ind          := map(input.corp_orig_org_structure_desc in profit_list		=>'Y',
																						 input.corp_orig_org_structure_desc in Nonprofit_list	=>'N','');		//Corp_for_profit_ind New in re corp 																						 
		//fAddressExists validates addresses before stamping code & desc ,not working for old addresses																					 
		/* self.corp_ra_address_type_cd		  := if(Corp2_Mapping.fAddressExists('DC','DISTRICT OF COLUMBIA',input.corp_ra_address_line1,'' ,input.corp_ra_address_line2,input.corp_ra_address_line3).ifAddressExists ,'R','');                     //new in recorp	
       self.corp_ra_address_type_desc		:= if(Corp2_Mapping.fAddressExists('DC','DISTRICT OF COLUMBIA',input.corp_ra_address_line1,'' ,input.corp_ra_address_line2,input.corp_ra_address_line3).ifAddressExists ,'REGISTERED OFFICE','');		//new in recorp							 
      
		*/
		list															:= ['NONE','','X','XX','SAME','UNKNOWN','N/A','NA','NONE LISTED'];
		temp_addr1												:= if(input.corp_ra_address_line1 not in list,input.corp_ra_address_line1,'');
		temp_addr2												:= if(input.corp_ra_address_line2 not in list,input.corp_ra_address_line2,'');
		temp_addr3												:= if(input.corp_ra_address_line3 not in list,input.corp_ra_address_line3,'');
		self.corp_ra_address_type_cd		  := if(temp_addr1<>'' or temp_addr2<>''  or temp_addr3<>'' ,'R','');                     
   	self.corp_ra_address_type_desc		:= if(temp_addr1<>'' or temp_addr2<>''  or temp_addr3<>'' ,'REGISTERED OFFICE'	,'');		
		self							                := input;
   		 
end;
	 
FixedIt	:=	project(ToFix, trfCleanFields(left));
Fixed   := sort(distribute(FixedIt,hash(corp_key)),record,local);

output(Fixed,,named('Fixed'));
output(count(Fixed),named('cnt_Fixed'));	// sanity check count

NewCorpBase := Fixed + TheRest;

output(NewCorpBase,,named('NewCorpBase'));
output(count(NewCorpBase),named('cnt_NewCorpBase'));	// sanity check count

//---------------------------------------------
// output new version of the data, clear superfiles & add to superfiles							
sequential(	output(NewCorpBase,,	'~thor_data400::base::corp2::' + pversion + '::corp_xtnd',overwrite,__compressed__),						
						// parallel(	FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_xtnd'),
											// FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_xtnd') ),
/* 						 parallel(	Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_xtnd',
   																									  '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	),
   											  Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_xtnd',
   																										'~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	)	)
*/
					);		
				
				
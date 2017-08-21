import corp2, Corp2_Raw_DC, Corp2_Mapping;

#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 thor patches ');
#workunit('priority','high');
#workunit('priority',12);
#option('activitiesPerCpp', 50);

pversion		 :=	'20160805z'; //new version of data
filterSet		 := ['SD'];  

state_origin 				:= 'SD';
state_fips	 				:= '46';
state_desc	 				:= 'SOUTH DAKOTA';

dsCurrentCorp			:=	corp2.files().Base_xtnd.corp.qa: independent; // Current QA superfile for corp file
//dsCurrentCorp			:=	dataset('~thor_data400::base::corp2::20160603s::corp_xtnd',Corp2.layout_corporate_direct_corp_base_expanded,thor);

output(dsCurrentCorp,,named('dsCurrentCorp'));
output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));	// sanity check count

//--------------------------------------------
SD_Recs	   	:= dsCurrentCorp(corp2.t2u(corp_state_origin) in filterSet);
SD_RecsDist	:= sort(distribute(SD_Recs,hash(corp_key)),record,local);
BadRecsFilt	:= stringlib.stringfilterout(corp2.t2u(SD_RecsDist.corp_key),'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')<>'' or 									//eliminate bad corp keys
							 stringlib.stringfilterout(corp2.t2u(SD_RecsDist.corp_orig_sos_charter_nbr),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')<>'' or 	//eliminate bad charter numbers
corp2.t2u(SD_RecsDist.corp_legal_name) = 'SD';							 
BadRecs			:= SD_RecsDist(BadRecsFilt);
output(BadRecs,,named('BadRecs'));
output(count(BadRecs),named('cnt_BadRecs'));	// These records will be removed from the output

ToFix				:= SD_RecsDist(not(BadRecsFilt));
TheRest			:= dsCurrentCorp(corp2.t2u(corp_state_origin) not in filterSet);

output(ToFix,,named('ToFix'));
output(count(ToFix),named('cnt_ToFix'));			// sanity check count

output(TheRest,,named('TheRest'));
output(count(TheRest),named('cnt_TheRest'));	// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded trfCleanFields(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded Input)	:=	transform
		
			self.corp_ln_name_type_cd         := map(corp2.t2u(input.corp_orig_org_structure_cd)='RG'=>'09', //['RG','RL','RP','RS'] are name types & Recorp is populating these codes in "corp_ln_name_type_cd"
																							   corp2.t2u(input.corp_orig_org_structure_cd)  in ['RL','RP','RS']=>'07',
																							   corp2.t2u(input.corp_orig_org_structure_cd) not in ['RG','RL','RP','RS']=>'01',input.corp_ln_name_type_cd);
			self.corp_ln_name_type_desc       := map(corp2.t2u(input.corp_orig_org_structure_cd)='RG'=>'REGISTRATION', 
																							 corp2.t2u(input.corp_orig_org_structure_cd)  in ['RL','RP','RS']=>'RESERVED',
																							 corp2.t2u(input.corp_orig_org_structure_cd) not in ['RG','RL','RP','RS']=>'LEGAL',input.corp_ln_name_type_desc);
   		self.corp_orig_org_structure_cd  	:= if(corp2.t2u(input.corp_orig_org_structure_cd)  in ['RG','RL','RP','RS'],'',input.corp_orig_org_structure_cd); // ['RG','RL','RP','RS'] are name types and Recorp not populating in "orig_org_structure_cd"
		  self.corp_orig_org_structure_desc := if(trim(self.corp_orig_org_structure_cd)<>'', Corp2_Raw_SD.Functions.CorpOrigOrgStructDesc(self.corp_orig_org_structure_cd),input.corp_orig_org_structure_desc);
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
sequential(	output(NewCorpBase,,	'~thor_data400::base::corp2::'+ pversion +'::corp_xtnd',overwrite,__compressed__),						
						// parallel(	FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_xtnd'),
											// FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_xtnd') ),
						// parallel(	Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_xtnd',
																									// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	),
											// Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_xtnd',
		    																	// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	)	)
					);
				
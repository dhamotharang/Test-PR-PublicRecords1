/*
		--Extract is from specific zip codes specified.  It will be in the response layout
		#workunit('name', 'Voter Registration Zip Extract')
*/
import VotersV2,address,ut;

Layout_Voter := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

export VoterExtract(
	 string					        pversion
	,dataset(Layout_Voter)	pVoterBase			= VotersV2.File_Voters_Base
	,set of string	        pZipCodes				= ZipcodeSet		
	,boolean								pOverwrite			= false
	,boolean								pCsvout					= true
	,string									pSeparator			= '|'	

) :=
function

	dVoter_Filter := pVoterBase(addr_type = '' and (zip in pZipCodes or mail_ace_zip in pZipCodes));
	
	Layout_temp := record
		FDS_Test.Layouts.Response.Voter_Extract;
		unsigned6  vtid := 0;
		string8		 dt_last_seen := '';
	end;

	Layout_temp tConvert2Response(Layout_Voter l) :=
	transform
	
		self.Source_Zip  						:= if(l.zip in pZipCodes, l.zip,
																		  if(l.mail_ace_zip in pZipCodes, l.mail_ace_zip,''));
		self.rec_id							 		:= '';//(string)cnt;
		self.first_Name				 			:= trim(l.fname);
		self.middle_Name			 			:= trim(l.mname);
		self.last_Name				 			:= trim(l.lname);
		self.Street_Addr			 			:= trim(Address.Addr1FromComponents(
																				l.prim_range
																				,l.predir
																				,l.prim_name
																				,l.addr_suffix
																				,l.postdir
																				,'',''
																				),left,right);
		self.Secondary_Addr		 			:= trim(Address.Addr1FromComponents(
																				l.unit_desig
																				,l.sec_range
																				,''
																				,''
																				,''
																				,''
																				,''
																				),left,right);
		self.Res_City								:= trim(l.p_city_name);
		self.St						 					:= trim(l.st);
		self.Zip					 					:= trim(l.zip);
		self.dob							 			:= if(l.dob != '',intformat(ut.Date_MMDDYYYY_i2(l.dob),8,1),'');
		self.ssn_out					 			:= trim(l.ssn);
		self.gender						 			:= map (trim(l.gender) = 'F' => 'FEMALE',
																				trim(l.gender) = 'M' => 'MALE',
																				'');
		self.race						 				:= l.race_exp;
		self.occupation							:= l.occupation;
		self.Mail_Street_Addr				:= trim(Address.Addr1FromComponents(
																				l.mail_prim_range
																				,l.mail_predir
																				,l.mail_prim_name
																				,l.mail_addr_suffix
																				,l.mail_postdir
																				,'',''
																				),left,right);
		self.Mail_Secondary_Addr		:= trim(Address.Addr1FromComponents(
																				l.mail_unit_desig
																				,l.mail_sec_range
																				,''
																				,''
																				,''
																				,''
																				,''
																				),left,right);
		self.Mail_City						 	:= trim(l.mail_p_city_name);
		self.Mail_St							 	:= trim(l.mail_st);
		self.Mail_Zip								:= trim(l.mail_ace_zip);
		//self.phone						 			:= l.phone;
		self.state_of_registration	:= trim(l.source_state);
		self.registration_date 			:= if(l.regDate != '', intformat(ut.Date_MMDDYYYY_i2(l.regDate),8,1),'');
		self.political_party				:= trim(l.politicalparty_exp);
		self.last_vote_date	 				:= if(l.LastDateVote != '', intformat(ut.Date_MMDDYYYY_i2(l.LastDateVote),8,1),'');
		self.Active_Status					:= trim(l.active_status_exp);
		self.dt_last_seen						:= trim(l.date_last_seen);
		self.vtid										:= l.vtid;
		self												:= l;
	
	end;

	dresponse := project(dVoter_Filter, tConvert2Response(left));
		
	dresponse_deduped := dedup(sort(dresponse, Source_Zip, vtid, -dt_last_seen), Source_Zip, vtid, keep 5);
	
	dresponse_srt_grp := sort(dresponse_deduped, Source_Zip, first_name, last_name, middle_name, res_city, st, zip, ssn_out, dob, -dt_last_seen);
	
	Layout_temp iterResponse(dresponse_deduped l, dresponse_srt_grp r) := transform
			same_group 		:= if(trim(l.last_name,left,right)	= trim(r.last_name,left,right) and 
													trim(l.first_name,left,right)	= trim(r.first_name,left,right) and 
													trim(l.middle_name,left,right)= trim(r.middle_name,left,right) and 
													trim(l.res_city,left,right)  	= trim(r.res_city,left,right) and 
													trim(l.st,left,right) 				= trim(r.st,left,right) and 
													trim(l.zip,left,right) 	 			= trim(r.zip,left,right) and
													trim(l.dob,left,right)				= trim(r.dob,left,right) and
													trim(l.ssn_out,left,right)		= trim(r.ssn_out,left,right) and
													trim(l.state_of_registration)	= trim(r.state_of_registration), true, false);
			self.rec_id		:= if(L.rec_id = '','1',
													if(same_group, l.rec_id, (string)((integer)L.rec_id + 1)));
			self					:= r;
	end;
	
	dresponse_fixRecordId := iterate(dresponse_srt_grp, iterResponse(left, right));

	dresponse_out := sort(project(dresponse_fixRecordId	,transform(Layouts.Response.Voter_Extract, self := left;)),Source_Zip);
	
	layout_stat := 
	record
    integer countGroup := count(group);
		//dresponse_forstats.stuff  ;
		Record_ID_CountNonBlank          	:= sum(group,if(dresponse_out.Rec_Id					<>'',1,0));
		first_Name_CountNonBlank      	 	:= sum(group,if(dresponse_out.first_Name			<>'',1,0));
		middle_Name_CountNonBlank      		:= sum(group,if(dresponse_out.middle_Name			<>'',1,0));
		last_Name_CountNonBlank      	 	 	:= sum(group,if(dresponse_out.last_Name				<>'',1,0));
		Street_Addr_CountNonBlank    	 		:= sum(group,if(dresponse_out.Street_Addr			<>'',1,0));
		Secondary_Addr_CountNonBlank 			:= sum(group,if(dresponse_out.Secondary_Addr	<>'',1,0));
		City_CountNonBlank             		:= sum(group,if(dresponse_out.Res_City				<>'',1,0));
		State_CountNonBlank            		:= sum(group,if(dresponse_out.St							<>'',1,0));
		Zip_CountNonBlank         		  	:= sum(group,if(dresponse_out.Zip							<>'',1,0));
		
		Mail_Street_Addr_CountNonBlank   	:= sum(group,if(dresponse_out.Mail_Street_Addr		<>'',1,0));
		Mail_Secondary_Addr_CountNonBlank := sum(group,if(dresponse_out.Mail_Secondary_Addr	<>'',1,0));
		Mail_City_CountNonBlank           := sum(group,if(dresponse_out.Mail_City						<>'',1,0));
		Mail_State_CountNonBlank          := sum(group,if(dresponse_out.Mail_St							<>'',1,0));
		Mail_Zip_CountNonBlank         		:= sum(group,if(dresponse_out.Mail_Zip						<>'',1,0));
		
		//phone_CountNonBlank            		  := sum(group,if(dresponse_out.phone							<>'',1,0));
		dob_CountNonBlank             		:= sum(group,if(dresponse_out.dob 						<>'',1,0));
		ssn_CountNonBlank             	 	:= sum(group,if(dresponse_out.ssn_out 				<>'',1,0));
		gender_CountNonBlank             	:= sum(group,if(dresponse_out.gender 					<>'',1,0));
		race_CountNonBlank             	 	:= sum(group,if(dresponse_out.race 						<>'',1,0));
		occupation_CountNonBlank          := sum(group,if(dresponse_out.occupation 			<>'',1,0));
		
		state_of_reg_countNonBlank 				:= sum(group,if(dresponse_out.state_of_registration		<>'',1,0));
		reg_date_CountNonBlank  					:= sum(group,if(dresponse_out.registration_date <>'',1,0));
		political_party_CountNonBlank   	:= sum(group,if(dresponse_out.political_party		<>'',1,0));
		last_vote_date_CountNonBlank   	 	:= sum(group,if(dresponse_out.last_vote_date		<>'',1,0));
		Active_Status_CountNonBlank   	 	:= sum(group,if(dresponse_out.Active_Status			<>'',1,0));
	end;
	
	dresponse_stats := table(dresponse_out, layout_stat, few);
	

	return parallel(output('FDS Voter Extract Results Follow'	,named('__'							))
									,output(dresponse_out,,'~thor_data400::out::FDS_Test::Voter::Extract',csv(separator(pSeparator)),overwrite)
									,output(dresponse_stats							,named('Voter_Extract_Fill_Rates'))
								 );

end;
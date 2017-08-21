//**************************Phonesplus process to:**********************************************************************
//                                             Assign initial score 
//                                             Validate (npa, nxx, tb) 
//                                             Flag neverseen , disconnected, current disconnect, non current and inactive 

//                          Valid values for vendor parameters are: 
//											Phonesplus.proc_asPhonesplus('header'); 
//											Phonesplus.proc_asPhonesplus('pcnsr'); 
//											Phonesplus.proc_asPhonesplus('intrado'); 
//											Phonesplus.proc_asPhonesplus('targus'); 
//											Phonesplus.proc_asPhonesplus('gongh'); 
//											Phonesplus.proc_asPhonesplus('cellphones'); 
//											Phonesplus.proc_asPhonesplus('infutor'); 
//											Phonesplus.proc_asPhonesplus('infutorcid'); 
//											Phonesplus.proc_asPhonesplus('paw'); 
											
import header, gong, Risk_Indicators,ut,yellowpages;
export proc_asPhonesplus (vendor, outfile):= MACRO

#uniquename(risk_ind_telecordia)
%risk_ind_telecordia% := Risk_Indicators.File_Telcordia_tpm;

#uniquename(telecordia_file)
%telecordia_file% := Phonesplus.File_telecordia_tds_base;

#uniquename(out_file_name)
%out_file_name% := IF(vendor ='pcnsr', 'infousa', vendor);


//*******************Map to common layout Phonesplus.layoutCommonOut****************************************************

#uniquename(ppCandidate)
#if(vendor = 'header')
%ppCandidate% := Phonesplus.map_HeaderstoPhonesplus;
#else
	#if(vendor = 'pcnsr')
	%ppCandidate% := Phonesplus.map_PCNSR_asPhonesplus;
	#else
		#if(vendor = 'intrado')
		%ppCandidate% := Phonesplus.map_Intrado_asPhonesplus;
		#else
			#if(vendor = 'targus')
			%ppCandidate% := Phonesplus.map_TargusWP_asPhonesplus;
			#else
					#if(vendor = 'gongh')
						%ppCandidate% := Phonesplus.map_GongHtoPhonesplus;
						#else
							#if(vendor = 'cellphones')
							 %ppCandidate% := Phonesplus.map_CellphonestoPhonesplus;
							 #else
								#if(vendor = 'infutor')
									%ppCandidate% := Phonesplus.map_Infutor_asPhonesplus;
									#else
										#if(vendor = 'infutorcid')
										%ppCandidate% := Phonesplus.map_InfutorCID_asPhonesplus;
											#else
											#if(vendor = 'paw')
											%ppCandidate% := Phonesplus.map_Paw_asPhonesplus;
												#else
												output('Not a valid vendor parameter');
											#end
										#end
									#end
							 #end
						#end
				#end
		#end
	 #end
#end

//*******************Reformat npa, nxx, tb *************************************************************************
#uniquename(layout_ppCandidate)
%layout_ppCandidate% := record
	string3 npa;
	string3 nxx;
	string1 tb;
	Phonesplus.layoutCommonOut;
end;

#uniquename(t_ppCandidate)
%layout_ppCandidate% %t_ppCandidate%(%ppCandidate% input) := Transform
	self.npa 			:= input.CellPhone[1..3];
	self.nxx 		    := input.CellPhone[4..6];
	self.tb 			:= input.CellPhone[7];
	self 				:= input;
end;

#uniquename(p_ppCandidate)
%p_ppCandidate% := sort(
				 distribute(project(%ppCandidate%,%t_ppCandidate%(left)),hash(npa,nxx,tb)),
					  npa,nxx,tb,local);

//*******************Validate npa, nxx, tb : Remove records that do NOT match Telecordia File by npa,nxx,tb*************			  
#uniquename(tpm)		
//validate npa,nxx,tb
%tpm%  := dedup(
			sort(
				distribute(Risk_Indicators.File_Telcordia_tpm,hash(npa,nxx,tb)),
			npa,nxx,tb,local),
		npa,nxx,tb,local);

#uniquename(t_tpm)
%layout_ppCandidate% %t_tpm%(%p_ppCandidate% L ,%tpm% R) := transform
	self := L;
end;

#uniquename(goodnpanxx)
%goodnpanxx%	:= join(%p_ppCandidate%,%tpm%,
					left.npa = right.npa and 
					left.nxx = right.nxx and 
					left.tb  = right.tb,
					%t_tpm%(left,right),local); 
//*******************Assign TDSMatch score******************************************************************************				
#uniquename(tds)
//Check for cellphone type
%tds% := dedup(sort(distribute(Phonesplus.File_telecordia_tds_base, hash(npa,nxx,tb)),npa,nxx,tb,local),npa,nxx,tb,local);

#uniquename(f_tds)
%f_tds% := %tds%(COCType in ['EOC','PMC','RCC','SP1','SP2'] and 
			    (regexfind('C',%tds%.scc,0) != '' or
			     regexfind('R',%tds%.scc,0) != '' or
				 regexfind('S',%tds%.scc,0) != ''));
				 
#uniquename(dd_tds)
%dd_tds% := dedup(%f_tds%,npa,nxx,tb,local);

#uniquename(t_tds)					
%goodnpanxx% %t_tds%(%goodnpanxx% L ,%dd_tds% R) := transform
                                          //Infutor CID identifies cellphones with code W
	self.TDSMatch	:= if(R.scc != '' or (L.carriercode = 'W' and L.sourcefile = 'Infutor CID'),phonesplus.codes.TDSMatch_score,L.TDSMatch);
	#if(vendor = 'gongh')
		self.InitScore			:= phonesplus.codes.initial_score(vendor);
	#else 
		self.InitScore			:= L.InitScore;
	#end
	
	#if(vendor = 'gongh')	
		self.InitScoreType		:= phonesplus.codes.discon_type;
	#else
		self.InitScoreType      := L.InitScoreType;
	#end
	
	self := L;
end;

#uniquename(hascelltype)
%hascelltype%	:= join(%goodnpanxx%,%dd_tds%,
				left.npa = right.npa and 
				left.nxx = right.nxx and 
				left.tb  = right.tb,
			    %t_tds%(left,right),left outer,local); 
							
//*******************Flag Utility Records*******************************************************************************	
// Is Utility record
#uniquename(t_isutility)
%hascelltype% %t_isutility%(%hascelltype% input) := Transform
	self.InitScore		:= if(input.src IN phonesplus.codes.utility_src,phonesplus.codes.utility_score,input.InitScore);
	self.InitScoreType	:= if(input.InitScoreType = '',if(input.src IN phonesplus.codes.utility_src,phonesplus.codes.utility_type,''),input.InitScoreType);
	self 				:= input;
end;

#uniquename(p_isUtility)
#if(vendor = 'header')
	%p_isUtility% := sort(distribute(project(%hascelltype%, %t_isUtility%(left)),hash(CellPhone)),CellPhone,local);
#else 
	%p_isUtility% := sort(distribute(%hascelltype%,hash(CellPhone)),CellPhone,local);
#end
		
//*******************Flag Never Seen Records and reassing initscore*****************************************************	
//Found in Gong History/Current ?
#uniquename(dd_gongH)

%dd_gongH% := dedup(Gong.File_History,phone10,all);


#uniquename(t_neverseen)
%p_isUtility% %t_neverseen%(%p_isUtility% L ,%dd_Gongh% R) := transform
	self.InitScoreType		:= map(R.phone10 = '' and L.InitScoreType = '' => phonesplus.codes.neverseen_type,L.InitScoreType);
	self.InitScore			:= if(R.phone10 = '',if(L.InitScoreType = '',if((string)L.DateLastSeen[1..4] < phonesplus.codes.yr_threshold,phonesplus.codes.dt_range_months,0),L.InitScore),L.InitScore);
	self 					:= L
end;					

#uniquename(neverseen)

#if(vendor = 'header' or vendor = 'pcnsr' or vendor = 'infutor' or vendor = 'infutorcid' or vendor = 'paw')	
%neverseen% 				:= join(%p_isUtility%,sort(distribute(%dd_gongH%,hash(phone10)),phone10,local),
								left.Cellphone = right.phone10,
								%t_neverseen%(left,right),left outer,local); 
#else 
		%neverseen%  := %p_isUtility%;
#end
			
//*******************Select records from Gong Base with valid phones********************************************	
//Neverseen's Address found in Gong Current ?
#uniquename(currGong)
#uniquename(f_currGong)
%currGong% := Gong.File_GongBase;

#if(vendor = 'header' or vendor = 'intrado' or vendor ='targus' or vendor = 'infutor' or vendor = 'infutorcid' or vendor = 'paw')	
%f_currGong% := %currGong%(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
			phoneno[1] > '1' and phoneno[7..10] != '0000' and phoneno[7..10] != '9999');
#else
	#if(vendor = 'pcnsr')
	%f_currGong%:= %currGong%(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
			phoneno[1] > '1' and phoneno[7..10] != '0000' and phoneno[7..10] != '9999' and publish_code != 'NP');
	
		#else
			#if(vendor = 'gongh' or vendor = 'cellphones')
			%f_currGong%:= %currGong%(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
					phoneno[7..10] != '0000' and phoneno[7..10] != '9999' and publish_code != 'NP');
	#end
			#end
#end

//*******************Match Current Disconnect and reassign InitScore and InitScoreType*********************************	
//Matches Current Disconnect?
#uniquename(currDisconn)
%currDisconn% := Phonesplus.map_GongHtoPhonesplus;

#uniquename(t_isCurrDisconn)
%neverseen% %t_isCurrDisconn%(%neverseen% L ,%currDisconn% R) := transform
	self.InitScore	:= if(R.Cellphone != '',
						if(L.TDSMatch !=0,
					     if(R.DateLastSeen - L.DateLastSeen > phonesplus.codes.dt_range_months,phonesplus.codes.curr_discon_score(vendor),1)
				      ,L.InitScore),L.InitScore);
								
	self.InitScoreType	:= map(R.Cellphone != '' and L.TDSMatch !=0 => phonesplus.codes.discon_type,L.InitScoreType);
	self 				:= L;
end;

#uniquename(matchCurrDisconn)
#if(vendor <> 'gongh' and vendor <> 'pcnsr')
%matchCurrDisconn% := join(sort(distribute(%neverseen%,hash(CellPhoneIDKey)),CellPhoneIDKey,local),
						dedup(sort(distribute(%currDisconn%,hash(CellPhoneIDKey)),CellPhoneIDKey,local),CellPhoneIDKey,local),
						left.CellphoneIDKey = right.CellPhoneIDKey,
						%t_isCurrDisconn%(left,right),left outer,local);
#else
	#if(vendor = 'pcnsr')
	%matchCurrDisconn% := join(sort(distribute(%neverseen%,hash(CellPhoneIDKey)),CellPhoneIDKey,local),
						 sort(distribute(%currDisconn%,hash(CellPhoneIDKey)),CellPhoneIDKey,local),
										left.CellphoneIDKey = right.CellPhoneIDKey,
										%t_isCurrDisconn%(left,right),left outer,local);
	#else
			%matchCurrDisconn% := %neverseen%;
	#end
#end	

//*******************Remove reocds based on InitScoreType, TDSMatch score, and DateLastSeen Differences**************	
//Filter on DateLastSeen						
#uniquename(f_matchCurrDisconn)
#if(vendor = 'header')
%f_matchCurrDisconn%:=  %matchCurrDisconn%(InitScoreType = phonesplus.codes.utility_type or InitScoreType = phonesplus.codes.neverseen_type or TDSMatch=10 or
									 (DateLastSeen > phonesplus.codes.portability_dt and DateLastSeen < (unsigned3)ut.GetDate - phonesplus.codes.dt_range_months) or
									 DateLastSeen = 0);
#else
	#if(vendor = 'pcnsr' or vendor = 'targus' or vendor = 'infutor' or vendor = 'infutorcid' or vendor = 'paw')
	%f_matchCurrDisconn%:=  %matchCurrDisconn%(TDSMatch = 10 or InitScoreType = phonesplus.codes.neverseen_type or
									 (DateLastSeen > phonesplus.codes.portability_dt and DateLastSeen < (unsigned3)ut.GetDate - phonesplus.codes.dt_range_months) or
									  DateLastSeen = 0);
	#else 
			%f_matchCurrDisconn%:= %matchCurrDisconn%;
	#end
#end

//*******************Remove Disconnect in current Gong at any address: Remove records that match Gong.File_Gong_Base with InitScoreType = DISCONN
//Remove any disconnect that is in the current Gong at any address	
#uniquename(t_isCurrPhone)
%f_matchCurrDisconn% %t_isCurrPhone%(%f_matchCurrDisconn% L ,%f_currGong% R) := transform
self := L;
end;

#uniquename(nonCurrPhone)
#if(vendor = 'gongh')
	%nonCurrPhone% := %hascelltype%(TDSMatch != 0 or (DateLastSeen > phonesplus.codes.portability_dt and DateLastSeen < (unsigned3)ut.GetDate - phonesplus.codes.dt_range_months) or
					   DateLastSeen = 0 );
#else 
	%nonCurrPhone% := join(sort(distribute(%f_matchCurrDisconn%,hash(CellPhone)),CellPhone,local)
					,dedup(sort(distribute(%f_currGong%,hash(phoneno)),phoneno,local),phoneno,local),
						left.InitScoreType = phonesplus.codes.discon_type and 
						left.Cellphone = right.phoneno,
						%t_isCurrPhone%(left,right),left only,local);
#end

//*******************Remove Active Gong: Remove records that match File_GongBase****************************************	
#uniquename(t_remActive)
%nonCurrPhone% %t_remActive%(%nonCurrPhone% L ,%f_currGong% R) := transform
	self := L;
end;

#uniquename(nonActive)
#if(vendor <> 'gongh' and vendor <> 'cellphones')
%nonActive% := join(sort(distribute(%nonCurrPhone%,hash(CellPhone)),CellPhone,local)
				 ,dedup(sort(distribute(%f_currGong%,hash(phoneno)),phoneno,local),phoneno,local),
						left.Cellphone = right.phoneno,
						// and left.lname = right.name_last and
						// left.fname = right.name_first,
						%t_remActive%(left,right),left only,local);
						
#else
	#if(vendor = 'gongh')
	%nonActive% := join(sort(distribute(%nonCurrPhone%,hash(CellPhone)),CellPhone,local),
				 dedup(sort(distribute(%f_currGong%,hash(phoneno)),phoneno,local),phoneno,local),
						left.Cellphone = right.phoneno,
						%t_remActive%(left,right),left only,local);
	#else
		#if(vendor = 'cellphones')
			%nonActive% :=	join(sort(distribute(%hascelltype%,hash(CellPhone,lname,fname)),CellPhone,lname,fname,local),
					dedup(sort(distribute(%f_currGong%,hash(phoneno,name_last,name_first)),phoneno,name_last,name_first,local),phoneno,name_last,name_first,local),
						left.Cellphone = right.phoneno and
						left.lname = right.name_last and
						left.fname = right.name_first,
						%t_remActive%(left,right),left only,local);
		#end
	#end
#end

//******************Match to Gong Base to flag Active Gong under different name and reassign InitScore and InititScoreType
//Mark Active Gong under different name and 
// Mark Header Other	
#uniquename(t_mrkActive)
Phonesplus.layoutCommonOut %t_mrkActive%(%nonActive% L ,%f_currGong% R) := transform
	self.ActiveFlag := if(R.phoneno != '','Y','');
#if(vendor = 'pcnsr' or vendor = 'targus' or vendor = 'infutor')
	self.InitScore		:= if(L.InitScore = 0,phonesplus.codes.initial_score(vendor),L.InitScore);
#else
	self.InitScore := L.InitScore;
#end
#if(vendor = 'header' or vendor = 'pcnsr' or vendor = 'targus' or vendor = 'infutor' or vendor = 'infutorcid')	
	self.InitScoreType	:= if(L.InitScoreType = '',phonesplus.codes.score_type(vendor),L.InitScoreType);
#else
	self.InitScoreType	:= L.InitScoreType ;
#end

	self := L;
end;	

#uniquename(ActiveDiffName)
#if(vendor <> 'gongh')
%ActiveDiffName% := join(sort(distribute(%nonActive%,hash(CellPhone,prim_range,prim_name,zip5)),CellPhone,prim_range,prim_name,zip5,local)
				 ,dedup(sort(distribute(%f_currGong%,hash(phoneno,prim_range,prim_name,z5)),phoneno,prim_range,prim_name,z5,local),phoneno,prim_range,prim_name,z5,local),
						left.Cellphone = right.phoneno and
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.zip5 = right.z5,
						%t_mrkActive%(left,right),left outer,local);
#else
	%ActiveDiffName%:= project(%nonActive%, transform(Phonesplus.layoutCommonOut, self := left));
#end

//******************Remove Active Gong Businesses**********************************************************
#uniquename(t_remActive2)
Phonesplus.layoutCommonOut %t_remActive2%(%nonActive% L ,%f_currGong% R) := transform
self := L;
end;	

#uniquename(nonActive2)
#if(vendor = 'cellphones')
%nonActive2% := 	join(sort(distribute(%nonActive%,hash(CellPhone)),CellPhone,local),
					dedup(sort(distribute(%f_currGong%,hash(phoneno)),phoneno,company_name,local),phoneno,company_name,local),
						left.OrigName = left.Company and
						left.Company = right.company_name and
						left.Cellphone = right.phoneno,
						%t_remActive2%(left,right),left only,local);
#else
	%nonActive2% := %ActiveDiffName%;
#end

//******************** Assign and append PhoneType to a temp field*******************************************
#uniquename(phtype)
#uniquename(out_phonetype)
#uniquename(layout_temp_phone)

%layout_temp_phone% := record
string10 phone;
end;

//assign phone type to unique phones
%phtype% := dedup(project(%nonActive2%, transform( %layout_temp_phone% , self.phone := left.cellphone)), all);
yellowpages.NPA_PhoneType(%phtype%, phone, phonetype, %out_phonetype%);

//append phonetype
#uniquename(layout_temp_phonetype)
%layout_temp_phonetype% := record
	Phonesplus.layoutCommonOut;
	string25 phonetype;
end;

#uniquename(t_append_phonetype)
%layout_temp_phonetype% %t_append_phonetype%(%nonActive2% L, %out_phonetype% R) := transform
	self.phonetype := R.phonetype;
	self := L;
end;

#uniquename(append_phonetype)
%append_phonetype% := join(sort(distribute(%nonActive2%, hash(cellphone)), cellphone, local),
						   sort(distribute(%out_phonetype%, hash(phone)), phone, local),
							left.cellphone = right.phone,
							%t_append_phonetype%(left, right), left outer, local);

//******************** Set the score and flag records that match Gong current Non-published
#uniquename(gong_nonpublished)
%gong_nonpublished% := Phonesplus.File_Nonpublished; 

#uniquename(t_nonpublished)
Phonesplus.layoutCommonOut %t_nonpublished%(%append_phonetype% L, %gong_nonpublished% R) := transform
	#uniquename(is_nonpub)
	%is_nonpub% := 			  L.lname		=  R.name_last and
							  L.prim_range 	=  R.prim_range and
							  L.prim_name 	=  R.prim_name and
							  L.sec_range 	=  R.sec_range and
							  L.zip5 		=  R.z5;
	self.PublishCode	:= if(%is_nonpub% and 
							//Infutor CID identifies Landlines with code L
							 ((trim(L.phonetype, all) = Phonesplus.Codes.land_line_type and  L.sourcefile <> 'Infutor CID')  or 
							  (L.carriercode[1] = 'L' and  L.sourcefile = 'Infutor CID')),
							  R.publish_code,
							  L.PublishCode);		 
	self := L;
end;


#uniquename(nonpublished)
#if(vendor = 'header' or vendor = 'intrado' or vendor = 'infutor' or vendor = 'infutorcid' or vendor = 'pcnsr' or vendor ='targus')
	%nonpublished% := join(sort(distribute(%append_phonetype%, hash(lname, prim_range, prim_name, sec_range, zip5)), lname, prim_range, prim_name, sec_range, zip5, local),
					   %gong_nonpublished%,
					   left.lname		= right.name_last and
					   left.prim_range 	= right.prim_range and
					   left.prim_name 	= right.prim_name and
					   left.sec_range 	= right.sec_range and
					   left.zip5 		= right.z5 and
					   trim(left.phonetype, all) = Phonesplus.Codes.land_line_type,
					   %t_nonpublished%(left, right), left outer, local);
#else
	%nonpublished% := %nonActive2%;
#end

//******************Generate Output File********************************************************************************
outfile := %nonpublished%  : persist('~thor400_30::persist::' + %out_file_name% + '_asphonesplus');
ENDMACRO;
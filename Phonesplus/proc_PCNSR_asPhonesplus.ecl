import header, gong, Risk_Indicators,ut;

ppCandidate := Phonesplus.map_PCNSR_asPhonesplus;

layout_ppCandidate := record
string3 npa;
string3 nxx;
string1 tb;
Phonesplus.layoutCommonOut;
end;

layout_ppCandidate t_ppCandidate(ppCandidate input) := Transform

self.npa 			:= input.CellPhone[1..3];
self.nxx 			:= input.CellPhone[4..6];
self.tb 			:= input.CellPhone[7];

self 						:= input;

end;

p_ppCandidate := sort(
				 distribute(project(ppCandidate,t_ppCandidate(left)),hash(npa,nxx,tb)),
					  npa,nxx,tb,local);
		
//validate npa,nxx,tb
tpm  := dedup(
			sort(
				distribute(Risk_Indicators.File_Telcordia_tpm,hash(npa,nxx,tb)),
			npa,nxx,tb,local),
		npa,nxx,tb,local);


layout_ppCandidate t_tpm(p_ppCandidate L ,tpm R) := transform
self := L;
end;

goodnpanxx	:= join(p_ppCandidate,tpm,
					left.npa = right.npa and 
					left.nxx = right.nxx and 
					left.tb  = right.tb,
					t_tpm(left,right),local); 

//Check for cellphone type
tds := dedup(sort(distribute(Risk_Indicators.File_Telcordia_tds,
		hash(npa,nxx,tb)),npa,nxx,tb,local),npa,nxx,tb,local);
f_tds := tds(COCType in ['EOC','PMC','RCC','SP1','SP2'] and 
			    (regexfind('C',tds.ssc,0) != '' or
			     regexfind('R',tds.ssc,0) != '' or
				 regexfind('S',tds.ssc,0) != '')); 

dd_tds := dedup(f_tds,npa,nxx,tb,local);
					
goodnpanxx t_tds(goodnpanxx L ,dd_tds R) := transform
self.TDSMatch	:= if(R.ssc != '',10,L.TDSMatch);

self := L;
end;

hascelltype	:= join(goodnpanxx,dd_tds,
				left.npa = right.npa and 
				left.nxx = right.nxx and 
				left.tb  = right.tb,
			    t_tds(left,right),left outer,local); 

/* ************************************************************************************************** */
//Found in Gong History/Current ?
dd_gongH := dedup(Gong.File_History,phone10,all);

hascelltype t_neverseen(hascelltype L ,dd_Gongh R) := transform
self.InitScoreType		:= map(R.phone10 = '' and L.InitScoreType = '' => 'NEVERSEEN',L.InitScoreType);
self.InitScore			:= if(R.phone10 = '',if(L.InitScoreType = '',if((string)L.DateLastSeen[1..4] < '2001',3,10),L.InitScore),L.InitScore);
self 					:= L
end;					

neverseen 				:= join(sort(distribute(hascelltype,hash(CellPhone)),CellPhone,local),
							sort(distribute(dd_gongH,hash(phone10)),phone10,local),
								left.Cellphone = right.phone10,
								t_neverseen(left,right),left outer,local);
								
/* ************************************************************************************************** */
//Neverseen's Address found in Gong Current ?
currGong := Gong.File_GongBase;
f_currGong := currGong(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
			phoneno[1] > '1' and phoneno[7..10] != '0000' and phoneno[7..10] != '9999' and publish_code != 'NP');

/*
neverseen  t_CurrAddr(neverseen  L ,f_currGong R) := transform
self 					:= L;
end;					

nonCurrAddr				:= join(sort(distribute(neverseen,hash(prim_range,prim_name,zip5)),
									 prim_range,prim_name,zip5,local),
								dedup(sort(distribute(f_currGong,hash(prim_range,prim_name,z5)),
									 prim_range,prim_name,z5,local),prim_range,prim_name,z5,local),
						        left.InitScoreType = 'NEVERSEEN' and 
								left.prim_range = right.prim_range and
								left.prim_name = right.prim_name and
								left.zip5 = right.z5,
								t_CurrAddr(left,right),left only,local);
*/												
/* ************************************************************************************************** */
//Matches Current Disconnect?
currDisconn := Phonesplus.map_GongHtoPhonesplus;


neverseen t_isCurrDisconn(neverseen L ,currDisconn R) := transform
self.InitScore	:= if(R.Cellphone != '',
						if(L.TDSMatch !=0,
					     if(R.DateLastSeen - L.DateLastSeen > 3,10,1)
				      ,L.InitScore),L.InitScore);
							
self.InitScoreType	:= map(R.Cellphone != '' and L.TDSMatch !=0 => 'DISCONN',L.InitScoreType);
self 				:= L;
end;						

matchCurrDisconn := join(sort(distribute(neverseen,hash(CellPhoneIDKey)),CellPhoneIDKey,local),
						 sort(distribute(currDisconn,hash(CellPhoneIDKey)),CellPhoneIDKey,local),
										left.CellphoneIDKey = right.CellPhoneIDKey,
						t_isCurrDisconn(left,right),left outer,local);
//Filter on DateLastSeen						
f_matchCurrDisconn:=  matchCurrDisconn(TDSMatch = 10 or InitScoreType = 'NEVERSEEN' or
									 (DateLastSeen > 200412 and DateLastSeen < (unsigned3)ut.GetDate - 3));
									 
/* ************************************************************************************************** */
//Remove any disconnect that is in the current Gong at any address	

f_matchCurrDisconn t_isCurrPhone(f_matchCurrDisconn L ,f_currGong R) := transform
self := L;
end;					

nonCurrPhone := join(sort(distribute(f_matchCurrDisconn,hash(CellPhone)),CellPhone,local),
					dedup(sort(distribute(f_currGong,hash(phoneno)),phoneno,local),phoneno,local),
						left.InitScoreType = 'DISCONN'and 
						left.Cellphone = right.phoneno,
						t_isCurrPhone(left,right),left only,local);
			
/* ************************************************************************************************** */
//Remove Active Gong	

nonCurrPhone t_remActive(nonCurrPhone L ,f_currGong R) := transform
self := L;
end;					

//commented out code. phone number matches only - cng 20081030
nonActive := join(sort(distribute(nonCurrPhone,hash(CellPhone)),CellPhone,local),
				 dedup(sort(distribute(f_currGong,hash(phoneno)),phoneno,local),phoneno,local),
						left.Cellphone = right.phoneno 
						// and
						// left.lname = right.name_last and
						// left.fname = right.name_first
						,t_remActive(left,right),left only,local);
/* ************************************************************************************************** */
//Mark Active Gong under different name and 
// Mark PCNSR Other	

Phonesplus.layoutCommonOut t_mrkActive(nonActive L ,f_currGong R) := transform
self.ActiveFlag := if(R.phoneno != '','Y','');
self.InitScore		:= if(L.InitScore = 0,5,L.InitScore);
self.InitScoreType	:= if(L.InitScoreType = '','PCNSR OTHER',L.InitScoreType);
self := L;
end;					

ActiveDiffName := join(sort(distribute(nonActive,hash(CellPhone,prim_range,prim_name,zip5)),CellPhone,prim_range,prim_name,zip5,local),
				 dedup(sort(distribute(f_currGong,hash(phoneno,prim_range,prim_name,z5)),phoneno,prim_range,prim_name,z5,local),phoneno,prim_range,prim_name,z5,local),
						left.Cellphone = right.phoneno and
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.zip5 = right.z5,
						t_mrkActive(left,right),left outer,local);
			
export proc_PCNSR_asPhonesplus := ActiveDiffName : PERSIST('~thor400_30::persist::infousa_asphonesplus');














					
	


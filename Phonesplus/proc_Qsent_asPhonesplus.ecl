import header, gong, Risk_Indicators,ut;

ppCandidate := dataset(ut.foreign_prod + 'thor_data400::in::qsent_clean',Phonesplus.layoutCommonOut,thor);

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
self.TDSMatch := if(R.ssc != '',1,L.TDSMatch);

self := L;
end;

hascelltype	:= join(goodnpanxx,dd_tds,
				left.npa = right.npa and 
				left.nxx = right.nxx and 
				left.tb  = right.tb,
			    t_tds(left,right),left outer,local); 
				
/* ************************************************************************************************** */
//Found in Gong History/Current ?
dd_gongH := Gong.File_History(phone10 <> '');

hascelltype t_neverseen(hascelltype L ,dd_Gongh R) := transform
self.InitScoreType		:= map(R.phone10 = '' and L.InitScoreType = '' => 'NEVERSEEN',L.InitScoreType);
self.InitScore			:= if(R.phone10 = '',if(L.InitScoreType = '',if((string)L.DateLastSeen[1..4] < '2001',3,11),L.InitScore),L.InitScore);
self 					:= L
end;					

neverseen 				:= join(sort(distribute(hascelltype,hash(CellPhone)),CellPhone,local),
							dedup(sort(distribute(dd_gongH,hash(phone10)),phone10,local), phone10, local),
								left.Cellphone = right.phone10,
								t_neverseen(left,right),left outer,local);
								
/* ************************************************************************************************** */
//Neverseen's Address found in Gong Current ?
currGong := Gong.File_GongBase;
f_currGong := currGong(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
			phoneno[1] > '1' and phoneno[7..10] != '0000' and phoneno[7..10] != '9999');

/*
neverseen  t_CurrAddr(neverseen  L ,f_currGong R) := transform
self.InitScore			:= map(R.phoneno != '' and L.InitScoreType = 'NEVERSEEN' => 0,L.InitScore);
self.InitScoreType		:= map(R.phoneno != '' and L.InitScoreType = 'NEVERSEEN' => 'CURRADDR',L.InitScoreTYPE);

self 					:= L;
end;					

nonCurrAddr				:= join(sort(distribute(neverseen,hash(prim_range,prim_name,zip5)),
									 prim_range,prim_name,zip5,local),
								dedup(sort(distribute(f_currGong,hash(prim_range,prim_name,z5)),
									 prim_range,prim_name,z5,local),prim_range,prim_name,z5,local),
						        //left.InitScoreType = 'NEVERSEEN' and 
								left.prim_range = right.prim_range and
								left.prim_name = right.prim_name and
								left.zip5 = right.z5,
								t_CurrAddr(left,right),left outer,local);
*/
/* ************************************************************************************************** */
//Score '0' for Matches to Phonesplus
pp := dedup(sort(distribute(Phonesplus.file_phonesplus_base,hash(CellPhone)),CellPhone,local), Cellphone, local);

neverseen	 t_remPP(neverseen L ,pp R) := transform
self.InitScore	:= if(R.Cellphone != '',0,L.InitScore);
			
self.InitScoreType	:= if(R.Cellphone != '','PP',L.InitScoreType);


self 				:= L;
end;					

ppmatch := join(sort(distribute(neverseen,hash(CellPhone)),CellPhone,local),
				 	      pp,
						left.CellPhone = right.CellPhone,
						t_remPP(left,right),left outer,local);

/* ************************************************************************************************** */
//Mark Active Gong under different name and 
// Mark QSENT Other	
//CCPA-5 Add global_sid and record_sid to Qsent base file
Phonesplus.layoutCommonOut_CCPA t_mrkActive(ppmatch L ,f_currgong R) := transform
self.ActiveFlag := if(R.phoneno != '','Y','');
self.InitScore		:= if(L.InitScoreType = '',5,L.InitScore);
self.InitScoreType	:= if(L.InitScoreType = '','QSENT OTHER',L.InitScoreType);
self.ConfidenceScore:= L.InitScore + L.TDSMatch;
self.global_sid := 0;
self.record_sid := 0;
self := L;
end;					

ActiveDiffName := join(sort(distribute(ppmatch,hash(CellPhone,prim_range,prim_name,zip5)),CellPhone,prim_range,prim_name,zip5,local)
				 ,dedup(sort(distribute(f_currgong,hash(phoneno,prim_range,prim_name,z5)),phoneno,prim_range,prim_name,z5,local),phoneno,prim_range,prim_name,z5,local),
						left.Cellphone = right.phoneno and
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.zip5 = right.z5,
						t_mrkActive(left,right),left outer,local);

		
export proc_Qsent_asPhonesplus := ActiveDiffName;

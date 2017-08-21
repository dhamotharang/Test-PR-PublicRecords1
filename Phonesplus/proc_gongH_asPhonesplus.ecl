import gong,risk_indicators,ut;

ppCandidate := Phonesplus.map_GongHtoPhonesplus;

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


p_ppCandidate t_tpm(p_ppCandidate L ,tpm R) := transform
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
self.InitScore			:= 3;
self.InitScoreType		:= 'DISCONN';

self := L;
end;

hascelltype	:= join(goodnpanxx,dd_tds,
				left.npa = right.npa and 
				left.nxx = right.nxx and 
				left.tb  = right.tb,
			    t_tds(left,right),left outer,local); 
				
f_hascelltype:= hascelltype(TDSMatch != 0 or (DateLastSeen > 200412 and DateLastSeen < (unsigned3)ut.GetDate - 3));
					
/* ************************************************************************************************** */
//Remove any disconnect that is in the current Gong at any address	


CurrGong := Gong.File_GongBase;
f_currGong := currGong(phoneno != '' and length(stringlib.stringfilter(phoneno,'0123456789')) = 10 and 
			phoneno[7..10] != '0000' and phoneno[7..10] != '9999' and publish_code != 'NP');




Phonesplus.layoutCommonOut t_remActive(f_hascelltype L ,f_currGong R) := transform
self := L;
end;					

nonActive := join(sort(distribute(f_hascelltype,hash(CellPhone)),CellPhone,local),
				 dedup(sort(distribute(f_currGong,hash(phoneno)),phoneno,local),phoneno,local),
						left.Cellphone = right.phoneno,
						t_remActive(left,right),left only,local): PERSIST('~thor400_30::persist::GongH_asphonesplus'); 
	
 
export proc_GongH_asPhonesplus := nonActive;

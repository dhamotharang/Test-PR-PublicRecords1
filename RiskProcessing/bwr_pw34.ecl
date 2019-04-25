#workunit('name','FCRA-pw34-process');
#option ('hthorMemoryLimit', 1000)
  
import riskwiseFCRA, riskwise, Scoring, risk_indicators;

layout_prii := record
     string ACCOUNT;
     string first;
     string MIDDLEINI;
     string last;
     string addr;
     string CITY;
     string STATE;
     string ZIP;
     string HPHONE;
     string SOCs;
     string DOB;
     string WPHONE;
     string INCOME;
     string DRLC;
     string DRLCST;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERLAST;
     string EMAIL;
     string COMPANY;
     integer HistoryDateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('~jpyon::in::embarq_1276_f_s_in', layout_prii, csv(QUOTE('"')));
//f := choosen(dataset('~jpyon::in::embarq_1276_f_s_in', layout_prii, csv(QUOTE('"'))),20);
output(f);


//mapping
Scoring.Layout_PRWO_Soapcall into_PRWO_input(f le) := transform
	self.tribcode := 'pw34';  // !! replace the tribcode here !!
//	self.run_Seed:=false ;
	self.dppapurpose := 0;
	self.glbpurpose := 5;
	
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);
	
//self.gateways := dataset([{'Neutral', 'http://oroxievip.sc.seisint.com:9876'}], risk_indicators.Layout_Gateways_In);
	self := le;
	self := [];
end;

soap_in := project(f,into_PRWO_input(LEFT));
output(soap_in, named('soap_in'));

roxieIP :='http://fcrabatch.sc.seisint.com:9876' ; // fcra roxie
isFCRA := true;


PRWO_layout := RECORD
	unsigned4 seq := 0;
	STRING account := '';
	STRING riskwiseid := '';
	STRING firstcount := '';
	STRING lastcount := '';
	STRING addrcount := '';
	STRING formeraddrcount := '';
	STRING hphonecount := '';
	STRING socscount := '';
	STRING socsverlevel := '';
	STRING dobcount := '';
	STRING drlccount := '';
	STRING cmpycount := '';
	STRING verfirst := '';
	STRING verlast := '';
	STRING vercmpy := '';
	STRING veraddr := '';
	STRING vercity := '';
	STRING verstate := '';
	STRING verzip := '';
	STRING verhphone := '';
	STRING versocs := '';
	STRING verdrlc := '';
	STRING verdob := '';
	STRING numelever := '';
	STRING numsource := '';
	STRING firstscore := '';
	STRING lastscore := '';
	STRING cmpyscore := '';
	STRING addrscore := '';
	STRING hphonescore := '';
	STRING socsscore := '';
	STRING dobscore := '';
	STRING drlcscore := '';
	STRING wphonename := '';
	STRING wphoneaddr := '';
	STRING wphonecity := '';
	STRING wphonestate := '';
	STRING wphonezip := '';
	STRING socsmiskeyflag := '';
	STRING hphonemiskeyflag := '';
	STRING addrmiskeyflag := '';
	STRING idtheftflag := '';
	STRING aptscanflag := '';
	STRING addrhistoryflag := '';
	STRING coaalertflag := '';
	STRING coafirst := '';
	STRING coalast := '';
	STRING coaaddr := '';
	STRING coacity := '';
	STRING coastate := '';
	STRING coazip := '';
	STRING wphonetypeflag := '';
	STRING wphonevalflag := '';
	STRING hphonetypeflag := '';
	STRING hphonevalflag := '';
	STRING phonezipflag := '';
	STRING phonedissflag := '';
	STRING addrvalflag := '';
	STRING dwelltypeflag := '';
	STRING ziptypeflag := '';
	STRING socsvalflag := '';
	STRING decsflag := '';
	STRING socsdobflag := '';
	STRING areacodesplitflag := '';
	STRING altareacode := '';
	STRING bansflag := '';
	STRING drlcvalflag := '';
	STRING drlcsoundx := '';
	STRING drlcfirst := '';
	STRING drlclast := '';
	STRING drlcmiddle := '';
	STRING drlcsocs := '';
	STRING drlcdob := '';
	STRING drlcgender := '';
	STRING distaddrprevaddr := '';
	STRING disthphonewphone := '';
	STRING distwphoneaddr := '';
	STRING statezipflag := '';
	STRING cityzipflag := '';
	STRING hphonestateflag := '';
	STRING checkacctflag := '';
	STRING cassaddr := '';
	STRING casscity := '';
	STRING cassstate := '';
	STRING casszip := '';
	STRING addrcommflag := '';
	STRING nonresname := '';
	STRING nonressic := '';
	STRING nonresphone := '';
	STRING nonresaddr := '';
	STRING nonrescity := '';
	STRING nonresstate := '';
	STRING nonreszip := '';
	STRING numfraud := '';
	STRING airwavesscore := '';
	STRING score2 := '';
	STRING tciaddrflag := '';
	STRING tciprevaddrflag := '';
	STRING estincome := '';
	STRING emaildomainflag := '';
	STRING emailuserflag := '';
	STRING emailbrowserflag := '';
	STRING hriskemaildomainflag := '';
	STRING distaddrdomain := '';
END;

Scoring.MAC_PROD_Soapcall(soap_in, PRWO_layout, roxieIP, 'RiskWiseFCRA.RiskWiseMainPRWO',s_f, parallel_threads);

s := s_f(errorcode=''); // + s_f2;

output(s, named('results'));

output(s,,'~jpyon::out::embarq_1276_pw34_out2',CSV(heading(single),QUOTE('"')), overwrite);
output(s(errorcode<>''),,'~jpyon::out::embarq_1276_pw34_errors2',CSV(QUOTE('"')), overwrite);


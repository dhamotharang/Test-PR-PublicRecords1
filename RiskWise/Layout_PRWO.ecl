import Risk_Indicators;

export Layout_PRWO := record
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
	DATASET(risk_indicators.Layout_Billing) Billing;
END;
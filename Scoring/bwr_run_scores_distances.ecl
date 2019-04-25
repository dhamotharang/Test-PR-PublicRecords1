SD2I := record
     string30 account := '';
     string1 apptype := '';
     string15 first := '';
     string20 last := '';
     string30 cmpy := '';
     string50 addr := '';
     string30 city := '';
     string2 state := '';
     string9 zip := '';
     string9 socs := '';
     string8 dob := '';
     string10 hphone := '';
     string10 wphone := '';
     string20 drlc := '';
     string2 drlcstate := '';
     string50 email := '';
     string1 apptype2 := '';
     string15 first2 := '';
     string20 last2 := '';
     string30 cmpy2 := '';
     string50 addr2 := '';
     string30 city2 := '';
     string2 state2 := '';
     string9 zip2 := '';
     string9 socs2 := '';
     string8 dob2 := '';
     string10 hphone2 := '';
     string10 wphone2 := '';
     string20 drlc2 := '';
     string2 drlcstate2 := '';
     string50 email2 := '';
     string6 saleamt := '';
     string8 purchdate := '';
     string6 purchtime := '';
     string11 checkaba := '';
     string9 checkacct := '';
     string7 checknum := '';
     string40 bankname := '';
     string2 pymtmethod := '';
     string1 cctype := '';
     string2 avscode := '';
     string2 inquiries := '';
     string3 trades := '';
     string6 balance := '';
     string6 bankbalance := '';
     string6 highcredit := '';
     string3 delinquent90plus := '';
     string2 revolving := '';
     string2 autotrades := '';
     string2 autotradesopen := '';
     string6 income := '';
     string6 income2 := '';
     string39 ipaddr := '';
     string16 ccnum := '';
     string8 ccexpdate := '';
     string2 taxclass := '';
end;

f := dataset('~eschepers::in::bestbuy_goods_dist_ist', SD2I, csv(quote('"')));
output(f, named('f'));


roxieIP := 'http://stcloudroxievip.sc.seisint.com:9876';  //St. Cloud Roxie
//roxieIP := 'http://10.173.193.240:9876';    //QA Roxie

s := risk_indicators.Scores_And_Distances_Soapcall(project(f, transform(riskwise.Layout_SD2I, self := left)), roxieIP);
/*
 this join doesn't work if there are duplicate account numbers in the file, need to make unique by using seq
try_2 := JOIN(f, s(errorcode<>''), LEFT.account=RIGHT.account, TRANSFORM(SD2I,SELF := LEFT));
s2 := risk_indicators.Scores_And_Distances_Soapcall(project(try_2, transform(riskwise.Layout_SD2I, self := left)), roxieIP);
ret := s(errorcode='') + s2;
output(ret);
*/
output(s,, '~eschepers::out::bestbuy_goods_dist_ist', csv(quote('"')));
output(s(errorcode!=''), named('errors'));
import STD, risk_indicators;
export _shortcuts := module

  // export neutral_roxie_cert := 'http://roxiestaging.br.seisint.com:9876';
  export neutral_roxie_cert := 'http://roxieqavip.br.seisint.com:9876';
  export dev_one_way_1 := 'http://10.173.3.1:9876';
  export dev_one_way_2 := 'http://10.173.3.2:9876';
  export dev_one_way_3 := 'http://10.173.3.3:9876';
  export dev_one_way_4 := 'http://10.173.3.4:9876';
  export dev_one_way_5 := 'http://10.173.3.5:9876';
  export dev_one_way_6 := 'http://10.173.3.6:9876';
  export dev_one_way_7 := 'http://10.173.3.7:9876';
  export dev_one_way_8 := 'http://10.173.3.8:9876';
  export dev_one_way_9 := 'http://10.173.3.9:9876';
  export dev_one_way_10 := 'http://10.173.3.10:9876';
  export dev154_roxie := 'http://dev154vip.hpcc.risk.regn.net:9876'; //or a specific node: http://10.173.154.1:9876'
  export dev155_roxie := 'http://dev155vip.hpcc.risk.regn.net:9876'; // 'http://10.173.155.1:9876'
  export dev156_roxie := 'http://dev156vip.hpcc.risk.regn.net:9876'; // 'http://10.173.156.1:9876'
  export dev157_roxie := 'http://dev157vip.hpcc.risk.regn.net:9876'; // 'http://10.173.157.1:9876'
  export dev158_roxie := 'http://dev158vip.hpcc.risk.regn.net:9876'; // 'http://10.173.158.1:9876'
  export soapshark(string target) := 'https://bctwpprroxie301.risk.regn.net/SoapShark/capture?target=' + STD.STR.toLowerCase(target);

  // This is just for testing convenience, feel free to add any gateway you need to this list.
  // ... but please avoid having credentials committed to git.
  // ... or, alternatively, add gateway._shortcuts to .ignore and change this as you wish.
  export gateways := dataset([
    {'neutralroxie', neutral_roxie_cert},
    {'qsentv2', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'targus', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'delta_phonefinder', '<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'accudata_ocn', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'ZumigoIdentity', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'ThreatMetrix', 'http:/<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'}
  ], risk_indicators.Layout_Gateways_In);

end;

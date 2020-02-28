import risk_indicators;
export _shortcuts := module

  export neutral_roxie_cert := 'http://roxiestaging.br.seisint.com:9876';
  
  
  // This is just for testing convenience, feel free to add any gateway you need to this list.
  // ... but please avoid having credentials committed to git.
  // ... or, alternatively, add gateway._shortcuts to .ignore and change this as you wish.
  export gateways := dataset([
    {'neutralroxie', 'http://roxiestaging.br.seisint.com:9876'},
    {'qsentv2', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'targus', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'delta_phonefinder', '<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'accudata_ocn', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'ZumigoIdentity', 'http://<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'},
    {'ThreatMetrix', 'http:/<redacted_user:password>@gatewaycertesp.sc.seisint.com:7726/WsGatewayEx/?ver_=999'}
  ], risk_indicators.Layout_Gateways_In);

end;

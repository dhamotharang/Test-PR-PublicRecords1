#warning('Deprecated. Use Gateway.SoapCall_NetAcuity instead.')
import risk_indicators;

export NA_SoapCall_Function(dataset(layout_NA_In) Inf, string gateway_URL) := function

//'http://wsgatewaycert.sc.seisint.com:8090/WsGateway';

layout_NA_In into_in(inf L) := transform
	self.netaddress := trim(L.netaddress);
	self := L;
end;

layout_na_out failX() := transform
	self.response.header.errmsg := FAILMESSAGE;
	self.response.header.errcode := FAILCODE;
	self := [];
end;

outf := if (gateway_URL != '', soapcall(inf, gateway_URL, 'NetAcuity',netAcuity.Layout_NA_In, into_in(LEFT),
			   dataset(netacuity.layout_NA_Out),XPATH('NetAcuityResponse'),
			   onfail(failx()), timeout(1)));

return outf;
			   
end;

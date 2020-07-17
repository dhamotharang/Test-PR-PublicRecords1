IMPORT riskwise, Risk_Indicators;
EXPORT GetGateways() := FUNCTION

gw_targus := riskwise.shortcuts.gw_targus;
gw_targus_prod := riskwise.shortcuts.gw_targus_prod ;
tmx_gw := riskwise.shortcuts.gw_threatmetrix;
// PROD gateways
Prefix1 := $.Constants.Prefix1; 
Prefix2 := $.Constants.Prefix2;
d_gateway_pf_prod:= DATASET([{'qsentv2', 'https://'+ Prefix1 + Prefix2 + 'gatewayprodesp.sc.seisint.com:8426/WsGateway?ver_=1.70'},
                             {'delta_phonefinder', 'https://'+ Prefix1 + Prefix2 + '10.176.69.151:8909/WsDeltaBase'},
                             {'delta_inquiry', 'https://'+ Prefix1 + Prefix2 + '10.176.69.151:8909/WsDeltaBase'},
                             {'accudata_cnam', 'https://'+ Prefix1 + Prefix2 + 'gatewayprodesp.sc.seisint.com:8246/WsGatewayEx/AccudataCnam?ver_=2.06'},
                             {'ZumigoIdentity', 'https://'+ Prefix1 + Prefix2 + 'gatewayprodesp.sc.seisint.com:8246/WsGatewayEx/ZumigoIdentity?ver_=2.05'}
                    ], Risk_Indicators.Layout_Gateways_In);

dGWIn := gw_targus_prod + tmx_gw + d_gateway_pf_prod;

RETURN dGWIn;
END;
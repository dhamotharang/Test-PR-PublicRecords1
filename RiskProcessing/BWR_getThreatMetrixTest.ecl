import ut, iesp, gateway, Risk_Indicators;


myInput := project(Risk_indicators.iid_constants.ds_record, transform(Risk_Indicators.layouts.layout_trustdefender_in,
																				
																				self.SessionId := trim('2067933A8E61C3616767047A42C727D6'),   
																				self.OrgId := trim('ymyo6b64'),
																				self.ApiKey := trim('dc1lautzmb0s44s4'),
																				self.Policy := trim('default'),
																				self.ApiType := trim('SessionQuery'),
																				self.serviceType := trim('all'),
																				self.seq := 1,
																				self := []
																				));																									

gateways := project(Risk_indicators.iid_constants.ds_record, transform(Gateway.Layouts.Config, self.ServiceName := 'ThreatMetrix',
																																				self.url :='http://rw_score_dev:Password01@10.176.68.164:7726/WsGatewayEx/TrustDefender/?ver_=1.95', //actual testing
																																				self.TransactionId := '16218257T5',
																																				self := [] 
																																				));
// gateways := gateways1[1];

mygateway_results := Risk_Indicators.getThreatMetrix(myInput, gateways);

output(myInput, named('myInput'));
output(gateways, named('gateways'));
output(mygateway_results, named('mygateway_results'));
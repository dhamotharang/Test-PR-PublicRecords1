
sequential(
           //gateway_collection_log.Spray_Input('bctlpedata12','/data/temp/crim/10.0.75.1_wsgateway_collectionreport_20190923.csv','20190926','thor400_dev1');
           gateway_collection_log.Proc_build_base('20190927','',false),
           gateway_collection_log.Proc_build_keys('20190927')
					 );
					 
/*           
// Warning:  Definition mac_sk_move_v2 is marked as deprecated.  use promotesupers.Mac_SK_Move_v2 
// ************* ETL - DATA FAB ********************
// infile := dataset('~thor400::ccpa::wsgatewayex_collectionreport.working',InLayout,CSV(SEPARATOR(','),TERMINATOR(['\n'])));
// infile := dataset('~thor400::ccpa::wsgatewayex.collectionreport.working',InLayout,CSV(SEPARATOR(','),TERMINATOR(['\n'])));
// infile := dataset('~thor400::ccpa::wsgatewayex_collectionreport_20190919.working',InLayout,CSV(SEPARATOR(','),TERMINATOR(['\n'])));
infile := dataset('~thor400::ccpa::wsgatewayex_collectionreport_20190919.working',gateway_collection_log.Layouts.raw_xml_in,CSV(SEPARATOR(','),TERMINATOR(['\n'])));
infile;

infile_decoded := gateway_collection_log.targus_file_reader.decodeFile(infile);
req_formatted := gateway_collection_log.targus_file_reader.formatRequest(infile_decoded);
resp_formatted := gateway_collection_log.targus_file_reader.formatResponse(infile_decoded);

output(req_formatted, named('req_formatted'));
output(resp_formatted, named('resp_formatted'));

// ************* SHARED PARSER CODE ********************

// -- dx_gateway is the interface between data and query
// 		-- shared index definition and key layout under dx_gateway; build code, base files, etc, should be under gateway_collection_log
// 		-- shared functions to parse gateway request/response and apply optout

req_parsed := dx_gateway.parser_targus.parseRequest(req_formatted);
resp_parsed := dx_gateway.parser_targus.parseResponse(resp_formatted);

output(req_parsed, named('req_parsed'));
output(resp_parsed, named('resp_parsed'));

// we need this to append lexid (remote)
gateways := dataset([{'neutralroxie', 'http://certstagingvip.hpcc.risk.regn.net:9876'}], risk_indicators.Layout_Gateways_In);
#STORED('Gateways', gateways);

mod_access := MODULE(doxie.IDataAccess)END;
// -- the code in dx_gateway.mac_append_did() can be replaced on ThorProd branch to use any standard did append routines
dx_gateway.mac_append_did(req_parsed, d_req_did_append, mod_access, FALSE);
d_req_did_optout := Suppress.MAC_FlagSuppressedSource(d_req_did_append, mod_access, did);

output(d_req_did_append, named('req_parsed_with_dids'));
output(d_req_did_optout, named('req_parsed_with_dids_optout'));
		
dx_gateway.mac_append_did(resp_parsed, d_resp_did_append, mod_access, FALSE);
d_resp_did_optout := Suppress.MAC_FlagSuppressedSource(d_resp_did_append, mod_access, did);

output(d_resp_did_append, named('resp_parsed_with_dids'));
output(d_resp_did_optout, named('resp_parsed_with_dids_optout'));*/

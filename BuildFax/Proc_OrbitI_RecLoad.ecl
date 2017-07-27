import orbit;
export Proc_OrbitI_RecLoad(string pdate,string product,string emailme) := function

// Get token for orbit user (generic) - authorization purpose.

tokenval := orbit.GetToken();

// Receive item

rec_status := Orbit.ReceiveItem(orbitIConstants(product).datasetname,
																orbitIConstants(product).media,
																orbitIConstants(product).updatetype,
																orbitIConstants(product).sourcename,
																tokenval,
																orbitIConstants(product).orbitreceivedate(pdate));

// Load the received item

load_item_status := orbit.LoadRemoteItem(tokenval,
														orbitIConstants(product).sourcename,
														orbitIConstants(product).datasetname,
														orbitIConstants(product).orbitreceivedate(pdate));

// Set file status - dummy for now

filestatus := orbit.SetSprayFileStatus(tokenval,
															orbitIConstants(product).orbitfilename,
															orbitIConstants(product).orbitpathname(pdate),
															WORKUNIT);


return sequential(
						output(rec_status[1].xmlrequest,named('receive_input_xml')),
						if ( rec_status[1].retcode = 'Success',
						sequential(
						output(load_item_status[1].requestxml,named('load_input_xml')),
						if (load_item_status[1].retcode = 'Success',
								sequential(output(filestatus),
								fileservices.sendemail(
												OrbitIConstants(product,emailme).dremaillist,
												product +' OrbitI Receive and Load:'+pdate+':SUCCESS',
												product +' OrbitI receive and load successful for '+pdate)),
								fileservices.sendemail(
												OrbitIConstants(product,emailme).emaillist,
												product +' OrbitI Load Item:'+pdate+':FAILED',
												'OrbitI Load Item failed. Reason: ' + load_item_status[1].retdesc)	
						 )
						 ),
						 
					fileservices.sendemail(
												OrbitIConstants(product,emailme).emaillist,
												product+' OrbitI Receive Item:'+pdate+':FAILED',
												'OrbitI Load Receive failed. Reason: ' + rec_status[1].retdesc)						 
					));

end;
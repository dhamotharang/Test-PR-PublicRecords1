import STD, UT;
EXPORT modWsTopology(
									string p_esp = ''
									,string p_port = '8010'
									
												) := module
	
	export vWebService := 'WsTopology';
	
	// if pythonversion is set to 2
	// use python2 code else use python3
	// to allow backward compatibility in code
	#IF (dops.constants.pythonversion = 2)
	import Python;
	export integer fIsNodeUp(STRING ip) := EMBED(Python)
	import socket
	sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	sock.settimeout(1)
	result = sock.connect_ex((ip, 7100))
	sock.close()
	return result
	ENDEMBED;
	#ELSE
	import Python3;
	export integer fIsNodeUp(STRING ip) := EMBED(Python3)
	import socket
	sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	sock.settimeout(1)
	result = sock.connect_ex((ip, 7100))
	sock.close()
	return result
	ENDEMBED;
	#END
	
	export fTpTargetClusterQuery(
												string p_type = '' // roxie or thor
												,string p_targetcluster = '') := function
												
		rTpMachineInfo := record
			string Name{xpath('Name')};
			string Netaddress{xpath('Netaddress')};
			string Path{xpath('Path')};
			string Directory{xpath('Directory')};
			string QueueName{xpath('QueueName')};
		end;
		
		rTpClusterInfo := record
			string Directory{xpath('Directory')};
			string LogDirectory{xpath('LogDirectory')};
			dataset(rTpMachineInfo) dTpMachineInfo{xpath('TpMachines/TpMachine')};
		end;
		
		rTpTargetCluster := record
			string Type{xpath('Type')};
			string Name{xpath('Name')};
			dataset(rTpClusterInfo) dTpClusterInfo{xpath('TpClusters/TpCluster')};
		end;
		
		rTpTargetClusterQueryRequest := record
			string Type{xpath('Type')} := p_type;
			string Name{xpath('Name')} := p_targetcluster;
			
		end;
		
		rTpTargetClusterQueryResponse := record
			string ShowDetails{xpath('ShowDetails')};
			string MemThresholdType{xpath('MemThresholdType')};
			//string MemThreshold;
			dataset(rTpTargetCluster) dTpTargetClusters{xpath('TpTargetClusters/TpTargetCluster')};
		end;
		
		dSoapResults := SOAPCALL(
				//'http://10.176.152.120:4546/'
				'http://'+p_esp+':'+p_port+'/' + vWebService+'?ver_=1.75'
				,'TpTargetClusterQuery'
				,rTpTargetClusterQueryRequest
				,dataset(rTpTargetClusterQueryResponse)
				,xpath('TpTargetClusterQueryResponse')
				,LOG
				,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues()));
		
		rPartsWithDataset := record
			string ShowDetails := '';
			string Type := '';
			string Name := '';
			string QueueName := '';
			string Build := '';
			string Directory := '';
			string LogDirectory := '';
			string Desc := '';
			string Prefix := '';
			string Path := '';
			string DataModel := '';
			string OS := '';
			string HasThorSpareProcess := '';
			string Netaddress := '';
			string ConfigNetaddress := '';
			string Domain := '';
			string Available := '';
			string Port := '';
			string ProcessNumber := '';
			dataset(rTpTargetCluster) dTpTargetClusters;
			dataset(rTpClusterInfo) dTpClusterInfo;
			dataset(rTpMachineInfo) dTpMachineInfo;
			//dataset(rTpMachine) dTpMachines;
		end;
		
		rParts := record
			boolean isNodeUp := true;
			rPartsWithDataset - [dTpTargetClusters, dTpClusterInfo, dTpMachineInfo];
		end;
		
		rPartsWithDataset xTargetCluster(dSoapResults l, rTpTargetCluster r) := transform
			self := r;
			self := l;
			self := [];
		end;
		
		dTpTargetCluster := normalize(dSoapResults,left.dTpTargetClusters,xTargetCluster(left,right));
		
		rPartsWithDataset xClusterInfo(dTpTargetCluster l, rTpClusterInfo r) := transform
			
			self := r;
			self := l;
			//self := [];
		end;
		
		dClusterInfo := normalize(dTpTargetCluster,left.dTpClusterInfo,xClusterInfo(left,right));
		
		rParts xMachineInfo(dClusterInfo l, rTpMachineInfo r) := transform
			//self.path := (string)STD.Str.DecodeBase64(r.Path);
			self := r;
			self := l;
			
		end;
		
		dParts := normalize(dClusterInfo,left.dTpMachineInfo,xMachineInfo(left,right));
		
		rParts xCheckNodes(dParts l) := transform
			self.isNodeUp := if (fisNodeUp(l.NetAddress) = 0, true, false);
			self := l;
		end;
		
		dCheckNodes := project(dParts,xCheckNodes(left));
		
		return dCheckNodes;
		
	end;
end;
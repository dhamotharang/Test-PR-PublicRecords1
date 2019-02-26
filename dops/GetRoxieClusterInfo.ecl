import did_add,STD,ut;
// Module: Get roxie cluster info 
// Functions: ClustersAssociatedESP and LiveCluster
// ClustersAssociatedESP - list of all clusters associated to ESP passed
// LiveCluster - Get cluster that live behind roxie vip within the associated cluster list
EXPORT GetRoxieClusterInfo(string roxieesp = ''
																	,string roxieport = '8010') := module
	
	export ClustersAssociatedToESP(string l_esp = roxieesp
																	,string l_port = roxieport) := function
		
		rTpClusterQueryRequest  := record
			string Type{xpath('Type')} := 'RoxieCluster';
		end;
		
		rTpClusterQueryResponse := record
			string Name{xpath('Name')};
		end;
		
		dTpClusterQuery := SOAPCALL(
				'http://'+l_esp+':'+l_port+'/WsTopology'
				,'TpClusterQuery'
				,rTpClusterQueryRequest
				,dataset(rTpClusterQueryResponse),
				xpath('TpClusterQueryResponse/TpClusters/TpCluster')
				,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
				,LOG);
				
		return dTpClusterQuery;
	end;
	
	export LiveCluster(string roxievip
											,string l_esp = roxieesp
											,string l_port = roxieport
											) := function
		roxiepackagename := did_add.get_EnvVariable('roxie_package_name',roxievip);
		
		dClustersAssociatedToESP := ClustersAssociatedToESP(l_esp,l_port);
		
		rClusterPackage := record
			string clustername;
			string packagename := '';
		end;
		
		rClusterPackage xClusterPackage(dClustersAssociatedToESP l) := transform
			self.clustername := l.Name;
			self.packagename := dedup(dops.GetRoxiePackage(l_esp, l_port, l.Name).Keys()(regexfind(roxiepackagename,packagename,nocase)),packagename)[1].packagename;
		end;

		dClusterPackage := dedup(project(dClustersAssociatedToESP,xClusterPackage(left))(packagename <> ''),packagename);
		
		return if (STD.Str.ToUpperCase(roxiepackagename) = 'DEFAULT' or trim(roxiepackagename) = ''
								,''
								,dClusterPackage[1].clustername);
		
	end;
	
	
	export fESPAssociatedToCluster(string p_cluster
																,string p_environment
																,string p_port = '8010') := function
		dESPs := dataset(dops.constants.vESPSet(p_cluster,p_environment),{string esps});

		rMatchingESP := record
			string esp;
			string roxiecluster;
		end;

		rMatchingESP xMatchingESP(dESPs l) := transform
			l_roxiecluster := LiveCluster(dops.constants.vRoxieVIP(p_cluster,p_environment),l.esps,p_port);
			self.esp := if (l_roxiecluster <> '', l.esps, '');
			self.roxiecluster := l_roxiecluster;
		end;

		dMatchingESP := project(dESPs,xMatchingESP(left))(esp <> '');

		return dedup(dMatchingESP,roxiecluster,KEEP(1));
	end;
	
	
end;
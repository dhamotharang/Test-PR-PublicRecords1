import did_add,STD;
// Module: Get roxie cluster info 
// Functions: ClustersAssociatedESP and LiveCluster
// ClustersAssociatedESP - list of all clusters associated to ESP passed
// LiveCluster - Get cluster that live behind roxie vip within the associated cluster list
EXPORT GetRoxieClusterInfo(string roxieesp, string roxieport = '8010') := module
	export ClustersAssociatedToESP() := function
		
		rTpClusterQueryRequest  := record
			string Type{xpath('Type')} := 'RoxieCluster';
		end;
		
		rTpClusterQueryResponse := record
			string Name{xpath('Name')};
		end;
		
		dTpClusterQuery := SOAPCALL(
				'http://'+roxieesp+':'+roxieport+'/WsTopology'
				,'TpClusterQuery'
				,rTpClusterQueryRequest
				,dataset(rTpClusterQueryResponse),
				xpath('TpClusterQueryResponse/TpClusters/TpCluster'));
				
		return dTpClusterQuery;
	end;
	
	export LiveCluster(string roxievip) := function
		roxiepackagename := did_add.get_EnvVariable('roxie_package_name',roxievip);
		
		dClustersAssociatedToESP := ClustersAssociatedToESP();
		
		rClusterPackage := record
			string clustername;
			string packagename := '';
		end;
		
		rClusterPackage xClusterPackage(dClustersAssociatedToESP l) := transform
			self.clustername := l.Name;
			self.packagename := dedup(dops.GetRoxiePackage(roxieesp, roxieport, l.Name).Keys()(regexfind(roxiepackagename,packagename,nocase)),packagename)[1].packagename;
		end;

		dClusterPackage := dedup(project(dClustersAssociatedToESP,xClusterPackage(left))(packagename <> ''),packagename);
		
		return if (STD.Str.ToUpperCase(roxiepackagename) = 'DEFAULT' or trim(roxiepackagename) = ''
								,''
								,dClusterPackage[1].clustername);
		
	end;
	
end;
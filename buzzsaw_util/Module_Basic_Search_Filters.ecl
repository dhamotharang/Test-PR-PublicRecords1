import buzzsaw;

export Module_Basic_Search_Filters := MODULE
	
	export by_srcport(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			INTEGER3 p) := FUNCTION
		RETURN IF( p < 0, ds, ds(srcport = p));
	END;
	
	export by_destport(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			INTEGER3 p) := FUNCTION
		RETURN IF( p < 0, ds, ds(destport = p));
	END;

	export wildcard_srcip(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			QSTRING ip) := FUNCTION
		UNSIGNED2 s1 := buzzsaw.Mod_Octets.F_Octet(ip, 1);
		UNSIGNED2 s2 := buzzsaw.Mod_Octets.F_Octet(ip, 2);
		UNSIGNED2 s3 := buzzsaw.Mod_Octets.F_Octet(ip, 3);
		UNSIGNED2 s4 := buzzsaw.Mod_Octets.F_Octet(ip, 4);

		f1 := if(s1 > 255, ds, ds(src_octets.octet1 = s1));
		f2 := if(s2 > 255, f1, f1(src_octets.octet2 = s2));
		f3 := if(s3 > 255, f2, f2(src_octets.octet3 = s3));
		f4 := if(s4 > 255, f3, f3(src_octets.octet4 = s4));
		
		RETURN f4;
	END;

	export wildcard_destip(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			QSTRING ip) := FUNCTION
		UNSIGNED2 d1 := buzzsaw.Mod_Octets.F_Octet(ip, 1);
		UNSIGNED2 d2 := buzzsaw.Mod_Octets.F_Octet(ip, 2);
		UNSIGNED2 d3 := buzzsaw.Mod_Octets.F_Octet(ip, 3);
		UNSIGNED2 d4 := buzzsaw.Mod_Octets.F_Octet(ip, 4);

		f5 := if(d1 > 255, ds, ds(dest_octets.octet1 = d1));
		f6 := if(d2 > 255, f5, f5(dest_octets.octet2 = d2));
		f7 := if(d3 > 255, f6, f6(dest_octets.octet3 = d3));
		f8 := if(d4 > 255, f7, f7(dest_octets.octet4 = d4));
		
		RETURN f8;
	END;

	export by_srcip(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			QSTRING ip) := FUNCTION
		RETURN MAP(
			buzzsaw.Mod_Octets.skip_filter(ip) => ds,
			buzzsaw.Mod_Octets.need_wildcard(ip) => wildcard_srcip(ds, ip),
			ds(srcip = ip));
	END;

	export by_destip(
			DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
			QSTRING ip) := FUNCTION
		RETURN MAP(
			buzzsaw.Mod_Octets.skip_filter(ip) => ds,
			buzzsaw.Mod_Octets.need_wildcard(ip) => wildcard_destip(ds, ip),
			ds(destip = ip));
	END;
	
export DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) F_Basic_Search(
		DATASET(buzzsaw.Mod_Data.L_Firewall_Octets) ds,
		QSTRING SourceIP, 
		INTEGER3 SourcePort, 
		QSTRING DestinationIP, 
		INTEGER3 DestinationPort, 
		BOOLEAN SortByIP) := FUNCTION

	f1 := by_srcport(ds, SourcePort);
	f2 := by_destport(f1, DestinationPort);
	f3 := by_destip(f2, DestinationIP);
	f4 := by_srcip(f3, SourceIP);
	RETURN f4;
				
END;	

END;
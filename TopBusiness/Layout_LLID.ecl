export Layout_LLID := module

	export LLID12 := module
	
		export Linked := record
			Layout_Linking.Linked.bid;
			Layout_Linking.Linked.brid;
			Layout_Linking.Linked.blid;
			Layout_Linking.Linked.beid;
			unsigned6 llid12;
			boolean active12;
		end;
	
	end;
	
	export LLID9 := module
	
		export Linked := record
			Layout_Linking.Linked.bid;
			Layout_Linking.Linked.brid;
			Layout_Linking.Linked.blid;
			Layout_Linking.Linked.beid;
			unsigned6 llid9;
			boolean active9;
		end;
	
	end;

end;

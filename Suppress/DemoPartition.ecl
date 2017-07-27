import codes, Suppress;

export DemoPartition(string demo_cust_name_val='') := module;
	 export boolean include_all := demo_cust_name_val = '';
	 shared unsigned6 low_did_value := Suppress.DemoPartitionTable(CustomerName=demo_cust_name_val)[1].didLow;
	 shared unsigned6 high_did_value := Suppress.DemoPartitionTable(CustomerName=demo_cust_name_val)[1].didHigh;
	 export boolean retainDID(unsigned6 in_did) := include_all or (in_did between low_did_value and high_did_value);
	 export boolean discardDID(unsigned6 in_did) := not retainDID(in_did);
end;	 

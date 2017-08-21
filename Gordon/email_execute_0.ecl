export email_execute_0(emailAddress, out_file) := macro

t := gordon.email_dataset(from = emailAddress or to = emailAddress);

gordon.graph_edge_record toEdge(gordon.email_dataset l) := 
	transform
		self.category := 0;
		self.from_category := 0;
		self.from_id := l.from;
		self.to_category := 0;
		self.to_id := l.to;
	end;

out_file := project(t, toEdge(left))

endmacro;
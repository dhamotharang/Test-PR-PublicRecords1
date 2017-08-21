r := 
	record
		unsigned1 category;
		unsigned1 from_category;
		varstring from_id;
		unsigned1 to_category;
		varstring to_id;
	end;

export graph_edge_record := r;
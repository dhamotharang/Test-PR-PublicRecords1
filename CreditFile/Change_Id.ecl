shared Change_Id(unsigned1 slice,unsigned4 current) := 
(current * 5 + slice - 1) * thorlib.nodes() + thorlib.node();
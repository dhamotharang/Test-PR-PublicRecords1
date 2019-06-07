export Layout_Consumer_out := record           
	targus.layout_consumer_In;
  targus.Layout_Consumer_slim;
	//Added for CCPA-6
	unsigned4 global_sid;
	unsigned8 record_sid;
end;
export Persists(

	boolean puseotherenvironment = false

) :=
module
	
	shared pnames := persistnames(puseotherenvironment);
	
	export ConsumerStandardizeInput		:= dataset(pnames.ConsumerStandardizeInput	,Layout_consumer.Temporary.StandardizeInput ,flat);
	export ConsumerAppendIds					:= dataset(pnames.ConsumerAppendIds					,Layout_consumer.Temporary.StandardizeInput	,flat);
                                                  
end;
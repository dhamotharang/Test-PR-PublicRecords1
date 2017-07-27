
export Persistnames := module
   
   shared root := _Dataset().thor_cluster_Persists + 'persist::' + _Dataset().name + '::';

    export StandardizeInput    := root + 'Standardize_Input';
	export AsBusinessHeader  := root + 'As_Business_Header';

end;
import ut;
EXPORT ReadData := module
	export fcra := dataset(consumerstatement.filenames('fcra').datafile,consumerstatement.layout.fcra.consumer,csv(separator('\t')),opt);
	export nonfcra := dataset(consumerstatement.filenames('nonfcra').datafile,consumerstatement.layout.nonfcra.consumer,csv(separator('\t')),opt);
end;
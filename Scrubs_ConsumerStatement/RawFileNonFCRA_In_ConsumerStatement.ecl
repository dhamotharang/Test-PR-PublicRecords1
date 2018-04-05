import ConsumerStatement;
EXPORT RawFileNonFCRA_In_ConsumerStatement := dataset(consumerstatement.filenames('nonfcra').rawfile,consumerstatement.layout.nonfcra.consumer,csv(separator('\t')),opt);
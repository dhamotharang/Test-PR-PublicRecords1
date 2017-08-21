import RoxieKeybuild;
export Copy_FCRA_Keys(string filedate) := function
	return sequential(official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::address');
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::addressb2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::citystname'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::citystnameb2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::name'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::nameb2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::namewords2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::payload'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::stname'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::stnameb2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::zip'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records','autokey::zipb2'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records_document','orid'),
	official_records.Proc_Copy_FCRA_Keys(filedate,'official_records_party','orid'),
	
	
	RoxieKeybuild.updateversion('FCRA_OfficialRecordsKeys',filedate,'skasavajjala@seisint.com',,'F')
	);
end;

import faa, FFD;

export layout_pilot_records := record
  faa.layout_airmen_Persistent_ID;
	unsigned6	did,
	FFD.Layouts.CommonRawRecordElements;
end;
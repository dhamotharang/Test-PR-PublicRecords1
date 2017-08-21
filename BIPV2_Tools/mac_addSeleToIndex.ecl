//requires sandboxed version of BIPV2.IDlayouts, most likely

EXPORT mac_addSeleToIndex(existing_index, existing_logical_name, new_logical_name) := macro

r := recordof(existing_index);
ei := existing_index;
output(choosen(ei, 20), named('existing_index'));

//pull and add new SELE fields
r3 := record
	BIPV2.IDlayouts.l_xlink_ids.UltID;
	BIPV2.IDlayouts.l_xlink_ids.OrgID;
	unsigned6 SELEID;
	BIPV2.IDlayouts.l_xlink_ids.ProxID;
	BIPV2.IDlayouts.l_xlink_ids.POWID;
	BIPV2.IDlayouts.l_xlink_ids.EmpID;
	BIPV2.IDlayouts.l_xlink_ids.DotID;
	
	BIPV2.IDlayouts.l_xlink_ids.UltScore;
	BIPV2.IDlayouts.l_xlink_ids.OrgScore;
	unsigned2 SELEScore;
	BIPV2.IDlayouts.l_xlink_ids.ProxScore;
	BIPV2.IDlayouts.l_xlink_ids.POWScore;
	BIPV2.IDlayouts.l_xlink_ids.EmpScore;
	BIPV2.IDlayouts.l_xlink_ids.DotScore;

	BIPV2.IDlayouts.l_xlink_ids.UltWeight;
	BIPV2.IDlayouts.l_xlink_ids.OrgWeight;
	unsigned2 SELEWeight;
	BIPV2.IDlayouts.l_xlink_ids.ProxWeight;
	BIPV2.IDlayouts.l_xlink_ids.POWWeight;
	BIPV2.IDlayouts.l_xlink_ids.EmpWeight;
	BIPV2.IDlayouts.l_xlink_ids.DotWeight;
	
	r - BIPV2.IDlayouts.l_key_ids;
end;
#uniquename(p)
%p% := 
project(
	pull(ei), 
	transform(
		r3, 
		self := left, 
		self.SELEID := left.ProxID,
		self.SELEScore := left.ProxScore,
		self.SELEWeight := left.ProxWeight,
		self := []
	)
);
output(%p%, named('projected'));

//index on new ID fields with new logical name

i :=index(
		%p%(UltID > 0),
		{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
		{%p%},
		new_logical_name
	);

b := build(
	i,
	overwrite
);

sequential(b, output(i, named('output_of_new_index')));

endmacro;

/*
//SAMPLE CALL (W20130312-082507)

existing_index := BIPV2.zzSampleKey.key;

existing_logical_name := BIPV2.zzSampleKey.logicalName;
output(existing_logical_name, named('existing_logical_name'));

new_logical_name := existing_logical_name + '_testing_new_logical3';
output(new_logical_name, named('new_logical_name'));

BIPV2_Tools.mac_addSeleToIndex(existing_index, existing_logical_name, new_logical_name)
*/




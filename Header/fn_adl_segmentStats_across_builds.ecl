import ut,doxie,header;

export fn_adl_segmentStats_across_builds(
dataset(recordof(header.Layout_Header)) ds_new,
dataset(recordof(header.Layout_Header)) ds_old
)
 := 
function

h_old := Header.fn_ADLSegmentation_v2(ds_old).core_check;
h_new := Header.fn_ADLSegmentation_v2(ds_new).core_check;

temp_rec := record 
h_new ; 
string25 changed_did := ''; 
end;  
 
temp_rec tjoin(h_new le, h_old ri) :=
   TRANSFORM
		SELF.changed_did := MAP(le.did=ri.did and le.ind <> ri.ind => ri.ind+'_TO_'+le.ind
		                       ,le.did=ri.did and le.ind = ri.ind =>'NO CHANGE'
							   ,le.did<> ri.did and ri.did =0 =>'Exists_H_new'
							   ,le.did<> ri.did and le.did =0 =>'Exists_H_old','' );
 		SELF := le
	END;
	
t_change0 := join(h_new,h_old,LEFT.did=RIGHT.did,tjoin(LEFT,RIGHT),full outer , LOCAL);

cross :=
RECORD
	t_change0.changed_did;
	cnt := COUNT(GROUP);
END;

 tab := output(sort(TABLE(t_change0, cross, changed_did, FEW),changed_did),named('segmentation_stats_across_builds'));

return tab;

end;
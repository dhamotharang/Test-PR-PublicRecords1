
import LinkingTools;
EXPORT PersistenceStatsV2(base,father,rec_id,cluster_id) := functionmacro
  oName1:=(string)RANDOM();
	ds:=linkingtools.PersistenceStats(base,father,rec_id,cluster_id,oName1).clusterDS;
	ts:=linkingtools.PersistenceStats(base,father,rec_id,cluster_id,oName1).recordDS;

	recA:=record
string40 cluster_type;
string60 stat_desc;
unsigned6 stat_value:=0;
integer stat_pct:=0;
end;

ds1:=dataset([{'1 ' + ds[1].stat_name, 'total', ds[1].stat_value,10000},
              {'1 ' + ds[1].stat_name, ds[1].subcategories[1].stat_name				,ds[1].subcategories[1].stat_value, 0.01*ds[1].subcategories[1].stat_pct},
							{'1 ' + ds[1].stat_name, ds[1].subcategories[2].stat_name				,ds[1].subcategories[2].stat_value, 100*ds[1].subcategories[2].stat_pct},
							
							{'1 ' + ds[2].stat_name, 'total', ds[2].stat_value,10000},
              {'1 ' + ds[2].stat_name, ds[2].subcategories[1].stat_name				,ds[2].subcategories[1].stat_value, 100*ds[2].subcategories[1].stat_pct},
							{'1 ' + ds[2].stat_name, ds[2].subcategories[2].stat_name				,ds[2].subcategories[2].stat_value, 100*ds[2].subcategories[2].stat_pct},
							
							{'1 ' + ds[3].stat_name, 'total', ds[3].stat_value,10000},
              {'1 ' + ds[3].stat_name, ds[3].subcategories[1].stat_name				,ds[3].subcategories[1].stat_value, 100*ds[3].subcategories[1].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[2].stat_name				,ds[3].subcategories[2].stat_value, 100*ds[3].subcategories[2].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[3].stat_name				,ds[3].subcategories[3].stat_value, 100*ds[3].subcategories[3].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[4].stat_name				,ds[3].subcategories[4].stat_value, 100*ds[3].subcategories[4].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[5].stat_name				,ds[3].subcategories[5].stat_value, 100*ds[3].subcategories[5].stat_pct},					
							
							{'1 ' + ds[4].stat_name, 'total', ds[4].stat_value, 10000},
              {'1 ' + ds[4].stat_name, ds[4].subcategories[1].stat_name				,ds[4].subcategories[1].stat_value, 100*ds[4].subcategories[1].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[2].stat_name				,ds[4].subcategories[2].stat_value, 100*ds[4].subcategories[2].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[3].stat_name				,ds[4].subcategories[3].stat_value, 100*ds[4].subcategories[3].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[4].stat_name				,ds[4].subcategories[4].stat_value, 100*ds[4].subcategories[4].stat_pct},
							
							{'1 ' + ds[5].stat_name, 'total', ds[5].stat_value, 10000},
              {'1 ' + ds[5].stat_name, ds[5].subcategories[1].stat_name				,ds[5].subcategories[1].stat_value, 100*ds[5].subcategories[1].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[2].stat_name				,ds[5].subcategories[2].stat_value, 100*ds[5].subcategories[2].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[3].stat_name				,ds[5].subcategories[3].stat_value, 100*ds[5].subcategories[3].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[4].stat_name				,ds[5].subcategories[4].stat_value, 100*ds[5].subcategories[4].stat_pct},
						
							{'pct_persistent_clusters', '(Same Cluster)/(Previous Cluster Total)',0, 10000*(real8)ds[5].stat_value/(real8)ds[2].stat_value}	,
							
							{'2 ' + ts[1].stat_name, 'total', ts[1].stat_value, 10000},
              {'2 ' + ts[1].stat_name, ts[1].subcategories[1].stat_name				,ts[1].subcategories[1].stat_value, 100*ts[1].subcategories[1].stat_pct},
							{'2 ' + ts[1].stat_name, ts[1].subcategories[2].stat_name				,ts[1].subcategories[2].stat_value, 100*ts[1].subcategories[2].stat_pct},
							
							{'2 ' + ts[2].stat_name, 'total', ts[2].stat_value, 10000},
              {'2 ' + ts[2].stat_name, ts[2].subcategories[1].stat_name				,ts[2].subcategories[1].stat_value, 100*ts[2].subcategories[1].stat_pct},
							{'2 ' + ts[2].stat_name, ts[2].subcategories[2].stat_name				,ts[2].subcategories[2].stat_value, 100*ts[2].subcategories[2].stat_pct},
							
							{'2 ' + ts[3].stat_name, 'total', ts[3].stat_value,10000},
              {'2 ' + ts[3].stat_name, ts[3].subcategories[1].stat_name				,ts[3].subcategories[1].stat_value, 100*ts[3].subcategories[1].stat_pct},
							{'2 ' + ts[3].stat_name, ts[3].subcategories[2].stat_name				,ts[3].subcategories[2].stat_value, 100*ts[3].subcategories[2].stat_pct},
							
							{'2 ' + ts[4].stat_name, 'total', ts[4].stat_value, 10000},
              {'2 ' + ts[4].stat_name, ts[4].subcategories[1].stat_name				,ts[4].subcategories[1].stat_value, 100*ts[4].subcategories[1].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[2].stat_name				,ts[4].subcategories[2].stat_value, 100*ts[4].subcategories[2].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[3].stat_name				,ts[4].subcategories[3].stat_value, 100*ts[4].subcategories[3].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[4].stat_name				,ts[4].subcategories[4].stat_value, 100*ts[4].subcategories[4].stat_pct},
							
							{'pct_persistent_records', '(Persistent Records Same Cluster)/(Previous Records Total)', 0.0, 10000*(real8)ts[3].subcategories[1].stat_value/(real8)ts[2].stat_value}
						 ],recA);

	return ds1;

endmacro;
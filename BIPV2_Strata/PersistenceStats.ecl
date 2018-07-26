/* //sample return result set: 
cluster_type											stat_desc																										stat_value 
c Current Clusters								total																												945534104
c Current Clusters								New Clusters																								6424536
c Current Clusters								Same Clusters																								939109568
c Current Clusters								New Clusters(%)																							68
c Current Clusters								Same Clusters(%)																						9932
c Previous Clusters								total																												939381258
c Previous Clusters								Missing Clusters																						271690
c Previous Clusters								Same Clusters																								939109568
c Previous Clusters								Missing Clusters(%)																					3
c Previous Clusters								Same Clusters(%)																						9997
c New Clusters										total																												6424536
c New Clusters										All New Records																							6366834
c New Clusters										New Base Record																							0
c New Clusters										From Split																									57702
c New Clusters										From Shuffle																								0
c New Clusters										Deleted Base Record																					0
c New Clusters										All New Records(%)																					9910
c New Clusters										New Base Record(%)																					0
c New Clusters										From Split(%)																								89
c New Clusters										From Shuffle(%)																							0
c New Clusters										Deleted Base Record(%)																			0
c Missing Clusters								total																												271690
c Missing Clusters								All Records Deleted																					103562
c Missing Clusters								Collapsed																										156086
c Missing Clusters								Deleted Base Record																					0
c Missing Clusters								Shuffled																										12042
c Missing Clusters								All Records Deleted(%)																			3811
c Missing Clusters								Collapsed(%)																								5745
c Missing Clusters								Deleted Base Record(%)																			0
c Missing Clusters								Shuffled(%)																									443
c Same Clusters										total																												939109568
c Same Clusters										Recs Removed																								135315
c Same Clusters										Recs Added																									29738366
c Same Clusters										Recs Mixed																									2260436
c Same Clusters										Persistent Clusters																					906975451
c Same Clusters										Recs Removed(%)																							1
c Same Clusters										Recs Added(%)																								317
c Same Clusters										Recs Mixed(%)																								24
c Same Clusters										Persistent Clusters(%)																			9658
pct_persistent_clusters						(Same Cluster)/(Previous Cluster Total)											9997
r Current Records									total																												6801149400
r Current Records									New Records																									78428628
r Current Records									Persistent Records																					6722720772
r Current Records									New Records(%)																							114
r Current Records									Persistent Records(%)																				9885
r Previous Records								total																												6728588022
r Previous Records								Deleted Records																							5867250
r Previous Records								Persistent Records																					6722720772
r Previous Records								Deleted Records(%)																					9
r Previous Records								Persistent Records(%)																				9991
r Persistent Records							total																												6722720772
r Persistent Records							Same Cluster																								6721518267
r Persistent Records							Diff Cluster																								1202505
r Persistent Records							Same Cluster(%)																							9998
r Persistent Records							Diff Cluster(%)																							2
r Persistent Records Diff Cluster	total																												1202505
r Persistent Records Diff Cluster	Collapsed Records																						1020465
r Persistent Records Diff Cluster	Split Records																								141955
r Persistent Records Diff Cluster	Shuffled Records																						40085
r Persistent Records Diff Cluster	Shifted Records																							0
r Persistent Records Diff Cluster	Collapsed Records(%)																				8486
r Persistent Records Diff Cluster	Split Records(%)																						1180
r Persistent Records Diff Cluster	Shuffled Records(%)																					333
r Persistent Records Diff Cluster	Shifted Records(%)																					0
pct_persistent_records						(Persistent Records Same Cluster)/(Previous Records Total)	9989

*/
import LinkingTools;
EXPORT PersistenceStats(base,father,rec_id,cluster_id,pDoOutputs = 'true') := functionmacro
  oName1:=(string)RANDOM();
	ds:=linkingtools.PersistenceStats(base,father,rec_id,cluster_id,oName1,pDoOutputs).clusterDS;
	ts:=linkingtools.PersistenceStats(base,father,rec_id,cluster_id,oName1,pDoOutputs).recordDS;

	recA:=record
string40 cluster_type;
string60 stat_desc;
unsigned6 stat_value:=0;
end;

ds1:=dataset([{'1 ' + ds[1].stat_name, 'total', ds[1].stat_value},
              {'1 ' + ds[1].stat_name, ds[1].subcategories[1].stat_name				,ds[1].subcategories[1].stat_value},
							{'1 ' + ds[1].stat_name, ds[1].subcategories[2].stat_name				,ds[1].subcategories[2].stat_value},
							{'1 ' + ds[1].stat_name, ds[1].subcategories[1].stat_name + '(%)',100*ds[1].subcategories[1].stat_pct},
							{'1 ' + ds[1].stat_name, ds[1].subcategories[2].stat_name + '(%)',100*ds[1].subcategories[2].stat_pct},
							
							{'1 ' + ds[2].stat_name, 'total', ds[2].stat_value},
              {'1 ' + ds[2].stat_name, ds[2].subcategories[1].stat_name				,ds[2].subcategories[1].stat_value},
							{'1 ' + ds[2].stat_name, ds[2].subcategories[2].stat_name				,ds[2].subcategories[2].stat_value},
							{'1 ' + ds[2].stat_name, ds[2].subcategories[1].stat_name + '(%)',100*ds[2].subcategories[1].stat_pct},
							{'1 ' + ds[2].stat_name, ds[2].subcategories[2].stat_name + '(%)',100*ds[2].subcategories[2].stat_pct},
							
							{'1 ' + ds[3].stat_name, 'total', ds[3].stat_value},
              {'1 ' + ds[3].stat_name, ds[3].subcategories[1].stat_name				,ds[3].subcategories[1].stat_value},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[2].stat_name				,ds[3].subcategories[2].stat_value},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[3].stat_name				,ds[3].subcategories[3].stat_value},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[4].stat_name				,ds[3].subcategories[4].stat_value},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[5].stat_name				,ds[3].subcategories[5].stat_value},					
							{'1 ' + ds[3].stat_name, ds[3].subcategories[1].stat_name + '(%)',100*ds[3].subcategories[1].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[2].stat_name + '(%)',100*ds[3].subcategories[2].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[3].stat_name + '(%)',100*ds[3].subcategories[3].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[4].stat_name + '(%)',100*ds[3].subcategories[4].stat_pct},
							{'1 ' + ds[3].stat_name, ds[3].subcategories[5].stat_name + '(%)',100*ds[3].subcategories[5].stat_pct},
							
							{'1 ' + ds[4].stat_name, 'total', ds[4].stat_value},
              {'1 ' + ds[4].stat_name, ds[4].subcategories[1].stat_name				,ds[4].subcategories[1].stat_value},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[2].stat_name				,ds[4].subcategories[2].stat_value},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[3].stat_name				,ds[4].subcategories[3].stat_value},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[4].stat_name				,ds[4].subcategories[4].stat_value},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[1].stat_name + '(%)',100*ds[4].subcategories[1].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[2].stat_name + '(%)',100*ds[4].subcategories[2].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[3].stat_name + '(%)',100*ds[4].subcategories[3].stat_pct},
							{'1 ' + ds[4].stat_name, ds[4].subcategories[4].stat_name + '(%)',100*ds[4].subcategories[4].stat_pct},
							
							{'1 ' + ds[5].stat_name, 'total', ds[5].stat_value},
              {'1 ' + ds[5].stat_name, ds[5].subcategories[1].stat_name				,ds[5].subcategories[1].stat_value},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[2].stat_name				,ds[5].subcategories[2].stat_value},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[3].stat_name				,ds[5].subcategories[3].stat_value},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[4].stat_name				,ds[5].subcategories[4].stat_value},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[1].stat_name + '(%)',100*ds[5].subcategories[1].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[2].stat_name + '(%)',100*ds[5].subcategories[2].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[3].stat_name + '(%)',100*ds[5].subcategories[3].stat_pct},
							{'1 ' + ds[5].stat_name, ds[5].subcategories[4].stat_name + '(%)',100*ds[5].subcategories[4].stat_pct},
							{'pct_persistent_clusters', '(Same Cluster)/(Previous Cluster Total)', 10000*(real8)ds[5].stat_value/(real8)ds[2].stat_value}	,
							
							{'2 ' + ts[1].stat_name, 'total', ts[1].stat_value},
              {'2 ' + ts[1].stat_name, ts[1].subcategories[1].stat_name				,ts[1].subcategories[1].stat_value},
							{'2 ' + ts[1].stat_name, ts[1].subcategories[2].stat_name				,ts[1].subcategories[2].stat_value},
							{'2 ' + ts[1].stat_name, ts[1].subcategories[1].stat_name + '(%)',100*ts[1].subcategories[1].stat_pct},
							{'2 ' + ts[1].stat_name, ts[1].subcategories[2].stat_name + '(%)',100*ts[1].subcategories[2].stat_pct},
							
							{'2 ' + ts[2].stat_name, 'total', ts[2].stat_value},
              {'2 ' + ts[2].stat_name, ts[2].subcategories[1].stat_name				,ts[2].subcategories[1].stat_value},
							{'2 ' + ts[2].stat_name, ts[2].subcategories[2].stat_name				,ts[2].subcategories[2].stat_value},
							{'2 ' + ts[2].stat_name, ts[2].subcategories[1].stat_name + '(%)',100*ts[2].subcategories[1].stat_pct},
							{'2 ' + ts[2].stat_name, ts[2].subcategories[2].stat_name + '(%)',100*ts[2].subcategories[2].stat_pct},
							
							{'2 ' + ts[3].stat_name, 'total', ts[3].stat_value},
              {'2 ' + ts[3].stat_name, ts[3].subcategories[1].stat_name				,ts[3].subcategories[1].stat_value},
							{'2 ' + ts[3].stat_name, ts[3].subcategories[2].stat_name				,ts[3].subcategories[2].stat_value},
							{'2 ' + ts[3].stat_name, ts[3].subcategories[1].stat_name + '(%)',100*ts[3].subcategories[1].stat_pct},
							{'2 ' + ts[3].stat_name, ts[3].subcategories[2].stat_name + '(%)',100*ts[3].subcategories[2].stat_pct},
							
							{'2 ' + ts[4].stat_name, 'total', ts[4].stat_value},
              {'2 ' + ts[4].stat_name, ts[4].subcategories[1].stat_name				,ts[4].subcategories[1].stat_value},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[2].stat_name				,ts[4].subcategories[2].stat_value},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[3].stat_name				,ts[4].subcategories[3].stat_value},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[4].stat_name				,ts[4].subcategories[4].stat_value},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[1].stat_name + '(%)',100*ts[4].subcategories[1].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[2].stat_name + '(%)',100*ts[4].subcategories[2].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[3].stat_name + '(%)',100*ts[4].subcategories[3].stat_pct},
							{'2 ' + ts[4].stat_name, ts[4].subcategories[4].stat_name + '(%)',100*ts[4].subcategories[4].stat_pct},
							
							{'pct_persistent_records', '(Persistent Records Same Cluster)/(Previous Records Total)', 10000*(real8)ts[3].subcategories[1].stat_value/(real8)ts[2].stat_value}
						 ],recA);

	return ds1;

endmacro;
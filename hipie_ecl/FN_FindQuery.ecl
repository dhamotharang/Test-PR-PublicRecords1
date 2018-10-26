EXPORT FN_FindQuery(STRING queryname='', STRING roxieURL='', STRING roxiecluster='',STRING filename=''):=FUNCTION
	publishendpoint :=roxieURL + 'WsWorkunits';
	layout_wupublish_in := {STRING QueryName {XPATH('QueryName')} := queryname,
							STRING ClusterName {XPATH('ClusterName')} := roxiecluster,
							STRING Activated {XPATH('Activated')} := (STRING) true,
							STRING FileName {XPATH('FileName')} := filename};
 
	layout_cluster:={STRING Cluster {XPATH('Cluster')},STRING State {XPATH('State')}};
	layout_result:={STRING Id {XPATH('Id')},
					STRING Name {XPATH('Name')},
					STRING Wuid {XPATH('Wuid')}, 
					STRING QuerySetId {XPATH('QuerySetId')},
					STRING PublishedBy {XPATH('PublishedBy')},
					dataset(layout_cluster) Clusters{XPATH('Clusters/ClusterQueryState')}};
layout_wupublish_out := {STRING NumberOfQueries {XPATH('NumberOfQueries')},dataset(layout_result) Results{XPATH('QuerysetQueries/QuerySetQuery')}};
ds2:= SOAPCALL(publishendpoint,'WUListQueries',layout_wupublish_in, layout_wupublish_out,LITERAL,XPATH('WUListQueriesResponse'));
RETURN ds2.results;
END;
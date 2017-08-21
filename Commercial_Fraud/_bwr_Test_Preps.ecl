#workunit('name',Commercial_Fraud._Dataset().Name + ' Prep Files');

dpplus				:= Commercial_Fraud.Prep_PhonesPlus		();
duspis				:= Commercial_Fraud.Prep_USPIS_HotList();
dadvo					:= Commercial_Fraud.Prep_Advo					();
dforeclosure	:= Commercial_Fraud.Prep_Foreclosure	();
dgong					:= Commercial_Fraud.Prep_Gong					();

countdpplus 			:= count(dpplus				);
countduspis 			:= count(duspis				);
countdadvo				:= count(dadvo				);
countdforeclosure := count(dforeclosure	);
countdgong				:= count(dgong				);

enthdpplus 				:= enth(dpplus				,300);
enthduspis 				:= enth(duspis				,300);
enthdadvo				 	:= enth(dadvo					,300);
enthdforeclosure 	:= enth(dforeclosure	,300);
enthdgong				 	:= enth(dgong					,300);

output(countdpplus				,named('countdpplus'			));
output(countduspis				,named('countduspis'			));
output(countdadvo					,named('countdadvo'				));
output(countdforeclosure	,named('countdforeclosure'));
output(countdgong					,named('countdgong'				));
output(enthdpplus					,named('enthdpplus'				),all);
output(enthduspis					,named('enthduspis'				),all);
output(enthdadvo					,named('enthdadvo'				),all);
output(enthdforeclosure		,named('enthdforeclosure'	),all);
output(enthdgong					,named('enthdgong'				),all);
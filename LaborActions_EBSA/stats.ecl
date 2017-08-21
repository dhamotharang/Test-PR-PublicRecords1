IMPORT LaborActions_EBSA;
			
ds := laborActions_EBSA.Files().Input.Used; 
output(ds);

Field_PopulationStats := record
	CountGroup          					:= count(group);
	unsigned4 DART_ID							:= ave(group,if(ds.DART_ID<>'',100,0));
	unsigned4 DATE_ADDED					:= ave(group,if(ds.DATE_ADDED<>'',100,0));
	unsigned4	DATE_UPDATED				:= ave(group,if(ds.DATE_UPDATED<>'',100,0));
	unsigned4 WEBSITE							:= ave(group,if(ds.WEBSITE<>'',100,0));
	unsigned4	STATE								:= ave(group,if(ds.STATE<>'',100,0));
	unsigned4 CASETYPE						:= ave(group,if(ds.CASETYPE<>'',100,0));
	unsigned4 PLAN_EIN						:= ave(group,if(ds.PLAN_EIN<>'',100,0));
	unsigned4	PLAN_NO							:= ave(group,if(ds.PLAN_NO<>'',100,0));
	unsigned4	PLAN_YEAR						:= ave(group,if(ds.PLAN_YEAR<>'',100,0));
	unsigned4 PLAN_NAME						:= ave(group,if(ds.PLAN_NAME<>'',100,0));
	unsigned4 PLAN_ADMINISTRATOR	:= ave(group,if(ds.PLAN_ADMINISTRATOR<>'',100,0));
	unsigned4 ADMIN_STATE					:= ave(group,if(ds.ADMIN_STATE<>'',100,0));
	unsigned4 ADMIN_ZIP_CODE			:= ave(group,if(ds.ADMIN_ZIP_CODE<>'',100,0));
	unsigned4 ADMIN_ZIP_CODE4			:= ave(group,if(ds.ADMIN_ZIP_CODE4<>'',100,0));
	unsigned4 CLOSING_REASON			:= ave(group,if(ds.CLOSING_REASON<>'',100,0));
	unsigned4 CLOSING_DATE				:= ave(group,if(ds.CLOSING_DATE<>'',100,0));
	unsigned4 PENALTY_AMOUNT			:= ave(group,if(ds.PENALTY_AMOUNT<>'',100,0));
end;
				
output(table(ds,Field_PopulationStats,few));

Field_MaxLengthStats := record
	CountGroup          					:= count(group);
	unsigned4 DART_ID							:= max(group,length(ds.DART_ID));
	unsigned4 DATE_ADDED					:= max(group,length(ds.DATE_ADDED));
	unsigned4	DATE_UPDATED				:= max(group,length(ds.DATE_UPDATEd));
	unsigned4 WEBSITE							:= max(group,length(ds.WEBSITE));
	unsigned4	STATE								:= max(group,length(ds.STATE));
	unsigned4 CASETYPE						:= max(group,length(ds.CASETYPE));
	unsigned4 PLAN_EIN						:= max(group,length(ds.PLAN_EIN));
	unsigned4	PLAN_NO							:= max(group,length(ds.PLAN_NO));
	unsigned4	PLAN_YEAR						:= max(group,length(ds.PLAN_YEAR));
	unsigned4 PLAN_NAME						:= max(group,length(ds.PLAN_NAME));
	unsigned4 PLAN_ADMINISTRATOR	:= max(group,length(ds.PLAN_ADMINISTRATOR));
	unsigned4 ADMIN_STATE					:= max(group,length(ds.ADMIN_STATE));
	unsigned4 ADMIN_ZIP_CODE			:= max(group,length(ds.ADMIN_ZIP_CODE));
	unsigned4 ADMIN_ZIP_CODE4			:= max(group,length(ds.ADMIN_ZIP_CODE4));
	unsigned4 CLOSING_REASON			:= max(group,length(ds.CLOSING_REASON));
	unsigned4 CLOSING_DATE				:= max(group,length(ds.CLOSING_DATE));
	unsigned4 PENALTY_AMOUNT			:= max(group,length(ds.PENALTY_AMOUNT));
end;
				
output(table(ds,Field_MaxLengthStats,few));
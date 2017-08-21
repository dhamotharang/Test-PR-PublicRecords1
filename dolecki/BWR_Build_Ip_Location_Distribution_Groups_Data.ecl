Ip_Location_Distribution_Groups_Layout add_group_info(Ip_Location_Layout l, INTEGER c) := TRANSFORM
	SELF.groupid := TRUNCATE(c/1000);
	SELF := l;
END;

Dataset_IP_Location_Grouping := PROJECT(dolecki.IP_Location_Std_Dataset, add_group_info(LEFT,COUNTER));

Ip_Location_Distribution_Groups_Layout rollup_groups(
		Ip_Location_Distribution_Groups_Layout l, Ip_Location_Distribution_Groups_Layout r) := TRANSFORM
	SELF.ip_to := r.ip_to;
	SELF := l;
END;

Dataset_IP_Location_Grouping_Rolled_Up := ROLLUP(
	Dataset_IP_Location_Grouping,
	LEFT.groupid = RIGHT.groupid,
	rollup_groups(LEFT,RIGHT)
);

output(Dataset_IP_Location_Grouping_Rolled_Up,,Ip_Location_Distribution_Groups_Filename,OVERWRITE);

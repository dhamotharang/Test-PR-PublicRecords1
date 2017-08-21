dolecki.Ip_Location_With_Group_Info_Layout add_group_info(dolecki.Ip_Location_Layout l, INTEGER c) := TRANSFORM
	SELF.groupid := TRUNCATE(c/1000);
	SELF := l;
END;

Ip_Location_With_Group_Info_Dataset := PROJECT(dolecki.IP_Location_Std_Dataset, add_group_info(LEFT,COUNTER));

output(Ip_Location_With_Group_Info_Dataset,,dolecki.Ip_Location_With_Group_Info_Filename,OVERWRITE);

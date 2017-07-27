export CleanPersonEnclarityFields(string266 clean_name) :=
module
	export string15 name_prefix		:=	clean_name[1..15];
	export string50 fname					:=	clean_name[16..65];
	export string50 mname					:=	clean_name[66..115];
	export string50 lname					:=	clean_name[116..165];
	export string15 name_prof			:=	clean_name[166..180];
	export string15 name_suffix		:=	clean_name[181..195];
	export string15 name_title		:=	clean_name[196..210];
	export string5  name_score		:=	clean_name[211..215];
	export string1  name_gender		:=	clean_name[216];
	export string50 name_prefered	:=	clean_name[217..266];	

	export CleanNameRecord := dataset([
		
		{
			 name_prefix
			,fname
			,mname
			,lname
			,name_prof
			,name_suffix
			,name_title
			,name_score
			,name_gender
			,name_prefered
		}
	],Address.Layout_Clean_Name_Enclarity)[1];

end;
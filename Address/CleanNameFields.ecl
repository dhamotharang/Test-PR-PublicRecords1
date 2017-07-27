export CleanNameFields(string73 clean_name) :=
module
	export string5  title				:=	clean_name[1..5];
	export string20 fname				:=	clean_name[6..25];
	export string20 mname				:=	clean_name[26..45];
	export string20 lname				:=	clean_name[46..65];
	export string5  name_suffix	:=	clean_name[66..70];
	export string3  name_score	:=	clean_name[71..73];
	export string73 full_name		:=	clean_name;
	
	export CleanNameRecord := dataset([
		
		{
			 title
			,fname
			,mname
			,lname
			,name_suffix
			,name_score
		}
	], Address.Layout_Clean_Name)[1];

end;
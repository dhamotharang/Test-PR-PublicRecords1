import	Nid;

EXPORT fn_Nid_CleanNames(dataset(layout_Base2) basein) := 

		PROJECT(basein, TRANSFORM(layout_Base2,
			nm := left.prepped_name;

			string73 cln_name := Nid.CleanPerson73(nm);
		
			self.title		:= cln_name[1..5];
			self.fname		:= cln_name[6..25];
			self.mname			:= cln_name[26..45];
			self.lname		:= IF(cln_name[46..65]='' and REGEXFIND('^[A-Z]+$',trim(left.LastName)), left.LastName, cln_name[46..65]);
			self.name_suffix		:= cln_name[66..70];
			self.prefname		  	:=	NID.PreferredFirstNew(self.fname);
			self := left;));

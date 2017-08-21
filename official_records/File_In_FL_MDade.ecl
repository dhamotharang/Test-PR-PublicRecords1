import lib_stringlib;


Layouts_MiamiDade.raw filterout(Files_raw.MiamiDade.File_in_raw l) := transform
  self.first_party     := trim(lib_stringlib.StringLib.StringFilterout(l.first_party,'\''));
  self.cross_party_name := trim(lib_stringlib.StringLib.StringFilterout(l.cross_party_name,'\''));
  self.subdivision_name := trim(lib_stringlib.StringLib.StringFilterout(l.subdivision_name,'\''));
  self.legal_description := trim(lib_stringlib.StringLib.StringFilterout(l.legal_description,'\',\r\n'));
  self                   := l;
  end;
 
 
 dWithoutslash := project(Files_raw.MiamiDade.File_in_raw,filterout(LEFT));
 
 

Layouts_MiamiDade.fixed Convert2fixed(dWithoutslash l) := transform
	self.lf       := '';
	self.cfn_year := if(length(intformat((integer)l.cfn_year,4,1)) > 4 ,
                                                                   l.cfn_year[lib_stringlib.StringLib.StringFind(l.cfn_year,'\n',1)+1..lib_stringlib.StringLib.StringFind(l.cfn_year,'\n',1)+5],
																																	 l.cfn_year);

	self         := l;
end;

  
export File_In_FL_MDade := project(dWithoutslash,Convert2fixed(LEFT));



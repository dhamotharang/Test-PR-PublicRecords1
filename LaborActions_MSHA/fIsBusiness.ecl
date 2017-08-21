import lib_stringlib;

export fIsBusiness(string name) := FUNCTION
		//This function tries to identify whether the Operator's Name is a
		//company name or a person's name.  This is being done for those Operator's
		//names that return back from Address.Mac_Is_Business with a name_flag = 'D' (dual names).
		IsBusiness1 	:= IF (StringLib.StringFind(name,' BRICK',1)<>0,True,False);
		IsBusiness2 	:= IF (StringLib.StringFind(name,' MINES',1)<>0,True,False);
		IsBusiness3 	:= IF (StringLib.StringFind(name,' LIME',1)<>0,True,False);
		IsBusiness4 	:= IF (StringLib.StringFind(name,' DIRT',1)<>0,True,False);
		IsBusiness5 	:= IF (StringLib.StringFind(name,' ROCK',1)<>0,True,False);
		IsBusiness6 	:= IF (StringLib.StringFind(name,' QUARRY',1)<>0,True,False);
		IsBusiness7 	:= IF (StringLib.StringFind(name,' COAL',1)<>0,True,False);
		IsBusiness8 	:= IF (StringLib.StringFind(name,' GRAVEL',1)<>0,True,False);
		IsBusiness9 	:= IF (StringLib.StringFind(name,' MINING',1)<>0,True,False);
		IsBusiness10 	:= IF (StringLib.StringFind(name,' SAND',1)<>0,True,False);
		IsBusiness11 	:= IF (StringLib.StringFind(name,' STONE',1)<>0,True,False);
		IsBusiness12 	:= IF (StringLib.StringFind(name,' FLAGSTONE',1)<>0,True,False);				
		IsBusiness13 	:= IF (StringLib.StringFind(name,' LIMESTONE',1)<>0,True,False);
		IsBusiness14 	:= IF (StringLib.StringFind(name,' S AND G',1)<>0,True,False);
		IsBusiness15 	:= IF (StringLib.StringFind(name,' R AND D',1)<>0,True,False);
		return(IsBusiness1 	OR IsBusiness2 	OR IsBusiness3 	OR IsBusiness4 	OR IsBusiness5 	OR
					 IsBusiness6 	OR IsBusiness7 	OR IsBusiness8 	OR IsBusiness9 	OR IsBusiness10 OR 
					 IsBusiness11 OR IsBusiness12 OR IsBusiness13 OR IsBusiness14 OR IsBusiness15);
end;

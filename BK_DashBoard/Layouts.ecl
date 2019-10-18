EXPORT Layouts := module

export overall	:= RECORD

string datatype;
string statstype;
string buildversion;
integer number;


end;
			
export linking := record
				
string datatype;
string nametype;
string linkingtype;
string buildversion;
integer number;

end;
	
export segmentation := record
				
string datatype;
string DIDtype;
string buildversion;
integer number;

end;	
	
export overall_in_days	:= RECORD

string datatype;
string statstype;
string processdate;
integer number;


end;
			
export linking_in_days := record
				
string datatype;
string nametype;
string linkingtype;
string processdate;
integer number;

end;	
	
			END;
import arrestlogs;

ds := arrestlogs.file_TX_Brazoria_old;

arrestlogs.Layout_TX_Brazoria.old_format tBrazoria(ds input) := Transform

searchpattern := '(.*) (.*) (.*) (.*)  (.*)  (.*)$';
searchpattern2 := '(.*), (.*) (.*)$';
searchpattern3 := '\\$(.*), (.*) (.*)';

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.ID				:= input.ID;
self.Name 			:= input.Name;
self.Alias 			:= input.Alias;
self.Arrest_Agency	:= '';
self.Dt_Confined	:= if(fSlashedMDYtoCYMD(input.Confined_Dt[1..10])<>'00000000',
						fSlashedMDYtoCYMD(input.Confined_Dt[1..10]),
						'');
self.Dt_Released	:= fSlashedMDYtoCYMD(input.Release_Dt);
self.Address		:= input.Address;
self.City			:= regexreplace(',',regexfind(searchpattern2,input.City_State,1),'');
self.State			:= regexfind(searchpattern2,input.City_State,2);
self.Zip			:= regexfind(searchpattern2,input.City_State,3);
self.Race			:= regexfind(searchpattern,input.Physical_Desc,1);
self.Sex			:= regexfind(searchpattern,input.Physical_Desc,2);
self.Height			:= (string)((integer)regexreplace('\'',regexfind(searchpattern,input.Physical_Desc,3),'')*12+
					   (integer)regexreplace('\"',regexfind(searchpattern,input.Physical_Desc,4),''));
self.Weight			:= regexfind(searchpattern,input.Physical_Desc,5);
self.DOB			:= fSlashedMDYtoCYMD(regexfind(searchpattern,input.Physical_Desc,6));
self.Hair			:= if(StringLib.StringToUpperCase(trim(input.hair,left,right)) in ['BALD',   
						'BLACK','BLOND','BROWN','GREY','RED','SANDY','WHITE'],
						StringLib.StringToUpperCase(trim(input.hair,left,right)),
						if(regexfind('BLOND',StringLib.StringToUpperCase(trim(input.hair,left,right)),0)<>'',
						'BLOND',
						if(regexfind('GREY',StringLib.StringToUpperCase(trim(input.hair,left,right)),0)<>'',
						'GREY',
						'')));
self.Eyes			:= if(StringLib.StringToUpperCase(trim(input.eyes,left,right)) in ['BLACK',
						'BLUE','BROWN','GREEN','GREY','HAZEL','MAROON','MULTI','PINK'],
						StringLib.StringToUpperCase(trim(input.eyes,left,right)),
						'');
self.DL_Num			:= input.DL;
self.SO_Num			:= input.SO_Num;
self.Cause			:= input.Cause;
self.Charge			:= if(length(trim(input.charge,left,right))>6 and regexfind('PD|'+'JP|'+'NOBOND|'+'COUNTY CLERK',input.charge,0)='',
						regexreplace('\\/[0-9]+|'+'[0-9]-[0-9]|'+'-[0-9]|'+'&amp; 2',regexreplace(', [A-Z]+[0-9]+|'+', [0-9]+|'+', [A-Z]+|'+'[0-9]+/[0-9]+|'+'CT 1|'+
						'CT 2|'+'CT 3|'+'CT. 1',input.charge,''),''),
						'');
self.Iss_Auth		:= '';
self.Disposition	:= input.Disposition;
self.Bond			:= if(regexfind('\\$',input.bond,0)<>'' and trim(input.bond,left,right)<>'$0.00',
						'$'+regexfind(searchpattern3,input.bond,1),
						'');
self.Bond_Type		:= '';
self.Fine			:= if(trim(input.Fine,left,right)<>'$0.00',
						input.Fine,
						'');

end;

pBrazoria := project(ds,tBrazoria(left));

export file_reformat_TX_Brazoria := pBrazoria;
import _control;

pversion								:= '20080411'												;
pDirectory							:= '/thor_back5/bbb/build/20080408'	;

#workunit('name', 'BBB Complete Process ' + pversion);

bbb2.Proc_Build_All(

	 pversion					
	,pDirectory				
   
).all;
import _Control, Data_Services;
export Constants := module

   export Cluster := Data_Services.Data_location.Prefix('CALBUS') + 'thor_data400::';
	 
	 export Groupname	:= if(_Control.ThisEnvironment.name		 = 'Dataland'	,'thor40_241'	,'thor400_20');
   
   export autokey_logical(string filedate) := Cluster + 'key::calbus::'+ filedate + '::autokey::';
   
   export autokey_keyname := Cluster + 'key::calbus::autokey::@version@::';
   
   export autokey_qa_name := Cluster + 'key::calbus::autokey::qa::';

   export key_logical(string filedate) := Cluster + 'key::calbus::'+ filedate + '::';
   
   export key_qa_name := Cluster + 'key::calbus::qa::';	 
   //P in this set to skip personal phones
   //Q in this set to skip business phones
   //S in this set to skip SSN
   //F in this set to skip FEIN
   //C in this set to skip ALL personal (Contact) data
   //B in this set to skip ALL Business data   
   export skip_set := ['F','P','Q','S'];
   
   // The following ownership codes indicates that the owner_name may 
   // be individual name instead of business name.
   export OwnerShip_Code_Check := ['P','R','V'];
   
end;
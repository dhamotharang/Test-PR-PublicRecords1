/*
  SuperfileAction can add to superfile, etc.
*/
import _control,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_SuperfileAction(
   string                paction              = ''    //valid types: add or remove (looking for more)     
  ,string                psuperfile           = ''    //superfile to modify     
  ,string                psubfile             = ''    //subfile to add or delete           
  ,string                pbefore              = ''    //add the subfile before this file in the superfile
  ,boolean               pdelete              = false //true = remove it from superfile and delete it. false = remove it from superfile
  ,boolean               premoveSuperfile     = false //true = delete superfile, false=keep superfile
  ,string                pesp                 = _Config.LocalEsp
) :=                           
function

  item_record := {string Item{xpath('Item')}};
  
	SuperfileActionRequest_Record :=
	record

    string                action               {xpath('action'           )} := paction                            ;
    string                superfile            {xpath('superfile'        )} := psuperfile                         ;
	  dataset(item_record)  subfiles             {xpath('subfiles'         )} := dataset([{psubfile}],item_record)  ;
    string                before               {xpath('before'           )} := pbefore                            ;
    boolean               delete               {xpath('delete'           )} := pdelete                            ; //not sure what this is yet
    boolean               removeSuperfile      {xpath('removeSuperfile'  )} := premoveSuperfile                   ;

  end;
       
	SuperfileActionResponse_Record :=
	record	
  
		string                exception_code      {xpath('Exceptions/Exception/Code'                )};
		string                exception_source    {xpath('Exceptions/Exception/Source'              )};
		string                exception_audience  {xpath('Exceptions/Exception/Audience'            )};
		string                exception_msg       {xpath('Exceptions/Exception/Message'             )};
		string                superfile           {xpath('superfile'                                )};
		integer               retcode             {xpath('retcode'                                  )};
    
	end;
  

  esp				:= pesp + ':8010';
  dsoap_results := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.31'
    ,'SuperfileAction'
    ,SuperfileActionRequest_Record
    ,dataset(SuperfileActionResponse_Record)
    ,xpath('SuperfileActionResponse')
    ,timeout(1200)  //max 20 minutes
  );
  
  return dsoap_results  ;

end;

/*
  DFUArrayAction deletes files
*/
import _control,ut;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export soapcall_DFUArrayAction(
   string                   pAction                   = ''    //valid types: Delete (looking for more)     
  ,string                   pFile                     = ''    //file to delete           
  ,boolean                  premoveFromSuperfiles     = false //remove it from superfiles first?
  ,boolean                  premoveRecursively        = false //i think this is recursively from superfiles
  ,string                   pesp                      = _Config.LocalEsp
) :=                           
function

  // <DFUArrayActionRequest>
   // <Type>Delete</Type>
   // <NoDelete>0</NoDelete>
   // <BackToPage/>
   // <LogicalFiles>
    // <Item>thor400_20::temp::values::bipv2_relative_proxid_cnp_hasnumber</Item>
   // </LogicalFiles>
   // <removeFromSuperfiles>1</removeFromSuperfiles>
   // <removeRecursively>0</removeRecursively>
  // </DFUArrayActionRequest>

  item_record := {string Item{xpath('Item')}};
  
	DFUArrayActionRequest_Record :=
	record

    string                Type                      {xpath('Type'                 )} := pAction                           ;
    boolean               NoDelete                  {xpath('NoDelete'             )} := if(pAction = 'Delete',false,true) ;
    string                BackToPage                {xpath('BackToPage'           )} := ''                                ; //not sure what this is yet
	  dataset(item_record)  LogicalFiles              {xpath('LogicalFiles'         )} := dataset([{pFile}],item_record)    ;
    boolean               removeFromSuperfiles      {xpath('removeFromSuperfiles' )} := premoveFromSuperfiles             ;
    boolean               removeRecursively         {xpath('removeRecursively'    )} := premoveRecursively                ;

  end;
       
	DFUArrayActionResponse_Record :=
	record	
  
		string                exception_code      {xpath('Exceptions/Exception/Code'                )};
		string                exception_source    {xpath('Exceptions/Exception/Source'              )};
		string                exception_audience  {xpath('Exceptions/Exception/Audience'            )};
		string                exception_msg       {xpath('Exceptions/Exception/Message'             )};
		string                BackToPage          {xpath('BackToPage'                               )};
		string                RedirectTo          {xpath('RedirectTo'                               )};
		string                Message             {xpath('DFUArrayActionResult/Message/Value'       )};
		string                FileName            {xpath('ActionResults/DFUActionInfo/FileName'     )};
		string                NodeGroup           {xpath('ActionResults/DFUActionInfo/NodeGroup'    )};
		string                ActionResult        {xpath('ActionResults/DFUActionInfo/ActionResult' )};
		string                Failed              {xpath('ActionResults/DFUActionInfo/Failed'       )};
    
	end;
  

  esp				:= pesp + ':8010';
  dsoap_results := SOAPCALL(
    'http://' + esp + '/WsDfu?ver_=1.31'
    ,'DFUArrayAction'
    ,DFUArrayActionRequest_Record
    ,dataset(DFUArrayActionResponse_Record)
    ,xpath('DFUArrayActionResponse')
    ,timeout(1200)  //max 20 minutes
  );
  
  return dsoap_results  ;

end;

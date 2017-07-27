/*2014-09-17T20:58:10Z (vern_p bentley)
Check-in for BIPV2 Sprint 20
*/
import wk_ut;
export get_DS_Result(pWuid,pNamedOutput,pRecordLayout,pesp = '_constants.LocalEsp') := 
functionmacro
  attr := DATASET( WORKUNIT(pWuid , pNamedOutput ), pRecordLayout );
  return if(wk_ut.Is_Valid_Wuid(pWuid) ,attr ,dataset([],pRecordLayout));
endmacro;
/*
datalandwuid  := 'W20140624-114853';
// layout        := tools.Layout_fun_CopyFiles.Out;

layname := {string name {xpath('name')}};

mylayout :=
record
  string 					  srclogicalname              {xpath('srclogicalname'        )};
  string            filedescription             {xpath('filedescription'       )};
  string 					  destinationgroup            {xpath('destinationgroup'      )};          
  string 					  destinationlogicalname			{xpath('destinationlogicalname')};		
  string 					  srcdali					            {xpath('srcdali'					     )};          
  dataset(layname)	dsuperfilenames             {xpath('dsuperfilenames/Row'   )};
  boolean					  IsALocalCopy                {xpath('isalocalcopy'          )};          
  boolean					  willCompress                {xpath('willcompress'          )};
  boolean					  willOverwrite               {xpath('willoverwrite'         )};          
  boolean					  sourcefileexists            {xpath('sourcefileexists'      )};
  boolean					  destinationfileexists       {xpath('destinationfileexists' )};          
  boolean					  willcopy                    {xpath('willcopy'              )};
end;                                                      

myd := {dataset(mylayout) fred{xpath('Row')}};

// raw := HTTPCALL('http://10.241.3.240:8010/WsWorkunits/WUResult?Wuid=W20140624-114853&Sequence=0', 'GET', 'text/xml', mylayout);
// raw := HTTPCALL('http://10.241.3.243:8010/WsWorkunits/WUResult.xml?Wuid=W20140624-114853&Sequence=0', 'GET', 'text/xml', mylayout,xpath('WUResultResponse/Result/Dataset/Row')); //works for 1 row in dataset
raw := HTTPCALL('http://10.241.3.243:8010/WsWorkunits/WUResult.xml?Wuid=W20140624-114853&Sequence=0', 'GET', 'text/xml', myd,xpath('WUResultResponse/Result/Dataset')); //works for 1 row in dataset

// output(dataset(raw));

 OUTPUT(normalize(dataset(raw),left.fred,transform(mylayout,self := right)));

*/
/*
  uses STD.Str.DecodeBase64 to decode the base64 archived query.  
  it is broken up into 73 character chunks, the last character being a line feed which is added by the python 3 encode function.
  so, we normalize out the archive string into 73 character chunks, removing the line feed to make it 72 chars before decoding to prevent buffer errors
  then we put the full decoded string back together and then normalize it out into one record per attribute
  that contains the module name, the attribute name, and the code for that attribute.
*/
import STD;
EXPORT get_Archive_Query(
   string    pWuid                   
  ,string    pesp       = WsWorkunits._Config.LocalEsp
  ,string    pSizeLimit = '0'
  
) :=                           
function


  ds_modules := WsWorkunits.soapcall_WUFile(pWuid,pesp,pSizeLimit);

  // STRING decodeit(STRING s01) := EMBED(Python) //this works too!
    // import base64
    // decode=base64.b64decode(s01)
    // return decode
  // ENDEMBED;
  
  blank_str := '====';

  ds_slim := normalize(ds_modules  ,(unsigned)(length(trim(left.modules)) / 73) + 1  ,transform(
  // ds_slim := normalize(ds_modules  ,4  ,transform(

    {  unsigned rid                 
      ,integer  total_code_length       
      ,unsigned start_index           
      ,unsigned end_index             
      ,unsigned len_raw_snippet           
      ,unsigned len_snippet           
      ,unsigned mod_length_snippet           
      ,string   raw_code_snippet        
      ,string   padded_code_snippet        
      ,string   code_snippet            
    },
    start_index         := if(counter = 1 ,1  ,((counter - 1) * 73) + 1);
    end_index           := if(counter = 1 ,73 ,  counter      * 73     ) - 1;
    raw_snippet         := trim(left.modules[start_index..end_index]);
    snippet             := raw_snippet;
    length_raw_snippet  := length(raw_snippet);
    length_snippet      := length(snippet);
    mod_length_snippet  := length_snippet % 4;
    pad_snippet         := snippet + if(mod_length_snippet > 0  ,blank_str[1..(4-mod_length_snippet)]  ,''  );

    self.rid                 := counter;
    self.total_code_length   := length(trim(left.modules));
    self.start_index         := start_index; // fails between 72 & 76.  for some reason
    self.end_index           := end_index; // fails between 72 & 76.  for some reason
    self.len_raw_snippet     := length_raw_snippet; // fails between 72 & 76.  for some reason
    self.len_snippet         := length_snippet; // fails between 72 & 76.  for some reason
    self.mod_length_snippet  := mod_length_snippet;
    self.raw_code_snippet    := raw_snippet; // fails between 72 & 76.  for some reason
    self.padded_code_snippet := pad_snippet; // fails between 72 & 76.  for some reason
    self.code_snippet        := (string)STD.Str.DecodeBase64 (pad_snippet ); // fails between 72 & 76.  for some reason
    // self.code_snippet        := '';
  ));

  // output(ds_slim  ,,'~temp::lbentley::archive_test',compressed);

  ds_rollup := rollup(ds_slim  ,true ,transform(recordof(left),self.code_snippet := left.code_snippet + right.code_snippet,self := right));

  lay_attributes := {string attributename,string code};
  lay_modules    := {string modulename,dataset(lay_attributes) attributes};
  lay_all        := {dataset(lay_modules) modules,string query};

  lay_all tParseAttributes :=
  transform
    self.modules := xmlproject('Module',transform(lay_modules,
      self.modulename            := xmltext('@name');
      self.attributes					   := xmlproject('Attribute',transform(lay_attributes
        ,
        self.attributename       := xmltext('@name');
        self.code                := xmltext('');
        ))
      ));
    self.query := xmltext('Query')
  end;

  ds_code_parsed	:= parse(ds_rollup, code_snippet, tParseAttributes, xml('Archive'));

  ds_code_parsed_norm1 := normalize(ds_code_parsed ,left.modules ,transform(lay_modules
    ,self          := right
  ));

  ds_code_parsed_norm2 := normalize(ds_code_parsed_norm1 ,left.attributes ,transform({string modulename,string attributename,string code}
    ,self.modulename    := left.modulename
    ,self.attributename := right.attributename
    ,self.code          := right.code
  ));

  // output(ds_code_parsed_norm1  ,named('ds_code_parsed_norm1'));
  // output(ds_code_parsed_norm2  ,named('ds_code_parsed_norm2'));

  return project(ds_code_parsed ,transform({string modulename,string attributename,string code} 
    ,self.modulename    := 'WUID-BWR-QUERY'
    ,self.attributename := 'WUID-BWR-QUERY'
    ,self.code          := left.query
  
  )) + ds_code_parsed_norm2;
  
end;
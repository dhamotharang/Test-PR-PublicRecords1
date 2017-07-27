//MAC_genCompanyNameTokenPatterns
import text;

export MAC_genCompanyNameTokenPatterns
(
   infile,  // input recordset
   coname,  // company name field in input recordset
   outfile,  // output dataset
	 coname_id='coname_id'
) := MACRO

#uniquename(sequence)
CompanyNameAnalysis.layouts.layout_infile_seq %sequence%(infile l, C) := transform
// self.coid := C;
 self.coid := l.coname_id;
 self := l;
end;

file_of_conames := project(infile, %sequence%(left, counter));

#uniquename(co_name_token_ds)
%co_name_token_ds% := CompanyNameAnalysis.parseForTokenPatterns(file_of_conames) ;

//------------- Make Tokenization a Child Dataset ------------

token_rec := RECORD
UNSIGNED8 coname_id;
string coname;
string tokname;
string toktext;
END;

#uniquename(child_token_rec)
%child_token_rec% := RECORD
string tokname;
string toktext;
END;

#uniquename(child_with_id_rec)
%child_with_id_rec% := RECORD(%child_token_rec%)
UNSIGNED8 coname_id;
string coname;
END;

#uniquename(tokens_by_coname_rec)
%tokens_by_coname_rec% := RECORD
   UNSIGNED8 coname_id;
   string coname;
   string token_pattern;
   string pattern_text;
   UNSIGNED8 nTokens;
END;

#uniquename(ParentMove)
%tokens_by_coname_rec% %ParentMove%(recordof(%co_name_token_ds%) L) := TRANSFORM
   SELF.coname_id := L.coid;
   SELF.coname := L.coname;
   SELF.token_pattern :='';
   SELF.pattern_text :='';
   SELF.nTokens := 0;
   SELF := L;
END;

#uniquename(ParentOnly)
%ParentOnly% := dedup(PROJECT(%co_name_token_ds%, %ParentMove%(LEFT)), coname_id);

#uniquename(TokenMove)
%tokens_by_coname_rec% %TokenMove%(%tokens_by_coname_rec% L, %child_token_rec% R,INTEGER C):=TRANSFORM
   SELF.token_pattern := IF(L.token_pattern='',R.tokname, L.token_pattern + ' ' + R.tokname);
   SELF.pattern_text := IF(L.pattern_text='', R.toktext, L.pattern_text + '|' + R.toktext);
   SELF.nTokens := C;
   SELF := L;
END;

#uniquename(co_name_token_ds_proj)
%co_name_token_ds_proj% := project(%co_name_token_ds%
                                 , transform(%child_with_id_rec%
                                             , SELF.coname_id := LEFT.coid
                                             , SELF.coname := LEFT.coname
                                             , SELF.tokname := LEFT.tokname
                                             , SELF.toktext := LEFT.toktext)
                                );
#uniquename(co_name_token_ds_rollup1)
#uniquename(co_name_token_ds_rollup2)
%co_name_token_ds_rollup1% := rollup(sort(%co_name_token_ds_proj%                           ,coname_id,local) ,left.coname_id = right.coname_id ,transform(recordof(left),self.tokname := left.tokname + ' ' + right.tokname,self.toktext := left.toktext + '|' + right.toktext,self := left),local);
%co_name_token_ds_rollup2% := rollup(sort(distribute(%co_name_token_ds_rollup1%  ,coname_id),coname_id,local) ,left.coname_id = right.coname_id ,transform(recordof(left),self.tokname := left.tokname + ' ' + right.tokname,self.toktext := left.toktext + '|' + right.toktext,self := left),local);
#uniquename(co_name_token_ds_rollup3)
%co_name_token_ds_rollup3% := project(%co_name_token_ds_rollup2%  ,transform({recordof(left),unsigned8 nTokens},self.nTokens := std.str.findcount(trim(left.tokname,right),' '),self := left));


// This DENORMALIZE concatenates 1) all toknames to make a token string, and
//  2) all toktext to make a toktext string.
// outfile := join(%ParentOnly%  ,%co_name_token_ds_rollup3% ,LEFT.coname_id = RIGHT.coname_id ,transform(recordof(left),self.token_pattern := right.tokname,self.pattern_text := right.toktext,self.nTokens := right.nTokens, self := left ),hash);

outfile := DENORMALIZE(%ParentOnly%
                       , %co_name_token_ds_proj%,
                        LEFT.coname_id = RIGHT.coname_id,
                        %TokenMove%(LEFT,RIGHT,COUNTER)
                       );

ENDMACRO;
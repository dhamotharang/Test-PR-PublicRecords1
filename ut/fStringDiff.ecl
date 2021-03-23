//---------------------------------------------------------------------------
// fStringDiff
// Process to perform a Diff between two multi-line strings using the python
// diff library.
// Input is two strings, within which lines are delimited by '\n'
// Output is a 2-column dataset containing the following:
// * status: 'Added', 'Removed', or [blank] (indicating no change)
// * line  : The specific line of code.  In cases where the
//           diff process sees partial line similarity, it will include 
//           indicators (+,-,^) directly below the changed line to show which
//           parts were added, removed or modified respectively. (use fixed-
//           pitch font to line up these indicators properly)
//---------------------------------------------------------------------------
EXPORT fStringDiff(STRING sInput01,STRING sInput02,boolean sCleanSpaces = true):=FUNCTION
  IMPORT std;
  IMPORT Python3;

  // Simple function to split a string into a multi-line dataset
  fParseLines(STRING s):= NORMALIZE(
     NOCOMBINE(DATASET([{'\n'+s+'\n'}],{STRING s;}))
    ,LENGTH(REGEXREPLACE('[^\n]',s,''))+1
    ,TRANSFORM(
       {UNSIGNED l,STRING s;},
       SELF.s:=LEFT.s[Std.Str.Find(LEFT.s,'\n',COUNTER)..Std.Str.Find(LEFT.s,'\n',COUNTER+1)];
       SELF.l:=COUNTER;
    )
  );

  // Embedded call to the Python3 difflib library, then parse the lines into
  // a dataset
  STRING diffit(STRING s01,STRING s02) := EMBED(Python3)
    import difflib
    d=difflib.Differ()
    diff=d.compare(s01.splitlines(),s02.splitlines())
    return '\n'.join(diff)
  ENDEMBED;
  
  //these aren't necessary because nocombine above speeds up the compare
  // STRING ndiffit(STRING s01,STRING s02) := EMBED(Python3)
    // import difflib
    // diff=difflib.ndiff(s01.splitlines(),s02.splitlines())
    // return '\n'.join(list(diff))
  // ENDEMBED;

  // STRING unifiedDiffit(STRING s01,STRING s02) := EMBED(Python3)
    // import difflib
    // diff=difflib.unified_diff(s01.splitlines(),s02.splitlines(),lineterm = '\n')
    // return '\n'.join(list(diff))
  // ENDEMBED;

  // -- remove leading, trailing, and consecutive spaces on each line.  this can cause a lot of extra diff noise.
  Input01 := if(sCleanSpaces  = true  ,trim(regexreplace('\n[[:space:]]*'  ,regexreplace('[[:space:]]*\n',STD.Str.CleanSpaces(sInput01 ) ,'\n',nocase)   ,'\n',nocase),left,right) ,sInput01);
  Input02 := if(sCleanSpaces  = true  ,trim(regexreplace('\n[[:space:]]*'  ,regexreplace('[[:space:]]*\n',STD.Str.CleanSpaces(sInput02 ) ,'\n',nocase)   ,'\n',nocase),left,right) ,sInput02);
    
  sRawDiff  := diffit(Input01,Input02);
  dParsed   := fParseLines(sRawDiff);

  diff_index := 4;
  
  // Simple cleaning.  Make the line's status readable, and remove non-
  // printing characters added by phython during processing.
  dAugmented:=PROJECT(dParsed,TRANSFORM({unsigned cnt,string1 firstchar,unsigned lineno_old,unsigned lineno_new,STRING status;string statuses;unsigned groupid;STRING line;},
    SELF.Status:=MAP(LEFT.s[2]='+' => 'Added',LEFT.s[2]='-' => 'Removed',LEFT.s[2]='?' => '------>','');
    SELF.line:=if(self.status != '------>'  ,REGEXREPLACE('\r|\n',LEFT.s[diff_index..],'')  ,regexreplace('[[:space:]]',REGEXREPLACE('\r|\n',LEFT.s[diff_index..],''),'_'));
    self.lineno_old := 1;
    self.lineno_new := 1;
    self.firstchar := if(trim(LEFT.s[2])  not in ['+','-','?'] ,'_'  ,LEFT.s[2]);
    self.statuses    := if(trim(self.firstchar) = '' ,'_'  ,self.firstchar);
    self.cnt          := left.l;
    self.groupid      := left.l;
  ));
  
  //if firstchar = blank, add 1 to both
  //if firstchar = '-' add 1 to left, not to right
  //if firstchar = '+' add 1 to right, not left
  //if firstchar = '?' add zero to both
  // get the left lineno and right lineno correct.  this will make it easier to find the diff lines if you want to filter out the lines in common.
  d_linenos := iterate(dAugmented ,transform({unsigned cnt,string1 firstchar,unsigned lineno_old,unsigned lineno_new,STRING status;string statuses;unsigned groupid;STRING line;}
    ,all_statuses    := trim(left.statuses) + if(right.firstchar = ' ' ,'_' ,right.firstchar);
     length_statuses := length(trim(all_statuses));
    
     self.lineno_old := map(  counter  = 1  and right.firstchar     in ['_','-']  => 1
                             ,counter  = 1  and right.firstchar not in ['_','-']  => 0
                             ,counter != 1  and right.firstchar     in ['_','-']  => left.lineno_old + 1
                             ,counter != 1  and right.firstchar not in ['_','-']  => left.lineno_old
                             ,                                                       left.lineno_old
                         );
  
     self.lineno_new:= map(   counter  = 1  and right.firstchar     in ['_','+']  => 1
                             ,counter  = 1  and right.firstchar not in ['_','+']  => 0
                             ,counter != 1  and right.firstchar     in ['_','+']  => left.lineno_new + 1
                             ,counter != 1  and right.firstchar not in ['_','+']  => left.lineno_new
                             ,                                                       left.lineno_new
                         );
    //keep rolling count of last three statuses
     self.statuses     := if(length_statuses  > 3 ,trim(all_statuses)[length(all_statuses) - 2..] ,all_statuses);
    
     self.groupid      := map(self.statuses not in ['__+','+?_','__-','_+_','_+-','-+-','++_','++-','+-_','+_-'/*,'_Added'*/]  =>   left.groupid    //keep same grouping
                            ,                                                                                                       right.groupid   //start new group
                          );
     self              := right;
  ));
  
  // zero out the added/removed line numbers for the opposite string to reduce confusion.
  ds_proj := project(d_linenos  ,transform({recordof(left),unsigned lines_old,unsigned lines_new,unsigned lines_same,unsigned lines_diff } //- firstchar
    ,self.lineno_old   := if(left.status = 'Added'    or left.firstchar = '?',0  ,left.lineno_old ) 
    ,self.lineno_new   := if(left.status = 'Removed'  or left.firstchar = '?',0  ,left.lineno_new) 
    ,self.lines_old    := max(d_linenos,lineno_old)
    ,self.lines_new    := max(d_linenos,lineno_new)
    ,self.lines_same   := count(d_linenos((status = '')))
    ,self.lines_diff   := 1//count(d_linenos((status not in ['','------>'])))
    ,self              := left
  ));
  
  ds_prep := project(ds_proj(status != '')  ,transform({unsigned cnt,unsigned groupid,unsigned lines_old,unsigned lines_new,unsigned lines_same,unsigned lines_diff,dataset({unsigned lineno_old,unsigned lineno_new,STRING status;STRING line;}) child}
    ,self.cnt     := left.cnt
    ,self.groupid := left.groupid
    ,self.child   := dataset([{left.lineno_old,left.lineno_new,left.status,left.line}],{unsigned lineno_old,unsigned lineno_new,STRING status;STRING line;})
    ,self         := left
  ));
  
  ds_rollup := rollup(ds_prep ,left.groupid = right.groupid ,transform(recordof(left),self.child := left.child + right.child,self := left));
  //attname, cnt,groupid, dataset({lineno_old, lineno_new,status, line}) child
  
  // {unsigned cnt,unsigned lineno_old,unsigned lineno_new,STRING status;string statuses;unsigned groupid;STRING line;}
  
  ds_norm := normalize(ds_rollup  ,count(left.child) + 1,transform(recordof(ds_proj) - statuses
  ,self.cnt           := left.cnt
  ,self.lineno_old    := if(left.child[counter].status != ''  ,left.child[counter].lineno_old   ,0 )
  ,self.lineno_new    := if(left.child[counter].status != ''  ,left.child[counter].lineno_new   ,0 )
  ,self.status        := if(left.child[counter].status != ''  ,left.child[counter].status       ,'')
  ,self.groupid       := if(left.child[counter].status != ''  ,left.groupid                     ,0 )
  ,self.line          := if(left.child[counter].status != ''  ,left.child[counter].line         ,'')
  ,self.firstchar     := ''
  ,self               := left
  ));
  
  diff_lines := if( count(ds_norm(status = 'Added')) > count(ds_norm(status = 'Removed'))  
                  ,count(ds_norm(status = 'Added'  ))  
                  ,count(ds_norm(status = 'Removed'))
                );
  ds_result := project(ds_norm  ,transform({unsigned cnt,recordof(ds_norm) - firstchar - cnt - groupid},self.cnt := counter,self.lines_diff := diff_lines,self := left));
  
  
  RETURN ds_result;
  // RETURN when(ds_result
            // ,parallel(
              //  output(sRawDiff      ,named('sRawDiff'     ))
              // ,output(diff_index    ,named('diff_index'   ))
              // ,output(dParsed       ,named('dParsed'      ))
              // ,output(dAugmented    ,named('dAugmented'   ))
              // ,output(d_linenos     ,named('d_linenos'    ))
              // ,output(ds_proj       ,named('ds_proj'      ))
              // ,output(ds_prep       ,named('ds_prep'      ))
              // ,output(ds_rollup     ,named('ds_rollup'    ))
              // ,output(ds_norm       ,named('ds_norm'      ))
              // ,output(diff_lines    ,named('diff_lines'   ))
              // ,output(ds_result     ,named('ds_result'    ))
            // )
         // );
END;
export MAC_Marshall_Results_NoCount(in_parms,infile,outfile,maxLengthIn = 4096,outputCount = 'optional') := macro

  #uniquename(new_rec)
  
  #if(maxLengthIn = 4096)
  	  %new_rec% := record(infile),
			unsigned2 output_seq_no;
	  end;  
  #else
	  %new_rec% := record, maxLength((INTEGER)maxLengthIn)
			unsigned2 output_seq_no;
			infile;
	  end;  
  #end

	
  #uniquename(trans)
  %new_rec% %trans%(infile le,unsigned8 cnt) := transform
		self.output_seq_no := cnt;
		self := le;
  end;
	
  #uniquename(numbered)
  %numbered% := choosen(project(infile,%trans%(left,counter)),in_parms.MaxResults_val);
  outputCount := output(count(%numbered%),NAMED('RecordsAvailable'));
  outfile := choosen(%numbered%(output_seq_no>in_parms.SkipRecords_val),in_parms.MaxResultsThisTime_val);
  
ENDMACRO;
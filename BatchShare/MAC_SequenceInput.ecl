
// **************************************************
// Min input layout required:
// 	 BatchShare.Layouts.ShareAcct
// **************************************************

export MAC_SequenceInput(infile, outfile) := macro

// **************************************************************************************
// Here we are sequencing all acctno fields. The idea is to eliminate the need to have a 
// valid acctno specified in the input. This also eliminates the need to dedup input 
// records by acctno. Note that this will require an additional project to set the acctno 
// to its original value before results can be returned.

// Also appending a layout to keep standard error information
// **************************************************************************************		
#uniquename(rec_res);
%rec_res% := record (recordof (infile))
	string20	orig_acctno 	:= ''; // [internal]
  Batchshare.Layouts.ShareErrors;
end;

#uniquename(tra);
%rec_res% %tra%(infile ref,integer C) := transform
  self.acctno := (string) C,
  self.orig_acctno := ref.acctno,
	self := ref
  end;
outfile := project(infile,%tra%(left,counter));

endmacro;
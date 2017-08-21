// WA UCC MAIN MAPPER 

import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;

name := FileServices.GetSuperFileSubName('~thor_data400::in::uccV2::WA', 1);
process_date := regexfind('[[:digit:]]{8}',name,0) : INDEPENDENT;
if(process_date='',fail('ERROR -- UNABLE TO OBTAIN PROCESS DATE FOR WA UCC DATA'));  
   
newInput := UCCV2.File_WA_in;
mainBase := UCCV2.File_WA_Main_Base;

UCCV2.Layout_UCC_Common.layout_UCC_new bldMain(newInput L) := TRANSFORM

	 clnOriginalFileNumber := trim(StringLib.StringFilterOut(L.originalFileNumber,'-'));
	 clnFileNumber := trim(StringLib.StringFilterOut(L.FileNumber,'-'));
	 clnFileTime := trim(StringLib.StringFilterOut(L.fileTime,':'));
	
	self.tmsid 				 := 'WA' + if(clnOriginalFileNumber = '',
										  clnFileNumber,
										  clnOriginalFileNumber) ;
	self.rmsid 				 := 'WA' + clnFileNumber;
	self.process_date		 := process_date;
	self.Filing_Jurisdiction := 'WA';
	self.orig_filing_number  := if(clnOriginalFileNumber='',
								   clnFileNumber,
								   clnOriginalFileNumber);
	self.orig_filing_type	 := 'INITIAL FILING';
	self.orig_filing_date    := if(trimUpper(L.transType)='INITIAL',L.fileDate,'');
	self.orig_filing_time    := if(trimUpper(L.transType)='INITIAL',clnFileTime,'');
	self.filing_number		 := clnFileNumber;
	self.filing_type	     := map(trimUpper(L.transType)='INITIAL' => 'INITIAL FILING',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType) in ['AMENDMENTCOLLATERAL','AMENDMENTPARTIES'] => 'AMENDMENT',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType)='ASSIGNMENT' => 'ASSIGNMENT',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType)='CONTINUATION' => 'CONTINUATION',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType)='CORRECTION' => 'CORRECTION',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType) in ['TERMINATIONDEBTOR','TERMINATIONSECUREDPARTY'] => 'TERMINATION',
									trimUpper(L.transType)='AMENDMENT' and 
									trimUpper(L.amendType)='FILINGOFFICERSTATEMENT' => 'FILING OFFICER STATEMENT',
									'');							
	self.filing_date		 := L.fileDate;
	self.filing_time		 := clnFileTime;
	self.expiration_date	 := L.expiration;
	tempDesignation          := if(trimUpper(L.designation)='NOTYPE','',L.designation);
	self.collateral_desc	 := map(trim(tempDesignation)<>'' and trim(L.colText)<>'' =>
									trimUpper(tempDesignation) + '; ' + trimUpper(L.colText),
									trim(tempDesignation)<>'' =>
									trimUpper(tempDesignation),
									trim(L.colText)<>'' =>
									trimUpper(L.colText),
									'');
	self.property_desc		 := IF(trimUpper(L.realEstateDescription)='NONE','',trimUpper(L.realEstateDescription));
	self.signer_name		 := trimUpper(L.contactNameAndPhone);
	self.filing_agency		 := 'SECRETARY OF STATE/UCC DIVISION';
	self.address	         := '405 BLACK LAKE BLVD SW';
	self.city	 			 := 'OLYMPIA';
	self.state				 := 'WA';
	self.zip				 := '98502';
	
	//Check to see if Box B, lines 3 and 4 are basically duplicates.
	
	compressLine3			 := trimUpper(StringLib.StringFilterOut(L.boxBLine3,', '));
	compressLine4			 := trimUpper(StringLib.StringFilterOut(L.boxBLine4,', ')); 
	clnBoxBLine1a			 := trimUpper(L.boxBLine1);
	clnBoxBLine2a			 := trimUpper(L.boxBLine2);
	clnBoxBLine3a			 := if(compressLine3=compressLine4,'',trimUpper(L.boxBLine3));	
	clnBoxBLine4a			 := trimUpper(L.boxBLine4);
	
	clnBoxBLine1b			 := if(clnBoxBLine1a in ['N/A',','],'',clnBoxBLine1a);
	clnBoxBLine2b			 := if(clnBoxBLine2a in ['N/A',','],'',clnBoxBLine2a);
	clnBoxBLine3b			 := if(clnBoxBLine3a in ['N/A',','],'',clnBoxBLine3a);
	clnBoxBLine4b			 := if(clnBoxBLine4a in ['N/A',','],'',clnBoxBLine4a);
	
	allLines         		 := clnBoxBLine1b + '#~ ' +
							    clnBoxBLine2b + '#~ ' +
							    clnBoxBLine3b + '#~ ' +
							    clnBoxBLine4b;
								
    referenceInfo            := if(trimUpper(L.optionalFilerReferenceData)<>'',
								   if(clnBoxBLine1b+clnBoxBLine2b+clnBoxBLine3b+clnBoxBLine4b<>'',
								      '; ' + trimUpper(L.optionalFilerReferenceData),
									  trimUpper(L.optionalFilerReferenceData)),
								    '');
	
	cln_allLines1 		 	 := regexreplace('(#~ ){2,}',allLines,'#~ ');
	cln_allLines2 		 	 := regexreplace('(#~ ?$)',cln_allLines1,'');
	cln_allLines3 		 	 := regexreplace('^(#~ ?)',cln_allLines2,'');
	
	description1	 			 := if(cln_allLines3+referenceInfo<>'',
								   'FILER REFERENCE INFO: ' + cln_allLines3+referenceInfo,
								   '');
								   
    description2  				 := regexreplace('(#~ )',description1,', '); 								   
	
    self.description         := description2;								   
	self			         := [];
   END; 

UCCV2.Layout_UCC_Common.layout_UCC_new  tRollupDuplicates(UCCV2.Layout_UCC_Common.layout_UCC_new  L,  
													  UCCV2.Layout_UCC_Common.layout_UCC_new  R) := TRANSFORM
		 self           	 := L;
         end;

sortNewInput                  := sort(distribute(project(newInput,bldMain(Left)) + mainBase,hash(tmsid)),tmsid,rmsid,-filing_date,local);
newMainBase                    := rollup(sortNewInput ,tRollupDuplicates(left,right),tmsid,rmsid,local);
AddRecordID := uccv2.fnAddPersistentRecordID_Main(newMainBase);
								     
export Proc_Build_WA_Main_Base      :=	AddRecordID;




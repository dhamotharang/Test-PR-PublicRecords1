
#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export MN := MODULE;

	export Layouts_Raw_Input := MODULE;
		
	export varies := record,MAXLENGTH(200)
	   string fields;
	   end;
	   
	export common_header := record
		string3 category;
		string2 recordType;
		string9 charterNumber;
		string1 unused;
		string3 sequence;
		end;

	export an01_out := record
		common_header;
		string name;
		end;
		
	export an02_out := record
		common_header;
		string30 nhName;
		string40 nhAddrs;
		string20 nhCity;
		string2  nhState;
		string10 nhZip;
		end;
			
	export	an0102_out := record
		an01_out;
		string30 nhName;
		string40 nhAddrs;
		string20 nhCity;
		string2  nhState;
		string10 nhZip;
		end;   	
		
	export an05_out := record
		common_header;
		string2  unusedOPid;
		string40 busAddrs;
		string20 busCity;
		string2  busState;
		string10 busZip;
		string8  busDateFiled;
		string8  busDuration;
		string12 unusedDTN;
		end;
		
	export an01_an05_out := record
		common_header;
		string   name;
		string2  unusedOPid;
		string40 busAddrs;
		string20 busCity;
		string2  busState;
		string10 busZip;
		string8  busDateFiled;
		string8  busDuration;
		string12 unusedDTN;
		end;
		
	export xx03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;		
		string12 unusedDocNbr;
		string1  cnFlag;
		end;
		
	export an03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;		
		string12 unusedDocNbr;
		string1  cnFlag;
		end;
		
	export	bt01_out := record
		common_header;
		string name;
		string8 dateFiled;
		string10 duration;
		end;
			
	export	bt02_out := record
		common_header;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;
		string12 unusedDTN;
		end;

	export	bt01_bt02_out := record
		common_header;
		string name;
		string8 dateFiled;
		string10 duration;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;
		string12 unusedDTN;
		end;
		
	export	bt03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;		 
		string12 unusedDocNbr;
		string1  cnFlag;
		end;
		
	export  dc01_out := record
		common_header;
		string name;
		end;
		
	export dc02_out := record
		common_header;
		string40 eoAddrs;
		string20 eoCity;
		string2  eoState;
		string10 eoZip;
		string11 federalID;
		end;
	export dc03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;
		string12 unusedDTN;	
		string1  cnFlag;
		end;		
	
	export dc04_out := record
		common_header;
		string30 regAgntName;
		string17 shares;
		string8  dateInc;
		string10 microFilmNbr;
		string10 duration;
		string8  dateNameFiled;
		string6  actStatDate;
		string5  actStatNumber;
		string4  mnStatuteNbr;
		string12 unusedDTN;
		end;					
		
	export dc05_out := record
		common_header;
		string40 regOfcAddrs;
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string1  unusedFlag1;
		string1  unusedFlag2;
		end;
		
	export dc07_out := record
		common_header;
		string19 ceoLName;
		string10 ceoFName;
		string40 ceoAddrs;
		string20 ceoCity;
		string2  ceoState;
		string10 ceoZip;
		string6  unusedCEO;
		end;
		
	export dc01_07_out := record
		dc01_out;
		string19 ceoLName;
		string10 ceoFName;
		string40 ceoAddrs;
		string20 ceoCity;
		string2  ceoState;
		string10 ceoZip;
		string6  unusedCEO;
		end;
		
	export norm_dcAR_out := record
		common_header;
		string8  annualRpt;	
		end;	
		
	export dc01_dc04_out := record
		common_header;
		string   name;
		string30 regAgntName;
		string17 shares;
		string8  dateInc;
		string10 microFilmNbr;
		string10 duration;
		string8  dateNameFiled;
		string6  actStatDate;
		string5  actStatNumber;
		string4  mnStatuteNbr;
		string12 unusedDTN;
		end;

	export dc01_dc02_dc04_out := record
		common_header;
		string   name;
		string30 regAgntName;
		string17 shares;
		string8  dateInc;
		string10 microFilmNbr;
		string10 duration;
		string8  dateNameFiled;
		string6  actStatDate;
		string5  actStatNumber;
		string4  mnStatuteNbr;
		string12 unusedDTN;
		string40 eoAddrs;
		string20 eoCity;
		string2  eoState;
		string10 eoZip;
		string11 federalID;
		end;	
		
	export	dc01020405_out := record
		dc01_dc02_dc04_out;
		string40 regOfcAddrs;
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string1  unusedFlag1;
		string1  unusedFlag2;
		end;
		
	export	fc01_out := record
		common_header;
		string name;
		end;
		
	export fc02_out := record
		common_header;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;
		end;
		
	export fc04_out := record
		common_header;
		string2	 unusedOpId;
		string12 status;
		string2  lawsState;
		string8  dateInc;
		string8  dateQual;
		string10 duration;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string2  agentCode;
		string1  reinstateCode;
		string12 unusedDTN;
		end;					
				
	export fc05_out := record
		common_header;
		string40 homeAddrs;
		string20 homeCity;
		string2  homeState;
		string10 homeZip;	
		end;
		
	export fc06_out := record
		common_header;
		string homeName;	
		end;	
		
	export norm_fcAR_out := record
		common_header;
		string8  annualRpt;	
		end;	
		
	export fc01_fc04_out := record
		common_header;
		string   name;
		string2	 unusedOpId;
		string12 status;
		string2  lawsState;
		string8  dateInc;
		string8  dateQual;
		string10 duration;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string2  agentCode;
		string1  reinstateCode;
		string12 unusedDTN;
		end;

	export fc01_fc04_fc05_out := record
		fc01_fc04_out;
		string40 homeAddrs;
		string20 homeCity;
		string2  homeState;
		string10 homeZip;
		end;

	export fc01_fc04_fc05_fc06_out := record
		fc01_fc04_fc05_out;
		string homeName;	
		end;
		
	export fc01_fc02_fc04_fc05_fc06_out := record
		fc01_fc04_fc05_fc06_out;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;	
		end;
		
	export fc03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;
		string12 unusedDTN;
		string1  cnFlag;
		end;		
		
	export fc0102040506TBL_out := record
		fc01_fc02_fc04_fc05_fc06_out;
		string lawsStateDesc;
		end;
		
	export ForgnStateDescLayout := record,MAXLENGTH(100)
			string code;
			string desc;
			end; 
			
	export	lp01_out := record
		common_header;
		string name;
		end;

	export  lp06_out := record
		common_header;
		string homeName;	
		end;
		
	export  lp01_lp06_out := record
		lp01_out;
		string homeName;
		end;
		
	export  lp04_out := record
		common_header;
		string2  unusedOpId;
		string2  homeState;
		string8  dateFormed;
		string8  dateFiled;
		string8  duration;
		string12 unusedDocNbr;
		string1  lllpFlag;
		string17 unusedEffTime;
		end;

	export  lp01_lp04_lp06_out  := record
		lp01_lp06_out;
		string2  unusedOpId;
		string2  homeState;
		string8  dateFormed;
		string8  dateFiled;
		string8  duration;
		string12 unusedDocNbr;
		string1  lllpFlag;
		string17 unusedEffTime;
		end;

	export  lp01_lp02_lp04_lp06_out := record
		lp01_lp04_lp06_out;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;
		end;
	export  lp01_lp02_lp04_lp05_lp06_out  := record
		lp01_lp02_lp04_lp06_out;
		string40 ofcAddrs;
		string20 ofcCity;
		string2  ofcState;
		string10 ofcZip;	
		string8  arDueDate;
		string1  unusedLP05;
		string4  chapterNbr;
		end;
		
	export  lp0102040505C06_out  := record
		lp01_lp02_lp04_lp05_lp06_out;
		string40 mailAddrs;
		string20 mailCity;
		string2  mailState;
		string10 mailZip;	
		end;
		
	export lp0102040505C06TBL_out := record
		lp0102040505C06_out;
		string homeStateDesc;
		end;

	export  lp02_out := record
		common_header;
		string30 agentName;
		string40 agentAddrs;
		string20 agentCity;
		string2  agentState;
		string10 agentZip;
		end;			
				
	export  lp05_out := record
		common_header;
		string40 ofcAddrs;
		string20 ofcCity;
		string2  ofcState;
		string10 ofcZip;	
		string8  arDueDate;
		string1  unusedLP05;
		string4  chapterNbr;
		end;
		
	export  lp03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;
		string12 unusedDTN;	
		string1  cnFlag;
		end;		
	
	export np01_out := record
		common_header;
		string name;
		end;
				
	export np04_out := record
		common_header;
		string30  agentName;
		string17  numberShares;
		string8   dateInc;
		string10  microNbr;
		string10  duration;
		string8   dateFiled;
		string19  presLName;
		string10  presFName;	
		end;					
				
	export np05_out := record
		common_header;
		string2	 unusedOpId;
		string40 regOfcAddrs;
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string1  unusedFlag1;
		string1  unusedFlag2;
		string12 unusedDTN;
		end;		
		
	export norm_npAR_out := record
		common_header;
		string8  annualRpt;	
		end;	
		
	export np01_np05_out := record
		np01_out;
		string2	 unusedOpId;
		string40 regOfcAddrs;
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		string8  ar1;
		string8  ar2;
		string8  ar3;
		string1  unusedFlag1;
		string1  unusedFlag2;
		string12 unusedDTN;
		end;

	export np01_np04_np05_out := record
		np01_np05_out;
		string30  agentName;
		string17  numberShares;
		string8   dateInc;
		string10  microNbr;
		string10  duration;
		string8   dateFiled;
		string19  presLName;
		string10  presFName;
		end;

	export np03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;
		string12 unusedDTN;
		string1  cnFlag;
		end;		
		
	export	rn01_out := record
		common_header;
		string name;
		end;

	export rn04_out := record
		common_header;
		string2  unusedOpId;
		string8  dateFiled;
		string8  duration;
		string12 unusedDTN;
		end;

	export rn01_rn04_out := record
		rn01_out;
		string2  unusedOpId;
		string8  dateFiled;
		string8  duration;
		string12 unusedDTN;
		end;

	export rn02_out := record
		common_header;
		string30 nhName;
		string40 nhAddrs;
		string20 nhCity;
		string2  nhState;
		string10 nhZip;
		end;
		
	export rn01_rn02_out := record
		rn01_out;
		string30 nhName;
		string40 nhAddrs;
		string20 nhCity;
		string2  nhState;
		string10 nhZip;
		end;
		
	export rn03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  amndDateEnter;
		string12 unusedDTN;	
		string1  cnFlag;
		end;		
		
	export tm01_out := record
		common_header;
		string name;
		end;
		
	export tm04_out := record
		common_header;
		string2	  unusedOpId;
		string8   dateFiled;
		string8   dateUsed;
		string8   duration;
		string1   markType;
		string3   classifyNbr;
		string1   logo;
		string65  usedWith;
		string12  unusedDTN;	
		end;					
		
	export tm04_logo_out := record
		common_header;
		string	  logoInfo;		
		end;
		
	export tm04_tm04_out := record
		tm04_out;
		string	  logoInfo;
		end;
		
	export tm01_tm04_out := record
		tm04_tm04_out;
		string	  name;	
		end;	
			
	export tm02_out := record
		common_header;
		string30 mhName;  //mh - Markholder
		string40 mhAddrs;
		string20 mhCity;
		string2  mhState;
		string10 mhZip;
		end;
	
	export tm01_tm02_out := record
		tm02_out;
		string name;
		end;
		
	export tm03_out := record
		common_header;
		string10 amndDateFiled;
		string10 amndMicNbr;
		string3  amndType;
		string   amndInfo;
		string6  unusedAmndDateEnter;
		string12 unusedDTN;
		string1  cnFlag;
		end;		
		
	export llc00_out := record
		common_header;
		string8  fileDate;
		string8  expireDate;
		string2  sic;
		string1  professionalLLC;
		string1  foreignLLC;
		string1  farmLand;
		string10 unusedUBN;
		string1  inactive;
		string4  chapterNbr;
		string10 unusedReceiptNbr;
		string3  unusedTypeCode;
		string12 unusedDTN;
		end;
		
	export llcA01_out := record
		common_header;
		string230 legalName;
		end;

	export llc00A01_out := record
		llc00_out;
		string230 legalName;
		end;
		
	export llcB0_out := record
		common_header;
		string40 regOfcAddrs;	
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		end;
		
	export llc00A01B0_out  := record
		llc00A01_out;
		string40 regOfcAddrs;	
		string20 regOfcCity;
		string2  regOfcState;
		string10 regOfcZip;
		end;

	export llcB1B2_out := record
		common_header;
		string30 raName;
		end;	
		
	export llc00A01B01_out := record
		llc00A01B0_out;
		string30 raName;
		end;
		
	export llcC0_out := record
		common_header;
		string40 mailAddrs;	
		string20 mailCity;
		string2  mailState;
		string10 mailZip;
		end;	
		
	export llc00A01B01C0_out := record
		llc00A01B01_out;
		string40 mailAddrs;	
		string20 mailCity;
		string2  mailState;
		string10 mailZip;
		end;	

	export llcD0123_out := record
		common_header;
		string comment;
		end;		
		
	export llc00A01B01C0D0123_out := record
		llc00A01B01C0_out;
		string comment;
		end;
		
	export llcE01_out := record
		common_header;
		string homeName;
		end;	
		
	export llc00A01B01C0D0123E01_out	:= record
		llc00A01B01C0D0123_out;
		string homeName;
		end;
		
	export llcE5_out := record
		common_header;
		string2 lawsState;
		end;
		
	export llc00A01B01C0D0123E015_out := record
		llc00A01B01C0D0123E01_out;
		string2 lawsState;
		end;
		
	export llc00A01B01C0D0123E015TBL_out := record
		llc00A01B01C0D0123E015_out;
		string lawsStateDesc;
		end;	
		
	export llcF0_out := record
		common_header;
		string40 homeAddrs;	
		string20 homeCity;
		string2  homeState;
		string10 homeZip;
		end;
		
	export llc00A01B01C0D0123E015TBLF0_out := record
		llc00A01B01C0D0123E015TBL_out;
		string40 homeAddrs;	
		string20 homeCity;
		string2  homeState;
		string10 homeZip;
		end;	
		
	export llcG0_out := record
		common_header;
		string8   amndDateFiled;
		string10  amndMicNbr;
		string3   amndType;
		string109 amndInfo;
		string12  unusedDTN;
		integer8  position;
		string1   cnFlag;
		end;
		
	export llcJ01_out := record
		common_header;
		string partnerNames;
		end;

	export llc00A01B01C0D0123E015TBLF0J01_out := record
		llc00A01B01C0D0123E015TBLF0_out;
		string partnerNames;		
		end;		
		
	end;    //End of Layouts_Raw_Input module
	
						
export Files_Raw_Input := MODULE;   
	    export rawANfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::an::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));		
		
		export rawBTfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::bt::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawDCfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::dc::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawFCfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::fc::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawLPfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::lp::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawNPfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::np::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawRNfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::rn::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawTMfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::tm::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));
										 
		export rawLLCfile(string fileDate) := distribute(dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::llc::mn',	
										 Layouts_Raw_Input.varies,
										 CSV(SEPARATOR(['']),TERMINATOR(['\r\n']),notrim)),hash64(trim(fields[6..14],left,right),trim(fields[1..3],left,right)));				
		
		export ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::corpstateprovince_table', Layouts_Raw_Input.ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function				
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;			
         
		// reformatDate(string inDate) := function
			// string DateOnly 	:= trim(regexreplace('00:00:00',inDate,''),left,right);
			// string clean_inDate := StringLib.StringFilterOut(DateOnly,'"');
			// string2 outMM 		:= if(	clean_inDate[2] = '/' or clean_inDate[2] = '-',
										// '0'+ clean_inDate[1],
										// clean_inDate[1..2]);
			// string2 outDD 		:= if(	clean_inDate[length(clean_inDate)-6] = '/' or clean_inDate[length(clean_inDate)-6] = '-',
										// '0'+ clean_inDate[length(clean_inDate)-5],
										// clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]);
			// string8 newDate 	:= clean_inDate[length(clean_inDate)-3..]+outMM+outDD;	
			// return newDate;	
		// end;		
		
		reformatDate(string inDate) := function			
			string DateOnly 	:= if(trim(inDate,left,right)<>'',
									  trim(regexreplace('00:00:00',inDate,''),left,right),
									  '');
			string clean_inDate := if(trim(inDate,left,right)<>'',
									  StringLib.StringFilterOut(DateOnly,'"'),
									  '');
			string2 outMM 		:= if(trim(inDate,left,right)<>'',
									  if(clean_inDate[2] = '/' or clean_inDate[2] = '-',
									    '0'+ clean_inDate[1],
									     clean_inDate[1..2]),
									  '');
			string2 outDD 		:= if(trim(inDate,left,right)<>'',
									  if(clean_inDate[length(clean_inDate)-6] = '/' or clean_inDate[length(clean_inDate)-6] = '-',
									     '0'+ clean_inDate[length(clean_inDate)-5],
									     clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]),
									  '');
			string8 newDate 	:= if(trim(inDate,left,right)<>'',
									  clean_inDate[length(clean_inDate)-3..]+outMM+outDD,
									  '');
			return newDate;	
		end;
		
		Layouts_Raw_Input.an01_out transformAn01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
			
		Layouts_Raw_Input.an02_out transformAN02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.nhName 		:= l.fields[19..48];
			self.nhAddrs 	    := l.fields[49..88];
			self.nhCity 		:= l.fields[89..108];
			self.nhState		:= l.fields[109..110];
			self.nhZip 			:= l.fields[111..120];
            end;
			
		Layouts_Raw_Input.an05_out transformAN05(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOPid 	:= '';
			self.busAddrs   	:= l.fields[21..60];
			self.busCity 		:= l.fields[61..80];
			self.busState		:= l.fields[81..82];
			self.busZip 		:= l.fields[83..92];
			self.busDateFiled 	:= l.fields[93..100];
			self.busDuration 	:= l.fields[101..108];
			self.unusedDTN 		:= '';			
            end;			
			
		Layouts_Raw_Input.xx03_out transformXX03(Layouts_Raw_Input.varies l) := transform			
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];			
			self.unusedDocNbr	:= l.fields[98..109];
			self.cnFlag			:= '';
            end;
			
		Layouts_Raw_Input.an03_out transform1AN03(Layouts_Raw_Input.varies l) := transform			
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];			
			self.unusedDocNbr	:= l.fields[98..109];
			self.cnFlag			:= '';
            end;									
			
		Layouts_Raw_Input.an03_out transform2AN03(Layouts_Raw_Input.an03_out l) := transform			
			self      := l;
            end;					
			
		Layouts_Raw_Input.an01_out rollup_an01(Layouts_Raw_Input.an01_out l, Layouts_Raw_Input.an01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
			self      := [];
            end;
			
		Layouts_Raw_Input.xx03_out rollup_xx03(Layouts_Raw_Input.xx03_out l, Layouts_Raw_Input.xx03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self      := r;
            end;	
			
		Layouts_Raw_Input.an03_out rollup_an03(Layouts_Raw_Input.an03_out l, Layouts_Raw_Input.an03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  r.amndInfo,
							  l.amndInfo);
			self      := r;
			self      := [];
            end;
		
		Layouts_Raw_Input.xx03_out iterate_xx03(Layouts_Raw_Input.xx03_out l, Layouts_Raw_Input.xx03_out r) := transform
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;
		
		Layouts_Raw_Input.an03_out iterate_an03(Layouts_Raw_Input.an03_out l, Layouts_Raw_Input.an03_out r) := transform
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;	
		
		Layouts_Raw_Input.bt01_out transformBt01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));
			self.dateFiled 		:= if(l.fields[16..18] = '000',
									l.fields[69..76],
									'');
			self.duration 		:= if(l.fields[16..18] = '000',
									l.fields[77..86],
									'');
            end;
			
		Layouts_Raw_Input.bt02_out transformBt02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.agentName 		:= l.fields[19..48];
			self.agentAddrs 	:= l.fields[49..88];
			self.agentCity 		:= l.fields[89..108];
			self.agentState		:= l.fields[109..110];
			self.agentZip 		:= l.fields[111..120];
			self.unusedDTN 		:= l.fields[121..132];			
            end;
			
		Layouts_Raw_Input.bt03_out transform1Bt03(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];
			self.unusedDocNbr	:= l.fields[98..109];
			self.cnFlag			:= '';
            end;			
			
		Layouts_Raw_Input.bt03_out transform2Bt03(Layouts_Raw_Input.bt03_out l) := transform
			self      := l;
            end;					
			
		Layouts_Raw_Input.bt01_out rollup_bt01(Layouts_Raw_Input.bt01_out l, Layouts_Raw_Input.bt01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
			self      := [];
            end;
			
		Layouts_Raw_Input.bt03_out rollup_bt03(Layouts_Raw_Input.bt03_out l, Layouts_Raw_Input.bt03_out r) := transform//,			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  r.amndInfo,
							  l.amndInfo);
			self      := r;
			self      := [];
            end;
			
		Layouts_Raw_Input.bt03_out iterate_bt03(Layouts_Raw_Input.bt03_out l, Layouts_Raw_Input.bt03_out r) := transform
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;		
			
		Layouts_Raw_Input.dc01_out transformDC01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
			
		Layouts_Raw_Input.dc02_out transformDC02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.eoAddrs 	    := l.fields[19..58];
			self.eoCity 		:= l.fields[59..78];
			self.eoState		:= l.fields[79..80];
			self.eoZip 			:= l.fields[81..90];
			self.federalID      := l.fields[91..101];
            end;
			
		Layouts_Raw_Input.dc04_out transformDC04(Layouts_Raw_Input.varies l) := transform,
            skip(trimUpper(l.fields[19..26])='SEE FILE' or
			     trimUpper(l.fields[19..36])='ORIGINALLY ENTERED')
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.regAgntName   	:= l.fields[19..48];
			self.shares     	:= l.fields[49..65];
			self.dateInc		:= l.fields[66..73];
			self.microFilmNbr	:= l.fields[74..83];			
			self.duration 		:= l.fields[84..93];
			self.dateNameFiled	:= l.fields[94..101];
			self.actStatDate	:= l.fields[102..107];
			self.actStatNumber 	:= l.fields[108..112];
			self.mnStatuteNbr 	:= l.fields[113..116];
			self.unusedDTN      := '';
            end;			
			
		Layouts_Raw_Input.dc05_out transformDC05(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.regOfcAddrs   	:= l.fields[19..58];
			self.regOfcCity 	:= l.fields[59..78];
			self.regOfcState	:= l.fields[79..80];
			self.regOfcZip 		:= l.fields[81..90];			
			self.ar1 			:= l.fields[91..98];
			self.ar2 			:= l.fields[99..106];
			self.ar3 			:= l.fields[107..114];
			self.unusedFlag1 	:= '';			
			self.unusedFlag2 	:= '';	
            end;			
	
		Layouts_Raw_Input.dc07_out transformDC07(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.ceoLName       := l.fields[19..37];
			self.ceoFName       := l.fields[38..47];
			self.ceoAddrs 	    := l.fields[48..87];
			self.ceoCity 		:= l.fields[88..107];
			self.ceoState		:= l.fields[108..109];
			self.ceoZip 		:= l.fields[110..119];
			self.unusedCEO      := '';
            end;
	
		Layouts_Raw_Input.norm_dcAR_out transformdcAR(Layouts_Raw_Input.norm_dcAR_out l) := transform,
			skip(stringlib.stringfilter(l.annualRpt,'0123456789') != l.annualRpt or 
					length(trim(l.annualRpt,left,right))!= 8)
			self      := l;
            end;	
	
		Layouts_Raw_Input.dc03_out transform1DC03(Layouts_Raw_Input.varies l) := transform			
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];
			self.unusedDTN		:= l.fields[98..109];
			self.cnFlag			:= '';
            end;
			
		Layouts_Raw_Input.dc03_out transform2DC03(Layouts_Raw_Input.dc03_out l) := transform			
			self      := l;
            end;					
			
		Layouts_Raw_Input.dc01_out rollup_dc01(Layouts_Raw_Input.dc01_out l, Layouts_Raw_Input.dc01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;
			
		Layouts_Raw_Input.dc03_out rollup_dc03(Layouts_Raw_Input.dc03_out l, Layouts_Raw_Input.dc03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self      := r;
            end;
			
		Layouts_Raw_Input.dc03_out iterate_dc03(Layouts_Raw_Input.dc03_out l, Layouts_Raw_Input.dc03_out r) := transform		
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;			
			
		Layouts_Raw_Input.fc01_out transformFC01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
			
		Layouts_Raw_Input.fc02_out transformFC02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.agentName 		:= l.fields[19..48];
			self.agentAddrs 	:= l.fields[49..88];
			self.agentCity 		:= l.fields[89..108];
			self.agentState		:= l.fields[109..110];
			self.agentZip 		:= l.fields[111..120];
            end;
			
		Layouts_Raw_Input.fc04_out transformFC04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOpId    	:= '';
			self.status     	:= l.fields[21..32];
			self.lawsState		:= l.fields[33..34];
			self.dateInc    	:= l.fields[35..42];			
			self.dateQual 		:= l.fields[43..50];
			self.duration   	:= l.fields[51..60];
			self.ar1			:= l.fields[61..68];
			self.ar2		 	:= l.fields[69..76];
			self.ar3		 	:= l.fields[77..84];
			self.agentCode		:= l.fields[85..86];
			self.reinstateCode	:= l.fields[87..87];
			self.unusedDTN      := '';
            end;			
			
		Layouts_Raw_Input.fc05_out transformFC05(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.homeAddrs   	:= l.fields[19..58];
			self.homeCity 		:= l.fields[59..78];
			self.homeState		:= l.fields[79..80];
			self.homeZip 		:= l.fields[81..90];				
            end;			
	
		Layouts_Raw_Input.fc06_out transformFC06(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.homeName       := if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));		
            end;
	
		Layouts_Raw_Input.norm_fcAR_out transformfcAR(Layouts_Raw_Input.norm_fcAR_out l) := transform,
			skip(stringlib.stringfilter(l.annualRpt,'0123456789') != l.annualRpt or 
					length(trim(l.annualRpt,left,right))!= 8)
			self      := l;
            end;	
	
		Layouts_Raw_Input.fc03_out transform1FC03(Layouts_Raw_Input.varies l) := transform			
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];
			self.unusedDTN		:= l.fields[98..109];
			self.cnFlag			:= '';
            end; 
			
		Layouts_Raw_Input.fc03_out transform2FC03(Layouts_Raw_Input.fc03_out l) := transform			
			self      := l;
            end;					
			
		Layouts_Raw_Input.fc01_out rollup_fc01(Layouts_Raw_Input.fc01_out l, Layouts_Raw_Input.fc01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;
			
		Layouts_Raw_Input.fc06_out rollup_fc06(Layouts_Raw_Input.fc06_out l, Layouts_Raw_Input.fc06_out r) := transform
			self.homeName := l.homeName + r.homeName;
			self      := l;
            end;			
			
		Layouts_Raw_Input.fc03_out rollup_fc03(Layouts_Raw_Input.fc03_out l, Layouts_Raw_Input.fc03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self      := r;
            end;
			
		Layouts_Raw_Input.fc03_out iterate_fc03(Layouts_Raw_Input.fc03_out l, Layouts_Raw_Input.fc03_out r) := transform
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;		
			
		Layouts_Raw_Input.lp01_out transformLP01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
			
		Layouts_Raw_Input.lp02_out transformLP02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.agentName 		:= l.fields[19..48];
			self.agentAddrs 	:= l.fields[49..88];
			self.agentCity 		:= l.fields[89..108];
			self.agentState		:= l.fields[109..110];
			self.agentZip 		:= l.fields[111..120];
            end;
			
		Layouts_Raw_Input.lp04_out transformLP04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOpId    	:= '';
			self.homeState     	:= l.fields[21..22];
			self.dateFormed		:= l.fields[23..30];
			self.dateFiled   	:= l.fields[31..38];			
			self.duration   	:= l.fields[39..46];
			self.unusedDocNbr	:= '';
			self.lllpFlag		:= l.fields[59..59];
			self.unusedEffTime	:= '';			
            end;											

		Layouts_Raw_Input.lp05_out transformLP05(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.ofcAddrs       := l.fields[19..58];
			self.ofcCity        := l.fields[59..78];
			self.ofcState		:= l.fields[79..80];
			self.ofcZip			:= l.fields[81..90];
			self.arDueDate		:= if(trimUpper(l.fields[1..3]) in ['MLP','NLP'],
									trimUpper(l.fields[91..98]),
									'');
			self.unusedLP05		:= '';
			self.chapterNbr		:= trimUpper(l.fields[100..103]);								
            end;
	
		Layouts_Raw_Input.lp06_out transformLP06(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.homeName       := if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));		
            end;
		 
		 Layouts_Raw_Input.lp03_out transform1LP03(Layouts_Raw_Input.varies l) := transform	//add recDel,orDel,cnDel columns; init ''		
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];
			self.unusedDTN		:= l.fields[98..109];
			self.cnFlag			:= '';
            end;			
			
		Layouts_Raw_Input.lp01_out rollup_lp01(Layouts_Raw_Input.lp01_out l, Layouts_Raw_Input.lp01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;
			
		Layouts_Raw_Input.lp06_out rollup_lp06(Layouts_Raw_Input.lp06_out l, Layouts_Raw_Input.lp06_out r) := transform
			self.homeName := l.homeName + r.homeName;
			self      := l;
            end;			
			
		Layouts_Raw_Input.lp03_out rollup_lp03(Layouts_Raw_Input.lp03_out l, Layouts_Raw_Input.lp03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self      := r;
            end;			
			
		Layouts_Raw_Input.lp03_out iterate_lp03(Layouts_Raw_Input.lp03_out l, Layouts_Raw_Input.lp03_out r) := transform	
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;												 
		 
		 Layouts_Raw_Input.np01_out transformNP01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
						
		Layouts_Raw_Input.np04_out transformNP04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.agentName    	:= l.fields[19..48];
			self.numberShares   := l.fields[49..65];
			self.dateInc		:= l.fields[66..73];
			self.microNbr    	:= l.fields[74..83];			
			self.duration 		:= l.fields[84..93];
			self.dateFiled   	:= l.fields[94..101];
			self.presLName		:= l.fields[102..120];
			self.presFName		:= l.fields[121..130];			
            end;			
		
		Layouts_Raw_Input.np05_out transformNP05(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOpId     := '';
			self.regOfcAddrs   	:= l.fields[21..60];
			self.regOfcCity 	:= l.fields[61..80];
			self.regOfcState	:= l.fields[81..82];
			self.regOfcZip 		:= l.fields[83..92];
			self.ar1 			:= l.fields[93..100];
			self.ar2 			:= l.fields[101..108];
			self.ar3 			:= l.fields[109..116];
			self.unusedFlag1	:= '';
			self.unusedFlag2	:= '';
			self.unusedDTN		:= '';
            end;			
	
		Layouts_Raw_Input.norm_npAR_out transformnpAR(Layouts_Raw_Input.norm_npAR_out l) := transform,
			skip(stringlib.stringfilter(l.annualRpt,'0123456789') != l.annualRpt or 
					length(trim(l.annualRpt,left,right))!= 8)
			self      := l;
            end;	
	
		Layouts_Raw_Input.np01_out iterate_np01(Layouts_Raw_Input.np01_out l, Layouts_Raw_Input.np01_out r) := transform,
			skip(l.charterNumber = r.charterNumber and  
				 trimUpper(l.name) = trimUpper(r.name))
			self := r;
            end;		
		Layouts_Raw_Input.np03_out transformNP03(Layouts_Raw_Input.varies l) := transform			
			self.category 				:= l.fields[1..3];
			self.recordType 			:= l.fields[4..5];
			self.charterNumber 			:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 				:= '';
			self.sequence 				:= l.fields[16..18];
			self.amndDateFiled			:= l.fields[19..28];
			self.amndMicNbr 			:= l.fields[29..38];
			self.amndType 				:= l.fields[39..41];
			self.amndInfo				:= l.fields[42..91];
			self.amndDateEnter      	:= l.fields[92..97];
			self.unusedDTN				:= l.fields[98..109];	
			self.cnFlag					:= '';
            end;							
			
		Layouts_Raw_Input.np01_out rollup_np01(Layouts_Raw_Input.np01_out l, Layouts_Raw_Input.np01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;
			

		Layouts_Raw_Input.np03_out rollup_np03(Layouts_Raw_Input.np03_out l, Layouts_Raw_Input.np03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self := r;
            end;
			
		Layouts_Raw_Input.np03_out iterate_np03(Layouts_Raw_Input.np03_out l, Layouts_Raw_Input.np03_out r) := transform								 
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;		
			
		Layouts_Raw_Input.rn01_out transformrn01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
			
		Layouts_Raw_Input.rn02_out transformrn02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.nhName 		:= l.fields[19..48];
			self.nhAddrs 		:= l.fields[49..88];
			self.nhCity 		:= l.fields[89..108];
			self.nhState		:= l.fields[109..110];
			self.nhZip 			:= l.fields[111..120];
            end;
			
		Layouts_Raw_Input.rn04_out transformrn04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOpId    	:= '';
			self.dateFiled   	:= l.fields[21..28];			
			self.duration   	:= l.fields[29..48];
			self.unusedDTN		:= '';
            end;											

		Layouts_Raw_Input.rn03_out transform1rn03(Layouts_Raw_Input.varies l) := transform		
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..28];
			self.amndMicNbr 	:= l.fields[29..38];
			self.amndType 		:= l.fields[39..41];
			self.amndInfo		:= l.fields[42..91];
			self.amndDateEnter	:= l.fields[92..97];
			self.unusedDTN		:= l.fields[98..109];
			self.cnFlag			:= '';
            end;			
			
		Layouts_Raw_Input.rn01_out rollup_rn01(Layouts_Raw_Input.rn01_out l, Layouts_Raw_Input.rn01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;
			
		Layouts_Raw_Input.rn03_out rollup_rn03(Layouts_Raw_Input.rn03_out l, Layouts_Raw_Input.rn03_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self := r;
            end;			
			
		Layouts_Raw_Input.rn03_out iterate_rn03(Layouts_Raw_Input.rn03_out l, Layouts_Raw_Input.rn03_out r) := transform	
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;												
			
		Layouts_Raw_Input.tm01_out transformtm01(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.name 			:= if(l.fields[16..18] <> '000',
									trimUpper(l.fields[19..88]),
									trimUpper(l.fields[19..68]));			
            end;
						
		Layouts_Raw_Input.tm04_out transform1TM04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.unusedOpId   	:= l.fields[19..20];
			self.dateFiled  	:= l.fields[21..28];
			self.dateUsed		:= l.fields[29..36];
			self.duration    	:= l.fields[37..44];			
			self.markType 		:= l.fields[45..45];
			self.classifyNbr   	:= l.fields[46..48];
			self.logo			:= l.fields[49..49];
			self.usedWith		:= l.fields[50..114];			
			self.unusedDTN		:= l.fields[115..126];
            end;								
			
		Layouts_Raw_Input.tm04_logo_out transform2TM04(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.logoInfo   	:= l.fields[19..];			
            end;				
		
		
		Layouts_Raw_Input.tm02_out transformTM02(Layouts_Raw_Input.varies l) := transform
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.mhName		    := l.fields[19..48];
			self.mhAddrs   		:= l.fields[49..88];
			self.mhCity 		:= l.fields[89..108];
			self.mhState		:= l.fields[109..110];
			self.mhZip 			:= l.fields[111..120];			
            end;				
	
		Layouts_Raw_Input.tm03_out transformTM03(Layouts_Raw_Input.varies l) := transform			
			self.category 				:= l.fields[1..3];
			self.recordType 			:= l.fields[4..5];
			self.charterNumber 			:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 				:= '';
			self.sequence 				:= l.fields[16..18];
			self.amndDateFiled			:= l.fields[19..28];
			self.amndMicNbr 			:= l.fields[29..38];
			self.amndType 				:= l.fields[39..41];
			self.amndInfo				:= l.fields[42..91];
			self.unusedAmndDateEnter 	:= l.fields[92..97];
			self.unusedDTN				:= l.fields[98..109];
			self.cnFlag					:= '';
            end;			
			
		Layouts_Raw_Input.tm01_out rollup_tm01(Layouts_Raw_Input.tm01_out l, Layouts_Raw_Input.tm01_out r) := transform
			self.name := l.name + r.name;
			self      := l;
            end;		
			
		Layouts_Raw_Input.tm03_out rollup_tm03(Layouts_Raw_Input.tm03_out l, Layouts_Raw_Input.tm03_out r) := transform				     
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self := r;
            end;

		Layouts_Raw_Input.tm03_out iterate_tm03(Layouts_Raw_Input.tm03_out l, Layouts_Raw_Input.tm03_out r) := transform
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType)='RO',
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																
												
			self.sequence :=	if(trimUpper(r.amndType) = '',			
									l.sequence,
									r.sequence),			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;						
			
		Layouts_Raw_Input.tm04_logo_out rollup_tm04(Layouts_Raw_Input.tm04_logo_out l, Layouts_Raw_Input.tm04_logo_out r) := transform
			self.logoInfo := l.logoInfo + r.logoInfo;
			self      := l;
            end;						
			
		Layouts_Raw_Input.llc00_out transformllc00(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.fileDate			:= l.fields[19..26];
			self.expireDate 		:= l.fields[27..34];
			self.sic 				:= l.fields[35..36];
			self.professionalLLC	:= l.fields[37..37];
			self.foreignLLC 		:= l.fields[38..38];
			self.farmLand			:= l.fields[39..39];
			self.unusedUBN			:= '';
			self.inactive 			:= l.fields[50..50];
			self.chapterNbr			:= l.fields[51..54];
			self.unusedReceiptNbr 	:= '';
			self.unusedTypeCode 	:= '';
			self.unusedDTN 			:= '';
            end;	
					
		Layouts_Raw_Input.llcA01_out transformllcA01(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.legalName 			:= l.fields[19..];			
            end;
			
		Layouts_Raw_Input.llcB0_out transformllcB0(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.regOfcAddrs		:= l.fields[19..58];
			self.regOfcCity 		:= l.fields[59..78];
			self.regOfcState 		:= l.fields[79..80];
			self.regOfcZip 			:= l.fields[81..90];			
            end;			
		
		Layouts_Raw_Input.llcB1B2_out transformllcB1B2(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.raName 			:= l.fields[19..48];			
            end;	
			
		Layouts_Raw_Input.llcC0_out transformllcC0(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.mailAddrs			:= l.fields[19..58];
			self.mailCity 			:= l.fields[59..78];
			self.mailState 			:= l.fields[79..80];
			self.mailZip 			:= l.fields[81..90];			
            end;			

		Layouts_Raw_Input.llcD0123_out transformllcD0123(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.comment 			:= l.fields[19..];			
            end;
			
		Layouts_Raw_Input.llcD0123_out rollup_llcD0123(Layouts_Raw_Input.llcD0123_out l, Layouts_Raw_Input.llcD0123_out r) := transform
			self.comment := l.comment + r.comment;
			self      := l;
            end;
			
		Layouts_Raw_Input.llcE01_out transformllcE01(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.homeName 			:= l.fields[19..];			
            end;			
			
		Layouts_Raw_Input.llcE01_out rollup_llcE01(Layouts_Raw_Input.llcE01_out l, Layouts_Raw_Input.llcE01_out r) := transform
			self.homeName := l.homeName + r.homeName;
			self      := l;
            end;			
		
		Layouts_Raw_Input.llcE5_out transformllcE5(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.lawsState 			:= l.fields[19..20];			
            end;		
		
		Layouts_Raw_Input.llcF0_out transformllcF0(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.homeAddrs			:= l.fields[19..58];
			self.homeCity 			:= l.fields[59..78];
			self.homeState 			:= l.fields[79..80];
			self.homeZip 			:= l.fields[81..90];			
            end;		
		
		Layouts_Raw_Input.llcG0_out transformllcG0(Layouts_Raw_Input.varies l, integer cntr) := transform	
			self.category 		:= l.fields[1..3];
			self.recordType 	:= l.fields[4..5];
			self.charterNumber 	:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 		:= '';
			self.sequence 		:= l.fields[16..18];
			self.amndDateFiled	:= l.fields[19..26];
			self.amndMicNbr 	:= l.fields[27..36];
			self.amndType 		:= l.fields[37..39];
			self.amndInfo		:= l.fields[40..148];
			self.unusedDTN		:= l.fields[149..160];	
			self.position       := cntr;
			self.cnFlag			:= '';
            end;			
		
		Layouts_Raw_Input.llcG0_out iterate_llcG0(Layouts_Raw_Input.llcG0_out l, Layouts_Raw_Input.llcG0_out r) := transform	
			self.amndInfo :=	map(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber) => trimUpper(r.amndInfo),
								    trimUpper(r.amndType) = '' => trimUpper(l.amndInfo) + 
									   if(trimUpper(l.amndType) in ['RO','PPB'],
									      ' ',
										  '') + trimUpper(r.amndInfo),												
									trimUpper(r.amndInfo));
									
			self.amndType :=	map(trimUpper(r.amndType) = 'OR' => 'XX',			
									trimUpper(r.amndType) = 'CN' and l.cnFlag <> 'X' => 'XX',								
									trimUpper(r.amndType) = '' => trimUpper(l.amndType),
									trimUpper(r.amndType));							
							 
            self.cnFlag   := 	if(trimUpper(l.charterNumber)<>trimUpper(r.charterNumber),
									'',
									map(l.cnFlag = 'X' => 'X',
									trimUpper(r.amndType) = 'CN' => 'X',
									''));																			
			
			self.amndDateFiled := if(trimUpper(r.amndType) = '',			                       
									 l.amndDateFiled,
									 r.amndDateFiled);										
										
			self.amndMicNbr := if(trimUpper(r.amndType) = '',			                        
									 trimUpper(l.amndMicNbr),
									 trimUpper(r.amndMicNbr));											
			self := r;
            end;			
			
		Layouts_Raw_Input.llcG0_out rollup_llcG0(Layouts_Raw_Input.llcG0_out l, Layouts_Raw_Input.llcG0_out r) := transform			
			self.amndInfo := if(length(trimUpper(r.amndInfo)) > length(trimUpper(l.amndInfo)),
							  trimUpper(r.amndInfo),
							  trimUpper(l.amndInfo));
			self      	  := r;
            end;			
		
		Layouts_Raw_Input.llcJ01_out transformllcJ01(Layouts_Raw_Input.varies l) := transform
			self.category 			:= l.fields[1..3];
			self.recordType 		:= l.fields[4..5];
			self.charterNumber 		:= regexreplace('^X',trimUpper(l.fields[6..14]),'');
			self.unused 			:= '';
			self.sequence 			:= l.fields[16..18];
			self.partnerNames 		:= l.fields[19..48];			
            end;	
			
		Layouts_Raw_Input.llcJ01_out rollup_llcJ01(Layouts_Raw_Input.llcJ01_out l, Layouts_Raw_Input.llcJ01_out r) := transform			
			self.partnerNames := trimUpper(l.partnerNames) + ', ' + 
								 trimUpper(r.partnerNames);
			self			  := r;
            end;			
		 
		 
        
		
		
	
//---------------------  Corporation File Mapping for Assumed Name Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformAN01(Layouts_Raw_Input.an01_an05_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);				
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'ASSUMED NAME';
 		    self.corp_address1_type_cd			:= 'B';
		    self.corp_address1_type_desc		:= 'BUSINESS';
			self.corp_address1_line1			:= trimUpper(input.busAddrs); 
			self.corp_address1_line2			:= '';
			self.corp_address1_line3			:= map(trimUpper(input.busCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.busCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.busCity));
			self.corp_address1_line4			:= trimUpper(input.busState);
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.busZip,'-'),left,right);
			self.corp_address1_line6			:= '';					
			self.corp_status_cd				    := trimUpper(input.category);
													   
			self.corp_status_desc				:= map(trimUpper(input.category) = 'ANI' => 'INACTIVE',
													   trimUpper(input.category) = 'AN' => 'ACTIVE',
													   '');						
			self.corp_inc_state					:= 'MN';							
			
			newDateFiled                        := if(stringlib.stringfilter(input.busDateFiled,'0123456789') != input.busDateFiled or 
													length(trim(input.busDateFiled,left,right))!= 8,
													'',			
												   input.busDateFiled[5..8] + 
				                                   input.busDateFiled[1..4]);
			
			self.corp_filing_date				:= if (	_validate.date.fIsValid(newDateFiled) and 
														_validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
															newDateFiled,
															''
													   );				
			newDurationDate                     := if(stringlib.stringfilter(input.busDuration,'0123456789') != input.busDuration or 
													length(trim(input.busDuration,left,right))!= 8,
													'',			
												   input.busDuration[5..8] + 
				                                   input.busDuration[1..4]);
			self.corp_term_exist_cd				:= if (	_validate.date.fIsValid(newDurationDate),
															'D',
															''
													   );
			self.corp_term_exist_exp			:= if (	_validate.date.fIsValid(newDurationDate),
															newDurationDate,
															''
													   );															 						
			self.corp_term_exist_desc			:= if (	_validate.date.fIsValid(newDurationDate),
															'EXPIRATION DATE',
															''
													   );			
			self 								:= [];
		end; 
		
//---------------------  Corporation File Mapping for Business Trust Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformBT01(Layouts_Raw_Input.bt01_bt02_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);				
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
		    self.corp_ra_name					:= trimUpper(input.agentName);
			self.corp_ra_address_line1			:= trimUpper(input.agentAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.agentCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.agentCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.agentCity));
			self.corp_ra_address_line4			:= trimUpper(input.agentState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.agentZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';					
			self.corp_status_cd				    := trimUpper(input.category);
													   
			self.corp_status_desc				:= map(trimUpper(input.category) = 'BTI' => 'INACTIVE',
													   trimUpper(input.category) = 'BT' => 'ACTIVE',
													   '');
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := 'BUSINESS TRUST';
			self.corp_inc_state					:= 'MN';
							
			newDateFiled                        := if(stringlib.stringfilter(input.dateFiled,'0123456789') != input.dateFiled or 
													length(trim(input.dateFiled,left,right))!= 8,
													'',			
												   input.dateFiled[5..8] + 
				                                   input.dateFiled[1..4]);
												   
			self.corp_inc_date			  		:= if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														''
													  );	
			newDurationDate                     := reformatDate(input.duration);	
		
			self.corp_term_exist_cd				:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   'D',
														   '')															   
													  );
													  
            self.corp_term_exist_exp			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   newDurationDate,
														   '')															   
													  );														

			self.corp_term_exist_desc			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],												
													  'PERPETUAL', 
													   if( _validate.date.fIsValid(newDurationDate),
														 'EXPIRATION DATE',
														 '')					
													  );
			self 								:= [];
		end; 	
		
		
//---------------------  Corporation File Mapping for Domestic Corporation Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformDC01(Layouts_Raw_Input.dc01020405_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);						 
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
		    self.corp_ra_name					:= trimUpper(input.regAgntName);
			self.corp_ra_address_line1			:= trimUpper(input.regOfcAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.regOfcCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.regOfcCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.regOfcCity));
			self.corp_ra_address_line4			:= trimUpper(input.regOfcState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.regOfcZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';	
			self.corp_ra_address_type_cd        := 'G';
			self.corp_ra_address_type_desc		:= 'REGISTERED OFFICE';
			self.corp_address1_line1			:= trimUpper(input.eoAddrs); 
			self.corp_address1_line2			:= '';
			self.corp_address1_line3			:= map(trimUpper(input.eoCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.eoCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.eoCity));
			self.corp_address1_line4			:= trimUpper(input.eoState);
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.eoZip,'-'),left,right);
			self.corp_address1_line6			:= '';	
			self.corp_address1_type_desc		:= 'EXECUTIVE OFFICE';
			self.corp_status_cd				    := trimUpper(input.category);
												   
			self.corp_status_desc				:= map(trimUpper(input.category) = 'DCI' => 'INACTIVE',
													   trimUpper(input.category) = 'DC' => 'ACTIVE',
													   '');
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := 'DOMESTIC CORPORATION';
			self.corp_inc_state					:= 'MN';
							
			newDateInc                          := if(stringlib.stringfilter(input.dateInc,'0123456789') != input.dateInc or 
													length(trim(input.dateInc,left,right))!= 8,
													'',			
												   input.dateInc[5..8] + 
				                                   input.dateInc[1..4]);
												   
			self.corp_inc_date			  		:= if(_validate.date.fIsValid(newDateInc) and 
													  _validate.date.fIsValid(newDateInc,_validate.date.rules.DateInPast),
														newDateInc,
														''
													  );	
			newDurationDate                     := reformatDate(input.duration);	
		
			self.corp_term_exist_cd				:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   'D',
														   '')															   
													  );

			self.corp_term_exist_exp			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   newDurationDate,
														   '')															   
													  );

			self.corp_term_exist_desc			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],												
													  'PERPETUAL', 
													   if( _validate.date.fIsValid(newDurationDate),
														 'EXPIRATION DATE',
														 '')					
													  );
			self.corp_microfilm_nbr             := trimUpper(input.microFilmNbr);
			newDateNameFiled                    := if(stringlib.stringfilter(input.dateNameFiled,'0123456789') != input.dateNameFiled or 
													length(trim(input.dateNameFiled,left,right))!= 8,
													'',			
												   input.dateNameFiled[5..8] + 
				                                   input.dateNameFiled[1..4]);
			
		 	newDateNameFiledFormat				:= input.dateNameFiled[1..2] + '/' +
				                                   input.dateNameFiled[3..4] + '/' +
												   input.dateNameFiled[5..8];
		    self.corp_name_comment				:= if(_validate.date.fIsValid(newDateNameFiled),
														 'CURRENT NAME FILED: ' + newDateNameFiledFormat,
														 '');
		 	integer yy                     		:=(integer)trim(input.actStatDate[5..6],left,right);
            integer low19                       :=20;
            integer high19                      :=99;		     
			self.corp_status_date				:= if(stringlib.stringfilter(input.actStatDate,'0123456789') != input.actStatDate or 
													length(trim(input.actStatDate,left,right))!= 6,
													 '',	
												     if(yy BETWEEN low19 AND high19,
													    '19',
														'20') +																												
												     input.actStatDate[5..6] +
				                                     input.actStatDate[1..4]); 
												   
			self.corp_status_comment			:= if(trimUpper(input.actStatNumber)<>'',
														'ACTIVE STATUS FILE NO: ' + trimUpper(input.actStatNumber),
														'');
			self.corp_acts						:= trimUpper(input.mnStatuteNbr);
			self.corp_fed_tax_id				:= trimUpper(input.federalID);
			self 								:= [];
		end; 			

		
//---------------------  Corporation File Mapping for Domestic Corporation Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformDC02(Layouts_Raw_Input.dc04_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									                                                                                                                   
		    self.corp_ra_name					:= trimUpper(input.regAgntName);
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self 								:= [];
		end; 						

//---------------------  Corporation File Mapping for Foreign Corporation Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformFC01(Layouts_Raw_Input.fc0102040506TBL_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);							
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			validAgntCodes                      := ['CT','NP','NU','MK','CS','NR','PH','US']; 
			agntCode							:= trimUpper(input.agentCode);
			ra_name								:= map(agntCode='CT'=>'C T CORPORATION SYSTEM INC',
													   agntCode='NP'=>'PRENTICE-HALL CORP SYSTEM INC', 	
													   agntCode='NU'=>'UNITED STATES CORP COMPANY',													  
													   agntCode='MK'=>'MESSERLI & KRAMER',
													   agntCode='CS'=>'CORPORATION SERVICE COMPANY',
													   agntCode='NR'=>'NATIONAL REGISTERED AGENTS INC',
													   agntCode='PH'=>'PRENTICE-HALL CORP SYSTEM INC',
													   agntCode='US'=>'UNITED STATES CORP COMPANY',
													   '');
			ra_addrs1							:= map(agntCode='CT'=>'100 S 5TH STR #1075',
													   agntCode='NP'=>'380 JACKSON STR #700', 	
													   agntCode='NU'=>'380 JACKSON STR #700',													   
													   agntCode='MK'=>'150 S 5TH STR - 1800 FIFTH STREET TOWERS',
													   agntCode='CS'=>'380 JACKSON STR #700',
													   agntCode='NR'=>'590 PARK STR, CAPITOL PROF BLDG 6',
													   agntCode='PH'=>'W 2200 1ST NAT\'L BANK BLDG',
													   agntCode='US'=>'SOO LINE BLDG, 507 MARQUETTE AVE',
													   '');
			ra_addrs2							:= map(agntCode='CT'=>'',
													   agntCode='NP'=>'', 	
													   agntCode='NU'=>'',													   
													   agntCode='MK'=>'',
													   agntCode='CS'=>'',
													   agntCode='NR'=>'',
													   agntCode='PH'=>'',
													   agntCode='US'=>'',
													   '');
			ra_addrs3							:= map(agntCode='CT'=>'MINNEAPOLIS',
													   agntCode='NP'=>'ST PAUL', 	
													   agntCode='NU'=>'ST PAUL',													   
													   agntCode='MK'=>'MINNEAPOLIS',
													   agntCode='CS'=>'ST PAUL',
													   agntCode='NR'=>'ST PAUL',
													   agntCode='PH'=>'ST PAUL',
													   agntCode='US'=>'MINNEAPOLIS',
													   '');
			ra_addrs4							:= if(agntCode in validAgntCodes,
														'MN',
														''); 														   
			ra_addrs5							:= map(agntCode='CT'=>'55402',
													   agntCode='NP'=>'55101', 	
													   agntCode='NU'=>'55101',													   
													   agntCode='MK'=>'55402',
													   agntCode='CS'=>'55101',
													   agntCode='NR'=>'55103',
													   agntCode='PH'=>'55101',
													   agntCode='US'=>'55402',
													   '');
			ra_addrs_type_desc					:= if(agntCode in validAgntCodes,
														'REGISTERED OFFICE',
														'');		
		    self.corp_ra_name					:= if(agntCode='',
														(trimUpper(input.agentName)),
														ra_name);
			self.corp_ra_address_line1			:= if(agntCode='',
														(trimUpper(input.agentAddrs)),
														ra_addrs1);
			self.corp_ra_address_line2			:= ''; //Check if ra_addrs2 is needed.
			self.corp_ra_address_line3			:= if(agntCode='',
														map(trimUpper(input.agentCity)='MPLS' => 'MINNEAPOLIS',
															trimUpper(input.agentCity)='BLMGTN' => 'BLOOMINGTON',
															trimUpper(input.agentCity)),
														ra_addrs3);
			self.corp_ra_address_line4			:= if(agntCode='',
														(trimUpper(input.agentState)),
														ra_addrs4);
			self.corp_ra_address_line5			:= if(agntCode='',
														trim(StringLib.StringFilterOut(input.agentZip,'-'),left,right),
														ra_addrs5);
		
			self.corp_ra_address_line6			:= '';	
			self.corp_ra_address_type_desc		:= if(trim(self.corp_ra_address_line1 +
														   self.corp_ra_address_line2 +
														   self.corp_ra_address_line3 +
														   self.corp_ra_address_line4 +
														   self.corp_ra_address_line5 +
														   self.corp_ra_address_line6,left,right)<>'',
													'REGISTERED OFFICE',
													'');
			
			self.corp_address1_line1			:= trimUpper(input.homeAddrs); 
			self.corp_address1_line2			:= '';
			self.corp_address1_line3			:= map(trimUpper(input.homeCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.homeCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.homeCity));
			self.corp_address1_line4			:= trimUpper(input.homeState);
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.homeZip,'-'),left,right);
			self.corp_address1_line6			:= '';	
			self.corp_address1_type_desc		:= 'HOME OFFICE';
			self.corp_name_comment				:= if(trimUpper(input.homeName)<>'',
													 'HOME STATE NAME: ' + trimUpper(input.homeName),
													 '');
			self.corp_status_cd				    := trimUpper(input.category);
												   
			self.corp_status_desc				:= map(trimUpper(input.category) = 'FCI' => 'INACTIVE',
													   trimUpper(input.category) = 'FC' => 'ACTIVE',
													   '');
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := 'FOREIGN CORPORATION';										
			newDurationDate                     := reformatDate(input.duration);			
			self.corp_forgn_term_exist_cd		:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
													'P',
													if( _validate.date.fIsValid(newDurationDate),
													   'D',
													   '')															   
													  );			
			self.corp_forgn_term_exist_exp		:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   newDurationDate,
														   '')															   
													  );
			self.corp_forgn_term_exist_desc		:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],												
													  'PERPETUAL', 
													   if( _validate.date.fIsValid(newDurationDate),
														 'EXPIRATION DATE',
														 '')					
													  );				    		 			    			
			self.corp_entity_desc               := if(trimUpper(input.status) in ['PROFESSIONAL','NON-PROFIT'],
													  trimUpper(input.status),
													  '');
			self.corp_forgn_state_cd			:= if(trimUpper(input.lawsStateDesc) = '',
													'',
													trimUpper(input.lawsState));
			self.corp_forgn_state_desc			:= trimUpper(input.lawsStateDesc);
			newForgnDate                        := if(stringlib.stringfilter(input.dateInc,'0123456789') != input.dateInc or 
													length(trim(input.dateInc,left,right))!= 8,
													'',			
												   input.dateInc[5..8] + 
				                                   input.dateInc[1..4]); 
			self.corp_forgn_date				:= if(_validate.date.fIsValid(newForgnDate),													   
													  newForgnDate,
														''
													  );
		    newDateQual							:= if(stringlib.stringfilter(input.dateQual,'0123456789') != input.dateQual or 
													length(trim(input.dateQual,left,right))!= 8,
													'',			
												   input.dateQual[5..8] + 
				                                   input.dateQual[1..4]); 
        	corp_addl_info_1					:= if(_validate.date.fIsValid(newDateQual),
													  'QUALIFICATION DATE: ' +
													  input.dateQual[1..2] + '/' +
													  input.dateQual[3..4] + '/' +
													  input.dateQual[5..8],
														''
													  ); 
			corp_addl_info_2					:= if(trimUpper(input.reinstateCode)='I',
													  if(corp_addl_info_1 <> '',	
														'; REINSTATED',
														'REINSTATED'), 
													  '');
			self.corp_addl_info					:= corp_addl_info_1 + corp_addl_info_2;
			self 								:= [];
		end; 				

//---------------------  Corporation File Mapping for Limited Partnership Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformLP01(Layouts_Raw_Input.lp0102040505C06TBL_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);						 
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self.corp_ra_name					:= trimUpper(input.agentName);
			self.corp_ra_address_line1			:= trimUpper(input.agentAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.agentCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.agentCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.agentCity));
			self.corp_ra_address_line4			:= trimUpper(input.agentState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.agentZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';	
			self.corp_ra_address_type_desc		:= 'REGISTERED OFFICE';
			self.corp_address1_line1			:= trimUpper(input.ofcAddrs); 
			self.corp_address1_line2			:= '';
			self.corp_address1_line3			:= map(trimUpper(input.ofcCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.ofcCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.ofcCity));
			self.corp_address1_line4			:= trimUpper(input.ofcState);
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.ofcZip,'-'),left,right);
			self.corp_address1_line6			:= '';	
			self.corp_address1_type_cd			:= 'B';
			self.corp_address1_type_desc		:= 'BUSINESS';
			self.corp_address2_line1			:= trimUpper(input.mailAddrs); 
			self.corp_address2_line2			:= '';
			self.corp_address2_line3			:= map(trimUpper(input.mailCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.mailCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.mailCity));
			self.corp_address2_line4			:= trimUpper(input.mailState);
			self.corp_address2_line5			:= trim(StringLib.StringFilterOut(input.mailZip,'-'),left,right);
			self.corp_address2_line6			:= '';	
			self.corp_address2_type_cd			:= if(trim(self.corp_address2_line1 +
														   self.corp_address2_line2 +
														   self.corp_address2_line3 +
														   self.corp_address2_line4 +
														   self.corp_address2_line5 +
														   self.corp_address2_line6,left,right)<>'',
													'G',
													'');
			self.corp_address2_type_desc		:= if(trim(self.corp_address2_line1 +
														   self.corp_address2_line2 +
														   self.corp_address2_line3 +
														   self.corp_address2_line4 +
														   self.corp_address2_line5 +
														   self.corp_address2_line6,left,right)<>'',
													'REGISTERED OFFICE',
													'');
			category							:= trimUpper(input.category);
			categoryName                        := map(category='LP'=>'LIMITED PARTNERSHIP',
													   category='LPI'=>'LIMITED PARTNERSHIP',
													   category='FLP'=>'FOREIGN LIMITED PARTNERSHIP',
													   category='FLI'=>'FOREIGN LIMITED PARTNERSHIP',
													   category='MLP'=>'MINNESOTA LIMITED PARTNERSHIP',
													   category='MLI'=>'MINNESOTA LIMITED PARTNERSHIP',
													   category='NLP'=>'FOREIGN LIMITED PARTNERSHIP',
													   category='NLI'=>'FOREIGN LIMITED PARTNERSHIP',
													   '');
			self.corp_status_cd				    := trimUpper(input.category);
												   
			self.corp_status_desc				:= map(trimUpper(input.category) in ['LPI','FLI','MLI','NLI']=> 'INACTIVE',
													   trimUpper(input.category) in ['LP','FLP','MLP','NLP']=> 'ACTIVE',
													   '');
			self.corp_orig_org_structure_cd     := category;
			self.corp_orig_org_structure_desc   := categoryName;
			self.corp_inc_state					:= if(trimUpper(input.homeState) ='MN',
													 'MN',
													 '');
							
			newDateFiled                        := if(stringlib.stringfilter(input.dateFiled,'0123456789') != input.dateFiled or 
													length(trim(input.dateFiled,left,right))!= 8,
													'',			
												   input.dateFiled[5..8] + 
				                                   input.dateFiled[1..4]);
			self.corp_inc_date			  		:= if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														''
													  );	

			newDurationDate 	                := if(stringlib.stringfilter(input.duration,'0123456789') != input.duration or 
													length(trim(input.duration,left,right))!= 8,
													'',			
												   input.duration[5..8] + 
				                                   input.duration[1..4]);
		
			self.corp_term_exist_cd				:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   'D',
														   '')															   
													  );

			self.corp_term_exist_exp			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   newDurationDate,
														   '')															   
													  );

			self.corp_term_exist_desc			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],												
													  'PERPETUAL', 
													   if( _validate.date.fIsValid(newDurationDate),
														 'EXPIRATION DATE',
														 '')					
													  );			
		    self.corp_name_comment				:= if(trimUpper(input.homeName)<>'',
													  'HOME STATE NAME: ' + trimUpper(input.homeName),
													  '');		 	
			self.corp_acts						:= trimUpper(input.chapterNbr);
			self.corp_forgn_state_cd			:= if(trimUpper(input.homeState) not in ['MN','XX'],
													 trimUpper(input.homeState),
													 '');
			self.corp_forgn_state_desc			:= if(trimUpper(input.homeState) not in ['MN','XX'],
													 trimUpper(input.homeStateDesc),
													 '');
			newDateFormed                        := if(stringlib.stringfilter(input.dateFormed,'0123456789') != input.dateFormed or 
													length(trim(input.dateFormed,left,right))!= 8,
													'',			
												   input.dateFormed[5..8] + 
				                                   input.dateFormed[1..4]);								
			self.corp_forgn_date				:= if(_validate.date.fIsValid(newDateFormed) and 
													  _validate.date.fIsValid(newDateFormed,_validate.date.rules.DateInPast),
														newDateFormed,
														''
													  );
			self.corp_entity_desc               := if(trimUpper(input.lllpFlag)='Y',
													 'LLLP',
													 '');
			self 								:= [];
		end; 				

//---------------------  Corporation File Mapping for Limited Partnership Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformLP02(Layouts_Raw_Input.lp02_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);	
			self.corp_ra_address_line1			:= trimUpper(input.agentAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.agentCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.agentCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.agentCity));
			self.corp_ra_address_line4			:= trimUpper(input.agentState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.agentZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';	
		    self.corp_ra_address_type_desc		:= 'AGENT MAILING ADDRESS';	
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self 								:= [];
		end; 
		
//---------------------  Corporation File Mapping for Non-Profit Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformNP01(Layouts_Raw_Input.np01_np04_np05_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  						
			self.corp_legal_name				:= trimUpper(input.name);						
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
		    self.corp_ra_name					:= trimUpper(input.agentName);
			self.corp_ra_address_line1			:= trimUpper(input.regOfcAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.regOfcCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.regOfcCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.regOfcCity));
			self.corp_ra_address_line4			:= trimUpper(input.regOfcState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.regOfcZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';	
			self.corp_ra_address_type_cd        := 'G';
			self.corp_ra_address_type_desc		:= 'REGISTERED OFFICE';			
			self.corp_status_cd				    := trimUpper(input.category);												   
			self.corp_status_desc				:= map(trimUpper(input.category) = 'NPI' => 'INACTIVE',
													   trimUpper(input.category) = 'NP' => 'ACTIVE',
													   '');
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := 'NON-PROFIT CORPORATION';
			self.corp_inc_state					:= 'MN';
																	
			newDateInc                        	:= if(stringlib.stringfilter(input.dateInc,'0123456789') != input.dateInc or 
													length(trim(input.dateInc,left,right))!= 8,
													'',			
												   input.dateInc[5..8] + 
				                                   input.dateInc[1..4]); 
			self.corp_inc_date			  		:= if(_validate.date.fIsValid(newDateInc) and 
													  _validate.date.fIsValid(newDateInc,_validate.date.rules.DateInPast),
														newDateInc,
														''
													  );
			newDateFiled                        := if(stringlib.stringfilter(input.dateFiled,'0123456789') != input.dateFiled or 
													length(trim(input.dateFiled,left,right))!= 8,
													'',			
												   input.dateFiled[5..8] + 
				                                   input.dateFiled[1..4]); 
			self.corp_filing_date			  	:= if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														''
													  );
			newDurationDate                     := reformatDate(input.duration);	
		
			self.corp_term_exist_cd				:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   'D',
														   '')															   
													  );

			self.corp_term_exist_exp			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],														
														'P',
														if( _validate.date.fIsValid(newDurationDate),
														   newDurationDate,
														   '')															   
													  );

			self.corp_term_exist_desc			:= if(trimUpper(input.duration) in ['PERPETUAL','PERP'],												
													  'PERPETUAL', 
													   if( _validate.date.fIsValid(newDurationDate),
														 'EXPIRATION DATE',
														 '')					
													  );
			self.corp_microfilm_nbr             := trimUpper(input.microNbr);			
			self 								:= [];
		end; 						
		
//---------------------  Corporation File Mapping for Non-Profit Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformNP02(Layouts_Raw_Input.np04_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';		
			self.corp_ra_name					:= trimUpper(input.agentName);
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self 								:= [];
		end; 	
		
//---------------------  Corporation File Mapping for Reserved Name Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformRN01(Layouts_Raw_Input.rn01_rn04_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_legal_name				:= trimUpper(input.name);
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := map(trimUpper(input.category) in ['RN','RNI']=>'RESERVED NAME',
													   trimUpper(input.category) in ['RLP','RLI']=>'RESERVED LIMITED PARTNERSHIP',
													   '');
			self.corp_status_cd				    := trimUpper(input.category);
			self.corp_status_desc				:= map(trimUpper(input.category) in ['RNI','RLI']=> 'INACTIVE',
													   trimUpper(input.category) in ['RN','RLP']=> 'ACTIVE',
													   '');
			self.corp_inc_state					:= 'MN';			
			newDateFiled                        := if(stringlib.stringfilter(input.dateFiled,'0123456789') != input.dateFiled or 
													length(trim(input.dateFiled,left,right))!= 8,
													'',			
												   input.dateFiled[5..8] + 
				                                   input.dateFiled[1..4]); 
			self.corp_filing_date			  	:= if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														''
													  );
			newDurationDate                     := if(stringlib.stringfilter(input.duration,'0123456789') != input.duration or 
													length(trim(input.duration,left,right))!= 8,
													'',			
												   input.duration[5..8] + 
				                                   input.duration[1..4]);
			self.corp_term_exist_cd				:= if( _validate.date.fIsValid(newDurationDate),
													 'D',
													 '');																													   													 
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(newDurationDate),													   
														newDurationDate,
														''
													  );
			self.corp_term_exist_desc			:= if( _validate.date.fIsValid(newDurationDate),
													 'EXPIRATION DATE',
													 '');													   																		 
			self 								:= [];
		end; 		
		
//---------------------  Corporation File Mapping for Trademark Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformTM01(Layouts_Raw_Input.tm01_tm04_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_legal_name				:= trimUpper(input.name);
			self.corp_ln_name_type_cd           := '03';
			self.corp_ln_name_type_desc			:= 'TRADEMARK';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									
			self.corp_orig_org_structure_desc   := 'TRADEMARK';
			self.corp_orig_org_structure_cd     := '03';
			self.corp_status_cd				    := trimUpper(input.category);
			self.corp_status_desc				:= map(trimUpper(input.category) ='TMI'=> 'INACTIVE',
													   trimUpper(input.category) ='TM'=> 'ACTIVE',
													   '');
			self.corp_inc_state					:= 'MN';
		
		    newDateUsed							:= if(stringlib.stringfilter(input.dateUsed,'0123456789') != input.dateUsed or 
													length(trim(input.dateUsed,left,right))!= 8,
													'',			
												   input.dateUsed[5..8] + 
				                                   input.dateUsed[1..4]); 
        	corp_addl_info_1					:= if(_validate.date.fIsValid(newDateUsed),
													  'DATE FIRST USED: ' +
													  input.dateUsed[1..2] + '/' +
													  input.dateUsed[3..4] + '/' +
													  input.dateUsed[5..8] + '; ',
														''
													  );
			corp_addl_info_2					:= if(trimUpper(input.markType)<>'' and 
													  trimUpper(input.markType) in ['T','S','C','N'],
													  'MARK TYPE: ' +
													  map(trimUpper(input.markType)='T'=>'TRADE; ',
													      trimUpper(input.markType)='S'=>'SERVICE; ',
														  trimUpper(input.markType)='C'=>'COLLECTIVE; ',
														  trimUpper(input.markType)='N'=>'CERTIFICATION; ',
														  ''),
													  '');
		 	corp_addl_info_3					:= if(trimUpper(input.classifyNbr)<>'',
														'CLASSIFICATION NO: ' +
														 trimUpper(input.classifyNbr) + '; ',
														 '');
		 	corp_addl_info_4					:= if(trimUpper(input.usedWith)<>'',
														'USED WITH: ' +
														 trimUpper(input.usedWith) + '; ',
														 '');														 
		 	corp_addl_info_5					:= if(trimUpper(input.logoInfo)<>'',
														'LOGO: ' +
														 trimUpper(input.logoInfo),
														 '');
			corp_addl_info_6					:= corp_addl_info_1 + corp_addl_info_2 +
												   corp_addl_info_3 + corp_addl_info_4 +
												   corp_addl_info_5;
		    self.corp_addl_info					:= regexreplace(';$',trim(corp_addl_info_6,left,right),'');	   
			newDateFiled                        := if(stringlib.stringfilter(input.dateFiled,'0123456789') != input.dateFiled or 
													length(trim(input.dateFiled,left,right))!= 8,
													'',			
												   input.dateFiled[5..8] + 
				                                   input.dateFiled[1..4]); 
			self.corp_filing_date			  	:= if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														''
													  );
			newDurationDate                     := if(stringlib.stringfilter(input.duration,'0123456789') != input.duration or 
													length(trim(input.duration,left,right))!= 8,
													'',			
												   input.duration[5..8] + 
				                                   input.duration[1..4]);
			self.corp_term_exist_cd				:= if( _validate.date.fIsValid(newDurationDate),
													 'D',
													 '');																													   													 
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(newDurationDate),													   
														newDurationDate,
														''
													  );
			self.corp_term_exist_desc			:= if( _validate.date.fIsValid(newDurationDate),
													 'EXPIRATION DATE',
													 '');													   																		 
			self 								:= [];
		end; 	
		
//---------------------  Corporation File Mapping for Trademark Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformTM02(Layouts_Raw_Input.tm02_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_legal_name				:= trimUpper(input.mhName);
			self.corp_ln_name_type_cd			:= '01';
			self.corp_ln_name_type_desc			:= 'LEGAL';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									
			self.corp_address1_type_desc		:= 'MARKHOLDER';
			self.corp_address1_line1			:= trimUpper(input.mhAddrs);
			self.corp_address1_line2			:= '';
            self.corp_address1_line3			:= map(trimUpper(input.mhCity)='MPLS' => 'MINNEAPOLIS',
												   trimUpper(input.mhCity)='BLMGTN' => 'BLOOMINGTON',
												   trimUpper(input.mhCity));	
			self.corp_address1_line4			:= trimUpper(input.mhState);		
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.mhZip,'-'),left,right);																   
			self.corp_address1_line6			:= '';													   																		 
			self 								:= [];
		end; 	
		
		
//---------------------  Corporation File Mapping for Limited Liability Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformLLC01(Layouts_Raw_Input.llc00A01B01C0D0123E015TBLF0J01_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_legal_name				:= trimUpper(input.legalName);
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									
			self.corp_orig_org_structure_cd     := trimUpper(input.category);
			self.corp_orig_org_structure_desc   := map(trimUpper(input.category) in ['LLC','LLI']=>'DOMESTIC LIMITED LIABILITY COMPANY',
													   trimUpper(input.category) in ['LFC','LFI']=>'FOREIGN LIMITED LIABILITY COMPANY',
													   trimUpper(input.category) in ['DPL','DPI']=>'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
													   trimUpper(input.category) in ['FPL','FPI']=>'FOREIGN LIMITED LIABILITY PARTNERSHIP',
													   '');		
			self.corp_orig_bus_type_desc		:= if(trimUpper(input.professionalLLC)='Y',
														'PROFESSIONAL',
														'');
			self.corp_foreign_domestic_ind		:= if(trimUpper(input.foreignLLC)='Y',
														'FOREIGN',
														'');
			self.corp_status_cd				    := if(trimUpper(input.inactive)='I',
														'I',
														'');
			self.corp_status_desc				:= if(trimUpper(input.inactive)='I',
														'INACTIVE',
														'ACTIVE');
			self.corp_acts						:= trimUpper(input.chapterNbr);
			self.corp_inc_state					:= if(trimUpper(input.lawsState)='MN' or
													  trimUpper(input.lawsState)='',
													  'MN',
													  '');
			self.corp_forgn_state_cd			:= if(trimUpper(input.lawsState)<>'MN' and
													  trimUpper(input.lawsState)<>'',
													  trimUpper(input.lawsState),
													  '');
			self.corp_forgn_state_desc			:= if(trimUpper(input.lawsState)<>'MN' and
													  trimUpper(input.lawsState)<>'',
													  trimUpper(input.lawsStateDesc),
													  '');												   
			corp_addl_info_1					:= if(trimUpper(input.farmLand)='Y',
														'FARMLAND INTEREST; ',
														'');
			corp_addl_info_2					:= if(trimUpper(input.comment)<>'',
													  trimUpper(input.comment) +'; ',
														'');
			corp_addl_info_3					:= if(trimUpper(input.homeName)<>'',
														'HOME NAME: '+trimUpper(input.homeName)+'; ',
														'');
			corp_addl_info_4					:= if(trimUpper(input.partnerNames)<>'',
														'SIGNING PARTNER: '+trimUpper(input.partnerNames),
														'');											
        	
			corp_addl_info_5					:= corp_addl_info_1 + corp_addl_info_2 +
												   corp_addl_info_3 + corp_addl_info_4;												   
		    self.corp_addl_info					:= regexreplace(';$',trim(corp_addl_info_5,left,right),'');	   
			newFileDate                       := if(stringlib.stringfilter(input.fileDate,'0123456789') != input.fileDate or 
													length(trim(input.fileDate,left,right))!= 8,
													'',			
												   input.fileDate); 
			self.corp_filing_date			  	:= if(_validate.date.fIsValid(newFileDate) and 
													  _validate.date.fIsValid(newFileDate,_validate.date.rules.DateInPast),
														newFileDate,
														''
													  );
			newExpireDate                       := if(stringlib.stringfilter(input.expireDate,'0123456789') != input.expireDate or 
													length(trim(input.fileDate,left,right))!= 8,
													'',			
												   input.expireDate);
			self.corp_term_exist_cd				:= if( _validate.date.fIsValid(newExpireDate),
													 'D',
													 '');																													   													 
			self.corp_term_exist_exp			:= if(_validate.date.fIsValid(newExpireDate),													   
														newExpireDate,
														''
													  );
			self.corp_term_exist_desc			:= if( _validate.date.fIsValid(newExpireDate),
													 'EXPIRATION DATE',
													 '');	
			self.corp_ra_name					:= trimUpper(input.raName);
			self.corp_ra_address_line1			:= trimUpper(input.regOfcAddrs); 
			self.corp_ra_address_line2			:= '';
			self.corp_ra_address_line3			:= map(trimUpper(input.regOfcCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.regOfcCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.regOfcCity));
			self.corp_ra_address_line4			:= trimUpper(input.regOfcState);
			self.corp_ra_address_line5			:= trim(StringLib.StringFilterOut(input.regOfcZip,'-'),left,right);
			self.corp_ra_address_line6			:= '';
			self.corp_ra_address_type_cd    	:= if(trim(self.corp_ra_address_line1 +
														   self.corp_ra_address_line2 +
														   self.corp_ra_address_line3 +
														   self.corp_ra_address_line4 +
														   self.corp_ra_address_line5 +
														   self.corp_ra_address_line6,left,right)<>'',
														'G',
														'');
			self.corp_ra_address_type_desc		:= if(trim(self.corp_ra_address_line1 +
														   self.corp_ra_address_line2 +
														   self.corp_ra_address_line3 +
														   self.corp_ra_address_line4 +
														   self.corp_ra_address_line5 +
														   self.corp_ra_address_line6,left,right)<>'',
														'REGISTERED OFFICE',
														'');
			self.corp_address1_line1			:= trimUpper(input.mailAddrs); 
			self.corp_address1_line2			:= '';
			self.corp_address1_line3			:= map(trimUpper(input.mailCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.mailCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.mailCity));
			self.corp_address1_line4			:= trimUpper(input.mailState);
			self.corp_address1_line5			:= trim(StringLib.StringFilterOut(input.mailZip,'-'),left,right);
			self.corp_address1_line6			:= '';	
			self.corp_address1_type_cd			:= if(trim(self.corp_address1_line1 +
														   self.corp_address1_line2 +
														   self.corp_address1_line3 +
														   self.corp_address1_line4 +
														   self.corp_address1_line5 +
														   self.corp_address1_line6,left,right)<>'',
													'M',
													'');
			self.corp_address1_type_desc		:= if(trim(self.corp_address1_line1 +
														   self.corp_address1_line2 +
														   self.corp_address1_line3 +
														   self.corp_address1_line4 +
														   self.corp_address1_line5 +
														   self.corp_address1_line6,left,right)<>'',
													'MAILING',
													'');
			self.corp_address2_line1			:= trimUpper(input.homeAddrs); 
			self.corp_address2_line2			:= '';
			self.corp_address2_line3			:= map(trimUpper(input.homeCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.homeCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.homeCity));
			self.corp_address2_line4			:= trimUpper(input.homeState);
			self.corp_address2_line5			:= trim(StringLib.StringFilterOut(input.homeZip,'-'),left,right);
			self.corp_address2_line6			:= '';				
			self.corp_address2_type_desc		:= if(trim(self.corp_address2_line1 +
														   self.corp_address2_line2 +
														   self.corp_address2_line3 +
														   self.corp_address2_line4 +
														   self.corp_address2_line5 +
														   self.corp_address2_line6,left,right)<>'',
													'HOME ADDRESS',
													'');
			self 								:= [];
		end; 	
		
//---------------------  Corporation File Mapping for Limited Liability Records  --------------------//	

		Corp2_mapping.Layout_CorpPreClean CorpTransformLLC02(Layouts_Raw_Input.llcB1B2_out input) := transform
		 	self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';			
			self.corp_process_date				:= fileDate;
            self.corp_src_type				    := 'SOS';
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);													  									                                                                                                                   
		    self.corp_ra_name					:= trimUpper(input.raName);	
			self.corp_ln_name_type_cd           := '01';                                                                                                                                                    
			self.corp_ln_name_type_desc         := 'LEGAL';
			self 								:= [];
		end; 	
				
		
// ---------------------  Contact File Mapping for Assumed Name Records  --------------------//	

		Corp2_mapping.Layout_ContPreClean ContTransformAN01(Layouts_Raw_Input.an0102_out input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';									
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);
			self.corp_legal_name                := trimUpper(input.name);
			self.cont_name			            := trimUpper(input.nhName);				
							
			self.cont_type_desc					:= 'NAMEHOLDER'; 
                                                   	
			self.cont_address_line1				:= trimUpper(input.nhAddrs);
			self.cont_address_line2				:= '';
            self.cont_address_line3				:= map(trimUpper(input.nhCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.nhCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.nhCity));	
			self.cont_address_line4				:= trimUpper(input.nhState);		
			self.cont_address_line5				:= trim(StringLib.StringFilterOut(input.nhZip,'-'),left,right);																   
			self.cont_address_line6				:= '';
			self 								:= [];						
		end; 

// ---------------------  Contact File Mapping for Domestic Corporation Records  --------------------//	

		Corp2_mapping.Layout_ContPreClean ContTransformDC01(Layouts_Raw_Input.dc01_07_out input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';									
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);
			self.corp_legal_name                := trimUpper(input.name);
			self.cont_name			            := trimUpper(input.ceoFName) + ' ' +
												   trimUpper(input.ceoLName);											
			self.cont_type_desc					:= 'CHIEF EXECUTIVE OFFICER';                                                    	
			self.cont_address_line1				:= trimUpper(input.ceoAddrs);
			self.cont_address_line2				:= '';
            self.cont_address_line3				:= map(trimUpper(input.ceoCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.ceoCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.ceoCity));	
			self.cont_address_line4				:= trimUpper(input.ceoState);		
			self.cont_address_line5				:= trim(StringLib.StringFilterOut(input.ceoZip,'-'),left,right);																   
			self.cont_address_line6				:= '';
			self 								:= [];						
		end; 

// ---------------------  Contact File Mapping for Non-Profit Records  --------------------//	

		Corp2_mapping.Layout_ContPreClean ContTransformNP01(Layouts_Raw_Input.np01_np04_np05_out input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';									
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);
			self.corp_legal_name                := trimUpper(input.name);
			self.cont_name			            := trimUpper(input.presFName) + ' ' +
												   trimUpper(input.presLName);											
			self.cont_type_desc					:= 'PRESIDENT';                                                    				
			self 								:= [];						
		end; 
		
// ---------------------  Contact File Mapping for Reserved Name Records  --------------------//	

		Corp2_mapping.Layout_ContPreClean ContTransformRN01(Layouts_Raw_Input.rn01_rn02_out input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;			
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';									
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.charterNumber);
		 	self.corp_legal_name                := trimUpper(input.name);
		 	self.cont_name			            := trimUpper(input.nhName);
			self.cont_type_cd					:= '01';
			self.cont_type_desc					:= 'RESERVER';
			self.cont_address_line1				:= trimUpper(input.nhAddrs);
			self.cont_address_line2				:= '';
            self.cont_address_line3				:= map(trimUpper(input.nhCity)='MPLS' => 'MINNEAPOLIS',
													   trimUpper(input.nhCity)='BLMGTN' => 'BLOOMINGTON',
													   trimUpper(input.nhCity));	
			self.cont_address_line4				:= trimUpper(input.nhState);		
			self.cont_address_line5				:= trim(StringLib.StringFilterOut(input.nhZip,'-'),left,right);																   
			self.cont_address_line6				:= '';
			self 								:= [];						
		end; 	
				
		
//---------------------  Event File Mapping for Assumed Name Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformAN01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc                     := map(code='AD'=>'CHANGE OF BUSINESS ADDRESS',
													   code='AM'=>'MISCELLANEOUS AMENDMENT',
													   code='C'=>'CANCELLATION',
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO SIMILAR NAME; ' + info,
													   code='NG'=>'NAME GRANTED WITHOUT A CONSENT',
													   code='NH'=>'NAMEHOLDER CHANGE',
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 
		
		
//---------------------  Event File Mapping for Business Trust Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformBT01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='AM'=>'MISCELLANEOUS AMENDMENT',													   
													   code='C'=>'CANCELLATION',
													   code='CA'=>'CHANGE OF AGENT NAME, ADDRESS',
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='D'=>'DISSOLUTION',													   
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 
		
//---------------------  Event File Mapping for Domestic Corporation Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformDC01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='A'=>'CERTIFICATE OF AUTHORIZATION',
													   code='AM'=>'MISCELLANEOUS AMENDMENT',
													   code='AS'=>'ACTIVE STATUS',
													   code='CL'=>'CONSOLIDATION',													  
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,
													   code='CS'=>'CHANGE OF SHARES/STOCK',
													   code='CT'=>'CERTIFICATE OF TRUSTEE',
													   code='CV'=>'CONVERSION',
													   code='D'=>'DISSOLUTION',
													   code='EX'=>'EXPIRED',
													   code='EL'=>'ELECTION',
													   code='ID'=>'INTENT TO DISSOLVE',
													   code='M'=>'MERGED WITH ' + info,
													   code='NG'=>'NAME GRANTED WITHOUT CONSENT',
													   code='NL'=>'NAME LOST',
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   code='RA'=>'RESTATED ARTICLES',
													   code='RD'=>'RESCIND DISSOLUTION',
													   code='RO'=>'REGISTERED OFFICE CHANGED TO: ' + info,
													   code='SD'=>'STATUTORY DISSOLUTION',
													   code='VD'=>'VOLUNTARY DISSOLUTION',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 		
		
//---------------------  Event File Mapping for Foreign Corporation Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformFC01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='AD'=>'CHANGE OF HOME ADDRESS',
													   code='AM'=>'MISCELLANEOUS AMENDMENT',													   												 
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,
													   code='CS'=>'CHANGE OF SHARES/STOCK',											
													   code='D'=>'DISSOLUTION',
													   code='EX'=>'EXPIRED',
													   code='HN'=>'HOME NAME CHANGED TO: ' + info,													
													   code='M'=>'MERGED WITH ' + info,
													   code='NG'=>'NAME GRANTED WITHOUT CONSENT',													   
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   code='RA'=>'RESTATED ARTICLES',
													   code='RI'=>'REINSTATEMENT',
													   code='RO'=>'REGISTERED OFFICE CHANGED TO: ' + info,
													   code='RQ'=>'REQUALIFY',
													   code='RV'=>'REVOCATION',
													   code='WD'=>'WITHDRAWAL',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 	
		
//---------------------  Event File Mapping for Limited Partnership Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformLP01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			preInfo                             := trimUpper(input.amndInfo);
			info								:= trim(regexreplace('  ',preInfo,' '),left,right);
			self.event_filing_cd                := code;						
			self.event_desc              := map(code='ACV'=>'ABANDONMENT OF CONVERSION',
													   code='AD'=>'CHANGE OF HOME ADDRESS',
													   code='ADD'=>'ADMINISTRATIVE DISSOLUTION',
													   code='AM'=>'MISCELLANEOUS AMENDMENT',
													   code='AOC'=>'ARTICLES OF CORRECTION',
													   code='AOM'=>'ABANDONMENT OF MERGER',
													   code='AR'=>'ANNUAL RENEWAL',
													   code='ARR'=>'ANNUAL RENEWAL REINSTATEMENT',
													   code='C'=>'CANCELLATION',
													   code='CA'=>'CHANGE OF AGENT',
													   code='CAM'=>'CHANGE AGENT MAILING ADDRESS',
													   code='CD'=>'CHANGE DURATION',
													   code='CDM'=>'CHANGE OF DESIGNATED MAILING ADDRESS',
													   code='CDO'=>'CHANGE DESIGNATED OFFICE ADDRESS',
													   code='CLS'=>'CHANGE LLLP STATUS',
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,											
													   code='D'=>'DISSOLUTION',
													   code='EFF'=>'EFFECTIVE DATE AND TIME',
													   code='ELP'=>'ELECTION TO MLP/NLP FROM LP/FLP',
													   code='EX'=>'EXPIRED',
													   code='HN'=>'HOME NAME CHANGED TO: ' + info,													
													   code='JD'=>'JUDICIAL DISSOLUTION',
													   code='M'=>'MERGED WITH ' + info,
													   code='NG'=>'NAME GRANTED',													   
													   code='OT'=>'MISCELLANEOUS',
													   code='POA'=>'PRINCIPAL OFFICE ADDRESS',
													   code='PMA'=>'PRINCIPAL MAILING ADDRESS',
													   code='PPB'=>'PRINCIPAL PLACE OF BUSINESS',
													   code='R'=>'RENEWAL',
													   code='RA'=>'RESTATED ARTICLES',
													   code='RAN'=>'RESCIND ALTERNATE NAME',
													   code='RD'=>'RESCIND DISSOLUTION',
													   code='RO'=>'REGISTERED OFFICE CHANGED TO: ' + info,
													   code='ROA'=>'RESIGNATION OF AGENT',
													   code='SDA'=>'STATEMENT OF DISASSOCIATION',
													   code='SDN'=>'STATEMENT OF DENIAL',
													   code='SDS'=>'STATEMENT OF DISSOLUTION',
													   code='SOA'=>'STATEMENT OF AMENDMENT',
													   code='SOC'=>'STATEMENT OF CANCELLATION',
													   code='SOT'=>'STATEMENT OF TERMINATION',
													   code='SPA'=>'STATEMENT OF PARTNERSHIP AUTHORITY',
													   '');	
			cleanMicNbr1                        := trimUpper(input.amndMicNbr);
			cleanMicNbr2 						:= trim(regexreplace('DEFER',cleanMicNbr1,''),left,right);
			cleanMicNbr3 						:= trim(regexreplace('PROFILE',cleanMicNbr2,''),left,right);
			self.event_microfilm_nbr            := trimUpper(cleanMicNbr3);												   
			self 								:= [];						
		end; 				
		
//---------------------  Event File Mapping for Non-Profit Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformNP01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			preInfo                             := trimUpper(input.amndInfo);
			info								:= trim(regexreplace('  ',preInfo,' '),left,right);
			self.event_filing_cd                := code;			
			self.event_desc              := map(code='AM'=>'MISCELLANEOUS AMENDMENT',													   
													   code='AR'=>'ANNUAL REGISTRATION',
													   code='CL'=>'CONSOLIDATION',													   
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,											
													   code='CS'=>'CHANGE OF SHARES/STOCK',
													   code='D'=>'DISSOLUTION',
													   code='EL'=>'ELECTION',
													   code='EX'=>'EXPIRED',
													   code='ID'=>'INTENT TO DISSOLVE',
													   code='IMD'=>'IMMEDIATE DISSOLUTION',
													   code='M'=>'MERGED WITH ' + info,
													   code='NG'=>'NAME GRANTED WITHOUT CONSENT',													   
													   code='OT'=>'MISCELLANEOUS',													   
													   code='R'=>'RENEWAL',
													   code='RA'=>'RESTATED ARTICLES',													   
													   code='RD'=>'RESCIND DISSOLUTION',
													   code='RO'=>'REGISTERED OFFICE CHANGED TO: ' + info,													   
													   code='SD'=>'STATUTORY DISSOLUTION',													   
													   '');	
			cleanMicNbr1                        := trimUpper(input.amndMicNbr);
			cleanMicNbr2 						:= trim(regexreplace('DEFER',cleanMicNbr1,''),left,right);
			cleanMicNbr3 						:= trim(regexreplace('PROFILE',cleanMicNbr2,''),left,right);
			self.event_microfilm_nbr            := trimUpper(cleanMicNbr3);												   
			self 								:= [];						
		end; 	
		
// -------------------  Event File Mapping for Reserved Name Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformRN01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='C'=>'CANCELLATION',
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,
													   code='NG'=>'NAME GRANTED WITHOUT A CONSENT',													   													   													  													   
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   code='TR'=>'TRANSFER',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 		
		
// -------------------  Event File Mapping for Trademark Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformTM01(Layouts_Raw_Input.xx03_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := reformatDate(input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='AM'=>'MISCELLANEOUS AMENDMENT',
													   code='C'=>'CANCELLATION',
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,
													   code='MH'=>'CHANGE OF MARKHOLDER',
													   code='NG'=>'NAME GRANTED WITHOUT CONSENT',													   													   													  													   
													   code='OT'=>'MISCELLANEOUS',
													   code='R'=>'RENEWAL',
													   code='TMA'=>'TRADEMARK ASSIGNMENT',
													   '');			
			self.event_microfilm_nbr            := trimUpper(input.amndMicNbr);
												   
			self 								:= [];						
		end; 			
	
//---------------------  Event File Mapping for Limited Liability Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Event_In EventTransformLLC01(Layouts_Raw_Input.llcG0_out input) := transform				
			self.corp_process_date				:= fileDate;
			self.corp_key						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor					:= '27';
			self.corp_state_origin				:= 'MN';								
			self.corp_sos_charter_nbr			:= trimUpper(input.charterNumber);
			newDateFiled                        := if(stringlib.stringfilter(input.amndDateFiled,'0123456789') != input.amndDateFiled or 
												    length(trim(input.amndDateFiled,left,right))!= 8,
													'',			
												   input.amndDateFiled);
			self.event_filing_date              := if(_validate.date.fIsValid(newDateFiled) and 
													  _validate.date.fIsValid(newDateFiled,_validate.date.rules.DateInPast),
														newDateFiled,
														'');			
			code                                := trimUpper(input.amndType);
			info                                := trimUpper(input.amndInfo);
			self.event_filing_cd                := code;
			self.event_desc              := map(code='AD'=>'CHANGE OF HOME ADDRESS',
													   code='AM'=>'MISCELLANEOUS AMENDMENT',
													   code='AOC'=>'ARTICLES OF CORRECTION',
													   code='AR'=>'ANNUAL REGISTRATION',
													   code='ARR'=>'ANNUAL REGISTRATION RENEWAL',
													   code='AT'=>'ADMINISTRATIVE TERMINATION',
													   code='CD'=>'CHANGE DURATION',
													   code='CJ'=>'CHANGE JURISDICTION',
													   code='CN'=>'NAME CHANGED TO: ' + info,
													   code='CO'=>'CONSENT TO USE SIMILAR NAME; ' + info,
													   code='CV'=>'CONVERSION',
													   code='EX'=>'EXPIRED',
													   code='HN'=>'HOME NAME CHANGED TO: ' + info,													
													   code='M'=>'MERGED WITH ' + info,													  													   
													   code='OT'=>'MISCELLANEOUS',										
													   code='RA'=>'RESTATED ARTICLES',
													   code='RD'=>'REVOCATION OF DISSOLUTION',
													   code='RO'=>'REGISTERED OFFICE CHANGED TO: ' + info,
													   code='ROA'=>'RESIGNATION OF AGENT',
													   code='RV'=>'REVOCATION',
													   code='T'=>'TERMINATION',
													   code='WD'=>'WITHDRAWAL',
													   '');	
			cleanMicNbr1                        := trimUpper(input.amndMicNbr);
			cleanMicNbr2 						:= trim(regexreplace('WEB',cleanMicNbr1,''),left,right);
			cleanMicNbr3 						:= trim(regexreplace('PROFILE',cleanMicNbr2,''),left,right);
			self.event_microfilm_nbr            := trimUpper(cleanMicNbr3);													   
			self 								:= [];						
		end; 		
	
//---------------------  Annual Report (AR) File Mapping for Domestic Corporation Records  --------------------//			

Corp2.Layout_Corporate_Direct_AR_In ArTransformDC01(Layouts_Raw_Input.norm_dcAR_out input) := transform
			Self.corp_key 						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			Self.corp_vendor 					:= '27';
			Self.corp_state_origin 				:= 'MN';
			Self.corp_process_date 				:= fileDate;
			Self.corp_sos_charter_nbr 			:= trimUpper(input.charterNumber);
			Self.ar_microfilm_nbr				:= input.annualRPT;			
			self								:=[];
		end; 	
		
//---------------------  Annual Report (AR) File Mapping for Foreign Corporation Records  --------------------//			

Corp2.Layout_Corporate_Direct_AR_In ArTransformFC01(Layouts_Raw_Input.norm_fcAR_out input) := transform
			Self.corp_key 						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			Self.corp_vendor 					:= '27';
			Self.corp_state_origin 				:= 'MN';
			Self.corp_process_date 				:= fileDate;
			Self.corp_sos_charter_nbr 			:= trimUpper(input.charterNumber);
			Self.ar_microfilm_nbr				:= input.annualRpt;			
			self								:=[];
		end; 	
		
//---------------------  Annual Report (AR) File Mapping for Limited Partnership Records  --------------------//			

Corp2.Layout_Corporate_Direct_AR_In ArTransformLP01(Layouts_Raw_Input.lp05_out input) := transform,
            skip(not _validate.date.fIsValid(reformatDate(input.arDueDate)))
			Self.corp_key 						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			Self.corp_vendor 					:= '27';
			Self.corp_state_origin 				:= 'MN';
			Self.corp_process_date 				:= fileDate;
			Self.corp_sos_charter_nbr 			:= trimUpper(input.charterNumber);
			Self.ar_due_dt						:= reformatDate(input.arDueDate);			
			self								:=[];
		end; 			
		
//---------------------  Annual Report (AR) File Mapping for Non-Profit Records   --------------------//			

Corp2.Layout_Corporate_Direct_AR_In ArTransformNP01(Layouts_Raw_Input.norm_npAR_out input) := transform
			Self.corp_key 						:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			Self.corp_vendor 					:= '27';
			Self.corp_state_origin 				:= 'MN';
			Self.corp_process_date 				:= fileDate;
			Self.corp_sos_charter_nbr 			:= trimUpper(input.charterNumber);
			Self.ar_microfilm_nbr				:= input.annualRpt;			
			self								:=[];
		end; 			
		
// ---------------------  Stock File Mapping for Domestic Corporation Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Stock_In StockTransformDC01(Layouts_Raw_Input.dc04_out input) := transform
			
			self.corp_key					:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor				:= '27';
			self.corp_state_origin			:= 'MN';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.charterNumber);
			self.stock_authorized_nbr		:= if(not REGEXFIND('[$]',input.shares),
													trim(input.shares,left,right),
													'');
			self.stock_par_value           	:= if(not REGEXFIND('[$]',input.shares),
													'',
													trim(input.shares,left,right));													  
			self							:=[];
			
		end; 		
		
// ---------------------  Stock File Mapping for Non-Profit Records  --------------------//	

		Corp2.Layout_Corporate_Direct_Stock_In StockTransformNP01(Layouts_Raw_Input.np04_out input) := transform,
			skip(not REGEXFIND('[$]',input.numbershares))
			self.corp_key					:= '27-' + trimUpper(input.category) + trimUpper(input.charterNumber);
			self.corp_vendor				:= '27';
			self.corp_state_origin			:= 'MN';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.charterNumber);
			self.stock_shares_issued		:= trim(input.numberShares,left,right);															
			self							:=[];
			
		end; 						


		Corp2.layout_corporate_direct_corp_in CleanCorps(Corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 				:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 						:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 					:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1				:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 			:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 			:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 			:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 		:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 			:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 			:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 		:= if(keepBusiness, pname.name_score,'');								
			string182 clean_address1		:= Address.CleanAddress182(
													trim(trim(input.corp_address1_line1,left,right) + ' ' +
														 trim(input.corp_address1_line2,left,right),left,right),
													trim(trim(input.corp_address1_line3,left,right) + ', ' +
														 trim(input.corp_address1_line4,left,right) + ' ' +
														 trim(input.corp_address1_line5,left,right) +
														 trim(input.corp_address1_line6,left,right),left,right)
													);
			self.corp_addr1_prim_range    	:= clean_address1[1..10];
			self.corp_addr1_predir 	      	:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  	:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   	:= clean_address1[41..44];
			self.corp_addr1_postdir 	    := clean_address1[45..46];
			self.corp_addr1_unit_desig 	  	:= clean_address1[47..56];
			self.corp_addr1_sec_range 	  	:= clean_address1[57..64];
			self.corp_addr1_p_city_name	  	:= clean_address1[65..89];
			self.corp_addr1_v_city_name	  	:= clean_address1[90..114];
			self.corp_addr1_state 			:= clean_address1[115..116];
			self.corp_addr1_zip5 		    := clean_address1[117..121];
			self.corp_addr1_zip4 		    := clean_address1[122..125];
			self.corp_addr1_cart 		    := clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 	 	:= clean_address1[130];
			self.corp_addr1_lot 		    := clean_address1[131..134];
			self.corp_addr1_lot_order 	  	:= clean_address1[135];
			self.corp_addr1_dpbc 		   	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  	:= clean_address1[138];
			self.corp_addr1_rec_type	  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  	:= clean_address1[141..142];
			self.corp_addr1_county 	  		:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	   	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	   	:= clean_address1[156..166];
			self.corp_addr1_msa 		   	:= clean_address1[167..170];
			self.corp_addr1_geo_blk			:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address1[178];
			self.corp_addr1_err_stat 	   	:= clean_address1[179..182];								
			string182 clean_address2		:= Address.CleanAddress182(
													trim(trim(input.corp_address2_line1,left,right) + ' ' +
														 trim(input.corp_address2_line2,left,right),left,right),
													trim(trim(input.corp_address2_line3,left,right) + ', ' +
														 trim(input.corp_address2_line4,left,right) + ' ' +
														 trim(input.corp_address2_line5,left,right) +
														 trim(input.corp_address2_line6,left,right),left,right)
													);
			self.corp_addr2_prim_range    	:= clean_address2[1..10];
			self.corp_addr2_predir 	      	:= clean_address2[11..12];
			self.corp_addr2_prim_name 	  	:= clean_address2[13..40];
			self.corp_addr2_addr_suffix   	:= clean_address2[41..44];
			self.corp_addr2_postdir 	   	:= clean_address2[45..46];
			self.corp_addr2_unit_desig 	  	:= clean_address2[47..56];
			self.corp_addr2_sec_range 	  	:= clean_address2[57..64];
			self.corp_addr2_p_city_name	  	:= clean_address2[65..89];
			self.corp_addr2_v_city_name	  	:= clean_address2[90..114];
			self.corp_addr2_state 			:= clean_address2[115..116];
			self.corp_addr2_zip5 		   	:= clean_address2[117..121];
			self.corp_addr2_zip4 		   	:= clean_address2[122..125];
			self.corp_addr2_cart 		   	:= clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 	 	:= clean_address2[130];
			self.corp_addr2_lot 		   	:= clean_address2[131..134];
			self.corp_addr2_lot_order 	  	:= clean_address2[135];
			self.corp_addr2_dpbc 		   	:= clean_address2[136..137];
			self.corp_addr2_chk_digit 	  	:= clean_address2[138];
			self.corp_addr2_rec_type	  	:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st	  	:= clean_address2[141..142];
			self.corp_addr2_county 	  		:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	   	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	   	:= clean_address2[156..166];
			self.corp_addr2_msa 		   	:= clean_address2[167..170];
			self.corp_addr2_geo_blk			:= clean_address2[171..177];
			self.corp_addr2_geo_match 	  	:= clean_address2[178];
			self.corp_addr2_err_stat 	   	:= clean_address2[179..182];										
			string182 clean_address 		:= Address.CleanAddress182(
													trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
														 trim(input.corp_ra_address_line2,left,right),left,right),
													trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
														 trim(input.corp_ra_address_line4,left,right) + ' ' +
														 trim(input.corp_ra_address_line5,left,right) +
														 trim(input.corp_ra_address_line6,left,right),left,right)
													);

			self.corp_ra_prim_range    		:= clean_address[1..10];
			self.corp_ra_predir 	      	:= clean_address[11..12];
			self.corp_ra_prim_name 	  		:= clean_address[13..40];
			self.corp_ra_addr_suffix   		:= clean_address[41..44];
			self.corp_ra_postdir 	    	:= clean_address[45..46];
			self.corp_ra_unit_desig 	  	:= clean_address[47..56];
			self.corp_ra_sec_range 	  		:= clean_address[57..64];
			self.corp_ra_p_city_name	  	:= clean_address[65..89];
			self.corp_ra_v_city_name	  	:= clean_address[90..114];
			self.corp_ra_state 			   	:= clean_address[115..116];
			self.corp_ra_zip5 		      	:= clean_address[117..121];
			self.corp_ra_zip4 		      	:= clean_address[122..125];
			self.corp_ra_cart 		      	:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 	:= clean_address[130];
			self.corp_ra_lot 		      	:= clean_address[131..134];
			self.corp_ra_lot_order 	  		:= clean_address[135];
			self.corp_ra_dpbc 		      	:= clean_address[136..137];
			self.corp_ra_chk_digit 	  		:= clean_address[138];
			self.corp_ra_rec_type		  	:= clean_address[139..140];
			self.corp_ra_ace_fips_st	  	:= clean_address[141..142];
			self.corp_ra_county 	  		:= clean_address[143..145];
			self.corp_ra_geo_lat 	    	:= clean_address[146..155];
			self.corp_ra_geo_long 	    	:= clean_address[156..166];
			self.corp_ra_msa 		      	:= clean_address[167..170];
			self.corp_ra_geo_blk			:= clean_address[171..177];
			self.corp_ra_geo_match 	  		:= clean_address[178];
			self.corp_ra_err_stat 	    	:= clean_address[179..182];			
			self							:= input;
			self							:= [];
		end;	
//---------------------------- Clean Corps Name and Addresses ---------------------//

		Corp2.Layout_Corporate_Direct_Cont_In CleanConts(Corp2_mapping.Layout_ContPreClean input) := transform
			string73 tempname 				:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
			
			string182 clean_address 		:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
											trim(input.cont_address_line2,left,right),left,right),														                   
											trim(trim(input.cont_address_line3,left,right) + ', ' +
											trim(input.cont_address_line4,left,right) + ' ' +
											trim(input.cont_address_line5,left,right),left,right));
	

			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			
			self							:= [];
		end;


rawAN := Files_Raw_Input.rawANfile(fileDate);
		
rawBT := Files_Raw_Input.rawBTfile(fileDate);
		
rawDC := Files_Raw_Input.rawDCfile(fileDate);
		
rawFC := Files_Raw_Input.rawFCfile(fileDate);
		
rawLP := Files_Raw_Input.rawLPfile(fileDate);
		
rawNP := Files_Raw_Input.rawNPfile(fileDate);
		
rawRN := Files_Raw_Input.rawRNfile(fileDate);
		 
rawTM := Files_Raw_Input.rawTMfile(fileDate);
		
rawLLC := Files_Raw_Input.rawLLCfile(fileDate);

		
an01_raw 	:= rawAN(fields[4..5]='01');	
mapped_an01 := project(an01_raw,transformAn01(left));
dist_an01   := distribute(mapped_an01,hash32(charterNumber));
sorted_an01 := sort(dist_an01,charterNumber,sequence,LOCAL); 
merged_an01 := distribute(rollup(sorted_an01,rollup_an01(left,right),charterNumber,LOCAL),hash32(charterNumber));

an02_raw 	:= rawAN(fields[4..5]='02');	
mapped_an02 := project(an02_raw,transformAN02(left));
dist_an02   := distribute(mapped_an02,hash32(charterNumber));

an03_raw 	 := rawAN(fields[4..5]='03');	
mapped_an03  := project(an03_raw,transformXX03(left));
dist1_an03   := distribute(mapped_an03,hash32(charterNumber));
sorted1_an03 := sort(dist1_an03,charterNumber,sequence,LOCAL);
merged1_an03 := iterate(sorted1_an03,iterate_xx03(left,right),LOCAL);
purged_an03  := merged1_an03(amndType<>'XX');
dist2_an03	 := distribute(purged_an03,hash32(charterNumber));
sorted2_an03 := sort(dist2_an03,charterNumber,sequence,LOCAL);
merged2_an03 := rollup(sorted2_an03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

an05_raw 	:= rawAN(fields[4..5]='05');	
mapped_an05 := project(an05_raw,transformAn05(left));
dist_an05   := distribute(mapped_an05,hash32(charterNumber));

bt01_raw 	:= rawBT(fields[4..5]='01');	
mapped_bt01 := project(bt01_raw,transformBt01(left));
dist_bt01   := distribute(mapped_bt01,hash32(charterNumber));
sorted_bt01 := sort(dist_bt01,charterNumber,sequence,LOCAL);
merged_bt01 := rollup(sorted_bt01,rollup_bt01(left,right),charterNumber,LOCAL);

bt02_raw 	:= rawBT(fields[4..5]='02' and fields[16..18]='000');	
mapped_bt02 := project(bt02_raw,transformBt02(left));
dist_bt02   := distribute(mapped_bt02,hash32(charterNumber));

bt03_raw 	 := rawBT(fields[4..5]='03');	
mapped_bt03  := project(bt03_raw,transformXX03(left));
dist1_bt03   := distribute(mapped_bt03,hash32(charterNumber));
sorted1_bt03 := sort(dist1_bt03,charterNumber,sequence,LOCAL);
merged1_bt03 := iterate(sorted1_bt03,iterate_xx03(left,right),LOCAL);
purged_bt03  := merged1_bt03(amndType<>'XX');
dist2_bt03	 := distribute(purged_bt03,hash32(charterNumber));
sorted2_bt03 := sort(dist2_bt03,charterNumber,sequence,LOCAL);
merged2_bt03 := rollup(sorted2_bt03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

dc01_raw 	:= rawDC(fields[4..5]='01');	
mapped_dc01 := project(dc01_raw,transformDC01(left));
dist_dc01   := distribute(mapped_dc01,hash32(charterNumber));
sorted_dc01 := sort(dist_dc01,charterNumber,sequence,LOCAL);
merged_dc01 := rollup(sorted_dc01,rollup_dc01(left,right),charterNumber,LOCAL);

dc02_raw 	:= rawDC(fields[4..5]='02');	
mapped_dc02 := project(dc02_raw,transformDC02(left));
dist_dc02   := distribute(mapped_dc02,hash32(charterNumber));

dc03_raw 	 := rawDC(fields[4..5]='03');	
mapped_dc03  := project(dc03_raw,transformXX03(left));
filter_dc03  := mapped_dc03(not(trimUpper(amndType)='M' and trimUpper(amndInfo)=''));
dist1_dc03   := distribute(filter_dc03,hash32(charterNumber));
sorted1_dc03 := sort(dist1_dc03,charterNumber,sequence,LOCAL);
merged1_dc03 := iterate(sorted1_dc03,iterate_xx03(left,right),LOCAL);
purged_dc03  := merged1_dc03(amndType<>'XX');
dist2_dc03	 := distribute(purged_dc03,hash32(charterNumber));
sorted2_dc03 := sort(dist2_dc03,charterNumber,sequence,LOCAL);
merged2_dc03 := rollup(sorted2_dc03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

dc04_raw 	:= rawDC(fields[4..5]='04' and fields[16..18]='000');	
mapped_dc04 := project(dc04_raw,transformDC04(left));
dist_dc04   := distribute(mapped_dc04,hash32(charterNumber));

dc04_raw_ra_only 	:= rawDC(fields[4..5]='04' and fields[16..18]<>'000');	
mapped_dc04_ra_only := project(dc04_raw_ra_only,transformDC04(left));

dc05_raw 	 := rawDC(fields[4..5]='05' and fields[16..18]='000');	
mapped_dc05  := project(dc05_raw,transformDC05(left));
dist_dc05    := distribute(mapped_dc05,hash32(charterNumber));

// Normalize the DC_05 records for use in creating AR records.						
Layouts_Raw_Input.norm_dcAR_out normalizeDC_05(mapped_dc05 l, unsigned1 cnt) := transform
	self.annualRpt    	:= choose(cnt,l.ar1,l.ar2,l.ar3);	
	self 				:= l;
    end;
	
dc_05_Normal := normalize(mapped_dc05, 3, normalizeDC_05(left, counter));
purged_dcAR  := project(dc_05_Normal,transformdcAR(left));

dc07_raw 	:= rawDC(fields[4..5]='07');	
mapped_dc07 := project(dc07_raw,transformDC07(left));
dist_dc07   := distribute(mapped_dc07,hash32(charterNumber));

fc01_raw 	:= rawFC(fields[4..5]='01');	
mapped_fc01 := project(fc01_raw,transformFC01(left));
dist_fc01   := distribute(mapped_fc01,hash32(charterNumber));
sorted_fc01 := sort(dist_fc01,charterNumber,sequence,LOCAL);
merged_fc01 := rollup(sorted_fc01,rollup_fc01(left,right),charterNumber,LOCAL);

fc02_raw 	:= rawFC(fields[4..5]='02');	
mapped_fc02 := project(fc02_raw,transformFC02(left));
dist_fc02   := distribute(mapped_fc02,hash32(charterNumber));

fc03_raw 	 := rawFC(fields[4..5]='03');	
mapped_fc03  := project(fc03_raw,transformXX03(left));
filter_fc03  := mapped_fc03(not(trimUpper(amndType)='M' and trimUpper(amndInfo)=''));
dist1_fc03   := distribute(filter_fc03,hash32(charterNumber));
sorted1_fc03 := sort(dist1_fc03,charterNumber,sequence,LOCAL);
merged1_fc03 := iterate(sorted1_fc03,iterate_xx03(left,right),LOCAL);
purged_fc03  := merged1_fc03(amndType<>'XX');
dist2_fc03	 := distribute(purged_fc03,hash32(charterNumber));
sorted2_fc03 := sort(dist2_fc03,charterNumber,sequence,LOCAL);
merged2_fc03 := rollup(sorted2_fc03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

fc04_raw 	:= rawFC(fields[4..5]='04' and fields[16..18]='000');	
mapped_fc04 := project(fc04_raw,transformFC04(left));
dist_fc04   := distribute(mapped_fc04,hash32(charterNumber));

// Normalize the DC_05 records for use in creating AR records.						
Layouts_Raw_Input.norm_fcAR_out normalizeFC_04(mapped_fc04 l, unsigned1 cnt) := transform
	self.annualRpt    	:= choose(cnt,l.ar1,l.ar2,l.ar3);	
	self 				:= l;
    end;
 
fc_04_Normal := normalize(mapped_fc04, 3, normalizeFC_04(left, counter));
purged_fcAR  := project(fc_04_Normal,transformfcAR(left));

fc05_raw 	 := rawFC(fields[4..5]='05' and fields[16..18]='000');	
mapped_fc05  := project(fc05_raw,transformFC05(left));
dist_fc05    := distribute(mapped_fc05,hash32(charterNumber));

fc06_raw 	 := rawFC(fields[4..5]='06');	
mapped_fc06  := project(fc06_raw,transformFC06(left));
dist_fc06    := distribute(mapped_fc06,hash32(charterNumber));
sorted_fc06  := sort(dist_fc06,charterNumber,sequence,LOCAL);
merged_fc06  := rollup(sorted_fc06,rollup_fc06(left,right),charterNumber,LOCAL);

lp01_raw 	:= rawLP(fields[4..5]='01');
mapped_lp01 := project(lp01_raw,transformLP01(left));
dist_lp01   := distribute(mapped_lp01,hash32(charterNumber));
sorted_lp01 := sort(dist_lp01,charterNumber,sequence,LOCAL);
merged_lp01 := rollup(sorted_lp01,rollup_lp01(left,right),charterNumber,LOCAL);	

lp02_raw 	       := rawLP(fields[4..5]='02');		
mapped_lp02        := project(lp02_raw,transformLP02(left));
dist_lp02          := distribute(mapped_lp02,hash32(charterNumber));
sorted_lp02        := sort(dist_lp02,charterNumber,agentAddrs,agentCity,agentState,agentZip,LOCAL);
lp02_all_addrs 	   := dedup(sorted_lp02,charterNumber,agentAddrs,agentCity,agentState,agentZip,LOCAL);
lp02_agent_addrs   := lp02_all_addrs(sequence='000');
lp02_mailing_addrs := lp02_all_addrs(sequence='001');

lp03_raw 	 := rawLP(fields[4..5]='03');	
mapped_lp03  := project(lp03_raw,transformXX03(left));
filter_lp03  := mapped_lp03(not(trimUpper(amndType)='M' and trimUpper(amndInfo)=''));
dist1_lp03   := distribute(filter_lp03,hash32(charterNumber));
sorted1_lp03 := sort(dist1_lp03,charterNumber,sequence,LOCAL);
merged1_lp03 := iterate(sorted1_lp03,iterate_xx03(left,right),LOCAL);
purged_lp03  := merged1_lp03(amndType<>'XX');
dist2_lp03	 := distribute(purged_lp03,hash32(charterNumber));
sorted2_lp03 := sort(dist2_lp03,charterNumber,sequence,LOCAL);
merged2_lp03 := rollup(sorted2_lp03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

lp04_raw 	 := rawLP(fields[4..5]='04' and fields[16..18]='000');	
mapped_lp04  := project(lp04_raw,transformLP04(left));
dist_lp04    := distribute(mapped_lp04,hash32(charterNumber));

lp05_raw 	       := rawLP(fields[4..5]='05');
mapped_lp05        := project(lp05_raw,transformLP05(left));
dist_lp05          := distribute(mapped_lp05,hash32(charterNumber));
sorted_lp05        := sort(dist_lp05,charterNumber,ofcAddrs,ofcCity,ofcState,ofcZip,LOCAL);	
lp05_all_addrs 	   := dedup(sorted_lp05,charterNumber,ofcAddrs,ofcCity,ofcState,ofcZip,LOCAL);
lp05_office_addrs  := lp05_all_addrs(sequence='000');
lp05_mailing_addrs := lp05_all_addrs(sequence='001');
lp05_ars 		   := lp05_office_addrs(trim(arDueDate,left,right)<>'');

lp06_raw 	:= rawLP(fields[4..5]='06');
mapped_lp06 := project(lp06_raw,transformLP06(left));
dist_lp06   := distribute(mapped_lp06,hash32(charterNumber));
sorted_lp06 := sort(dist_lp06,charterNumber,sequence,LOCAL);	
merged_lp06 := rollup(sorted_lp06,rollup_lp06(left,right),charterNumber,LOCAL);

np01_raw 	 := rawNP(fields[4..5]='01');	
mapped_np01  := project(np01_raw,transformNP01(left));
dist_np01    := distribute(mapped_np01,hash32(charterNumber));
sorted_np01  := sort(dist_np01,charterNumber,sequence,LOCAL);
cleaned_np01 := iterate(sorted_np01,iterate_np01(left,right),LOCAL);
merged_np01  := rollup(cleaned_np01,rollup_np01(left,right),charterNumber,LOCAL);

np03_raw 	 := rawNP(fields[4..5]='03');	
mapped_np03  := project(np03_raw,transformXX03(left));
filter_np03  := mapped_np03(not(trimUpper(amndType)='M' and trimUpper(amndInfo)=''));
dist1_np03   := distribute(filter_np03,hash32(charterNumber));
sorted1_np03  := sort(dist1_np03,charterNumber,sequence,LOCAL);
merged1_np03 := iterate(sorted1_np03,iterate_xx03(left,right),LOCAL);
purged_np03  := merged1_np03(amndType<>'XX');
dist2_np03   := distribute(purged_np03,hash32(charterNumber));
sorted2_np03 := sort(dist2_np03,charterNumber,sequence,LOCAL);
merged2_np03 := rollup(sorted2_np03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

np04_raw 	     	:= rawNP(fields[4..5]='04');	
mapped_np04 	 	:= project(np04_raw,transformNP04(left));
dist_np04   		:= distribute(mapped_np04,hash32(charterNumber));
mapped_np04_full 	:= dist_np04(sequence='000');
mapped_np04_ra_only := dist_np04(sequence<>'000');

np05_raw 	:= rawNP(fields[4..5]='05' and fields[16..18]='000');	
mapped_np05 := project(np05_raw,transformNP05(left));
dist_np05   := distribute(mapped_np05,hash32(charterNumber));

// Normalize the NP_05 records for use in creating AR records.						
Layouts_Raw_Input.norm_npAR_out normalizeNP_05(mapped_np05 l, unsigned1 cnt) := transform
	self.annualRpt    	:= choose(cnt,l.ar1,l.ar2,l.ar3);	
	self 				:= l;
    end;
 
np_05_Normal := normalize(mapped_np05, 3, normalizeNP_05(left, counter));
purged_npAR  := project(np_05_Normal,transformnpAR(left));
 
rn01_raw 	:= rawRN(fields[4..5]='01');
mapped_rn01 := project(rn01_raw,transformrn01(left));
dist_rn01   := distribute(mapped_rn01,hash32(charterNumber));
sorted_rn01 := sort(dist_rn01,charterNumber,sequence,LOCAL);	
merged_rn01 := rollup(sorted_rn01,rollup_rn01(left,right),charterNumber,LOCAL);

rn02_raw 	:= rawRN(fields[4..5]='02');	
mapped_rn02 := project(rn02_raw,transformRN02(left));
dist_rn02   := distribute(mapped_rn02,hash32(charterNumber));

rn03_raw 	 := rawRN(fields[4..5]='03');	
mapped_rn03  := project(rn03_raw,transformXX03(left));
dist1_rn03   := distribute(mapped_rn03,hash32(charterNumber));
sorted1_rn03 := sort(dist1_rn03,charterNumber,sequence,LOCAL);
merged1_rn03 := iterate(sorted1_rn03,iterate_xx03(left,right),LOCAL);
purged_rn03  := merged1_rn03(amndType<>'XX');
dist2_rn03   := distribute(purged_rn03,hash32(charterNumber));
sorted2_rn03 := sort(dist2_rn03,charterNumber,sequence,LOCAL);
merged2_rn03 := rollup(sorted2_rn03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);

rn04_raw 	:= rawRN(fields[4..5]='04' and fields[16..18]='000');	
mapped_rn04 := project(rn04_raw,transformRN04(left));
dist_rn04   := distribute(mapped_rn04,hash32(charterNumber));

tm01_raw 	:= rawTM(fields[4..5]='01');	
mapped_tm01 := project(tm01_raw,transformtm01(left));
dist_tm01   := distribute(mapped_tm01,hash32(charterNumber));
sorted_tm01 := sort(dist_tm01,charterNumber,sequence,LOCAL);
merged_tm01 := rollup(sorted_tm01,rollup_tm01(left,right),charterNumber,LOCAL);

tm02_raw 	:= rawTM(fields[4..5]='02');	
mapped_tm02 := project(tm02_raw,transformTM02(left));

tm03_raw 	 := rawTM(fields[4..5]='03');	
mapped_tm03  := project(tm03_raw,transformXX03(left));
dist1_tm03   := distribute(mapped_tm03,hash32(charterNumber));
sorted1_tm03 := sort(dist1_tm03,charterNumber,sequence,LOCAL);
merged1_tm03 := iterate(sorted1_tm03,iterate_xx03(left,right),LOCAL); 
purged_tm03  := merged1_tm03(amndType<>'XX');
dist2_tm03	 := distribute(purged_tm03,hash32(charterNumber));
sorted2_tm03 := sort(dist2_tm03,charterNumber,sequence,LOCAL);
merged2_tm03 := rollup(sorted2_tm03,rollup_xx03(left,right),charterNumber,sequence,LOCAL);
	
tm04_raw 	     := rawTM(fields[4..5]='04' and fields[16..18]='000');	
tm04_logo_raw    := rawTM(fields[4..5]='04' and fields[16..18]<>'000');
mapped_tm04      := project(tm04_raw,transform1TM04(left));
dist_tm04        := distribute(mapped_tm04,hash32(charterNumber));
mapped_tm04_logo := project(tm04_logo_raw,transform2TM04(left));
dist_tm04_logo   := distribute(mapped_tm04_logo,hash32(charterNumber));
sorted_tm04_logo := sort(dist_tm04_logo,charterNumber,sequence,LOCAL);
merged_tm04_logo := rollup(sorted_tm04_logo,rollup_tm04(left,right),charterNumber,LOCAL);

llc00_raw 		:= rawLLC(fields[4..5]='00');
mapped_llc00 	:= project(llc00_raw,transformllc00(left));
dist_llc00      := distribute(mapped_llc00,hash64(charterNumber,recordType,category,sequence));	
	
llcA0_raw 		:= rawLLC(trimUpper(fields[4..5])='A0');
mapped_llcA0 	:= project(llcA0_raw,transformllcA01(left));
dist_llcA0      := distribute(mapped_llcA0,hash64(charterNumber,recordType,category,sequence));
llcA1_raw 		:= rawLLC(trimUpper(fields[4..5])='A1');
mapped_llcA1 	:= project(llcA1_raw,transformllcA01(left));
dist_llcA1      := distribute(mapped_llcA1,hash64(charterNumber,recordType,category,sequence));

llcB0_raw 		:= rawLLC(trimUpper(fields[4..5])='B0');
mapped_llcB0 	:= project(llcB0_raw,transformllcB0(left));
dist_llcB0      := distribute(mapped_llcB0,hash64(charterNumber,recordType,category,sequence));

llcB1_raw 		:= rawLLC(trimUpper(fields[4..5])='B1');
mapped_llcB1 	:= project(llcB1_raw,transformllcB1B2(left));
dist_llcB1      := distribute(mapped_llcB1,hash64(charterNumber,recordType,category,sequence));

llcB2_raw 		:= rawLLC(trimUpper(fields[4..5])='B2');
llcB2_ra_only 	:= project(llcB2_raw,transformllcB1B2(left));

llcC0_raw 		:= rawLLC(fields[4..5]='C0');
mapped_llcC0 	:= project(llcC0_raw,transformllcC0(left));
dist_llcC0      := distribute(mapped_llcC0,hash64(charterNumber,recordType,category,sequence));

llcD0123_raw 	:= rawLLC(fields[4..4]='D');
mapped_llcD0123 := project(llcD0123_raw,transformllcD0123(left));
dist_llcD0123   := distribute(mapped_llcD0123,hash64(charterNumber,recordType,category,sequence));
sorted_llcD0123 := sort(dist_llcD0123,charterNumber,recordType,LOCAL);
merged_llcD0123 := rollup(sorted_llcD0123,rollup_llcD0123(left,right),charterNumber,LOCAL);

llcE01_raw 		:= rawLLC(fields[4..5]='E0' or fields[4..5]='E1');
mapped_llcE01 	:= project(llcE01_raw,transformllcE01(left));
dist_llcE01     := distribute(mapped_llcE01,hash64(charterNumber,recordType,category,sequence));
sorted_llcE01 	:= sort(dist_llcE01,charterNumber,recordType,LOCAL);
merged_llcE01 	:= rollup(sorted_llcE01,rollup_llcE01(left,right),charterNumber,LOCAL);

llcE5_raw 		:= rawLLC(fields[4..5]='E5');
mapped_llcE5 	:= project(llcE5_raw,transformllcE5(left));
dist_llcE5      := distribute(mapped_llcE5,hash64(charterNumber,recordType,category,sequence));

llcF0_raw 		:= rawLLC(fields[4..5]='F0');
mapped_llcF0 	:= project(llcF0_raw,transformllcF0(left));
dist_llcF0      := distribute(mapped_llcF0,hash64(charterNumber,recordType,category,sequence));

llcG0_raw 		:= rawLLC(fields[4..5]='G0');
mapped_llcG0 	:= project(llcG0_raw,transformllcG0(left,counter));
filter_llcG0    := mapped_llcG0(not(trimUpper(amndType)='M' and trimUpper(amndInfo)=''));
dist_llcG0      := distribute(filter_llcG0,hash32(charterNumber));
sorted1_llcG0 	:= sort(dist_llcG0,charterNumber,-position,LOCAL);
merged1_llcG0 	:= iterate(sorted1_llcG0,iterate_llcG0(left,right),LOCAL);
purged_llcG0 	:= merged1_llcG0(amndType<>'XX');
dist2_llcG0   	:= distribute(purged_llcG0,hash32(charterNumber));
sorted2_llcG0 	:= sort(dist2_llcG0,charterNumber,amndDateFiled,amndType,LOCAL);
merged2_llcG0 	:= rollup(sorted2_llcG0,rollup_llcG0(left,right),charterNumber,amndDateFiled,amndType,LOCAL);

llcJ01_raw 		:= rawLLC(fields[4..4]='J');
mapped_llcJ01 	:= project(llcJ01_raw,transformllcJ01(left));
dist_llcJ01     := distribute(mapped_llcJ01,hash32(charterNumber));
sorted_llcJ01 	:= sort(dist_llcJ01,charterNumber,recordType,LOCAL);
merged_llcJ01 	:= rollup(sorted_llcJ01,rollup_llcJ01(left,right),charterNumber,LOCAL);
							

////////////////////

Layouts_Raw_Input.an0102_out	joinan0102(Layouts_Raw_Input.an02_out l, Layouts_Raw_Input.an01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedan0102	:= join(dist_an02,merged_an01,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinan0102(left,right),
							 left outer,LOCAL);
							 
////////////////////

Layouts_Raw_Input.an01_an05_out	joinan01_an05(Layouts_Raw_Input.an01_out l, Layouts_Raw_Input.an05_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedan01_an05	:= join(merged_an01, dist_an05,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinan01_an05(left,right),
							 left outer,LOCAL);
							 
////////////////////							 							 
							 
Layouts_Raw_Input.bt01_bt02_out	joinBT01_BT02(Layouts_Raw_Input.bt01_out l, Layouts_Raw_Input.bt02_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedbt01_bt02	:= join(merged_bt01, dist_bt02,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinBT01_BT02(left,right),
							 left outer,LOCAL);		
////////////////////

Layouts_Raw_Input.dc01_dc04_out	joindc01_dc04(Layouts_Raw_Input.dc01_out l, Layouts_Raw_Input.dc04_out r) := transform
		self   	:= l;
		self	:= r;
		self	:= [];
	end;
	
joineddc01_dc04	:= join(merged_dc01, dist_dc04,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joindc01_dc04(left,right),
							 left outer,LOCAL);	
/////////////////////////
							 
Layouts_Raw_Input.dc01_dc02_dc04_out	joindc01_dc02_dc04(Layouts_Raw_Input.dc01_dc04_out l, Layouts_Raw_Input.dc02_out r) := transform
		self   	:= l;
		self	:= r;
		self	:= [];
	end;
	
joineddc01_dc02_dc04	:= join(joineddc01_dc04, dist_dc02,
						        trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							         joindc01_dc02_dc04(left,right),
							         left outer,LOCAL);	
							 
////////////////////

Layouts_Raw_Input.dc01_07_out	joindc01_dc07(Layouts_Raw_Input.dc07_out l, Layouts_Raw_Input.dc01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joineddc01_dc07	:= join(dist_dc07,merged_dc01,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joindc01_dc07(left,right),
							 left outer,LOCAL);

/////////////////////////
		
Layouts_Raw_Input.dc01020405_out	joindc01020405(Layouts_Raw_Input.dc01_dc02_dc04_out l, Layouts_Raw_Input.dc05_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joineddc01020405	:= join(joineddc01_dc02_dc04, dist_dc05,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joindc01020405(left,right),
							 left outer,LOCAL);
							 
/////////////////////////

Layouts_Raw_Input.fc01_fc04_out	joinfc01_fc04(Layouts_Raw_Input.fc01_out l, Layouts_Raw_Input.fc04_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedfc01_fc04	:= join(merged_fc01, dist_fc04,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinfc01_fc04(left,right),
							 left outer,LOCAL);	
///////////////////////
							 
Layouts_Raw_Input.fc01_fc04_fc05_out	joinfc01_fc04_fc05(Layouts_Raw_Input.fc01_fc04_out l, Layouts_Raw_Input.fc05_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedfc01_fc04_fc05	:= join(joinedfc01_fc04, dist_fc05,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinfc01_fc04_fc05(left,right),
							 left outer,LOCAL);							 
		
///////////////////////
							 
Layouts_Raw_Input.fc01_fc04_fc05_fc06_out	joinfc01_fc04_fc05_fc06(Layouts_Raw_Input.fc01_fc04_fc05_out l, Layouts_Raw_Input.fc06_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedfc01_fc04_fc05_fc06	:= join(joinedfc01_fc04_fc05, merged_fc06,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinfc01_fc04_fc05_fc06(left,right),
								left outer,LOCAL);
								
///////////////////////
							 
Layouts_Raw_Input.fc01_fc02_fc04_fc05_fc06_out	joinfc01_fc02_fc04_fc05_fc06(Layouts_Raw_Input.fc01_fc04_fc05_fc06_out l, Layouts_Raw_Input.fc02_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedfc01_fc02_fc04_fc05_fc06	:= join(joinedfc01_fc04_fc05_fc06, dist_fc02,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinfc01_fc02_fc04_fc05_fc06(left,right),
								left outer,LOCAL);	
								
///////////////////////		

Layouts_Raw_Input.fc0102040506TBL_out		joinfc0102040506TBL(Layouts_Raw_Input.fc01_fc02_fc04_fc05_fc06_out l, Layouts_Raw_Input.ForgnStateDescLayout r) := transform
		self   				:= l;
		self.lawsStateDesc	:= r.desc;
	end;
	
joinedfc0102040506TBL		:= join(joinedfc01_fc02_fc04_fc05_fc06, Files_Raw_Input.ForgnStateTable,
								trimUpper(left.lawsState) = trimUpper(right.code),
								joinfc0102040506TBL(left,right),
								left outer, LOOKUP);
								
///////////////////	

Layouts_Raw_Input.lp01_lp06_out	joinlp01_lp06(Layouts_Raw_Input.lp01_out l, Layouts_Raw_Input.lp06_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedlp01_lp06	:= join(merged_lp01, merged_lp06,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinlp01_lp06(left,right),
							 left outer,LOCAL);	
/////////////////////
							 
Layouts_Raw_Input.lp01_lp04_lp06_out	joinlp01_lp04_lp06(Layouts_Raw_Input.lp01_lp06_out l, Layouts_Raw_Input.lp04_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedlp01_lp04_lp06	:= join(joinedlp01_lp06, dist_lp04,
							trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinlp01_lp04_lp06(left,right),
							 left outer,LOCAL);							 
		
/////////////////////
							 
Layouts_Raw_Input.lp01_lp02_lp04_lp06_out	joinlp01_lp02_lp04_lp06(Layouts_Raw_Input.lp01_lp04_lp06_out l, Layouts_Raw_Input.lp02_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedlp01_lp02_lp04_lp06	:= join(joinedlp01_lp04_lp06, lp02_agent_addrs,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinlp01_lp02_lp04_lp06(left,right),
								left outer,LOCAL);
								
/////////////////////
							 
Layouts_Raw_Input.lp01_lp02_lp04_lp05_lp06_out	joinlp01_lp02_lp04_lp05_lp06(Layouts_Raw_Input.lp01_lp02_lp04_lp06_out l, Layouts_Raw_Input.lp05_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedlp01_lp02_lp04_lp05_lp06	:= join(joinedlp01_lp02_lp04_lp06, lp05_office_addrs,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinlp01_lp02_lp04_lp05_lp06(left,right),
								left outer,LOCAL);
								
/////////////////////

Layouts_Raw_Input.lp0102040505C06_out	joinlp0102040505C06(Layouts_Raw_Input.lp01_lp02_lp04_lp05_lp06_out l, Layouts_Raw_Input.lp05_out r) := transform
		self   	:= l;
		self.mailAddrs	:= r.ofcAddrs;
		self.mailCity	:= r.ofcCity;
		self.mailState	:= r.ofcState;
		self.mailZip	:= r.ofcZip;
	end;
		
joinedlp0102040505C06	:= join(joinedlp01_lp02_lp04_lp05_lp06, lp05_mailing_addrs,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinlp0102040505C06(left,right),
								left outer,LOCAL);
								
/////////////////////

Layouts_Raw_Input.lp0102040505C06TBL_out		joinlp0102040505C06TBL(Layouts_Raw_Input.lp0102040505C06_out l, Layouts_Raw_Input.ForgnStateDescLayout r) := transform
		self   				:= l;
		self.homeStateDesc	:= r.desc;
	end;
	
joinedlp0102040505C06TBL		:= join(joinedlp0102040505C06, Files_Raw_Input.ForgnStateTable,
								trimUpper(left.homeState) = trimUpper(right.code),
								joinlp0102040505C06TBL(left,right),
								left outer, LOOKUP);
								
///////////////////	

Layouts_Raw_Input.np01_np05_out	joinnp01_np05(Layouts_Raw_Input.np01_out l, Layouts_Raw_Input.np05_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinednp01_np05	:= join(merged_np01, dist_np05,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinnp01_np05(left,right),
							 left outer,LOCAL);	
/////////////////////
							 
Layouts_Raw_Input.np01_np04_np05_out	joinnp01_np04_np05(Layouts_Raw_Input.np01_np05_out l, Layouts_Raw_Input.np04_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinednp01_np04_np05	:= join(joinednp01_np05, mapped_np04_full,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinnp01_np04_np05(left,right),
							 left outer,LOCAL);							 
		
////////////////////

Layouts_Raw_Input.rn01_rn04_out	joinrn01_rn04(Layouts_Raw_Input.rn01_out l, Layouts_Raw_Input.rn04_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedrn01_rn04	:= join(merged_rn01, dist_rn04,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinrn01_rn04(left,right),
							 left outer,LOCAL);
								
////////////////////

Layouts_Raw_Input.rn01_rn02_out	joinrn01_rn02(Layouts_Raw_Input.rn02_out l, Layouts_Raw_Input.rn01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedrn01_rn02	:= join(dist_rn02, merged_rn01,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinrn01_rn02(left,right),
							 left outer,LOCAL);
								
////////////////////	

Layouts_Raw_Input.tm04_tm04_out	jointm04_tm04(Layouts_Raw_Input.tm04_out l, Layouts_Raw_Input.tm04_logo_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedtm04_tm04	:= join(dist_tm04, merged_tm04_logo,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 jointm04_tm04(left,right),
							 left outer,LOCAL);	
							 
////////////////////

Layouts_Raw_Input.tm01_tm04_out	jointm01_tm04(Layouts_Raw_Input.tm01_out l, Layouts_Raw_Input.tm04_tm04_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedtm01_tm04	:= join(dist_tm01, joinedtm04_tm04,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 jointm01_tm04(left,right),
							 left outer,LOCAL);								 	
							 
////////////////////	

Layouts_Raw_Input.llcA01_out		joinllcA01(Layouts_Raw_Input.llcA01_out l, Layouts_Raw_Input.llcA01_out r) := transform
		self.legalName := trimUpper(l.legalName) + trimUpper(r.legalName);
		self	  := l;
	end;
	
joinedllcA01	:= join(dist_llcA0, dist_llcA1,
						trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinllcA01(left,right),
							 left outer,LOCAL);	
///////////////////
							 
Layouts_Raw_Input.llc00A01_out	joinllc00A01(Layouts_Raw_Input.llc00_out l, Layouts_Raw_Input.llcA01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01	:= join(dist_llc00, joinedllcA01,
							trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
							 joinllc00A01(left,right),
							 left outer,LOCAL);							 
		
///////////////////
							 
Layouts_Raw_Input.llc00A01B0_out	joinllc00A01B0(Layouts_Raw_Input.llc00A01_out l, Layouts_Raw_Input.llcB0_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B0	:= join(joinedllc00A01, dist_llcB0,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B0(left,right),
								left outer,LOCAL);
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01_out	joinllc00A01B01(Layouts_Raw_Input.llc00A01B0_out l, Layouts_Raw_Input.llcB1B2_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01	:= join(joinedllc00A01B0, dist_llcB1,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01(left,right),
								left outer,LOCAL);								
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0_out	joinllc00A01B01C0(Layouts_Raw_Input.llc00A01B01_out l, Layouts_Raw_Input.llcC0_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0	:= join(joinedllc00A01B01, dist_llcC0,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0(left,right),
								left outer,LOCAL);
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0D0123_out	joinllc00A01B01C0D0123(Layouts_Raw_Input.llc00A01B01C0_out l, Layouts_Raw_Input.llcD0123_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0D0123	:= join(joinedllc00A01B01C0, dist_llcD0123,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0D0123(left,right),
								left outer,LOCAL);	
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0D0123E01_out	joinllc00A01B01C0D0123E01(Layouts_Raw_Input.llc00A01B01C0D0123_out l, Layouts_Raw_Input.llcE01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0D0123E01	:= join(joinedllc00A01B01C0D0123, dist_llcE01,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0D0123E01(left,right),
								left outer,LOCAL);	
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0D0123E015_out	joinllc00A01B01C0D0123E015(Layouts_Raw_Input.llc00A01B01C0D0123E01_out l, Layouts_Raw_Input.llcE5_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0D0123E015	:= join(joinedllc00A01B01C0D0123E01, dist_llcE5,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0D0123E015(left,right),
								left outer,LOCAL);
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0D0123E015TBL_out	joinllc00A01B01C0D0123E015TBL(Layouts_Raw_Input.llc00A01B01C0D0123E015_out l, Layouts_Raw_Input.ForgnStateDescLayout r) := transform
		self   				:= l;
		self.lawsStateDesc	:= r.desc;
	end;
	
joinedllc00A01B01C0D0123E015TBL	:= join(joinedllc00A01B01C0D0123E015, Files_Raw_Input.ForgnStateTable,
								trimUpper(left.lawsState) = trimUpper(right.code),
								joinllc00A01B01C0D0123E015TBL(left,right),
								left outer, LOOKUP);
								
///////////////////
							 
Layouts_Raw_Input.llc00A01B01C0D0123E015TBLF0_out	joinllc00A01B01C0D0123E015TBLF0(Layouts_Raw_Input.llc00A01B01C0D0123E015TBL_out l, Layouts_Raw_Input.llcF0_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0D0123E015TBLF0	:= join(joinedllc00A01B01C0D0123E015TBL, dist_llcF0,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0D0123E015TBLF0(left,right),
								left outer,LOCAL);																			
								
//////////////////								
							 
Layouts_Raw_Input.llc00A01B01C0D0123E015TBLF0J01_out	joinllc00A01B01C0D0123E015TBLF0J01(Layouts_Raw_Input.llc00A01B01C0D0123E015TBLF0_out l, Layouts_Raw_Input.llcJ01_out r) := transform
		self   	:= l;
		self	:= r;
	end;
	
joinedllc00A01B01C0D0123E015TBLF0J01	:= join(joinedllc00A01B01C0D0123E015TBLF0, merged_llcJ01,
								trimUpper(left.charterNumber) = trimUpper(right.charterNumber),
								joinllc00A01B01C0D0123E015TBLF0J01(left,right),
								left outer,LOCAL);									
//////////////////	
		
		
		
		//Corps -----------------------------------------------------
		Corps01      	:= joinedan01_an05;
		mappedCorps01   := project(Corps01,CorpTransformAN01(left));
		
		Corps02      	:= joinedBT01_BT02;
		mappedCorps02   := project(Corps02,CorpTransformBT01(left));
		
		Corps03      	:= joineddc01020405;
		mappedCorps03   := project(Corps03,CorpTransformDC01(left));
		
		Corps04      	:= mapped_dc04_ra_only;
		mappedCorps04   := project(Corps04,CorpTransformDC02(left));
		
		Corps05      	:= joinedfc0102040506TBL;
		mappedCorps05   := project(Corps05,CorpTransformFC01(left));
		
		Corps06      	:= joinedlp0102040505C06TBL;
		mappedCorps06   := project(Corps06,CorpTransformLP01(left));
		
		Corps07      	:= lp02_mailing_addrs;
		mappedCorps07   := project(Corps07,CorpTransformLP02(left));
		
		Corps08      	:= joinednp01_np04_np05;
		mappedCorps08   := project(Corps08,CorpTransformNP01(left));
		
		Corps09      	:= mapped_np04_ra_only;
		mappedCorps09   := project(Corps09,CorpTransformNP02(left));
		
		Corps10      	:= joinedrn01_rn04;
		mappedCorps10   := project(Corps10,CorpTransformRN01(left));
		
		Corps11      	:= joinedtm01_tm04;
		mappedCorps11   := project(Corps11,CorpTransformTM01(left));		
		
		Corps12      	:= mapped_tm02;
		mappedCorps12   := project(Corps12,CorpTransformTM02(left));		
		
		Corps13      	:= joinedllc00A01B01C0D0123E015TBLF0J01;
		mappedCorps13   := project(Corps13,CorpTransformLLC01(left));
		
		Corps14      	:= llcB2_ra_only;
		mappedCorps14   := project(Corps14,CorpTransformLLC02(left));
		
		corpsList       := mappedCorps01 + mappedCorps02 + mappedCorps03 +
						   mappedCorps04 + mappedCorps05 + mappedCorps06 + 
        				   mappedCorps07 + mappedCorps08 + mappedCorps09 +
						   mappedCorps10 + mappedCorps11 + mappedCorps12 +
						   mappedCorps13 + mappedCorps14;
		
		cleanedCorps 	:= project(corpsList,CleanCorps(left));	
		
		allCorps 		:= sort(cleanedCorps,corp_key);
		
		
		//Conts -----------------------------------------------------
		Conts01         := joinedan0102;
		mappedConts01   := project(Conts01,ContTransformAN01(left));
		
		Conts02         := joineddc01_dc07;
		mappedConts02   := project(Conts02,ContTransformDC01(left));
		
		Conts03         := joinednp01_np04_np05;
		mappedConts03   := project(Conts03,ContTransformNP01(left));
		
		Conts04         := joinedrn01_rn02;
		mappedConts04   := project(Conts04,ContTransformRN01(left));		
		
		contsList    	:= mappedConts01 + mappedConts02 + mappedConts03 +
						   mappedConts04;
		
		cleanedConts 	:= project(contsList,CleanConts(left));
		
		allconts        := sort(cleanedConts,corp_key);
		
		
		//Events ----------------------------------------------------
		Events01        := merged2_an03;
		mappedEvents01  := project(Events01,EventTransformAN01(left));
		
		Events02        := merged2_bt03;
		mappedEvents02  := project(Events02,EventTransformBT01(left));
		
		Events03        := merged2_dc03;
		mappedEvents03  := project(Events03,EventTransformDC01(left));
		
		Events04        := merged2_fc03;
		mappedEvents04  := project(Events04,EventTransformFC01(left));
		
		Events05        := merged2_lp03;
		mappedEvents05  := project(Events05,EventTransformLP01(left));
		
		Events06        := merged2_np03;
		mappedEvents06  := project(Events06,EventTransformNP01(left));
		
		Events07        := merged2_rn03;
		mappedEvents07  := project(Events06,EventTransformNP01(left));
		
		Events08        := merged2_tm03;
		mappedEvents08  := project(Events08,EventTransformTM01(left));
		
		Events09        := merged2_llcG0;
		mappedEvents09  := project(Events09,EventTransformLLC01(left));
		
		eventsList   	:= mappedEvents01 + mappedEvents02 + mappedEvents03 +
						   mappedEvents04 + mappedEvents05 + mappedEvents06 +
						   mappedEvents07 + mappedEvents08 + mappedEvents09;				
		
		allEvents       := sort(eventsList,corp_key);	
		
		
		//Annual Reports(AR) ----------------------------------------
		ARs01        	:= purged_dcAR;
		mappedAR01  	:= project(ARs01,ArTransformDC01(left));
		
		ARs02       	:= purged_fcAR;
		mappedAR02  	:= project(ARs02,ArTransformFC01(left));
		
		ARs03       	:= lp05_ars;
		mappedAR03  	:= project(ARs03,ArTransformLP01(left));
		
		ARs04       	:= purged_npAR;
		mappedAR04  	:= project(ARs04,ArTransformNP01(left));
		
		arsList       	:= mappedAR01 + mappedAR02 + mappedAR03 + mappedAR04;
		
		allARs      	:= sort(arsList,corp_key);
		
		
		 
		//Stocks ----------------------------------------------------
		Stocks01        := mapped_dc04;
		mappedStocks01  := project(Stocks01,StockTransformDC01(left));
		
		Stocks02        := mapped_np04;
		mappedStocks02  := project(Stocks02,StockTransformNP01(left));
		
		stocksList   	:= mappedStocks01 + mappedStocks02;
		
		allStocks       := sort(stocksList,corp_key);
		
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_mn'	,allCorps	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_mn'	,allEvents,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_mn'	,allConts	,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_mn'		,allARs		,ar_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_mn'	,allStocks,stock_out,,,pOverwrite);
                                                                                     
		mapMN := parallel(                                                                                                                                       
			 corp_out	
			,event_out
			,cont_out	
			,ar_out		
			,stock_out
	);

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('mn',filedate,pOverwrite := pOverwrite))
			,mapMN
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_mn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_mn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_mn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_mn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_mn')
			)
		);
		 
		return result;
	end;					 					
			
end; // end of module
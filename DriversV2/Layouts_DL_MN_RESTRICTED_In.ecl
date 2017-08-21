// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

IMPORT address;

EXPORT Layouts_DL_MN_RESTRICTED_In := Module

	export address_rec := record
		 string15  operatorid;
		 unsigned2 sequencenum;  //added to show rank or priority
		 string80  address;   
		 string25  city;      
		 string2   statepostalcode;   
		 string9   zip;       
		 string3   countycode; 
		 address.layout_clean182_fips cleanaddress;
		 string20  AddRecID; // new
	end;

	export text_segment_rec := record
			integer3 textlineseq;    // resultant text line number
			integer3 segmentseq;     // 1-n segment within line number
			string200 desctext;      // text to output before any code translation
			string20 datatype := ''; 
			string10 code := '';
	end;

	export viol_segment_rec := record
			integer3 violtextlineseq;    // resultant text line number
			integer3 violsegmentseq;     // 1-n segment within line number
			string200 violdesctext;      // text to output before any code translation
			string20 violdatatype := ''; 
			string10 violcode := '';
	end;

	export misc_rec := record
		 string15  operatorid;
		 string20  MiscRecID; // new
		 dataset (text_segment_rec) textlinesegments {maxlength(10000)}; 
	end;

	export restriction_rec := record
		 string15  operatorid;  //added to tie to operator rec if needed
		 unsigned8 licenseid;
		 unsigned2 sequencenum; //added to show rank or priority
		 string5   restrictioncode;
		 string1   applyall;
		 string23  restrictiondesc;	 
		 string20	 RestRecID; // new
	end;

	export license_rec := record
		 string15   operatorid;
		 string25   dln;           //moved from operator rec 
		 string2    statepostalcode;  //added so lookups can be done from this record
		 unsigned2  sequencenum;  //added to show rank or priority
		 unsigned8  licenseid;
		 string22   statuscode;
		 string20   classcode;
		 unsigned4  issueddate;      
		 unsigned4  expirationdate;  
		 string1    validexpirationdate;
		 string8    licensetype;
		 unsigned6  modifieddate;	 //new added
		 string2    loadid;        //new added
		 string22 	statusdesc;    //new added
		 string20 	classdesc;     //new added	 
		 //child recs of restrictions removed so can tie to operator rec if needed
		 string20   LicRecID; // new
	end;

	export violation_rec := record
		 string15   operatorid;
		 unsigned2  sequencenum;  //added to show rank or priority
		 string20   violationcode;
		 string4    violationtype;
		 unsigned4  violsuspnsndate;  
		 unsigned4  convreinstmtdate; 
		 unsigned4  prescrsrchdate;   
		 string1    cdlflag;
		 unsigned2  violationpoints;
		 string1    withdrawalstatus;
		 string1    suppressdisplay;
		 string1    expandedsrchflag;
		 string10   dispositioncode;
		 string20   casestatus;
		 string5    datasourcecode := '';		 
		 string3		sentencecode;	   //new added
		 string5    svc;	           //new added
		 string5    svcqualifiers;	 //new added
		 unsigned6  modifieddate;	   //new added
		 string20		ViolRecID;     // new
		 unsigned4  DtFirstSeen;   // new
		 string50		ControlSource; // new
		 dataset (text_segment_rec) textlinesegments {maxlength(5000)}; // ~20 text segments
	end;

	export violation_flat_rec := record
		 violation_rec - [textlinesegments];
		 viol_segment_rec;
	end;

	export operator_rec := record
		 string15   operatorid;
		 string2    loadid;
		 string2    filetype;
		 string2    sourcetype;
		 string2    sourcefrequency;
		 string2    statepostalcode;  
		 string5    title;          
		 string28   lname;          
		 string20   fname;          
		 string20   mname;          
		 string5    sname;          
		 string9    ssn;
		 unsigned4  dob;           
		 string1    gender;        
		 string4    height;
		 string3    weight;
		 string10   eyecolor;
		 string10   haircolor;
		 string1    donorflag;
		 string50   aka;
		 unsigned4  mvrrptdate;    
		 string1    mvrsourcecode;
		 string1    mvrorigincode;
		 string1    mvrstatuscode;
		 string1    privacyflag;
		 string4    mvrtypelist;
		 string2    driverstate;
		 string10   driverid;
		 unsigned8  idl;
		 string20   transactionid;   //dhd migration 
		 unsigned2  sequencenum;     //dhd migration
		 string9    account;         //dhd migration
		 string1    restrictedflag;  //dhd migration
		 string1    amplified;       //dhd migration
		 string20   referencenumber; //dhd migration
		 string20   uniquemvrid;     //dhd migration
		 string3    fulfilledby;     //dhd migration
		 string10   businessline;    //dhd migration
		 unsigned3  mvrrpttime;      //dhd migration
		 unsigned6  modifieddate;		  //new added
		 string1    adversecondition; //new added
		 string1    derivedvalidpdl;	//new added
		 string2 	  searchperiod;	    //new added
		 unsigned6  mvrorderdatetime; //new added
		 string1    derivedmvrstatus; //new added
		 string1		permissiblepurposecode; //new added
		 string3    eyecolordesc; 		//new added
		 string3		haircolordesc; 		//new added	 
		 string20	  OperRecID;   // new
		 unsigned4  DtFirstSeen; // new
	end;

	export almost_full_rec := record
		 string15 	operatorid;
		 string8		process_date;
		 unsigned4  dt_first_seen;
		 unsigned4  dt_last_seen;
		 unsigned4  dt_vendor_first_reported;
		 unsigned4  dt_vendor_last_reported;	 
		 unsigned8 	licenseid;
		 string3 	 	cdl_status;
		 string2 		donorflag;
		 string1  	licensetype;
		 string10   lic_endorsement;
		 string5   	derived_restrictioncode;
		 string42  	restrictions;
		 string42  	restrictions_delimited;
		 license_rec 			- [operatorid, licenseid];
		 address_rec 			- [operatorid];
		 restriction_rec 	- [operatorid, licenseid];
		 dataset (text_segment_rec) misctextlinesegments {maxlength(10000)}; 
		 operator_rec 		- [operatorid, DtFirstSeen];
		 violation_rec 		- [operatorid, textlinesegments, DtFirstSeen];
		 viol_segment_rec;
		 unsigned4  operator_DtFirstSeen;
		 unsigned4  violation_DtFirstSeen;
	end;

	export full_rec := record
		 almost_full_rec - [misctextlinesegments];
		 text_segment_rec;
	end;

	export misc_normalized_rec := record
		 string15  operatorid;
		 string1   licensetype;
		 string1   cdl_status;
		 string2 	 donorflag;
		 string200 lic_endorsement;
	end;

	export temp_restrictions := record
		 string15  operatorid;  //added to tie to operator rec if needed
		 unsigned8 licenseid;
		 unsigned2 sequencenum; //added to show rank or priority
		 string5   restrictioncode;
		 string1   applyall;
		 string23  restrictiondesc;
		 string42  restrictions;
		 string42  restrictions_delimited;
		 string5   derived_restrictioncode;
	end;
		
	export slim_violations := record
		 string15   operatorid;
		 string25   dln;  
		 integer3 	textlineseq;
		 integer3 	segmentseq;
		 string200  desctext;
		 string20 	datatype;
		 string10 	code;
		 string3		loc_code;
		 string50		loc_desc; 
		 string1		cdl_code;
		 string1		sentence_code;
		 violation_rec - [operatorid, textlinesegments];
	end;

end;
/*
  This script does the following:
    1.	Read customer records from input file written to disk on Thor.
    2.	Append BIP IDs to customer records.
    3.	Append Cortera IDs to customer records based on BIP ID lookup.
    4.	Transform customer records having BIP IDs and Cortera IDs to "LINKID Input File" 
       layout required by Cortera.
    5.	Write LINKID Input File to csv file and despray to the cargoDayton dropzone for 
       FTP transfer.
    6. Generate Input XML Control File, write it to disk, and then despray it to the 
       cargoDayton dropzone for FTP transfer.

    After this someone must FTP manually both the LINKID Input and Control Files from 
    the dropzone to the Cortera SFTP site per "Cortera File Processing Guide.docx"
*/

#workunit('name','Prep Cortera Input and Control files for FTP transfer');
#option ('hthorMemoryLimit', 1000);

IMPORT BIPV2, Business_Header_SS, BusinessInstantID20_Services, STD, ut;

// -----[ NOTE! Before you run this script, set target to a Thor, e.g. "thor50_dev" ]-----

recordsToRun := ALL; // or a numeric value, e.g. 100

// LexisNexis Risk login credentials:
customerlogin := 'lnretro'; 

// Input filename.
inputFile := // ut.foreign_prod + 'tfuerstenberg::in::Wells_7950_bus_in1.csv';
    '~tfuerstenberg::in::cortera_bac_records_3.csv';

/*
NOTES on output file names:

For the LINKID input file: [customerlogin]_linkid_[YYYYMMDD]_[sequence].txt
Example:  login_linkid_20100115_1.txt

Input file name must be unique. When there are multiple files submitted on the same day, 
the sequence number must be incremented in the file name to keep uniqueness.
Example:  login_address_20100115_1.txt, login_address_20100115_2.txt, etc.

For the LINKID input file, the control file is: [customerlogin]_linkid_[YYYYMMDD]_[sequence].xml
Example:  login_linkid_20100115_1.xml
*/
outputFileBase  := '~cortera::out::';
dateYYYYMMDD    := STD.System.Job.WUID()[2..9];
sequence        := STD.System.Job.WUID()[11..16];
outputFileRoot  := customerlogin + '_linkid_' + dateYYYYMMDD + '_' + sequence;
outputFileName  := outputFileRoot + '.txt';
controlFileName := outputFileRoot + '.xml';

thorFileName    := outputFileBase + outputFileName;

/*
  NOTE: Cortera requires that the histroyDate format for the Retrotester process be YYYYMM.
*/

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/

// (1)	Read customer records from input file.

// Input layout:
bus_in := record
	string30  AccountNumber := '';
	string100 CompanyName := '';
	string100 AlternateCompanyName := '';
	string50  Addr := '';
	string30  City := '';
	string2   State := '';
	string9   Zip := '';
	string10  BusinessPhone := '';
	string9   TaxIdNumber := '';
	string16  BusinessIPAddress := '';
	string15  Representativefirstname := '';
	string15  RepresentativeMiddleName := '';
	string20  Representativelastname := '';
	string5   RepresentativeNameSuffix := '';
	string50  RepresentativeAddr := '';
	string30  RepresentativeCity := '';
	string2   RepresentativeState := '';
	string9   RepresentativeZip := '';
	string9   RepresentativeSSN := '';
	string8   RepresentativeDOB := '';
	string3   RepresentativeAge := '';
	string20  RepresentativeDLNumber := '';
	string2   RepresentativeDLState := '';
	string10  RepresentativeHomePhone := '';
	string50  RepresentativeEmailAddress := '';
	string20  RepresentativeFormerLastName := '';
	integer   historydate;
	string8   SICCode;
	string8   NAICCode;
end;

ds_input_raw      := CHOOSEN( DATASET( inputFile, bus_in, CSV(HEADING(SINGLE),QUOTE('"')) ), recordsToRun );
ds_input_raw_dist := DISTRIBUTE( ds_input_raw, HASH32(RANDOM()) );

OUTPUT( CHOOSEN(ds_input_raw_dist,100), NAMED('input_raw_dist') );

// (2)	Append BIP IDs to customer records.
Options := MODULE(BusinessInstantID20_Services.iOptions) END;
TodayYYYYMM := (INTEGER)(ThorLib.wuid()[2..7]);

BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo xfm_LoadInput( bus_in le, INTEGER c ) := 
  TRANSFORM
    SELF.Seq            := c;
    SELF.AcctNo         := le.AccountNumber;		
    SELF.HistoryDate    := IF( le.historydate IN [0, 999999, 99999999], TodayYYYYMM, (INTEGER)(((STRING)le.historydate)[1..6]) );
    SELF.CompanyName    := le.CompanyName;
    SELF.StreetAddress1 := le.Addr;
    SELF.StreetAddress2 := '';
    SELF.City           := le.City;
    SELF.State          := le.State;
    SELF.Zip            := le.Zip;
    SELF.FEIN           := le.TaxIdNumber;
    SELF.Phone10        := le.BusinessPhone;
    SELF.Fax_Number     := '';
    SELF.AuthReps := 
        DATASET( 1,
          TRANSFORM( BusinessInstantID20_Services.layouts.InputAuthRepInfo,
            SELF.Rep_WhichOne   := 1,
            SELF.NameTitle      := '',
            SELF.FullName       := '',
            SELF.FirstName      := le.RepresentativeFirstName,
            SELF.MiddleName     := le.RepresentativeMiddleName,
            SELF.LastName       := le.RepresentativeLastName,
            SELF.NameSuffix     := le.RepresentativeNameSuffix,
            SELF.FormerLastName := le.RepresentativeFormerLastName,
            SELF.StreetAddress1 := le.RepresentativeAddr,
            SELF.StreetAddress2 := '',
            SELF.City           := le.RepresentativeCity,
            SELF.State          := le.RepresentativeState,
            SELF.Zip            := le.RepresentativeZip,
            SELF.SSN            := le.RepresentativeSSN,
            SELF.DateOfBirth    := le.RepresentativeDOB,
            SELF.Age            := le.RepresentativeAge,
            SELF.DLNumber       := le.RepresentativeDLNumber,
            SELF.DLState        := le.RepresentativeDLState,
            SELF.Phone10        := le.RepresentativeHomePhone,
            SELF.Email          := le.RepresentativeEmailAddress,
            SELF.LexID          := 0,
            SELF := []
          )
        );
  END;
    
ds_input         := PROJECT( ds_input_raw_dist, xfm_LoadInput(LEFT,COUNTER) );
ds_input_cleaned := BusinessInstantID20_Services.fn_CleanInput(ds_input);

OUTPUT( CHOOSEN(ds_input_cleaned,100), NAMED('input_cleaned') );

// (2.a.) Now append BIPIDs to the input records. Minimum input requirements to resolve to 
// a set of BIP IDs is:
//  o  company name + Address, OR
//  o  fein
//  o  Occasionally just the company_name or phone may provide a match, but only if 
//     data are unique enough within the universe of business data we have in-house.

// Define the BIP_Matchset. Do not adjust or twiddle.
//
// 'A' = Address
// 'F' = FEIN
// 'P'	= phone
// * company name will always be part of the match if any of the above flags are set.
// 'N' = Allow match on company name only.
BIP_Matchset := ['A','F','P'];

layout_output_bipappend := 
  {BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean OR BIPV2.IDlayouts.l_xlink_ids};

// (2.b.) Run the BIP-append macro.
Business_Header_SS.MAC_Add_BDID_Flex(	
                       ds_input_cleaned(CompanyName != '')	// Input Dataset
                       ,BIP_Matchset           // BDID Matchset what fields to match on
                       ,CompanyName            // company_name
                       ,prim_range             // prim_range
                       ,prim_name              // prim_name
                       ,zip5                   // zip5
                       ,sec_range              // sec_range
                       ,st                     // state
                       ,Phone10                // phone
                       ,fein									          // fein
                       ,''					                // bdid
                       ,RECORDOF(layout_output_bipappend) // Output Layout
                       ,FALSE                  // output layout has bdid score field?
                       ,''                     // bdid_score
                       ,ds_with_BIPIDs         // Output Dataset
                       ,															        // default threshold
                       ,													 	        // use prod version of superfiles
                       ,														         // default is to hit prod from dataland, and on prod hit prod.		
                       ,[BIPV2.IDconstants.xlink_version_BIP]	// Create BIP Keys only
                       ,CompanyURL             // Url
                       ,													          // Email
                       ,p_city_name            // City
                       ,AuthReps[1].FirstName	 // fname
                       ,AuthReps[1].MiddleName	// mname
                       ,AuthReps[1].LastName	  // lname
                       ,AuthReps[1].SSN							 // Contact_SSN
                       , 							               // Source  MDR.sourceTools
                       , 	                     // Source_Record_Id
                       ,									              // Src_Matching_is_priorty
                    );

// (2.c.) Filter out any non-matches.
ds_with_BIPIDs_valid := 
    ds_with_BIPIDs(PowID != 0 OR ProxID != 0 OR SeleID != 0 OR OrgID != 0 OR UltID != 0); 

OUTPUT( CHOOSEN(ds_with_BIPIDs_valid,100), NAMED('with_BIPIDs_valid') );

// (3)	Append Cortera IDs and (4) transform records to the layout required by Cortera.
layout_LINKID_Input_File := RECORD
  STRING ID1        := ''; // Unique identifier for customer.
  STRING ID2        := ''; // Unique identifier for customer.
  STRING9 LINKID    := ''; // LINKID from Cortera; max length is 9.
  STRING6 RetroDate := ''; // RetroDate is YYYYMM format only.
END;

ds_with_BIPIDs_dist         := DISTRIBUTE( ds_with_BIPIDs_valid, HASH32(ultid, orgid, seleid) );
ds_cortera_header_file_dist := DISTRIBUTE( Cortera.Files.Hdr_Out(seleid != 0), HASH32(ultid, orgid, seleid) );

// Join to Cortera Header file to obtain Cortera Link_IDs.
ds_LINKID_Input_File :=
  JOIN(
    ds_cortera_header_file_dist, ds_with_BIPIDs_dist, 
    LEFT.ultid = RIGHT.ultid AND
    LEFT.orgid = RIGHT.orgid AND
    LEFT.seleid = RIGHT.seleid,
    TRANSFORM( layout_LINKID_Input_File,
      SELF.ID1       := (STRING)RIGHT.seq;
      SELF.ID2       := (STRING)RIGHT.acctno;
      SELF.LINKID    := (STRING)LEFT.link_id;
      SELF.RetroDate := ((STRING)RIGHT.historydate)[1..6];
    ),
    INNER, KEEP(1000), LOCAL
  );

// (5)	Write to csv file and despray to a LN location for FTP transfer.

despray_ip_address       := 'cargo.risk.regn.net'; // cargoDayton dropzone
despray_outputfile_path  := '/data/' + outputFileName;
despray_controlfile_path := '/data/' + controlFileName;
ALLOW_OVERWRITE          := TRUE;

output_view_action  := OUTPUT( CHOOSEN(ds_LINKID_Input_File,100) );
output_file_action  := OUTPUT( ds_LINKID_Input_File, , thorFileName, CSV(HEADING(0), QUOTE('"')), EXPIRE(30), OVERWRITE );
despray_file_action := STD.File.DeSpray( thorFileName, despray_ip_address, despray_outputfile_path, -1, , , ALLOW_OVERWRITE );

output_file_actions := SEQUENTIAL( output_view_action, output_file_action, despray_file_action );

// (6) Generate Input XML Control File, write it to disk, and then despray it to the dropzone.
_wuid := ThorLib.wuid();

yyyy := _wuid[2..5];
mo   := _wuid[6..7];
dd   := _wuid[8..9];
hh   := _wuid[11..12];
mm   := _wuid[13..14];
ss   := _wuid[15..16];

STRING completeTime := mo + '/' + dd + '/' + yyyy + ' ' + hh + ':' + mm + ':' + ss;
STRING recordCount  := (STRING)(COUNT(ds_LINKID_Input_File));

layout_BatchInputInfo := RECORD
  STRING FileName;
  STRING Status;
  STRING CompleteTime;
  STRING RecordCount;
END;

layout_BatchOutputInfo := RECORD
  STRING InputFile;
  STRING OutputFile;
  STRING Status;
  STRING CompleteTime;
  STRING RecordCount;
END;

layout_ControlFileInfo := RECORD
  layout_BatchInputInfo BatchInput;
  layout_BatchOutputInfo BatchOutput;
END;

ds_ControlFileInfo :=
    DATASET( 1,
      TRANSFORM( layout_ControlFileInfo,
        SELF.BatchInput  := ROW( {outputFileName,'COMPLETE',completeTime,recordCount}, layout_BatchInputInfo ),
        SELF.BatchOutput := ROW( {'','','','',''}, layout_BatchOutputInfo )
      )
    );

headerText := '<?xml version="1.0"?><CorteraBatch xmlns:xs="http://www.w3.org/2001/XMLSchema-instance">';
footerText := '</CorteraBatch>';

output_view_controlFile_action := OUTPUT( ds_ControlFileInfo );
output_controlFile_action      := OUTPUT( ds_ControlFileInfo, , controlFileName, XML('', HEADING(headerText,footerText), TRIM), OVERWRITE );
despray_controlFile_action     := STD.File.DeSpray( controlFileName, despray_ip_address, despray_controlfile_path, -1, , , ALLOW_OVERWRITE );

output_controlFile_actions := SEQUENTIAL( output_view_controlFile_action, output_controlFile_action, despray_controlFile_action );

OUTPUT( thorFileName, NAMED('thorFileName') );
OUTPUT( controlFileName, NAMED('controlFileName') );

// Perform actions on the output file and control file.
SEQUENTIAL( output_file_actions, output_controlFile_actions );

//
// CONCERNs/RISKs: 
//   o  Lack of control over subdirectories created on cargoDayton.
//   o  There are already problems WRT space on cargoDayton.
//   o  Also, the number of records that our customers will want us to process.
//

// ==========================================================================

// DEBUGs:
// OUTPUT( CHOOSEN( ds_input_raw, 100 ), NAMED('input_raw') );
// OUTPUT( CHOOSEN( ds_input, 100 ), NAMED('input') );
// OUTPUT( CHOOSEN( ds_input_cleaned, 100 ), NAMED('input_cleaned') );
// OUTPUT( ds_BIPIDs, NAMED('BIPIDs') );
// OUTPUT( ds_with_BIPIDs, NAMED('with_BIPIDs') );
// OUTPUT( ds_input_with_BIPIDs, NAMED('input_with_BIPIDs') );
// OUTPUT( ds_LINKID_Input_File, NAMED('LINKID_Input_File') );
// OUTPUT( outputFile, NAMED('outputFileName') );

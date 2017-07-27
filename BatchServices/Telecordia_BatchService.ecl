/*--SOAP--
<message name="Telecordia_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

/* ***** SEE BLOCK COMMENT at bottom for explanation of SCCs (Special Service Codes)
   and nxx_types. */

IMPORT BatchServices, Risk_Indicators, ut;

EXPORT Telecordia_BatchService(useCannedRecs = 'false') := 
	MACRO
		// UNSIGNED1 DPPA_Purpose  := 1     : STORED('DPPAPurpose');
		// UNSIGNED1 GLB_Purpose   := 8     : STORED('GLBPurpose');

		Records := BatchServices.Telecordia_BatchService_Records;
		
		UNSIGNED4 Max_Results := 10000 : STORED('MaxResults');	
		ds_input_raw          := DATASET([], Records.rec_input) : STORED('batch_in', FEW);

		// 1. Capture the batch_in.					
		ds_batch_in := IF( NOT useCannedRecs, ds_input_raw, Records.ds_sample );	

		Pre_result := Records.BatchView(ds_batch_in, true);		
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		OUTPUT(result, NAMED('Results'));			
	
	ENDMACRO;	
	
	
	
/*                           Special Service Codes (SSCs)

SSCs are used in conjunction with the COCTYPE field to further identify special 
services provided by a Destination Code (NXX) record.  (LERG6, LERG9).  Allowable 
codes are:

A = INTRALATA – for INTRALATA use only.  Calls can only originate and terminate 
within the LATA to which the NXX or thousands blocks is assigned.  An NXX “A” 
record and all associated thousands blocks must show (or not show) an SSC of A.

B = Paging Services – Note that the information supplied by data providers regarding 
the “use” of an NXX or thousands block may vary over time due to a company’s line 
assignments.  Such changes are not necessarily conveyed to those maintaining the data.  
For example, a COCTYPE /SSC combination of EOC B (i.e. shared wireline/paging) may 
technically become an EOC N (i.e. wireline only), but the data provider may not be 
aware that the initial inclusion of some cellular lines may have since changed.

C = Cellular Services – Note that the information supplied by data providers regarding 
the “use” of an NXX or thousands block may vary over time due to a company’s line 
assignments.  Such changes are not necessarily conveyed to those maintaining the data.  
For example, a COCTYPE /SSC combination of EOC C (i.e. shared wireline/cellular) may 
technically become an EOC N (i.e. wireline only), but the data provider may not be aware 
that the initial inclusion of some cellular lines may have since changed.

I = Pseudo 800 Service Code – Used for INWATS service.  These numbers are the actual 
ring to number for an 800 number that is PIC'd to a long distance carrier and terminates 
within the LATA.  Even if the A record is marked SSC I, thousands blocks do not have to 
have the SSC of I.

J = Designates that this NXX and/or thousands block has an extended/expanded local 
Calling area.  It is advisable to refer to the appropriate state tariffs for the Rate 
Center associated with this NXX. Note:  Appropriate refers to the tariff of the company 
using the “J’ on their records in BIRRDS.

M = Local Mass Calling – This is different than choke or high volume calling codes that 
are Oddball codes identified with a COCTYPE of HVL.  Note that when an NXX is dedicated 
to a specific switch and Rate Center and is involved with “Mass Calling”, it would be 
considered non-Oddball and represented as COCTYPE EOC / SSC M (when some lines serve for 
“Mass Calling”) or COCTYPE EOC / SSC MO (when all assigned lines serve for “Mass Calling”). 
Cases where “MO” is used can only apply to NXX “A” records that are not portable.

N = Not Applicable – No SSC is needed, nor is one applicable.  Examples of types of 
services where an SSC of “N” is used may include Plain Old Telephone Service (POTS), 
900 Service, Test Code, and 500 Personal Communication Services (PCS).

O = Other – When ”O” is used, there may be restrictions and/or special services that 
are otherwise not definable by an existing SSC value.  These restrictions and/or special 
services may apply to some or to all lines within the NXX “A” record or thousands block.  
Any need for further clarification should be addressed to the AOCN associated with the 
NXX “A” record or thousands block to which the ”O” has been associated.

Where “O” is used, there must be an explanation of the service type entered into the NOTES 
field in BIRRDS for that NXX “A” record and/or thousands block.   NOTES appear only in the 
LERG when the “record” is an “Oddball code”.

R = Two-way Conventional Mobile Radio – This is a pre-cellular technology primarily used 
for situations where there needed to be two-way communications and an ability to patch to 
a phone.  This is similar to the old push-to-talk systems in a fleet arrangement.  This was 
also referred to as Improved Mobile Telephone Service (IMTS).

Note that the information supplied by data providers regarding the "use" of an NXX or 
thousands block may very over time due to a company's line assignments. Such changes are 
not necessarily conveyed to those maintaining the data. For example, COCTYPE/SSC combination 
of EOC R (share wireline/mobile) may technically become an EOC N (wireline only), but the 
data provider may not be aware that the initial inclusion of some cellular lines may have 
since changed.

S = Miscellaneous Services – For example, this includes non-500 PCS, Voice Mail, etc.

T = Time – This is used if an entire thousands block or entire NXX is dedicated to providing 
a “time of day” announcement or service.  T can only be associated with a COCTYPE of INP.

V = Internet Protocol Voice Enabled Services

W = Weather – This is used if an entire thousands block or entire NXX is dedicated to 
providing a “weather” announcement or service.  W can only be associated with a COCTYPE 
of INP.

X = Service Provider requests Local Exchange

Company IntraLATA Special Billing Option

X indicates that there may be line numbers or thousands blocks assigned to a Service Provider 
who has requested a LEC IntraLATA special billing option on a LATA-wide basis.  IntraLATA toll 
calls originating from LEC wireline subscribers are billed to the Service Provider as 
specified by state tariffs.  A B, C or R entry, or combinations of B, and/or C, and/or R, 
and/or S entries should always accompany an “X” entry in the SSC field.

Z = Service Provider requests SELECTIVE Local

Exchange Company IntraLATA Special Billing Option

Z indicates that there may be line numbers or thousands blocks assigned to a Service Provider 
who has requested a LEC IntraLATA special billing option on a SELECTIVE Exchange basis.  
IntraLATA toll calls originating from LEC wireline subscribers, in SELECTED Exchanges, are 
billed to the Service Provider as specified by state tariffs.  A B, C, or R entry, or 
combinations of B, and/or C, and/or R, and/or S entries should always accompany a “Z” entry 
in the SSC field.

8 = Puerto Rico and U.S. Virgin Islands

The SSC value of “8” applies to NXXs in Puerto Rico and the U.S. Virgin Islands.  The original 
SSC “8” definition was used when the North American Numbering Plan areas in the Caribbean and 
Atlantic were all handled by NPA 809.  

The digit "8" in the SSC field identifies those codes that are within Puerto Rico and the 
U.S. Virgin Islands and belong to either WATS Band 4 (for Florida and Rhode Island) or WATS 
Band 5 (for the remainder of the continental U.S. portion of the NANP) and must be screened at 
the WATS originating screening office to pass calls from WATS Band 4 or 5.  These codes must 
be reviewed each month in order to provide up-to-date originating WATS screening.

Although the Atlantic/Caribbean are now associated with area specific NPAs, use of “8” has 
been retained in deference to billing and other systems that may still utilize the value in 
their processing of data.

*/	

/*
           nxx_type: Provides information on how the NXX is being used.
					 
   00 = Regular (Plain Old Telephone Service (POTS)) *
   01 = Dedicated to Mobile Radio (Improved Mobile Telephone Service (IMTS))
   02 = Dedicated to Paging *
   03 = Packet Switching
   04 = Dedicated to Cellular *
   05 = Test Code
   06 = Maritime
   07 = Air to Ground
   09 = 900 Service
   10 = Called Party Pays
   11 = Information Provider Services
   13 = Directory Assistance
   15 = Official Exchange Service
   16 = Originating Only
   17 = Billing Only
   30 = Broadband
   50 = Shared between 3 or more - (POTS, Cellular, Paging, Mobile, or miscellaneous)
   51 = Shared between POTS and Mobile
   52 = Shared between POTS and Paging
   54 = Shared between POTS and Cellular
	 
   NXXTYPEs 55-58 - These indicate a dedicated code assigned to a (cellular, paging, mobile, 
	 (or shared among 2 or 3 of these)) service provider, for the specified service AND the 
	 service provider has requested LEC IntraLATA special billing option on a LATAwide basis.  
	 IntraLATA toll calls originating from LEC landline subscribers are billed to the service 
	 provider as specified by state tariffs.
   55 = Special Billing Option - Cellular
   56 = Special Billing Option - Paging
   57 = Special Billing Option - Mobile
   58 = Special Billing Option shared between 2 or more - (Cellular, Paging, Mobile)
	 
   NXXTYPEs 60-63 - These indicate a dedicated code assigned to a (cellular, paging, mobile, 
	 (or shared among 2 or 3 of these)) service provider, for the specified service AND the 
	 service provider has requested LEC IntraLATA special billing option on a SELECTIVE exchange basis.  
	 IntraLATA toll calls originating from LEC landline subscribers, in SELECTIVE exchanges, are 
	 billed to the service provider as specified by state tariffs.
   60 = Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Cellular
   61 = Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Paging
   62 = Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - Mobile
   63 = Combinations of 60, 61, and 62
	 
   64 = Personal Communications Services (NPA 500)
   65 = Personal Communications Services (not NPA 500)
   66 = Shared between POTS and Personal Communications Services (not NPA 500)
   67 = Special Billing Option - PCS / Personal Communications Services (not NPA 500)
   68 = Service provider requests SELECTIVE Local Exchange Company IntraLATA Special Billing Option - 
	      PCS/ Personal Communications Services (non NPA 500)
   77 = Oddball Codes (This is used for Oddball NXXs codes such as 411, 700, etc. which are either 
	      processed and/or used differently by the carriers who may use them or are not specific to a 
				given Rate Center, etc.  Some NXXs may be considered Oddball codes, however they may have 
				unique NXXTYPEs already assigned (e.g. NXXTYPE 11, 30, etc.).  Oddball codes are essentially 
				special use codes.  In some cases, an Oddball code may be specific to a carrier and to a 
				specific Rate Center in which case another NXXTYPE code may be used.  
*/	

/*  ****************************************************************************

PRTE Business Header Build Process:-

Data insight team provides the PRTE Business Header input files for both BDID and BIP Business Header builds.

Input files provided exists on the tapeload02b server in the below directory file path

Tapeload02b path:- \\tapeload02b\k\customer_data\prct_pii\archive\BusinessHeaderNew 

The below input files are expected in the following file name format.
1)  prct__businessrecs__lnpr_<date>.txt								- LNPR test case business header records
2)  prct__businessrecs__search_bdid_<date>.txt				- Historical BDID business header records
3)  prct__businessrecs__relatives_bdid1_<date>.txt		- Historical BDID relatives business header records
4)  prct__businessrecs__relatives_bdid2_<date>.txt		- Historical BDID relatives business header records
5)  prct__businessrecs__relatives_bdid3_<date>.txt		- Historical BDID relatives business header records
6)  prct__businessrecs__relatives_bdid4_<date>.txt		- Historical BDID relatives business header records
7)  prct__businessrecs__GoldmanSachs_<date>.txt				- GoldmanSachs test case business header records
8)  prct__businessrecs__CapitalOne_<date>.txt					- CapitalOne test case business header records

9)  prct___businessrecs__contacts_lnpr_<date>.txt			- LNPR test case business contact records
10) prct___businessrecs__contacts_bdid_<date>.txt			- Historical BDID test case business contact records

Update Frequency:- When the new input files available from the data insight team.

The following steps to update the BH build process.

************
* Step 1 :- 
************
	FTP the above files from "tapeload02b" to "bctlpedata12" landing zone in the below mentioned directory path.
	
	Landing zone Directory path :- /data/data_build_4/prct/BusinessHeader/

	The spray process expects the above files in the below mentioned file name formats. Make sure the contact files name are in the expected file name pattern. 
	If not, rename them to match the below file name pattern. 

	Business header file format		-> *prct__businessrecs__*'+pversion+'*txt'
	Business contact file format	-> *prct___businessrecs__contacts_*'+pversion+'*txt'

	Once the files are in the expected file name pattern. Kick off the below code in the ECLIDE by passing the version date (same date as the input files created).
	
	PRTE2_Business_Header.BWR_Build_Spray

	Spray process will send an email upon successful completion or build failures. The email sent will have details of the sprayed files it sprayed for both Business Header and Business Contact files.

	Once the spray process successfully completes, make sure the sprayed version input superfiles have all the expected files. 

************
* Step 2:-
************
	The 2nd step of the build process is...

	Kicking off the main build process. But before kicking off the build, make sure to sandbox the below attribute and change this constant "_PRTE_BUILD" to "true" from "false" as shown (_PRTE_BUILD := true;).

	PRTE2_Business_Header.Constants

	Open the below code in the builder window and just update the build version date value and kick off the build.

	PRTE2_Business_Header.BWR_Build_All

************
* Step 3:-
************
	When the build starts running, kick off the PRCT BIPV2 Business header build process too with the same version date, since the BIP Business Header build also uses the same input files.

	PRTE2_BIPV2_BusHeader.BWR_Build_All

	When the builds completes it will build all the Business Header base files and keys needed for the prct roxie package files. 

************
* Step 4:-
************
	Once the above builds successfully completes, kick of the PRCT WAF key build by passing the same version date as above build.
	
	PRTE2_BIPV2_WAF.BWR_Build_WAF

	Once all these 3 builds complete, update the below PRCT roxie package files.

	PRCT roxie package files:- 
	1)BusinessHeaderKeys   (PRTE Business Header build)

	2)BIPV2FullKeys				 (PRTE BIPV2 Business Header Build)
	3)BIPV2WeeklyKeys			 (PRTE BIPV2 Business Header Build)
	
	4)BIPV2WAFKeys				 (PRTE BIPV2 WAF Key Build)

*/

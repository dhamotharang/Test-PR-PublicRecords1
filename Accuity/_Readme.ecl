/*
There are two source files from Accuity found at
 \\tapeload02b\k\sanctions_patriot\accuity_watchlists_(en)\{version date}

MLPIDGWL.ZIP	-- This is a deliverable to XG Bridger and needs to be copied to the OUTPUT file

PIDGWL.ZIP		-- This contains the files used by the build process.
					These files need to be copied to edata12: /hds_3/accuity/{version date}
					ENTITY.XML
					extractsummary.txt
					GROUP.XML
					SRCCODE.XML

FullAccuityAKAlog.csv	-- this file is provided by XG Bridger (frequency TBD)
					The build process expects to find it here:
						/hds_3/accuity/akalist/FullAccuityAKAlog.csv


To run the process:
Accuity.Build_All({version date});   version date is yyyymmdd to match the date of the source
example: Accuity.Build_All('20121010');

This will create several output files at /hds_3/accuity/output on edata12
This is the list of deliverables:
accuity_source_ACB_1040.xml
accuity_source_ALL_1180.xml
accuity_source_BCW_1074.xml
accuity_source_BEL_1008.xml
accuity_source_BIT_1086.xml
accuity_source_CAC_1146.xml
accuity_source_CBI_1054.xml
accuity_source_CEL_1082_countries.xml
accuity_source_CEL_1082_noncountries.xml
accuity_source_CSL_1080.xml
accuity_source_CSSF_1114.xml
accuity_source_CWL_32.xml
accuity_source_DB_1088.xml
accuity_source_DNB_1090.xml
accuity_source_ES_1014.xml
accuity_source_ESE_1158.xml
accuity_source_EUE_1170.xml
accuity_source_FDJ_1152.xml
accuity_source_FDJ_1152_countries.xml
accuity_source_FMU_1126.xml
accuity_source_FR_1010.xml
accuity_source_HME_1130.xml
accuity_source_IND_1048.xml
accuity_source_ISA_1164.xml
accuity_source_ITL_1078.xml
accuity_source_MEX_1038.xml
accuity_source_MFR_1068.xml
accuity_source_NEP_1156.xml
accuity_source_NZ_1140.xml
accuity_source_OCF_1122.xml
accuity_source_ofac.xml
accuity_source_OFAC_countries.xml
accuity_source_PRT_1128.xml
accuity_source_RPL_1176.xml
accuity_source_SAP_1056.xml
accuity_source_SAR_1032.xml
accuity_source_SECO_42.xml
accuity_source_SL_1136.xml
accuity_source_UGO_1120.xml
accuity_source_UK_1046.xml
accuity_source_UN.xml
accuity_source_UNE_1172.xml
accuity_source_USM_45.xml
akalog.csv					(this is a log of new aka names)
FullAccuityAKAlog.csv		(this is a copy of the input file used)
MLPIDGWL.ZIP				(as is, from accuity)

Job Completion
When the job completes successfully, it will send an email with the workunit.
If it is unsucessful, an email will be sent to the DistributionList

There is one particular error that is checked for. If Accuity fails to provide a version date for
one of the lists, the following error message will be generated:

'The following list failed to build with listissuerdate=000000000000:  {listid}'

Someone on the distribution list will get in touch with Accuity to correct the problem.































*/
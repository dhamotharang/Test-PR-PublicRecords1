export Build_all(string versiondate) := sequential(
SprayAccuityFiles(versiondate),
Accuity.SprayAKAList,
Accuity.MakeHdr.OutputDataXMLFile('OGO 1072', 'source_ofac.xml',Accuity.Reformat.outputs.allofac),
Accuity.MakeHdr.OutputDataXMLFile('DB 1088', 'source_DB_1088.xml',Accuity.Reformat.outputs.source_DB_1088),
output(Accuity.Reformat.outputs.source_ACB_1040,,'~thor_data400::accuity::source_ACB_1040.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ACB 1040', Accuity.Reformat.outputs.source_ACB_1040), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_ALL_1180,,'~thor_data400::accuity::source_ALL_1180.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ALL 1180', Accuity.Reformat.outputs.source_ALL_1180), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),

output(Accuity.Reformat.outputs.source_BCW_1074,,'~thor_data400::accuity::source_BCW_1074.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('BCW 1074', Accuity.Reformat.outputs.source_BCW_1074), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_BEL_1008,,'~thor_data400::accuity::source_BEL_1008.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('BEL 1008', Accuity.Reformat.outputs.source_BEL_1008), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_BIT_1086,,'~thor_data400::accuity::source_BIT_1086.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('BIT 1086', Accuity.Reformat.outputs.source_BIT_1086), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CAC_1146,,'~thor_data400::accuity::source_CAC_1146.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CAC 1146', Accuity.Reformat.outputs.source_CAC_1146), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CBI_1054,,'~thor_data400::accuity::source_CBI_1054.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CBI 1054', Accuity.Reformat.outputs.source_CBI_1054), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CEL_1082_noncountries,,'~thor_data400::accuity::source_CEL_1082_noncountries.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CEL 1082', Accuity.Reformat.outputs.source_CEL_1082_noncountries), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CSL_1080,,'~thor_data400::accuity::source_CSL_1080.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CSL 1080', Accuity.Reformat.outputs.source_CSL_1080), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CSSF_1114,,'~thor_data400::accuity::source_CSSF_1114.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CSSF 1114', Accuity.Reformat.outputs.source_CSSF_1114), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_CWL_32,,'~thor_data400::accuity::source_CWL_32.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('CWL 32', Accuity.Reformat.outputs.source_CWL_32), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_DNB_1090,,'~thor_data400::accuity::source_DNB_1090.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('DNB 1090', Accuity.Reformat.outputs.source_DNB_1090), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
/*output(Accuity.Reformat.outputs.source_ECO_1144,,'~thor_data400::accuity::source_ECO_1144.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ECO 1144', Accuity.Reformat.outputs.source_ECO_1144), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),*/
output(Accuity.Reformat.outputs.source_ES_1014,,'~thor_data400::accuity::source_ES_1014.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ES 1014', Accuity.Reformat.outputs.source_ES_1014), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_ESE_1158,,'~thor_data400::accuity::source_ESE_1158.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ESE 1158', Accuity.Reformat.outputs.source_ESE_1158), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_EUE_1170,,'~thor_data400::accuity::source_EUE_1170.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('EUE 1170', Accuity.Reformat.outputs.source_EUE_1170), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_FDJ_1152,,'~thor_data400::accuity::source_FDJ_1152.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('FDJ 1152', Accuity.Reformat.outputs.source_FDJ_1152), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_FMU_1126,,'~thor_data400::accuity::source_FMU_1126.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('FMU 1126', Accuity.Reformat.outputs.source_FMU_1126), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_FR_1010,,'~thor_data400::accuity::source_FR_1010.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('FR 1010', Accuity.Reformat.outputs.source_FR_1010), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_HME_1130,,'~thor_data400::accuity::source_HME_1130.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('HME 1130', Accuity.Reformat.outputs.source_HME_1130), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_IND_1048,,'~thor_data400::accuity::source_IND_1048.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('IND 1048', Accuity.Reformat.outputs.source_IND_1048), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_ISA_1164,,'~thor_data400::accuity::source_ISA_1164.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ISA 1164', Accuity.Reformat.outputs.source_ISA_1164), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_ITL_1078,,'~thor_data400::accuity::source_ITL_1078.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('ITL 1078', Accuity.Reformat.outputs.source_ITL_1078), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_MEX_1038,,'~thor_data400::accuity::source_MEX_1038.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('MEX 1038', Accuity.Reformat.outputs.source_MEX_1038), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_MFR_1068,,'~thor_data400::accuity::source_MFR_1068.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('MFR 1068', Accuity.Reformat.outputs.source_MFR_1068), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_NEP_1156,,'~thor_data400::accuity::source_NEP_1156.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('NEP 1156', Accuity.Reformat.outputs.source_NEP_1156), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_NZ_1140,,'~thor_data400::accuity::source_NZ_1140.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('NZ 1140', Accuity.Reformat.outputs.source_NZ_1140), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_OCF_1122,,'~thor_data400::accuity::source_OCF_1122.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('OCF 1122', Accuity.Reformat.outputs.source_OCF_1122), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_PRT_1128,,'~thor_data400::accuity::source_PRT_1128.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('PRT 1128', Accuity.Reformat.outputs.source_PRT_1128), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_RPL_1176,,'~thor_data400::accuity::source_RPL_1176.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('RPL 1176', Accuity.Reformat.outputs.source_RPL_1176), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_SAP_1056,,'~thor_data400::accuity::source_SAP_1056.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('SAP 1056', Accuity.Reformat.outputs.source_SAP_1056), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_SAR_1032,,'~thor_data400::accuity::source_SAR_1032.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('SAR 1032', Accuity.Reformat.outputs.source_SAR_1032), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_SECO_42,,'~thor_data400::accuity::source_SECO_42.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('SECO 42', Accuity.Reformat.outputs.source_SECO_42), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
						
output(Accuity.Reformat.outputs.source_SL_1136,,'~thor_data400::accuity::source_SL_1136.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('SL 1136', Accuity.Reformat.outputs.source_SL_1136), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_UGO_1120,,'~thor_data400::accuity::source_UGO_1120.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('UGO 1120', Accuity.Reformat.outputs.source_UGO_1120), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_UK_1046,,'~thor_data400::accuity::source_UK_1046.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('UK 1046', Accuity.Reformat.outputs.source_UK_1046), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_UN,,'~thor_data400::accuity::source_UN.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('UNT 1064', Accuity.Reformat.outputs.source_UN), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_UNE_1172,,'~thor_data400::accuity::source_UNE_1172.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('UNE 1172', Accuity.Reformat.outputs.source_UNE_1172), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
output(Accuity.Reformat.outputs.source_USM_45,,'~thor_data400::accuity::source_USM_45.xml', 
			xml('Entity', heading(FROMUNICODE(Accuity.MakeHdr.CreateXMLFileHdr('USM 45', Accuity.Reformat.outputs.source_USM_45), 'utf8')
						,Accuity.MakeHdr.Footer),trim, OPT), overwrite),
// country files
output(Accuity.Geo.source_CEL_1082_countries,,'~thor_data400::accuity::source_CEL_1082_countries.xml', 
			xml('Country', heading(FROMUNICODE(Accuity.MakeHdr.CreateGeoXMLFileHdr('CEL 1082', Accuity.Geo.source_CEL_1082_countries), 'utf8')
						,Accuity.MakeHdr.GeoFooter),trim, OPT), overwrite),
output(Accuity.Geo.source_FDJ_1152_countries,,'~thor_data400::accuity::source_FDJ_1152_countries.xml', 
			xml('Country', heading(FROMUNICODE(Accuity.MakeHdr.CreateGeoXMLFileHdr('FDJ 1152', Accuity.Geo.source_FDJ_1152_countries), 'utf8')
						,Accuity.MakeHdr.GeoFooter),trim, OPT), overwrite),
output(Accuity.Geo.source_OFAC_countries,,'~thor_data400::accuity::source_OFAC_countries.xml', 
			xml('Country', heading(FROMUNICODE(Accuity.MakeHdr.CreateGeoXMLFileHdr('RBL 1072', Accuity.Geo.source_OFAC_countries), 'utf8')
						,Accuity.MakeHdr.GeoFooter),trim, OPT), overwrite),
// reports
output(Accuity.AkaReport,,'~thor::accuity::akalog.csv',CSV(HEADING(SINGLE),QUOTE('"')),overwrite),

parallel(
//fileservices.Accuity.Despray('~thor_data400::accuity::output::source_all.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_all.xml'),
Accuity.Despray('~thor::accuity::source_ofac.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ofac.xml'),
Accuity.Despray('~thor::accuity::source_DB_1088.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_DB_1088.xml'),
Accuity.Despray('~thor_data400::accuity::source_ACB_1040.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ACB_1040.xml'),
Accuity.Despray('~thor_data400::accuity::source_ALL_1180.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ALL_1180.xml'),
Accuity.Despray('~thor_data400::accuity::source_BCW_1074.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_BCW_1074.xml'),
Accuity.Despray('~thor_data400::accuity::source_BEL_1008.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_BEL_1008.xml'),
Accuity.Despray('~thor_data400::accuity::source_BIT_1086.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_BIT_1086.xml'),
Accuity.Despray('~thor_data400::accuity::source_CAC_1146.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CAC_1146.xml'),
Accuity.Despray('~thor_data400::accuity::source_CBI_1054.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CBI_1054.xml'),
Accuity.Despray('~thor_data400::accuity::source_CEL_1082_noncountries.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CEL_1082_noncountries.xml'),
Accuity.Despray('~thor_data400::accuity::source_CSL_1080.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CSL_1080.xml'),
Accuity.Despray('~thor_data400::accuity::source_CSSF_1114.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CSSF_1114.xml'),
Accuity.Despray('~thor_data400::accuity::source_CWL_32.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CWL_32.xml'),
Accuity.Despray('~thor_data400::accuity::source_DNB_1090.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_DNB_1090.xml'),
//Accuity.Despray('~thor_data400::accuity::source_ECO_1144.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ECO_1144.xml'), Deactivated by Vendor 10/25/2017
Accuity.Despray('~thor_data400::accuity::source_ES_1014.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ES_1014.xml'),
Accuity.Despray('~thor_data400::accuity::source_ESE_1158.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ESE_1158.xml'),
Accuity.Despray('~thor_data400::accuity::source_EUE_1170.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_EUE_1170.xml'),
Accuity.Despray('~thor_data400::accuity::source_FDJ_1152.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_FDJ_1152.xml'),
Accuity.Despray('~thor_data400::accuity::source_FMU_1126.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_FMU_1126.xml'),
Accuity.Despray('~thor_data400::accuity::source_FR_1010.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_FR_1010.xml'),
Accuity.Despray('~thor_data400::accuity::source_HME_1130.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_HME_1130.xml'),
Accuity.Despray('~thor_data400::accuity::source_IND_1048.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_IND_1048.xml'),
Accuity.Despray('~thor_data400::accuity::source_ISA_1164.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ISA_1164.xml'),
Accuity.Despray('~thor_data400::accuity::source_ITL_1078.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_ITL_1078.xml'),
Accuity.Despray('~thor_data400::accuity::source_MEX_1038.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_MEX_1038.xml'),
Accuity.Despray('~thor_data400::accuity::source_MFR_1068.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_MFR_1068.xml'),
Accuity.Despray('~thor_data400::accuity::source_NEP_1156.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_NEP_1156.xml'),
Accuity.Despray('~thor_data400::accuity::source_NZ_1140.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_NZ_1140.xml'),
Accuity.Despray('~thor_data400::accuity::source_OCF_1122.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_OCF_1122.xml'),
Accuity.Despray('~thor_data400::accuity::source_PRT_1128.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_PRT_1128.xml'),
Accuity.Despray('~thor_data400::accuity::source_RPL_1176.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_RPL_1176.xml'),
Accuity.Despray('~thor_data400::accuity::source_SAP_1056.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_SAP_1056.xml'),
Accuity.Despray('~thor_data400::accuity::source_SAR_1032.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_SAR_1032.xml'),
Accuity.Despray('~thor_data400::accuity::source_SECO_42.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_SECO_42.xml'),
Accuity.Despray('~thor_data400::accuity::source_SL_1136.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_SL_1136.xml'),
Accuity.Despray('~thor_data400::accuity::source_UGO_1120.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_UGO_1120.xml'),
Accuity.Despray('~thor_data400::accuity::source_UK_1046.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_UK_1046.xml'),
Accuity.Despray('~thor_data400::accuity::source_UNE_1172.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_UNE_1172.xml'),
Accuity.Despray('~thor_data400::accuity::source_UN.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_UN.xml'),
Accuity.Despray('~thor_data400::accuity::source_USM_45.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_USM_45.xml'),
// country files
Accuity.Despray('~thor_data400::accuity::source_CEL_1082_countries.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_CEL_1082_countries.xml'),
Accuity.Despray('~thor_data400::accuity::source_FDJ_1152_countries.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_FDJ_1152_countries.xml'),
Accuity.Despray('~thor_data400::accuity::source_OFAC_countries.xml', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/accuity_source_OFAC_countries.xml'),
// reports
Accuity.Despray('~thor::accuity::akalog.csv', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/akalog.csv'),
Accuity.Despray('~thor::bridger::akalist', _Control.IPAddress.bctlpedata10,'/data/stub_cleaning/accuity/output/FullAccuityAKAlog.csv'),
/* Old Unix Code
Accuity.Despray('~thor::accuity::source_ofac.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ofac.xml'),
Accuity.Despray('~thor::accuity::source_DB_1088.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_DB_1088.xml'),
Accuity.Despray('~thor_data400::accuity::source_ACB_1040.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ACB_1040.xml'),
Accuity.Despray('~thor_data400::accuity::source_ALL_1180.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ALL_1180.xml'),
Accuity.Despray('~thor_data400::accuity::source_BCW_1074.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_BCW_1074.xml'),
Accuity.Despray('~thor_data400::accuity::source_BEL_1008.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_BEL_1008.xml'),
Accuity.Despray('~thor_data400::accuity::source_BIT_1086.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_BIT_1086.xml'),
Accuity.Despray('~thor_data400::accuity::source_CAC_1146.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CAC_1146.xml'),
Accuity.Despray('~thor_data400::accuity::source_CBI_1054.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CBI_1054.xml'),
Accuity.Despray('~thor_data400::accuity::source_CEL_1082_noncountries.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CEL_1082_noncountries.xml'),
Accuity.Despray('~thor_data400::accuity::source_CSL_1080.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CSL_1080.xml'),
Accuity.Despray('~thor_data400::accuity::source_CSSF_1114.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CSSF_1114.xml'),
Accuity.Despray('~thor_data400::accuity::source_CWL_32.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CWL_32.xml'),
Accuity.Despray('~thor_data400::accuity::source_DNB_1090.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_DNB_1090.xml'),
Accuity.Despray('~thor_data400::accuity::source_ECO_1144.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ECO_1144.xml'),
Accuity.Despray('~thor_data400::accuity::source_ES_1014.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ES_1014.xml'),
Accuity.Despray('~thor_data400::accuity::source_ESE_1158.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ESE_1158.xml'),
Accuity.Despray('~thor_data400::accuity::source_EUE_1170.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_EUE_1170.xml'),
Accuity.Despray('~thor_data400::accuity::source_FDJ_1152.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_FDJ_1152.xml'),
Accuity.Despray('~thor_data400::accuity::source_FMU_1126.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_FMU_1126.xml'),
Accuity.Despray('~thor_data400::accuity::source_FR_1010.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_FR_1010.xml'),
Accuity.Despray('~thor_data400::accuity::source_HME_1130.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_HME_1130.xml'),
Accuity.Despray('~thor_data400::accuity::source_IND_1048.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_IND_1048.xml'),
Accuity.Despray('~thor_data400::accuity::source_ISA_1164.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ISA_1164.xml'),
Accuity.Despray('~thor_data400::accuity::source_ITL_1078.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_ITL_1078.xml'),
Accuity.Despray('~thor_data400::accuity::source_MEX_1038.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_MEX_1038.xml'),
Accuity.Despray('~thor_data400::accuity::source_MFR_1068.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_MFR_1068.xml'),
Accuity.Despray('~thor_data400::accuity::source_NEP_1156.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_NEP_1156.xml'),
Accuity.Despray('~thor_data400::accuity::source_NZ_1140.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_NZ_1140.xml'),
Accuity.Despray('~thor_data400::accuity::source_OCF_1122.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_OCF_1122.xml'),
Accuity.Despray('~thor_data400::accuity::source_PRT_1128.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_PRT_1128.xml'),
Accuity.Despray('~thor_data400::accuity::source_RPL_1176.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_RPL_1176.xml'),
Accuity.Despray('~thor_data400::accuity::source_SAP_1056.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_SAP_1056.xml'),
Accuity.Despray('~thor_data400::accuity::source_SAR_1032.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_SAR_1032.xml'),
Accuity.Despray('~thor_data400::accuity::source_SECO_42.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_SECO_42.xml'),
Accuity.Despray('~thor_data400::accuity::source_SL_1136.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_SL_1136.xml'),
Accuity.Despray('~thor_data400::accuity::source_UGO_1120.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_UGO_1120.xml'),
Accuity.Despray('~thor_data400::accuity::source_UK_1046.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_UK_1046.xml'),
Accuity.Despray('~thor_data400::accuity::source_UNE_1172.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_UNE_1172.xml'),
Accuity.Despray('~thor_data400::accuity::source_UN.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_UN.xml'),
Accuity.Despray('~thor_data400::accuity::source_USM_45.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_USM_45.xml'),
// country files
Accuity.Despray('~thor_data400::accuity::source_CEL_1082_countries.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_CEL_1082_countries.xml'),
Accuity.Despray('~thor_data400::accuity::source_FDJ_1152_countries.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_FDJ_1152_countries.xml'),
Accuity.Despray('~thor_data400::accuity::source_OFAC_countries.xml', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/accuity_source_OFAC_countries.xml'),
// reports
Accuity.Despray('~thor::accuity::akalog.csv', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/akalog.csv'),
Accuity.Despray('~thor::bridger::akalist', 'edata12-bld.br.seisint.com','/stub_cleaning/accuity/output/FullAccuityAKAlog.csv'),
*/
Accuity.Accuity_Strata(versiondate)
)) 
	: SUCCESS(FileServices.SendEmail('jason.allerdings@lexisnexisrisk.com', 'Accuity Build Complete', thorlib.wuid() + ' Version: ')),
      Failure(FileServices.SendEmail(Accuity.DistributionList, 
					'Accuity Build Failed', thorlib.wuid() + '\r\n' + FAILMESSAGE))
;
export Send_Email(string filedate):= module
	ver	:=	if(Mode.IsWeekly	,'/hds_180/cid/weekly/out/','/hds_180/cid/monthly/out/');
	export build_success := fileservices.sendemail(
													'jbello@seisint.com;DataReceiving@lexisnexis.com;Ids.support@lexisnexis.com;satish.krishnamurthy@lexisnexis.com;skasavajjala@seisint.com ',
													'compID Enhanced Build Succeeded ' + filedate,
													'The following files were successfuly staged on edata12 and are ready for pickup.\n' +
													'	1	)' + ver + 'LN_NM.OUT	\n' +
													'	2	)' + ver + 'LN_NH.OUT	\n' +
													'	3	)' + ver + 'LN_CA.OUT	\n' +
													'	4	)' + ver + 'LN_NC.OUT	\n' +
													'	5	)' + ver + 'LN_NJ.OUT	\n' +
													'	6	)' + ver + 'LN_NY.OUT	\n' +
													'	7	)' + ver + 'LN_MO.OUT	\n' +
													'	8	)' + ver + 'LN_IN.OUT	\n' +
													'	9	)' + ver + 'LN_VA.OUT	\n' +
													'	10	)' + ver + 'LN_FL.OUT	\n' +
													'	11	)' + ver + 'LN_IL.OUT	\n' +
													'	12	)' + ver + 'LN_PA.OUT	\n' +
													'	13	)' + ver + 'LN_TX.OUT	\n' +
													'	14	)' + ver + 'LN_GA.OUT	\n' +
													'	15	)' + ver + 'LN_MI.OUT	\n' +
													'	16	)' + ver + 'LN_OH.OUT	\n' +
													'	17	)' + ver + 'LN_MD.OUT	\n' +
													'	18	)' + ver + 'LN_TN.OUT	\n' +
													'	19	)' + ver + 'LN_WA.OUT	\n' +
													'	20	)' + ver + 'LN_NV.OUT	\n' +
													'	21	)' + ver + 'LN_AL.OUT	\n' +
													'	22	)' + ver + 'LN_ID.OUT	\n' +
													'	23	)' + ver + 'LN_RI.OUT	\n' +
													'	24	)' + ver + 'LN_NE.OUT	\n' +
													'	25	)' + ver + 'LN_MA.OUT	\n' +
													'	26	)' + ver + 'LN_DE.OUT	\n' +
													'	27	)' + ver + 'LN_SD.OUT	\n' +
													'	28	)' + ver + 'LN_OR.OUT	\n' +
													'	29	)' + ver + 'LN_KY.OUT	\n' +
													'	30	)' + ver + 'LN_SC.OUT	\n' +
													'	31	)' + ver + 'LN_WV.OUT	\n' +
													'	32	)' + ver + 'LN_UT.OUT	\n' +
													'	33	)' + ver + 'LN_MT.OUT	\n' +
													'	34	)' + ver + 'LN_ND.OUT	\n' +
													'	35	)' + ver + 'LN_WY.OUT	\n' +
													'	36	)' + ver + 'LN_KS.OUT	\n' +
													'	37	)' + ver + 'LN_CT.OUT	\n' +
													'	38	)' + ver + 'LN_AZ.OUT	\n' +
													'	39	)' + ver + 'LN_MS.OUT	\n' +
													'	40	)' + ver + 'LN_ME.OUT	\n' +
													'	41	)' + ver + 'LN_OK.OUT	\n' +
													'	42	)' + ver + 'LN_DC.OUT	\n' +
													'	43	)' + ver + 'LN_AK.OUT	\n' +
													'	44	)' + ver + 'LN_VT.OUT	\n' +
													'	45	)' + ver + 'LN_WI.OUT	\n' +
													'	46	)' + ver + 'LN_HI.OUT	\n' +
													'	47	)' + ver + 'LN_CO.OUT	\n' +
													'	48	)' + ver + 'LN_LA.OUT	\n' +
													'	49	)' + ver + 'LN_MN.OUT	\n' +
													'	50	)' + ver + 'LN_IA.OUT	\n' +
													'	51	)' + ver + 'LN_AR.OUT	\n' +
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												'jbello@seisint.com;skasavajjala@seisint.com',
												'compID Enhanced '+filedate+' Build FAILED',
												workunit);						
end;
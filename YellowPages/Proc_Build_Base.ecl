import tools,ut;

export Proc_Build_Base(

	 string																		pversion
	,dataset(Layout_YellowPages							)	pUpdateFile			= Files().Input.Using
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile				= Files().Base.QA
) :=
function

	Field_stats				:= Query_YP_Field_Stats(pversion);
	YellowPages_Base	:= YellowPages.YellowPages_Base_YP(pversion) + YellowPages.YellowPages_Base_Gong(pversion);
	dRollup_Base			:= YellowPages.Rollup_Base(YellowPages_Base	);
	dappendbdid 			:= YellowPages.Append_BDID(dRollup_Base	);
	dFiltered_Base    := dappendbdid( /* filter out bad records */
												not(~regexfind(' ',trim(business_name,left,right),nocase) 
														and trim(prim_name) = 'MARIETTA' 
														and pub_date in ['20131104','20131105','20131108','20131111','20131113'
																						,'20131114','20131118','20131119','20140324']));

	//Add the source_rec_id to the base file
	UT.MAC_Append_Rcid(dFiltered_Base, source_rec_id, final_base);

	tools.mac_WriteFile(Filenames(pversion).base.new		,final_base			,Build_Base_File		);

	bdid_count	:= output(COUNT(Files(pversion).base.new(bdid <> 0)), named('YellowPagesBdidCount'));
	total_count := output(COUNT(Files(pversion).base.new)						, named('YellowPagesTotalCount'));

	return
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				 Field_stats
				,Build_Base_File
				,Promote(pversion).buildfiles.New2Built
				,parallel(bdid_count,total_count)		
		)
		,output('No Valid version parameter passed, skipping YellowPages.Proc_Build_Base atribute')
	);
		
end;
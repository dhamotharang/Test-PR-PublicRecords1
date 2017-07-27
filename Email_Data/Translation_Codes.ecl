import lib_stringlib, ut, mdr;
export Translation_Codes := module


//Setting bit map for the different souces
export source_bitmap_code(string source = '')  := map(
													//Sources other than header
													source = mdr.sourceTools.src_entiera  					=> ut.bit_set(0,0),
													source = mdr.sourceTools.src_impulse						=> ut.bit_set(0,1),
													source = mdr.sourceTools.src_acquiredweb				=> ut.bit_set(0,2),
													source = mdr.sourceTools.src_wired_assets_email	=> ut.bit_set(0,3),
													source = mdr.sourceTools.src_MediaOne						=> ut.bit_set(0,4),
													source = mdr.sourceTools.src_OutwardMedia				=> ut.bit_set(0,5),
													0);
//Funtion to obtain the string of contributing sources
export	string	fGet_email_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_entiera					 )),			' ' + mdr.sourceTools.src_entiera						,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_impulse					 )),			' ' + mdr.sourceTools.src_impulse						,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_acquiredweb			 )),			' ' + mdr.sourceTools.src_acquiredweb				,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_wired_assets_email)),			' ' + mdr.sourceTools.src_wired_assets_email,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_MediaOne						)),			' ' + mdr.sourceTools.src_mediaone					,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_OutwardMedia				)),			' ' + mdr.sourceTools.src_OutwardMedia			,'')
										);
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;		

//Funtion to determine if a bit is set
export fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;		

export fCheapest_Src (src_set):= 
/*Flat rate*/			map(fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_impulse)) 						= true => mdr.sourceTools.src_impulse,
/*Flat rate*/					fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_wired_assets_email)) = true => mdr.sourceTools.src_wired_assets_email,
/*0.03*/							fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_acquiredweb)) 				= true => mdr.sourceTools.src_acquiredweb,
/*0.03*/							fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_MediaOne)) 					= true => mdr.sourceTools.src_MediaOne,
/*0.03*/							fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_OutwardMedia)) 			= true => mdr.sourceTools.src_OutwardMedia,
/*0.04*/							fFlagIsOn(src_set,source_bitmap_code(mdr.sourceTools.src_entiera)) 						= true => mdr.sourceTools.src_entiera,
					'');

export fNum_Src := function
in_src(unsigned email_src_all, string src) := fFlagIsOn(email_src_all,source_bitmap_code(src)) ;

num_src(unsigned email_src_all) := (unsigned1)in_src(email_src_all,mdr.sourceTools.src_impulse) +
																	 (unsigned1)in_src(email_src_all,mdr.sourceTools.src_wired_assets_email) +
																	 (unsigned1)in_src(email_src_all,mdr.sourceTools.src_acquiredweb) +
																	 (unsigned1)in_src(email_src_all,mdr.sourceTools.src_entiera) +
																	 (unsigned1)in_src(email_src_all,mdr.sourceTools.src_MediaOne) +
																	 (unsigned1)in_src(email_src_all,mdr.sourceTools.src_OutwardMedia);
return num_src;
end;										
end;


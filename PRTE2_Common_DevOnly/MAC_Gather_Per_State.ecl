EXPORT MAC_Gather_Per_State (incomingDS, StateFieldName, GatherCnt) := FUNCTIONMACRO

RETURN CHOOSESETS(incomingDS,
				 StateFieldName='AK'=>GatherCnt,StateFieldName='AL'=>GatherCnt,StateFieldName='AR'=>GatherCnt,StateFieldName='AZ'=>GatherCnt,StateFieldName='CA'=>GatherCnt,
				 StateFieldName='CO'=>GatherCnt,StateFieldName='CT'=>GatherCnt,StateFieldName='DC'=>GatherCnt,StateFieldName='DE'=>GatherCnt,StateFieldName='FL'=>GatherCnt,
				 StateFieldName='GA'=>GatherCnt,StateFieldName='HI'=>GatherCnt,StateFieldName='IA'=>GatherCnt,StateFieldName='ID'=>GatherCnt,StateFieldName='IL'=>GatherCnt,
				 StateFieldName='IN'=>GatherCnt,StateFieldName='KS'=>GatherCnt,StateFieldName='KY'=>GatherCnt,StateFieldName='LA'=>GatherCnt,StateFieldName='MA'=>GatherCnt,
				 StateFieldName='MD'=>GatherCnt,StateFieldName='ME'=>GatherCnt,StateFieldName='MI'=>GatherCnt,StateFieldName='MN'=>GatherCnt,StateFieldName='MO'=>GatherCnt,
				 StateFieldName='MS'=>GatherCnt,StateFieldName='MT'=>GatherCnt,StateFieldName='NC'=>GatherCnt,StateFieldName='ND'=>GatherCnt,StateFieldName='NE'=>GatherCnt,
				 StateFieldName='NH'=>GatherCnt,StateFieldName='NJ'=>GatherCnt,StateFieldName='NM'=>GatherCnt,StateFieldName='NV'=>GatherCnt,StateFieldName='NY'=>GatherCnt,
				 StateFieldName='OH'=>GatherCnt,StateFieldName='OK'=>GatherCnt,StateFieldName='OR'=>GatherCnt,StateFieldName='PA'=>GatherCnt,StateFieldName='RI'=>GatherCnt,
				 StateFieldName='SC'=>GatherCnt,StateFieldName='SD'=>GatherCnt,StateFieldName='TN'=>GatherCnt,StateFieldName='TX'=>GatherCnt,StateFieldName='UT'=>GatherCnt,
				 StateFieldName='VA'=>GatherCnt,StateFieldName='VT'=>GatherCnt,StateFieldName='WA'=>GatherCnt,StateFieldName='WI'=>GatherCnt,StateFieldName='WV'=>GatherCnt,
				 StateFieldName='WY'=>GatherCnt, 0);

ENDMACRO;
import header;
export source_is_marketing_eligible(

	 string			src
	,string			vendorid
	,string			st
	,string			county
	,unsigned3	dt_nonglb_last_seen
	,unsigned3	dt_first_seen

) := 
			~mdr.Source_is_on_Probation	(src)
	and ~mdr.Source_is_DPPA					(src)
	and ~mdr.Source_is_Utility			(src)
	and	header.translateSource			(src)!='Utilities'
	and //List of included sources
	(
					(MDR.sourceTools.SourceIsEquifax									(src) and (dt_nonglb_last_seen>0 or dt_first_seen between 1 and 200106)) //x Equifax, assumed to be non-glb filtered before getting here 
			or	 MDR.sourceTools.SourceIsLexis_Trans_Union				(src)     //x TU from Lexis, assumed to be non-glb filtered before getting here
			or	 MDR.sourceTools.SourceIsTransUnion								(src)			//x Trans Union, assumed to be non-glb filtered before getting here
			or	 MDR.sourceTools.SourceIsDeath_Master							(src) 		//x Death Master 
			or	 MDR.sourceTools.SourceIsAK_Perm_Fund							(src) 		//x AK Permanent Fund 
			or	 MDR.sourceTools.SourceIsFederal_Firearms					(src) 		//x Federal Firearm 
			or	 MDR.sourceTools.SourceIsFederal_Explosives				(src)			//x Federal Explosive 
			or	 MDR.sourceTools.SourceIsAircrafts								(src) 		//x Aircraft
			or	 MDR.sourceTools.SourceIsAirmen										(src) 		//x Airman
			or	 MDR.sourceTools.SourceIsDEA											(src) 		//x DEA Registration 
			or	 MDR.sourceTools.SourceIsMS_Worker_Comp						(src)   	//x MS workers comp FCRA?
			or	(MDR.sourceTools.SourceIsLiens										(src) and st not in ['ID','IL','KS','WA','NM','SC']) 			//x Liens 
			or	(MDR.sourceTools.SourceIsLiens_v2									(src) and st not in ['ID','IL','KS','WA','NM','SC']) 			//x Liens V2
			or	(MDR.sourceTools.SourceIsBankruptcy								(src) and st not in ['ID','IL','KS','WA','NM','SC']) 			//x Bankruptcy FCRA?
			or	(MDR.sourceTools.SourceIsProfessional_License			(src) and st not in ['ID','IL','KS','WA','NM','SC','UT']) 			//x Professional License, state exceptions ?? let em go for now
			or	(MDR.sourceTools.SourceIsLnPropV2_Lexis_Deeds_Mtgs(src) and st not in ['ID','IL','KS','NM','SC'] and (st<>'PA' and county<>'001')) 	//x Lexis Deeds and Mortgages state/county exceptions ??
			or	(MDR.sourceTools.SourceIsLnPropV2_Lexis_Asrs			(src) and st not in ['ID','IL','KS','WA','NM','SC'] and (st<>'PA' and county<>'001') and (st<>'SC' and county<>'091'))  //x Lexis Assessor state/county exceptions??
			or	(MDR.sourceTools.SourceIsDeath_State							(src) and st not in ['ID','IL','KS','WA','NM','SC'])	    		//x State Death, state exceptions ??
			or	 MDR.sourceTools.SourceIsTUCS_Ptrack							(src)

			//or MDR.sourceTools.SourceIsGong_History							(src) //per legal - Gong is not ok for marketing.
	);

//'MI' Mixed non-dppa - "unknown" sources,could be license restricted.

//'CG' Coast Guard 

//'FB' Fares Deeds from Assessors
//'FP' Fares Deeds and Mortgages s
//'FA' Fares Assessor 
//'FR' Foreclosure-Fares

//'EB' Emerges Boat according to mdr.source_group this is ok

//'PH'  Appended phone from gong file, multiple sources- some restricted?, any Targus=no?
//'NC' NCOA 
//'TC' TCOA 
//'TB' TCOA 
//'DC' DOC - fcra-prob from source group
//'CC' Criminal Court - fcra-prob from source group
//'AL' Arrest Log - fcra-prob from source group
//'IS' Ingenix Sanctioned Providers 
//'WP' Targus White Pages, only in headers=yes?
//'EM' Emerges Master voters ?? stop all
//'DU' dummy IRS
//'PQ' misc
// --------------------------------------------------------------------------------
// PRTE2._Macro_to_Flaten_Layout
// This macro take complex denormalised layout and convert to flat field list.
// It have helped with building Customer Test simulators
// --------------------------------------------------------------------------------

IMPORT doxie, doxie_crs;
IMPORT Risk_Indicators;

Fnm_Layout_info(m_Layout) := FUNCTIONMACRO
	LOADXML('<xml/>');
	#EXPORTXML(m_Layout_XML,m_Layout);
	LOCAL out_rec := RECORD
		string a_rec;
		string b_rec;
		string rec;
		string field_type;
		string field_size;
		string field_name;
		string info;
	END;
	#DECLARE(field_number_a);
	#SET(field_number_a,1);
	#DECLARE(field_number_b);
	#SET(field_number_b,1);
	return dataset([
	 {'EXPORT Layout_Name123 := RECORD','EXPORT Layout_Name123 := RECORD','EXPORT Layout_Name123 := RECORD','type','size','name','info'}
	#FOR(m_Layout_XML)
		#FOR(Field)
			,{
//---------------------------------------------
 			#if(%'{@isDataset}'% = '1')
   			'// DATASET( --------- )   ' + %'{@name}'%
			#elseif(%'{@isRecord}'% = '1')
   			'//  RECORD( ' + %'{@type}'% + ' )   ' + %'{@name}'%
 			#elseif(%'{@isEnd}'% = '1')
   			'//   EndOf    -----    ' + %'{@name}'%
   		#else
   			'\t' + %'{@type}'%
   			#if(%'{@size}'% = '-15' OR %'{@type}'% = 'boolean')
   				+ ''
   			#else
   				+ %'{@size}'%
   			#end
   				+ '\t\t' + 'f' + %'{field_number_a}'% + '_' + %'{@name}'% + ';' #SET(field_number_a,%{field_number_a}% + 1)
   		#end
//---------------------------------------------
			,
 			#if(%'{@isDataset}'% = '1')
   			'// DATASET( --------- )   ' + %'{@name}'% #SET(field_number_b,%{field_number_b}% + 1)
			#elseif(%'{@isRecord}'% = '1')
   			'//  RECORD( ' + %'{@type}'% + ' )   ' + %'{@name}'% #SET(field_number_b,%{field_number_b}% + 1)
 			#elseif(%'{@isEnd}'% = '1')
   			'//   EndOf    -----    ' + %'{@name}'% #SET(field_number_b,%{field_number_b}% + 1)
   		#else
   			'\t' + %'{@type}'%
   			#if(%'{@size}'% = '-15' OR %'{@type}'% = 'boolean')
   				+ ''
   			#else
   				+ %'{@size}'%
   			#end
   				+ '\t\t' + 'f' + %'{field_number_b}'% + '_' + %'{@name}'% + ';'
   		#end
//---------------------------------------------
			,
 			#if(%'{@isDataset}'% = '1')
   			'// DATASET( --------- )   ' + %'{@name}'%
			#elseif(%'{@isRecord}'% = '1')
   			'//  RECORD( ' + %'{@type}'% + ' )   ' + %'{@name}'%
 			#elseif(%'{@isEnd}'% = '1')
   			'//   EndOf    -----    ' + %'{@name}'%
   		#else
   			'\t' + %'{@type}'%
   			#if(%'{@size}'% = '-15' OR %'{@type}'% = 'boolean')
   				+ ''
   			#else
   				+ %'{@size}'%
   			#end
   				+ '\t\t' + %'{@name}'% + ';'
   		#end
//---------------------------------------------
			, %'{@type}'%,  
			#if(%'{@size}'% = '-15')
				''
			#else
				%'{@size}'%
			#end
			, %'{@name}'%
			#if(%'{@isRecord}'% = '1')
				, 'isRecord'
			#elseif(%'{@isDataset}'% = '1')	
			  , 'isDataset'
			#elseif(%'{@isEnd}'% = '1')
			  , 'isEnd'
			#else
			   , ''
			#end
			}
		#END
	#END
	,{'END;','END;','END;','type','size','name','info'}],out_rec);
ENDMACRO;

//Layout_Request := doxie_crs.layout_report;
//OUTPUT(Fnm_Layout_info(doxie_crs.layout_report),,'thor::temp::prte2::bg::FCRA_ComprehensiveReport::doxie_crs_layout_report',OVERWRITE, NAMED('doxie_crs_x_layout_report'));

//Layout_Request2 := doxie.Layout_Rollup.KeyRec_feedback;
//OUTPUT(Fnm_Layout_info(doxie.Layout_Rollup.KeyRec_feedback),,'thor::temp::prte2::bg::Rollup::KeyRec_feedback',OVERWRITE, NAMED('doxie_x_Layout_Rollup_x_KeyRec_feedback'));

//OUTPUT(Fnm_Layout_info(Risk_Indicators.Layout_Boca_Shell),,'thor::temp::prte2::bg::BocaShellV4NF::Layout_Boca_Shell',OVERWRITE, NAMED('Risk_Indicators_x_Layout_Boca_Shell'));

//OUTPUT(Fnm_Layout_info(doxie_crs.layout_report),,'thor::temp::prte2::bg::CompRP::layout_report',OVERWRITE, NAMED('doxie_crs_x_layout_report'));
OUTPUT(Fnm_Layout_info(WatercraftV2_services.Layouts),,'thor::temp::prte2::bg::CompRP::layout_report',OVERWRITE, NAMED('WatercraftV2_services__Layouts'));

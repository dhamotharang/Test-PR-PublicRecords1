import Data_Services;

lVINAFileBaseName := '~thor_Data400::in::VehReg_VINA_Info_';

File_raw_VINA	:=	dataset(Data_Services.foreign_prod + 'thor_data400::in::vehreg_vina_info_all',VehLic.Layout_VINA,thor);

VehLic.Layout_VINA tr(File_raw_VINA l) := transform
	specia_case:=	['MONTE'
					,'GRAND'
					,'CROWN'
					,'TOWN'	
					,'EL'	
					,'CUTLASS'
					,'LIGHT'
					,'HEAVY'
					,'PARK'
					,'PT'
					,'OFF'
					,'NEW'
					,'FIFTH'
					,'LAND'
					,'PASSENGER'
					,'CUSTOM'
					,'DELTA'
					];

	model_desc:= stringlib.StringToUpperCase(trim(l.model_description, left, right));
	
	w0:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$0');
	w1:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$1');
	w2:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$2');
	w3:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$3');
	w4:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$4');
	w5:=regexreplace('([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*) *([^ ]*)',model_desc,'$5');

	model_description_temp	:=if(regexfind('^TOWN & COUNTRY', model_desc),model_desc[1..14],
	
	                if( w1 in specia_case
						,w1+' '+w2
						,w1));
	series_description_temp	:=if(regexfind('^TOWN & COUNTRY', model_desc),model_desc[15..],
						if(w1 in specia_case
						,		w3+' '+w4+' '+w5
						,w2+' '+w3+' '+w4+' '+w5));
	//DF-28271 - Use series description if series_description_temp is blank
	series_description_temp1:= if (series_description_temp='',trim(l.series_description, left, right),'');


	self.model_description  := if(series_description_temp = '' and StringLib.stringfind(model_description_temp,'/', 1) <> 0 
	                             and model_description_temp not in ['1/2 TON', '3/4 TON'], 
	                             model_description_temp[1..StringLib.stringfind(model_description_temp,'/', 1)-1], model_description_temp);
    
	//DF-28271 - Use series description if series_description_temp is blank
	self.series_description := if(series_description_temp = '' and StringLib.stringfind(model_description_temp,'/', 1) <> 0 
	                             and model_description_temp not in ['1/2 TON', '3/4 TON'], 
	                             model_description_temp[StringLib.stringfind(model_description_temp,'/', 1)+1..],  series_description_temp1);

	self :=l;
end;

export File_VINA := project(File_raw_VINA,tr(left));
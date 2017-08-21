//#workunit('name', 'EDA and PhonesPlus STATS')

import Gong, ut, utilfile, Phonesplus, YellowPages, Cellphone, Risk_Indicators;

//* **********************************EDA
eda_f 		  :=  Gong.File_GongBase;

pplus_f 	  :=  Phonesplus.file_phonesplus_base;

//* **********************************Phonesplus
eda_dedp      := dedup(sort(distribute(eda_f, hash(phoneno)), phoneno, local), phoneno, local);
pplus_dedup   := dedup(sort(distribute(pplus_f, hash(cellphone)), cellphone, -confidencescore, local), cellphone, local);
pplus_dedup_a := dedup(sort(distribute(pplus_f(confidencescore > 10), hash(cellphone)), cellphone, local), cellphone, local);

pplus_tbl     := table( pplus_dedup, {string phone := cellphone, unsigned score := confidencescore});
YellowPages.NPA_PhoneType(pplus_tbl, phone, phonetype, pplus_phonetype);

cell_p		  := (real8) (count(pplus_phonetype(phonetype = 'CELL')) / count(pplus_phonetype)); 
cell_a	  	  := pplus_phonetype(phonetype = 'CELL' and score > 10);
cell_p_a	  := (real8) (count(pplus_phonetype(phonetype = 'CELL' and score > 10)) / count(pplus_phonetype(score > 10))); 

 //* **********************************Gong History
eda_hist_f   := Gong.File_History;

//* **********************************		  
fn_AddStat(real8 value, string name) := 
FUNCTION
	return ut.fn_AddStatDS(dataset([{name, value}], ut.layout_stats_extend));
END;

ph_stats := parallel(

//* **********************************EDA
fn_AddStat(count(eda_f),                                         	   '01) EDA (Gong)  Total records'),

fn_AddStat(count(eda_dedp),                               		       '02) EDA (Gong)  Unique phones'),

fn_AddStat(count((eda_dedp(listing_type_res <>'' and
				            listing_type_bus = ''
							))),                               	       '03) EDA (Gong)  Unique phones - residential'),
							
fn_AddStat(count((eda_dedp(listing_type_res ='' and
				            listing_type_bus <> ''
							))),                               		   '04) EDA (Gong)  Unique phones - business'),

fn_AddStat(count((eda_dedp(listing_type_res  <>'' and
				            listing_type_bus <> ''
							)))  ,                               	   '05) EDA (Gong)  Unique phones - res / bus combination'),
							
//* **********************************Gong History

fn_AddStat(count(eda_hist_f(current_record_flag <> 'Y' and
							 did > 0 and
							 phone10 <> '' )),         				   '06) EDA (Gong)  Historical phones'),

//* **********************************Phonesplus
fn_AddStat(count(pplus_f),                                             '07) Phones Plus  Total records'),

fn_AddStat(count(pplus_f(confidencescore > 10)),                       '08) Phones Plus  Total records over threshold'),

fn_AddStat(count(pplus_dedup),                                         '09) Phones Plus  Unique phones'),

fn_AddStat(cell_p, 						  					           '10) Phones Plus % Unique phones likely cell phones'),

fn_AddStat(count(pplus_dedup_a),                   					   '11) Phones Plus  Unique phones over threshold'),

fn_AddStat(count(cell_a),                   					 	   '12) Phones Plus  Unique phones over threshold likely cell phones'),

fn_AddStat(cell_p_a,                   					 	   		   '13) Phones Plus % Unique phones over threshold likely cell phones')
);

export Phone_Stats := ph_stats;
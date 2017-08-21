export File_mdv2_lookup  := module
Layout_mar_div_filter := record
string2 state_origin;
string70 party_name;
string25 filing_number;
string1 filing_type;
end;




export File_In :=  dataset([{'OH','TSIMPIRIS    STEVEN  D','17882-039185','3'},
               {'CA','VANDRAANEN, ARLEN C','00179','3'}],Layout_mar_div_filter);
						
export fState := ['OH','CA'];

export fparty := ['TSIMPIRIS    STEVEN  D','VANDRAANEN, ARLEN C'];

export mfilingnbr := ['17882-039185','00179'];

end;


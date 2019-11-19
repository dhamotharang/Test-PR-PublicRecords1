//The input file must be sprayed as a delimited file with separator | and no quotation operators
import crim_offense_cat, std;
export build_Base_Data(boolean pUseProd = false) := function
    data_source := crim_offense_cat.filenames(pUseProd).BaseIn;
    base_layout := crim_offense_cat.layouts.base_layout;

    RawData := dataset(data_source, base_layout, CSV(Heading(1),separator(['^|^'])));
    base_layout remove_quotes(base_layout L) := TRANSFORM
            Self.offensecharge := if(L.offensecharge[1] = '"', 
                L.offensecharge[2..],
                L.offensecharge
                );
            self.category := if(L.category[length(L.category)] = '"',
                L.category[..length(L.category)-1],
                L.category
                );
            self.id := L.id;
    END;
    final_data := project(rawdata, remove_quotes(left));
    RETURN final_data;
END;

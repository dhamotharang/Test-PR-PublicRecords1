//The input file must be sprayed as a delimited file with separator | and no quotation operators
import crim_offense_cat, std;
export build_Base_Data(boolean pUseProd = false) := function
    data_source := crim_offense_cat.filenames(pUseProd).BaseIn; //whatever is in the input superfile is pulled in
    base_layout := crim_offense_cat.layouts.base_layout;

    RawData := dataset(data_source, base_layout, CSV(Heading(1),separator(['^|^'])));
    base_layout remove_quotes(base_layout L) := TRANSFORM //necessary steps to deal with strange formating of input files
            Self.offensecharge := trim(
                if(L.offensecharge[1] = '"', 
                    L.offensecharge[2..],
                    L.offensecharge
                    ),
                left,
                right
                );
            self.id := if(L.id[length(L.id)] = '"',
                L.id[..length(L.id)-1],
                L.id
                );
            self.category := L.category;
    END;
    final_data := project(rawdata, remove_quotes(left));
    RETURN final_data;
END;

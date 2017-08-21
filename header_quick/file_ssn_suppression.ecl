import Data_Services;
export file_ssn_suppression := dataset(Data_Services.Data_location.prefix('Header_Quick')
+'thor_data400::base::ssn_suppression',{string9 ssn,string ssn_mask,string rc,string2 crlf},flat);
import $;
export Build_all(string pversion = '', boolean pUseProd = false, boolean isfcra = false) := function

/* B_BaseBLKGRP := output($.sources.BaseBLKGRP,, $.Filenames().BaseBLKGRP, overwrite);
B_BaseBLKGRP_attr_over18 := output($.sources.BaseBLKGRP_attr_over18,, $.Filenames().BaseBLKGRP_attr_over18, overwrite);
B_BaseCensus_surnames := output($.sources.BaseCensus_surnames,, $.Filenames().BaseCensus_surnames, overwrite);  */

index_BLKGRP := buildindex($.key_BLKGRP( $.Filenames(pversion, pUseProd, isfcra).keyBLKGRP),
                            $.sources.BaseBLKGRP, overwrite); 
                            
index_BLKGRP_attr_over18 := buildindex($.key_BLKGRP_attr_over18($.Filenames(pversion, pUseProd, isfcra).keyBLKGRP_attr_over18),
                                        $.sources.BaseBLKGRP_attr_over18, overwrite);

index_census_surnames := buildindex($.key_census_surnames($.Filenames(pversion, pUseProd, isfcra).keyCensus_surnames), 
                                    $.sources.BaseCensus_surnames,overwrite); 
//sequential(B_BaseBLKGRP,B_BaseBLKGRP_attr_over18,B_BaseCensus_surnames,index_blkgrp);

/* Do_BLKGRP := sequential(B_BaseBLKGRP, index_BLKGRP);
Do_BLKGRP_attr_over18 := sequential(B_BaseBLKGRP_attr_over18, index_BLKGRP_attr_over18);
Do_census_surnames := sequential(B_Basecensus_surnames, index_census_surnames); 
built := parallel(Do_BLKGRP, Do_BLKGRP_attr_over18, Do_census_surnames); */
built := parallel(index_BLKGRP, index_BLKGRP_attr_over18, index_census_surnames);
return built;
end;
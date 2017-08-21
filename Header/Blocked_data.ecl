//Monthly Blocked data - ACTUALLY, THIS IS THE UNBLOCKED DATA
import mdr;

export Blocked_data(isFCRA=false) := MACRO

not header.isDemoData() and if(isFCRA,src in mdr.sourceTools.set_scoring_FCRA,true)

ENDMACRO;
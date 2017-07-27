// NOTE:  This attribute produces a file but will do so only if called.  This
//		  allows it to be called via sequential() and to more easily limit
//		  whether it is called at all using conditional compile #IF() blocks.

export Out_Punishment := output(Punishment_Joined,,Name_Moxie_Punishment_Dev,overwrite, __compressed__);
export Email_rec_key (string email, 
														string prim_range, 
														string prim_name, 
														string sec_range, 
														string zip , 
														string lname, 
														string fname) := hash64((data)email + 																																																									 
																							(data)prim_range + 
																							(data)prim_name + 
																							(data)sec_range + 
																							(data)zip +
																							(data)lname + 
																							(data)fname);
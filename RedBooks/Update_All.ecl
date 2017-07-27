export Update_State :=
module

	export _All(string pversion) := Update_Combined(
									 RedBooks.Files().input._All.using
									,RedBooks.Files().base._All.qa
									,pversion
						);
end;
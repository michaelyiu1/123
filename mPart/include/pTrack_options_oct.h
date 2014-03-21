
//The Octave version of the validate options function
partoptions validate_options(octave_scalar_map oct_opt){
	//This function takes the octave option structure and returns a c++ option structure
	const char* sOptions[] = {"Nal", "search", "bed_corr", 	"Knodes", "step", "minstep", "errmin",
	  					      "errmax", "method", "pornodes", "porinterp", "Ngen", "maxstep",
	  					      "stall_times", "el_type", "el_order",	"valid", "Nel",	"Np", "Nsides", "Nsh", "Nlay"};
						       
   partoptions opt;
   opt.valid = true;
   for (int i=0;i<22;i++){
	   if (i==0){
		   //check Nal option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Nal = tmp.int_value();
		   else{
				std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==1){
		   //check search option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.search = tmp.int_value();
		   else{
				std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==2){
		   //check bed_corr option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.bed_corr = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==3){
		   //check Knodes option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Knodes = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==4){
		   //check step option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   std::cout << tmp.int_value() << std::endl;
		   if (tmp.is_defined ())
			   opt.step = tmp.double_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==5){
		   //check minstep option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.minstep = tmp.double_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==6){
		   //check errmin option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.errmin = tmp.double_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==7){
		   //check errmax option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.errmax = tmp.double_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==8){
		   //check method option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.method = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==9){
		   //check pornodes option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.pornodes = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==10){
		   //check porinterp option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.porinterp = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==11){
		   //check Ngen option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Ngen = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==12){
		   //check maxstep option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.maxstep = tmp.double_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==13){
		   //check stall_times option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.stall_times = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==14){
		   //check el_type option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.el_type = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==15){
		   //check el_order option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.el_order = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==17){
		   //check Nel option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Nel = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==18){
		   //check Np option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Np = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==19){
		   //check Nsides option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Nsides = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==20){
		   //check Nsh option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Nsh = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
	   if (i==21){
		   //check Nlay option
		   octave_value tmp = oct_opt.contents(sOptions[i]);
		   if (tmp.is_defined ())
			   opt.Nlay = tmp.int_value();
		   else{
			    std::cout << "The field " << sOptions[i] << " is not defined in option structure" << std::endl;
				opt.valid = false;
				break;
		   }
	   }
   }// end for loop
   
   return opt;
}

